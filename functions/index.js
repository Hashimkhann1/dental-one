const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { setGlobalOptions } = require("firebase-functions/v2");
const nodemailer = require("nodemailer");
const { SecretManagerServiceClient } = require("@google-cloud/secret-manager");

// Set global options for all functions
setGlobalOptions({ maxInstances: 10 });

const client = new SecretManagerServiceClient();

// Fetch Gmail app password from Secret Manager
async function getGmailPassword() {
  try {
    console.log("Fetching Gmail password from Secret Manager...");
    const [version] = await client.accessSecretVersion({
      name: "projects/email-sender-e9f76/secrets/gmail-app-password/versions/latest",
    });
    console.log("Successfully fetched Gmail password");
    return version.payload.data.toString();
  } catch (error) {
    console.error("Error fetching Gmail password:", error.message);
    throw error;
  }
}

exports.sendMail = onCall(async (request) => {
  try {
    const { data } = request;
    console.log("Function called with data keys:", Object.keys(data || {}));

    // Validate input data
    if (!data || !data.subject || !data.text) {
      throw new HttpsError("invalid-argument", "Subject and text are required");
    }

    // Get Gmail app password from Secret Manager
    const appPassword = await getGmailPassword();

    // Create transporter
    console.log("Creating nodemailer transporter...");
    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "hashimkhan199999@gmail.com",
        pass: appPassword,
      },
    });

    // Verify transporter
    console.log("Verifying transporter...");
    await transporter.verify();
    console.log("Transporter verified successfully");

    // Email options
    const mailOptions = {
      from: "hashimkhan199999@gmail.com",
      to: "hmk200218@gmail.com",
      subject: data.subject,
      text: data.text,
    };

    // Send email
    console.log("Sending email...");
    const result = await transporter.sendMail(mailOptions);
    console.log("Email sent successfully with messageId:", result.messageId);

    return {
      success: true,
      message: "Email sent successfully!",
      messageId: result.messageId
    };

  } catch (error) {
    console.error("Error sending email:", {
      message: error.message,
      code: error.code,
      name: error.name
    });

    // Handle specific errors
    if (error.code === 'EAUTH') {
      throw new HttpsError("unauthenticated", "Gmail authentication failed. Check your app password.");
    } else if (error.code === 'ENOTFOUND') {
      throw new HttpsError("unavailable", "Network error. Unable to connect to Gmail servers.");
    } else if (error.message && error.message.includes("Invalid login")) {
      throw new HttpsError("unauthenticated", "Invalid Gmail credentials.");
    }

    throw new HttpsError("internal", `Failed to send email: ${error.message}`);
  }
});

// Simple test function without Secret Manager (for debugging)
exports.sendMailTest = onCall(async (request) => {
  try {
    console.log("Test function called");

    // REPLACE 'your-app-password-here' with your actual Gmail app password
    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "hashimkhan199999@gmail.com",
        pass: "your-app-password-here", // Replace this!
      },
    });

    const mailOptions = {
      from: "hashimkhan199999@gmail.com",
      to: "hmk200218@gmail.com",
      subject: "Test Email from Firebase Function",
      text: "This is a test email to verify the setup is working correctly.",
    };

    const result = await transporter.sendMail(mailOptions);
    console.log("Test email sent successfully");

    return { success: true, message: "Test email sent successfully!" };

  } catch (error) {
    console.error("Test function error:", error.message);
    throw new HttpsError("internal", `Test failed: ${error.message}`);
  }
});
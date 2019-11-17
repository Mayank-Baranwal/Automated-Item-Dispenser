import smtplib, ssl, email
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

smtp_server = "smtp.gmail.com"
port = 587  # For starttls
sender_email = "group5cs321@gmail.com"
receiver_email = "krtk.anurima123@gmail.com"
password = "mbucmbuc"

def sendMail(subject,body):
	# Create a secure SSL context
	context = ssl.create_default_context()

	# Try to log in to server and send email
	try:
		server = smtplib.SMTP(smtp_server,port)
		server.ehlo() # Can be omitted
		server.starttls(context=context) # Secure the connection
		server.ehlo() # Can be omitted
		server.login(sender_email, password)
		message = MIMEMultipart()
		message["From"] = sender_email
		message["To"] = receiver_email
		message["Subject"] = subject
		message.attach(MIMEText(body, "plain"))
		server.sendmail(sender_email, receiver_email, message.as_string())
		print("Sent Mail")
		
	except Exception as e:
		print(e)
	finally:
		server.quit()
	

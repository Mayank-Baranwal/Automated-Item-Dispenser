"""The first step is to create an SMTP object, each object is used for connection 
with one server."""

import smtplib
server = smtplib.SMTP('smtp.gmail.com', 587)
server.connect("smtp.gmail.com",587)
server.ehlo()
server.starttls()
server.ehlo()

#Next, log in to the server
server.login("group5cs321@gmail.com", "mbucmbuc")

#Send the mail
msg = "Inventory Low" # The /n separates the message from the headers
server.sendmail("group5cs321@gmail.com", "krtk.anurima123@gmail.com", msg)

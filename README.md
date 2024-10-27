# wordpress-jetpack-broken-access-control-vulnerable-application

This is a vulnerable application to test the exploit for the **Jetpack** broken access control.

## WARNING!

**This application contains serious security vulnerabilities. Run it at your own risk! It is recommended using a backed-up and sheltered environment (such as a VM with a recent snapshot and host-only networking). Do not upload this application to any Internet facing servers, as they will be compromised.**

***DISCLAIMER*: I do not take responsibility for the way in which any one uses this application. The only purpose of this application is to be a test scenario for the Jetpack broken access control exploit and it should not be used maliciously. If your server is compromised via an installation of this application it is not my responsibility, it is the responsibility of the person(s) who uploaded and installed it.**

## Vulnerability info

* **Link**: [https://jetpack.com/blog/jetpack-13-9-1-critical-security-update/](https://jetpack.com/blog/jetpack-13-9-1-critical-security-update/)
* **Description**: This vulnerability could be used by any logged in users on a site to read forms submitted by visitors on the site.
* **Fix:** [https://github.com/Automattic/jetpack-production/commit/18605ae8cdc7438c2088336c51f3db8d6a5b90fd](https://github.com/Automattic/jetpack-production/commit/18605ae8cdc7438c2088336c51f3db8d6a5b90fd)

## Usage

Here the steps to **setup** the environment:
1. Launch `./up.sh` to start composition.
2. Complete the installation of WordPress here: [http://localhost:1337/wp-admin/install.php](http://localhost:1337/wp-admin/install.php).
3. Login into WordPress.
4. Go to "*Tools*" > "*Network Setup*" ([http://localhost:1337/wp-admin/network.php](http://localhost:1337/wp-admin/network.php)) and complete manually the multisite configuration (accessing to the running container).
   * It should be sufficient to complete the step #1: network configuration rules for `wp-config.php`.
5. Go to "*Plugins*": [http://localhost:1337/wp-admin/plugins.php](http://localhost:1337/wp-admin/plugins.php).
6. Click on "*Activate*" under the "*Jetpack*" plugin. **DO NOT UPDATE IT**, since we need the vulnerable version.
7. Go to "*Jetpack*" > "*Settings*" > "*Writing*" and, in the "*Composing*" section, enable "*Jetpack Blocks give you the power to deliver quality content that hooks website visitors without needing to hire a developer or learn a single line of code.*".
8. Create a new page in WordPress adding a "*Contact Form*" element.

The container will be called `vuln-wp-jetpack`.

To **teardown** the environment use `./down.sh` command or `./down_and_delete.sh` command to also remove images and the volume of the database.

## Root cause

Having a look at the [fix](https://github.com/Automattic/jetpack-production/commit/18605ae8cdc7438c2088336c51f3db8d6a5b90fd), it's trivial to understand that the only check performed, by both `get_items_permissions_check()` and `get_item_permissions_check()` methods, is the membership of the user to the blog.

Both methods are declared in the `Contact_Form_Endpoint` class of the `automattic/jetpack-forms/src/contact-form/class-contact-form-endpoint.php` file. As the comment at the beginning of the class says, this class is...
> Used as `rest_controller_class` parameter when `feedback` post type is registered in `\Automattic\Jetpack\Forms\ContactForm\Contact_Form`

This can be seen in the `automattic/jetpack-forms/src/contact-form/class-contact-form-plugin.php` file at line 201, where the `feedback` custom post type is registered.

The available types can be retrieved via REST APIs with a request like the following.

```
GET /?rest_route=/wp/v2/types
```

The response contains the `feedback` type.

## Exploit

To exploit the vulnerability, a request like the following is sufficient.

```
GET /?rest_route=/wp/v2/feedback
```

The request must contains cookies of a logged user of the blog.

## Authors

* **Antonio Francesco Sardella** - *implementation* - [m3ssap0](https://github.com/m3ssap0)

## License

This project is licensed under the Unlicense - see the **LICENSE** file for details.

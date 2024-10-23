# wordpress-jetpack-info-disclosure-vulnerable-application

This is a vulnerable application to test the exploit for the **Jetpack** information disclosure.

## WARNING!

**This application contains serious security vulnerabilities. Run it at your own risk! It is recommended using a backed-up and sheltered environment (such as a VM with a recent snapshot and host-only networking). Do not upload this application to any Internet facing servers, as they will be compromised.**

***DISCLAIMER*: I do not take responsibility for the way in which any one uses this application. The only purpose of this application is to be a test scenario for the Jetpack information disclosure exploit and it should not be used maliciously. If your server is compromised via an installation of this application it is not my responsibility, it is the responsibility of the person(s) who uploaded and installed it.**

## Vulnerability info

* **Link**: [https://jetpack.com/blog/jetpack-13-9-1-critical-security-update/](https://jetpack.com/blog/jetpack-13-9-1-critical-security-update/)
* **Description**: This vulnerability could be used by any logged in users on a site to read forms submitted by visitors on the site.
* **Fix:** [https://github.com/Automattic/jetpack-production/commit/18605ae8cdc7438c2088336c51f3db8d6a5b90fd](https://github.com/Automattic/jetpack-production/commit/18605ae8cdc7438c2088336c51f3db8d6a5b90fd)

## Usage

Here the steps to **setup** the environment:
1. Launch `./up.sh` to start composition.
2. Complete the installation of WordPress here: [http://localhost:1337/wp-admin/install.php](http://localhost:1337/wp-admin/install.php).
3. Login into WordPress.
4. Go to "*Plugins*": [http://localhost:1337/wp-admin/plugins.php](http://localhost:1337/wp-admin/plugins.php).
5. Click on "*Activate*" under the "*Jetpack*" plugin. **DO NOT UPDATE IT**, since we need the vulnerable version.
6. Go to "*Jetpack*" > "*Settings*" > "*Writing*" and, in the "*Composing*" section, enable "*Jetpack Blocks give you the power to deliver quality content that hooks website visitors without needing to hire a developer or learn a single line of code.*".
7. Create a new page in WordPress adding the "*Contact Form*".

The container will be called `vuln-wp-jetpack`.

To **teardown** the environment use `./down.sh` command or `./down_and_delete.sh` command to also remove images and the volume of the database.

## Root cause

TODO

## Exploit

TODO

## Authors

* **Antonio Francesco Sardella** - *implementation* - [m3ssap0](https://github.com/m3ssap0)

## License

This project is licensed under the Unlicense - see the **LICENSE** file for details.

From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: suspend-to-mem broken by eed4d47efe95 (ACPI / sleep: Ignore spurious
 SCI wakeups from suspend-to-idle)
Date: Mon, 5 Jun 2017 11:05:21 +0200
Message-ID: <20170605090521.GA1912@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rafael,

unfortunately, commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI
wakeups from suspend-to-idle) breaks suspend-to-mem on my Dell XPS 13
(9343) up to v4.12-rc4: Issuing

	$ echo "mem" > /sys/power/state

in the initramfs returns, after a while, with "write error: Resource
busy", and the system *not* having entered the sleep state in between.

In contrast thereto, 8a537ece3d94 (PM / wakeup: Integrate mechanism to abort
transitions in progress) still works fine, and allows to enter
suspend-to-mem. No real difference is to be seen in dmesg, with the notable
exception of

	ACPI: Low-level resume complete
	ACPI : EC: EC started
	PM: Restoring platform NVS memory
	Suspended for N.NNNN seconds

only showing up on working kernels. Reverting eed4d47efe95 on top of
v4.12-rc4 restores suspend-to-mem to work as expected.

Best,
	Dominik

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAlk1Hs4ACgkQmpdgiUyN
ow0XlA/8DCh6scNIL+LHx+s0L2JrrvOi34aeGp5mXJAuDE8ZJw1JiOKnp0L/O8TQ
kkxT9Rq0Rg4TmHmcYkfmIjqiLMo+IRo9F4jQmOMQ8uAON75QZnPSjO+lwgwqTL5X
/USfuMNSm+xDae8fSeKnbiZp3vnbEKM5IDBnwgUH0hw0Rh4/LFlbIz+nQgx6DTVz
8dA8KdHeSKgJsEMNFwFy30u/fK0S3JQK6S4Fk2c8jnUsbYes1b1VChJNgmTqzP/i
yL/O7K9ZZQoawQnObPzq4ByKzPwCkGALSc6BN02IfUHKYu/1F0F1YYGAXmS/y/v3
FeQSgn/Xgqrni9ykNFV+ljnzGQfenkoCWwRQ7T/D7UeR3T/JEYMagULJPw1o/Cgn
JyV9+RyJBhybUzmQXl+z4w3EFGgHYsGMuq5/+8vx+CBTPrltEIL95UYiVpM0wLJW
wMlmUrqiqpbqMJ+Us7DGW2NbEq0shYhD16bT+BloWhzKVT+DlxmHwQ69cldg/6e0
D2NHUkivtyZ1f0BsUWIixXP4k7RBvU3M9IfiP6QFpnF80O1x3kTT7/XntaytEH4G
DLZ9pn0VUzwsI+nXAa2c5whKfSJWtIsZj8Y8FSpysoKhhcX3PUhoFq6sAbCZ9y7v
f9II962HXJ12oxWYPDBcoyGC+XqyPcDZ2VK+DBrpdIQr6tM7450=
=aho9
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

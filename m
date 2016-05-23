From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: let SPI masters ignore their children for PM
Date: Mon, 23 May 2016 14:10:29 +0100
Message-ID: <20160523131029.GU8206@sirena.org.uk>
References: <1460375463-15557-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZPNwnhDHDVD3=Mm0iYqCavH0Oemu7qZ4bRM3AfWbH38A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B0+HW0pjZ+2jqF7e"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZPNwnhDHDVD3=Mm0iYqCavH0Oemu7qZ4bRM3AfWbH38A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--B0+HW0pjZ+2jqF7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2016 at 02:56:29PM +0200, Linus Walleij wrote:

> Mark did this slip through the cracks or is there some
> problem with it?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

> The corresponding patch to I2C is applied in commit
> 04f59143b571 "i2c: let I2C masters ignore their children for PM"
>=20
> Tell me if I should resend it.

It's in my git...

--B0+HW0pjZ+2jqF7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQwFEAAoJECTWi3JdVIfQbjgH/0+7OHOfdxqPJ0AAoBQ6at4o
o+qzjLN++kRmlEaxWaoGMTltSvnhuVY7zZkYhBwS5DrVVM63safr2EB3YIVpaWzw
G5EqUAkGB3Jsvbe+anbtDCWa5iB/NIjqezsQO6ObfQ93u0jI1j9WkHvB421Cu8Oi
+wtoaqG7IY31lUZXjWpVWiDwEP9ppjrDkM5a0JfOfOl59Fc67ydFOsa/QX9uGM9w
vXfW1Jrd9Bmcw+fKnOS2dpPCDuB+aAVGPpu6rCqsJX4qenzjCzh0EelcddwPaSf+
Bcc8l0m7YKsnEZh0+Cr1vZwe75RyLcvXRYruw/+xmDHbmCIAzkNtfWsPPeIB4Z8=
=wv5b
-----END PGP SIGNATURE-----

--B0+HW0pjZ+2jqF7e--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

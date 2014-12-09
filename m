From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Tue, 9 Dec 2014 16:17:17 +0000
Message-ID: <20141209161717.GL1934@sirena.org.uk>
References: <2091649.zj2SIBdzpD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2091649.zj2SIBdzpD-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 06, 2014 at 03:30:23AM +0100, Rafael J. Wysocki wrote:

> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> PM_SLEEP is selected) which is only in linux-next at the moment (via the
> linux-pm tree).

> Please let me know if it is OK to take this one into linux-pm.

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

if you fix the subject line to resemble the style for the subsystem
(spi: ) - using normal subject line styles really helps spot relevant
mails in the inbox.

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhyCMAAoJECTWi3JdVIfQZDAH/jxHEqTaZq0PSH+i6f7lKHTd
VaFYWWOA+kv50Djh9WSr8mXVKMqOPtWFG30RDRPW3aNwVguDmPgkQ5gDLBsVIxAN
GSMkMqe5+dnR7T5O6JkUIg3lEw2DATtifuX4Jv5mJpqcTPdKNPxD5HFiNpHsg3Z+
GkWeAy4taukU5J/fCf+WJOaBySnigOTfHCctD2uqMrLTo6zl9zSpI8tFX7ldRk12
E6zVNCHaexLuKpHQmuwEO3O+sQyIeQyBqpg+U/ya0DU0d6ufK45PmB9+zMmbI2OZ
V3o5atUqSD9vWw3aT6dPgsvub5Jgx0GMS7utBdoIAqevtPWRlyQ2msG1aY44Zlc=
=nKwU
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

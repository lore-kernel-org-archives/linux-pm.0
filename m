From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Revert "thermal: thermal_hwmon: Convert to
 hwmon_device_register_with_info()"
Date: Mon, 23 Jan 2017 21:23:24 +0100
Message-ID: <20170123202324.GA24227@amd>
References: <1485184438-26016-1-git-send-email-festevam@gmail.com>
 <20170123171036.GB23924@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54207 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdAWUdF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2017 15:33:05 -0500
Content-Disposition: inline
In-Reply-To: <20170123171036.GB23924@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Fabio Estevam <festevam@gmail.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-01-23 09:10:36, Guenter Roeck wrote:
> On Mon, Jan 23, 2017 at 01:13:58PM -0200, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> >=20
> > This reverts commit 7611fb68062f8d7f416f3272894d1edf7bbff29c.
> >=20
> > Pavel Machek reported breakage in the Nokia N900 due to this commit.
> >=20
> > We can revisit a proper fix for the warning later.
> >=20
> > Reported-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliGZjwACgkQMOfwapXb+vJaQQCgk2HuXuOQugRyYv9wZOPf98cB
AG4AoJmqlQh0Yo1cK9z8A+AHDlLKaRnz
=oU2v
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

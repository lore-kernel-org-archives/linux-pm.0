From: Sebastian Reichel <sre@kernel.org>
Subject: Re: bq24735 charger and ac-detect
Date: Wed, 14 Dec 2016 15:25:02 +0100
Message-ID: <20161214142502.su4auesnlqmgxspv@earth>
References: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ggqwgrkzdfj5p7ar"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756131AbcLNOZP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Dec 2016 09:25:15 -0500
Content-Disposition: inline
In-Reply-To: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-pm@vger.kernel.org, Darbha Sriharsha <dsriharsha@nvidia.com>


--ggqwgrkzdfj5p7ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Dec 12, 2016 at 12:12:47AM +0100, Peter Rosin wrote:
> Hi!
>=20
> I'm wondering about the dt bindings for the bq24735 charger. Specifically
> the ac-detect property. The bindings say:

I don't have a device with bq24735 and the driver has been added
before I was the maintainer of the power-supply subsystem.

>  - ti,ac-detect-gpios : This GPIO is optionally used to read the AC adapt=
er
>    presence. This is a Host GPIO that is configured as an input and
>    connected to the bq24735.
>=20
> The only way I can make sense of that is if this is the pin on the bq24735
> that is named ACOK.

Yes. I would expect the same.

> But that pin is active high, and the code has this:
>=20
> static bool bq24735_charger_is_present(struct bq24735 *charger)
> {
> 	if (charger->status_gpio)
> 		return !gpiod_get_value_cansleep(charger->status_gpio);
> ...
>=20
>=20
> (status_gpio is what holds the gpio_desc of ac-detect)
>=20
> In other words, the code seems to want a signal that is effectively
> active low (the code negates the signal and thus returns "present"
> when the signal is zero). The existing dts users all have active high
> in their bindings, so it's not like they say active low to work around
> the negation in the code...
>=20
> This just makes no sense to me and I'm wondering what I'm missing and
> what pin is really meant to be fed to ac-detect???
>=20
> Yes, there is a pin on the bq24735 that is named ACDET which seems like
> a good match, but that is a signal that is entering the bq24735. And it
> is also active high, at least the way I read it so the problem persists...
>=20
> Cheers,
> Peter

As far as I can see all current users are Tegra boards and the
driver is also from Nvidia, so let's ask them directly. I guess
the driver was ported incorrectly and the "!" should be removed.

-- Sebastian

--ggqwgrkzdfj5p7ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRVjsACgkQ2O7X88g7
+pqHFhAApUtFp5YmflObP3tGdBlxH70HGLqO0WgjF+5KW7Q+vsrTgBQfRA7efLPK
D0/BQFV8y1t6vnzyRp0aadH0p1dm/DZ5hKksSSucOVEPMMRj/NSMFaVG2CI+LiSg
BKFS9jVPwHNs5XiEbGE3GDWLUN0yoynoPRbFGwzPvwFWE01QoLZmLrTHFT/H1sNl
euVdP+0GLxIxtfJfKXaVSYUaelzrN4jGT0hsQUov13wiGtRmmI2FHJo3T20uhgCZ
bjfBgzdQQcBSRt1EsPct863tkGovxo0o66mli+MHvJM2iIpwpf+NrkGv7iV1XFeX
Dm1aVWCJ8Is9vNbis3C3G59rVN4aoOMIK7q9uXA3sk2OCsrNXfHwI3GVyl2Lecsl
qkTc58O1uVO96mk70f9gzuKkpYtuTr2mSKMtwCGwDDfXG6NfS0TrOiJKcJk9ilrE
YBqdjRycDQnqnuzG5/DEZqyVf+B9tFbE4jn/xcqBh02GG/cbD43svku7EhgIcOTj
6yyODAqIIM2FA3z8TaXKyojETIBKsGzawRYa0gkdJGv9ac1oQ+KMaMxjhGc41qab
kq7M1YII0f9td7IBNctWmf9VspoXjHbfzRumXfCoCB4KaPRgNM/4XP3xaJo1/Lzg
82fJrfdPnVIAR2VKE8NdYSnEtYLE7wBWGeT4bGPhQaI2CiG1uxQ=
=qebr
-----END PGP SIGNATURE-----

--ggqwgrkzdfj5p7ar--

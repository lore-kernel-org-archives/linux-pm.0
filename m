From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] dev_pm_qos: Improve sysfs pm_qos_latency_tolerance
 validation
Date: Mon, 5 Dec 2016 12:19:24 +0100
Message-ID: <20161205111924.GA9148@amd>
References: <cover.1480468027.git.luto@kernel.org>
 <9f642daf2787251258336c4ce93b1d3090afd590.1480468027.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41895 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbcLELT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2016 06:19:27 -0500
Content-Disposition: inline
In-Reply-To: <9f642daf2787251258336c4ce93b1d3090afd590.1480468027.git.luto@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2016-11-29 17:11:50, Andy Lutomirski wrote:
> Negative values are special.  Don't let users write them directly.
>=20
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -263,7 +263,11 @@ static ssize_t pm_qos_latency_tolerance_store(struct=
 device *dev,
>  	s32 value;
>  	int ret;
> =20
> -	if (kstrtos32(buf, 0, &value)) {
> +	if (kstrtos32(buf, 0, &value) =3D=3D 0) {
> +		/* Users can't write negative values directly */
> +		if (value < 0)
> +			return -EINVAL;
> +	} else {
>  		if (!strcmp(buf, "auto") || !strcmp(buf, "auto\n"))
>  			value =3D PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
>  		else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhFTTwACgkQMOfwapXb+vIO/wCfS4VH7lD/60hkUkzSCSn3jwxT
WLcAoIlzXm5KgGZy0WFsTP7sC7F8Z628
=QRy+
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sysfs: return -EINVAL for bogus strings
Date: Mon, 10 Jul 2017 09:29:35 +0200
Message-ID: <20170710072935.GA12630@amd>
References: <20170710072140.chms22ep35myvvbd@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170710072140.chms22ep35myvvbd@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-07-10 10:21:40, Dan Carpenter wrote:
> In the current code, if the user accidentally writes a bogus command to
> this sysfs file, then we set the latency tolerance to an uninitialized
> variable.
>=20
> Fixes: 2d984ad132a8 ("PM / QoS: Introcuce latency tolerance device PM QoS=
 type")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

I'd suggest this is a stable candidate. It only leaks 32 bits to
userspace, but still...

> @@ -272,6 +272,8 @@ static ssize_t pm_qos_latency_tolerance_store(struct =
device *dev,
>  			value =3D PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
>  		else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))
>  			value =3D PM_QOS_LATENCY_ANY;
> +		else
> +			return -EINVAL;
>  	}
>  	ret =3D dev_pm_qos_update_user_latency_tolerance(dev, value);
>  	return ret < 0 ? ret : n;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlljLN8ACgkQMOfwapXb+vIDRgCgw/OQW3KtyB2ywui/QvMJLGtt
ReYAnjqpSZ2/Ep8BgwBCJP4JP1cGVUWa
=SLSS
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

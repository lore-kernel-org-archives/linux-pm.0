From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: mxs: implement runtime pm
Date: Sun, 30 Apr 2017 21:55:38 +0900
Message-ID: <20170430125538.cps4dsud47tvlcal@sirena.org.uk>
References: <20170426201028.19217-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j5uwz677cwed62xx"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170426201028.19217-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--j5uwz677cwed62xx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 10:10:28PM +0200, Uwe Kleine-K=F6nig wrote:

> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(ssp->dev);
> +	if (ret < 0) {
> +		dev_err(ssp->dev, "Failed to runtime resume for transfer\n");
> +		return ret;
> +	}

There's a flag auto_runtime_pm the driver can set which should do what
you're doing here in the core (with the very slight advantage that it'll
hold the device on while the queue is busy so we don't bounce the power
in the event that there's transactions queued up).

Otherwise this looks good to me.

--j5uwz677cwed62xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkF3soACgkQJNaLcl1U
h9C3NggAgDv6H/wHNoogMxFVPyUxeAeQNWCx5X7qdTIdtFE7h3eiL91VJj22eqsm
X4XpQ/YoZkMWkcxM8mLP+atnJGYLq4USNvPjPXtAKU4P9sbVFXP07aRlcsi073Uc
MC+RoJpvUQmeSdBRCd29DOdTFdOfxw+KM3VlDsia3vxWcsh8GqvZ8kYa8VWj9dB6
zLmfUGc7Z2i2GeHvsIYEFg9K2Sb5LvOM3EKuECsPl6stM0iVlgEPnFYO7Mn7EqS6
GBSR2lhgwtySQ/+u1HIM7lr+3gqUbuGTkFtbP4wbh+eldC4BuIlBq3Z9HX4pFgW1
Y0eZfFnEoX+GfftrKnCgjoIoMq5V6Q==
=4Y9d
-----END PGP SIGNATURE-----

--j5uwz677cwed62xx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

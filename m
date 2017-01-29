From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 09/25] iio: adc: axp20x_adc: map acin_i and acin_v
Date: Sun, 29 Jan 2017 17:31:29 +0100
Message-ID: <20170129163129.znc563s2prgmwuf2@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-10-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7713042558611372678=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-10-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============7713042558611372678==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uuavyfprcv5dqexw"
Content-Disposition: inline


--uuavyfprcv5dqexw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 27, 2017 at 09:54:42AM +0100, Quentin Schulz wrote:
> This maps the IIO channels acin_i and acin_v (respectively exposing the
> current current and voltage measures of the AC power supply) to the AC
> power supply driver.
>=20
> Only the AXP20X PMICs have these ADC channels and thus they are only
> mapped for this version of the PMIC.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>=20
> added in v2
>=20
>  drivers/iio/adc/axp20x_adc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index bacde92..14f4ec0 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -104,6 +104,14 @@ static struct iio_map axp20x_maps[] =3D {
>  		.consumer_dev_name =3D "axp20x-usb-power-supply",
>  		.consumer_channel =3D "vbus_i",
>  		.adc_channel_label =3D "vbus_i",
> +	}, {
> +		.consumer_dev_name =3D "axp20x-ac-power-supply",
> +		.consumer_channel =3D "acin_v",
> +		.adc_channel_label =3D "acin_v",
> +	}, {
> +		.consumer_dev_name =3D "axp20x-ac-power-supply",
> +		.consumer_channel =3D "acin_i",
> +		.adc_channel_label =3D "acin_i",
>  	}, { /* sentinel */ }
>  };

I suggest to merge this into Patch 4 before resending the series.

-- Sebastian

--uuavyfprcv5dqexw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOGOAACgkQ2O7X88g7
+pr4AQ/9FmZ5xB/2bgIzPOsDf4/K4rkCMIec6Wc9M/wrRjBFFfe8eBR6TFBpKhSi
l1ciLjEZ1iNJ9Lqvq/juoebLpOp8lACKHiQYyilgnhIOVyh9j7WKiP4Owy76b+qh
BeCPx4uIfR/9en2t0BXbusF8zmzlD6158W/lN2xTE+ot8lqTmAVmTvbpEqWV40Q/
dqaoPtV1Iq6VioxIzW4TIQNC1c3TI2aIM8oYf5lM/Sr+g1FxuSQIgwyrxCgwqpbh
EWDjHdj6OwuYk+5ptixVrNLPZ+mL6YEZ32UzpNhxrQuU4EhCl/XTPizfTP+MX0Qv
dQRJQ/3jXuoE95iZPRBZ+nLQ6fe9+eQwrN+9J7JVyzeSNk66cNmDVrJ+H4sFl/hR
6LfPi1xRIkVHUljyjN35l7E9rTUCDpmGhwfEFqEuS70tEInMdzuexETeDsToCGZ9
X7ey+F6hawsOguu96FXZ+2UXY12HOoGjfNprgJTo05I/KIJZ/ZahyiH7+OSx6daI
tGSx3pD3N6R6tJGOtrkt03ZlyQIvKa98/oDUDTzuVSY6SITYUFAW8RulwTsI7HZ/
ARc5MWz/n1spB36wRn2OLQoT6h4+OIjrGCipYHuTgTnZmhILZILPvGbPVgzM+Ixc
FuBDmFx3TZKdxQGuuMtWj9GORr7kGJh/N8ddlQ2WyRcHQI7bYHE=
=mLHT
-----END PGP SIGNATURE-----

--uuavyfprcv5dqexw--


--===============7713042558611372678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7713042558611372678==--

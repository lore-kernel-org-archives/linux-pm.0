From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 06/12] power: supply: account for const type of
 of_device_id.data
Date: Tue, 9 Jan 2018 17:22:24 +0100
Message-ID: <20180109162224.g6pw37qrzkjzx3ax@earth.universe>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-7-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yt25y5mx5ughqgal"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514899688-27844-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--yt25y5mx5ughqgal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 02, 2018 at 02:28:02PM +0100, Julia Lawall wrote:
> This driver creates two const structures that it stores in the data
> field of an of_device_id array.
>=20
> The data field of an of_device_id structure has type const void *, so
> there is no need for a const-discarding cast when putting const values
> into such a structure.
>=20
> Furthermore, adding const to the declaration of the location that
> receives a const value from such a field ensures that the compiler
> will continue to check that the value is not modified.  The
> const-discarding cast on the extraction from the data field is thus
> no longer needed.
>=20
> Done using Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp20x_ac_power.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff -u -p a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/suppl=
y/axp20x_ac_power.c
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -159,7 +159,7 @@ static int axp20x_ac_power_probe(struct
>  	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
>  	struct power_supply_config psy_cfg =3D {};
>  	struct axp20x_ac_power *power;
> -	struct axp_data *axp_data;
> +	const struct axp_data *axp_data;
>  	static const char * const irq_names[] =3D { "ACIN_PLUGIN", "ACIN_REMOVA=
L",
>  		NULL };
>  	int i, irq, ret;
> @@ -176,7 +176,7 @@ static int axp20x_ac_power_probe(struct
>  	if (!power)
>  		return -ENOMEM;
> =20
> -	axp_data =3D (struct axp_data *)of_device_get_match_data(&pdev->dev);
> +	axp_data =3D of_device_get_match_data(&pdev->dev);
> =20
>  	if (axp_data->acin_adc) {
>  		power->acin_v =3D devm_iio_channel_get(&pdev->dev, "acin_v");
> @@ -230,10 +230,10 @@ static int axp20x_ac_power_probe(struct
>  static const struct of_device_id axp20x_ac_power_match[] =3D {
>  	{
>  		.compatible =3D "x-powers,axp202-ac-power-supply",
> -		.data =3D (void *)&axp20x_data,
> +		.data =3D &axp20x_data,
>  	}, {
>  		.compatible =3D "x-powers,axp221-ac-power-supply",
> -		.data =3D (void *)&axp22x_data,
> +		.data =3D &axp22x_data,
>  	}, { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
>=20

--yt25y5mx5ughqgal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpU7D8ACgkQ2O7X88g7
+pqpOw/9ET2Vvi2UoM0hzMPFNolvhS61gO04izGH1BI+KesGDEdk1ZRdErNsBvHm
hrhTuZWPAcMUiAPMEJjrSZsOPaQx8LDyDE98QrvGdtntKJM/scVjrTTojxCYBvv2
9XLNRVjduuaBWoGoAeTWNTEbd04FI8TFqNIGc9qAIATIUY87qMZPVH5QxniQEcN9
T/pQfYkEsilrJ/k22T82SpyWPkxR6ioJkHLqLyZ/Yj4tleeV4f93ivP+tP+HtP6z
AAKuGx3TNqOmmypNuxzug6Cj36ZgG0JfTNOGRyOXFGEpPN7COZbRL+xb8hEhDCz8
D80CZ331+VXZd5+r0w5winqgekZqp5QT5551yLNNR9Jug+vmekIamhONVKECpT4B
OiyY2HT9jlQUNXIhNuRE9NCebz/hOsaiwllShmCuHo5REPk4P66znnwcZM9xL5xP
ru+YHdhYhtVdyWaK1tJe2LWt5+IgNSUxYFgBa8+9tls0VvSIDbwTTZa4r9oNuGDg
FORPW3fDxmQI6M0Np1tlvUSp2Roz8YJmiTn0JUz7TQM53lKtx3oev05BUNIHWOND
rUkmRkSyluIycb1TIgkbuiDdAU0oKwEoutjYuzSFbtEqvPTKHSvy8bMKinUWlZlu
Okk/H4bLeMj9t63NNwo5WI8BxItVtpCDLZbqS4LyKGclpf0u5BU=
=MDRc
-----END PGP SIGNATURE-----

--yt25y5mx5ughqgal--

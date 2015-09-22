From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 05/11] power: bq24257: Add SW-based approach for Power
 Good determination
Date: Tue, 22 Sep 2015 21:37:20 +0200
Message-ID: <20150922193719.GD9949@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-6-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45739 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933773AbbIVThb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 15:37:31 -0400
Content-Disposition: inline
In-Reply-To: <1442612399-341-6-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 18, 2015 at 04:39:53PM -0500, Andreas Dannenberg wrote:
> A software-based approach for determining the charger's input voltage
> "Power Good" state is introduced for devices like the bq24250 which
> don't have a dedicated hardware pin for that purpose. This SW-based
> approach is also used for other devices (with dedicated PG pin) as a
> fall back solution if that pin is not configured to be used through
> "pg-gpios".
>=20
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  drivers/power/bq24257_charger.c | 49 +++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 43 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_char=
ger.c
> index 502dd8a5..135cfd4 100644
> --- a/drivers/power/bq24257_charger.c
> +++ b/drivers/power/bq24257_charger.c
> @@ -107,6 +107,7 @@ struct bq24257_device {
>  	struct mutex lock; /* protect state data */
> =20
>  	bool iilimit_autoset_enable;
> +	bool pg_gpio_disable;

I don't think this is required.

>  };
> =20
>  static bool bq24257_is_volatile_reg(struct device *dev, unsigned int reg)
> @@ -360,7 +361,26 @@ static int bq24257_get_chip_state(struct bq24257_dev=
ice *bq,
> =20
>  	state->fault =3D ret;
> =20
> -	state->power_good =3D !gpiod_get_value_cansleep(bq->pg);
> +	if (bq->pg_gpio_disable)
> +		/*
> +		 * If we have a chip without a dedicated power-good GPIO or
> +		 * some other explicit bit that would provide this information
> +		 * assume the power is good if there is no supply related
> +		 * fault - and not good otherwise. There is a possibility for
> +		 * other errors to mask that power in fact is not good but this
> +		 * is probably the best we can do here.
> +		 */
> +		switch (state->fault) {
> +		case FAULT_INPUT_OVP:
> +		case FAULT_INPUT_UVLO:
> +		case FAULT_INPUT_LDO_LOW:
> +			state->power_good =3D false;
> +			break;
> +		default:
> +			state->power_good =3D true;
> +		}
> +	else
> +		state->power_good =3D !gpiod_get_value_cansleep(bq->pg);

I guess you can just handle this like an optional gpio

if(bq->pg)
    state->power_good =3D !gpiod_get_value_cansleep(bq->pg);
else
    ...

> =20
>  	return 0;
>  }
> @@ -680,7 +700,7 @@ static int bq24257_pg_gpio_probe(struct bq24257_devic=
e *bq)
>  {
>  	bq->pg =3D devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0, GPIOD_IN);
>  	if (IS_ERR(bq->pg)) {
> -		dev_err(bq->dev, "could not probe PG pin\n");
> +		dev_info(bq->dev, "could not probe PG pin\n");
>  		return PTR_ERR(bq->pg);
>  	}
> =20
> @@ -814,10 +834,27 @@ static int bq24257_probe(struct i2c_client *client,
>  		INIT_DELAYED_WORK(&bq->iilimit_setup_work,
>  				  bq24257_iilimit_setup_work);
> =20
> -	/* we can only check Power Good status by probing the PG pin */
> -	ret =3D bq24257_pg_gpio_probe(bq);
> -	if (ret < 0)
> -		return ret;
> +	/*
> +	 * The BQ24250 doesn't have a dedicated Power Good (PG) pin so we
> +	 * explicitly disable this feature for this device and instead use
> +	 * a SW-based approach to determine the PG state.
> +	 */
> +	if (bq->chip =3D=3D BQ24250)
> +		bq->pg_gpio_disable =3D true;
> +
> +	/*
> +	 * For devices that do have a dedicated PG pin go ahead and probe it,
> +	 * using the SW-based approach as a fall back solution. Note that the
> +	 * use of the dedicated pin is preferred.
> +	 */
> +	if (!bq->pg_gpio_disable) {
> +		ret =3D bq24257_pg_gpio_probe(bq);
> +		if (ret < 0) {
> +			dev_info(bq->dev,
> +				 "using SW-based power-good detection\n");
> +			bq->pg_gpio_disable =3D true;
> +		}
> +	}
> =20
>  	/* reset all registers to defaults */
>  	ret =3D bq24257_field_write(bq, F_RESET, 1);

-- Sebastian

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAa3vAAoJENju1/PIO/qaY9cP/RzSB9IKYjECpXQlLKbuWQDV
N5klZf8ZbcvKfoHqMR3acD1FvJIqrFlPHSZlgXehMV9EMBkIIwM8+NBBCJNFsYEJ
zwBg1s3wwhPcNRtD/L45JXkksuSw4glKBYo1ZDqVCFMD9YNy11PHXfRyNyXuYplm
znid4t4dbtjt+g4LcfXf8G0t8/KvzjQ4wFzHhvgyZQBK1983HlBS+jJYC3fK7P+M
zC15AKQHtMqWQQztZ7VKAaNgzo6Qixase8T/gNI1ZjP9OJz6LSb9SZ2fDfVkWhAb
3T1+QNDo1CN3YuKDUsvS76L6NtQ87Omn7wIeJU6MdvVzi1D/XZswk5n09hhB+HqK
t2cJY5dGo5LR16xnFsYTJ2ZT4jKKrY7bemgOqS/Iq6OAOiukicFTdpxFVAHlyb1h
Ey/wtL3aEVgi6iiwqozKmg3lCNuC4xF/BiVeT2SM5O9cT7bEE8ln6Sx88l4y/e07
tKaXF+IS3dHA12C4UmmmrWFUVy58oM7iRt30JrLXMj/NXnxv1L+HuS//MhYmMDfs
EHFzHDVq1fXUeODGe/QEUVVk+Vsld8LF2dj7Uzwi2Bwt9Q+HSgOeFiTtBc2SH8ey
ZLxNtxv2dFHa4iv7g0vxZ+TrzqRoIU8WY09ba8lKbqqpx8Nu3u52ZVQ6LUPgE6vN
2QPBWgssUEi9VnzUpuix
=hQ0Y
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--

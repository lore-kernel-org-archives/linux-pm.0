From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 5/7] thermal: rcar_gen3_thermal: enable hardware
 interrupts for trip points
Date: Mon, 20 Mar 2017 21:25:50 +0100
Message-ID: <20170320202550.GC1587@katana>
References: <20170317155300.21566-1-niklas.soderlund+renesas@ragnatech.se>
 <20170317155300.21566-6-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317155300.21566-6-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Fri, Mar 17, 2017 at 04:52:58PM +0100, Niklas S=C3=B6derlund wrote:
> Enable hardware trip points by implementing the set_trips callback. The
> thermal core will take care of setting the initial trip point window and
> to update it once the driver reports a TSC has moved outside it.
>=20
> The interrupt structure for this device is a bit odd. There is not a
> dedicated IRQ for each TSC, instead the interrupts are shared between
> all TSCs. IRQn is fired if the temp monitored in IRQTEMPn is reached in
> any of the TSCs, example IRQ3 is fired if temperature in IRQTEMP3 is
> reached in either TSC0, TSC1 or TSC2.
>=20
> For this reason the usage of interrupts in this driver is an all-on or
> all-off design. When an interrupt happens all TSCs are checked and all
> thermal zones are updated. This could be refined to be more fine grained
> but the thermal core takes care of only updating the thermal zones that
> have left their trip point window.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Looks mostly good, thanks!

=2E..

>  static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops =3D {
>  	.get_temp	=3D rcar_gen3_thermal_get_temp,
> +	.set_trips	=3D rcar_gen3_thermal_set_trips,
>  };
> =20
> +static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, in=
t on)

'bool' instead of 'int'?

> +{
> +	unsigned int i;
> +	u32 val;
> +
> +	val =3D on ? IRQ_TEMPD1 | IRQ_TEMP2 : 0;

Very minor, merge the 2 lines?

	u32 val =3D on ? IRQ_TEMPD1 | IRQ_TEMP2 : 0;


> +
> +	for (i =3D 0; i < priv->num_tscs; i++)
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, val);
> +}
> +
> +static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
> +{
> +	struct rcar_gen3_thermal_priv *priv =3D data;
> +	unsigned long flags;
> +	u32 status;
> +	int i, ret =3D IRQ_HANDLED;
> +
> +	spin_lock_irqsave(&priv->lock, flags);

Why _irqsave? You are in interrupt context already.

> +	for (i =3D 0; i < priv->num_tscs; i++) {
> +		status =3D rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
> +		if (status)
> +			ret =3D IRQ_WAKE_THREAD;
> +	}
> +
> +	if (ret =3D=3D IRQ_WAKE_THREAD)
> +		rcar_thermal_irq_set(priv, 0);

'false' instead of '0'? I think this is more readable.

> +	spin_unlock_irqrestore(&priv->lock, flags);

Add a blank line before unlock?

> +
> +	return ret;
> +}
> +
> +static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
> +{
> +	struct rcar_gen3_thermal_priv *priv =3D data;
> +	unsigned long flags;
> +	int i;
> +
> +	for (i =3D 0; i < priv->num_tscs; i++)
> +		thermal_zone_device_update(priv->tscs[i]->zone,
> +					   THERMAL_EVENT_UNSPECIFIED);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	rcar_thermal_irq_set(priv, 1);

'true' instead of '1'?

> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +

=2E..

> @@ -252,7 +351,8 @@ static int rcar_gen3_thermal_probe(struct platform_de=
vice *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct resource *res;
>  	struct thermal_zone_device *zone;
> -	int ret, i;
> +	int ret, irq, i;
> +	char *irqname;
>  	const struct rcar_gen3_thermal_data *match_data =3D
>  		of_device_get_match_data(dev);
> =20
> @@ -269,8 +369,27 @@ static int rcar_gen3_thermal_probe(struct platform_d=
evice *pdev)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> +	spin_lock_init(&priv->lock);
> +
>  	platform_set_drvdata(pdev, priv);
> =20
> +	for (i =3D 0; i < 2; i++) {

Maybe a comment saying that the driver works with two interrupts
currently, so the '2' gets explained?

> +		irq =3D platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		irqname =3D devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
> +					 dev_name(dev), i);
> +		if (!irqname)
> +			return -ENOMEM;
> +
> +		ret =3D devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
> +						rcar_gen3_thermal_irq_thread,
> +						IRQF_SHARED, irqname, priv);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
> =20
> @@ -307,6 +426,12 @@ static int rcar_gen3_thermal_probe(struct platform_d=
evice *pdev)
>  		}
>  		tsc->zone =3D zone;
>  		priv->num_tscs++;
> +
> +		ret =3D of_thermal_get_ntrips(tsc->zone);
> +		if (ret < 0)
> +			goto error_unregister;
> +
> +		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
>  	}
> =20
>  	if (!priv->num_tscs) {
> @@ -314,6 +439,8 @@ static int rcar_gen3_thermal_probe(struct platform_de=
vice *pdev)
>  		goto error_unregister;
>  	}
> =20
> +	rcar_thermal_irq_set(priv, 1)

'true' instead of '1' again?

> +

Kind regards,

   Wolfram


--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY0DrOAAoJEBQN5MwUoCm2W6UQAJdS8RUdUIXpvx/IvofmnDE/
hsIaVFS0yPSBc6Gb4YIExBTZZyNh73CW8GYOWPu7f7b4CWbefGsPaqYlBd8eDcWY
d9NT+np+aQHmrtXlHAXMGeaXz6Rr3TBJY6duFn16ByjCOHy0MGkAzN7zOjwuwCp0
QlLFibv88h0PTeoBsyeTIIbxRdMn8tUBmfgFeapPW3ZIMfktxySDpzS44bVwY+Ab
hWlkJDKfxe6zMDSWDZZ1shzE23OCTTKPtq2w21OE0iUwasbq9aSYMMv+GooiE05E
3fa1qQOQswZjue+sq7pGL1kUUaXTWz+p5IVhGHxvIERrzs6FvNQck7xOM2yGT6dR
BeikjYPKLT6pKlZKUVSRXQCsXwaBubJWsOnvyj3TnzTQp7aMPwyRajkoT2IsVBwd
MAPmc47fupBF+4a6No+d8wjFM0P1VxtDNdKRBt6/Tf+Y7WtSFNY0BnNMl96z94JH
7hEt7BKCrf1Ttf+h9ZmZlhzSY6Go/lQ956fsGxKRWNin+4vrpl16qdsnSM6elpAZ
37ZBeD3QfAc+7fxTFkdyOraETWp9QprjBf2UXvXWnw3QSdq0/UwlVK7zeq3UcIQt
Fiyn834Csp3xrkoe1EDczvq3Gsy52FnHr/okwacNuShmtjuyx37e52uXAy4nD40f
4DAEsKjx7c1KLAjSoVAu
=EeyS
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--

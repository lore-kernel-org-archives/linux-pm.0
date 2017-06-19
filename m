From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v7 04/10] i2c: i2c-smbus: add of_i2c_setup_smbus_alert
Date: Mon, 19 Jun 2017 17:27:44 +0200
Message-ID: <20170619152744.4gtlyrwdhjbhy562@ninjato>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-5-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sg3igiwhncn6se2f"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1497535178-12001-5-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--sg3igiwhncn6se2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 09:59:32PM +0800, Phil Reid wrote:
> This commit adds of_i2c_setup_smbus_alert which allows the smbalert
> driver to be attached to an i2c adapter via the device tree.
>=20
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

CCing Benjamin

> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt |  4 ++--
>  drivers/i2c/i2c-smbus.c                       | 34 +++++++++++++++++++++=
+++---
>  include/linux/i2c-smbus.h                     |  9 +++++++
>  3 files changed, 42 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentatio=
n/devicetree/bindings/i2c/i2c.txt
> index cee9d50..1126398 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
> @@ -59,8 +59,8 @@ wants to support one of the below features, it should a=
dapt the bindings below.
>  	interrupts used by the device.
> =20
>  - interrupt-names
> -	"irq" and "wakeup" names are recognized by I2C core, other names are
> -	left to individual drivers.
> +	"irq", "wakeup" and "smbus_alert" names are recognized by I2C core,
> +	other names are	left to individual drivers.
> =20
>  - host-notify
>  	device uses SMBus host notify protocol instead of interrupt line.
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index d4af270..0ad7f7f 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_irq.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> =20
> @@ -131,7 +132,7 @@ static int smbalert_probe(struct i2c_client *ara,
>  {
>  	struct i2c_smbus_alert_setup *setup =3D dev_get_platdata(&ara->dev);
>  	struct i2c_smbus_alert *alert;
> -	struct i2c_adapter *adapter =3D ara->adapter;
> +	struct i2c_adapter *adap =3D ara->adapter;
>  	int res, irq;
> =20
>  	alert =3D devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
> @@ -139,7 +140,14 @@ static int smbalert_probe(struct i2c_client *ara,
>  	if (!alert)
>  		return -ENOMEM;
> =20
> -	irq =3D setup->irq;
> +	if (setup) {
> +		irq =3D setup->irq;
> +	} else {
> +		irq =3D of_irq_get_byname(adap->dev.of_node, "smbus_alert");
> +		if (irq <=3D 0)
> +			return irq;
> +	}
> +
>  	INIT_WORK(&alert->alert, smbalert_work);
>  	alert->ara =3D ara;
> =20
> @@ -153,7 +161,7 @@ static int smbalert_probe(struct i2c_client *ara,
>  	}
> =20
>  	i2c_set_clientdata(ara, alert);
> -	dev_info(&adapter->dev, "supports SMBALERT#\n");
> +	dev_info(&adap->dev, "supports SMBALERT#\n");
> =20
>  	return 0;
>  }
> @@ -214,6 +222,26 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_=
adapter *adapter,
>  }
>  EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
> =20
> +int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
> +{
> +	struct i2c_client *client;
> +	int irq;
> +
> +	irq =3D of_property_match_string(adap->dev.of_node, "interrupt-names",
> +				       "smbus_alert");
> +	if (irq =3D=3D -EINVAL || irq =3D=3D -ENODATA)
> +		return 0;
> +	else if (irq < 0)
> +		return irq;
> +
> +	client =3D i2c_setup_smbus_alert(adap, NULL);
> +	if (!client)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
> +
>  /**
>   * i2c_handle_smbus_alert - Handle an SMBus alert
>   * @ara: the ARA client on the relevant adapter
> diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
> index 19efbd1..b5261c1 100644
> --- a/include/linux/i2c-smbus.h
> +++ b/include/linux/i2c-smbus.h
> @@ -49,4 +49,13 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_ad=
apter *adapter,
>  					 struct i2c_smbus_alert_setup *setup);
>  int i2c_handle_smbus_alert(struct i2c_client *ara);
> =20
> +#if IS_ENABLED(CONFIG_I2C_SMBUS)
> +int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
> +#else
> +static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_I2C_SMBUS_H */
> --=20
> 1.8.3.1
>=20

--sg3igiwhncn6se2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH7XAACgkQFA3kzBSg
KbZh7Q//bKXPeqfEQOmkErIzU4f+GpW5CdRA/F7oUeaRWrZyubYBX5jxk13iGqAN
edcafYoo4yKwEAmP3GstMO7khhWaDFPfHhuHJdrPZDA2aWHxY1yLFHFrBatAFPvN
9jmDtYD3Np7AX+svYrrdw4P9IY9j6ZnC62NkwTMw7y1XDnNQVup5ycYykLXM6jAw
RPBj4u+livjhx67OdY2DyO72G7XmR4afp0ST7AkpDpgbp5bTUNXFNNGFnnLAqYVd
C7zCQYn6qMMzImoQr1uxGV8hIXHdtDWWic7nVkfrJ37xYm6c1l/mOSUXY3GC7VSI
SokAx4pbh2q37FoAo+AJbQ4A6LHHYoVA2iuTmLn+wIEg1p/ArKiR/vJSFXAGZOYI
qttwWxhiwuF9N/C6UX9qXC1r5TntSD+xhPJJENKafD5/emow9hXAXJKgT43WwUns
jdA2UBLdJ1+8+vB1W1e+zl1gUuqL2JeG/ugb+TfrJzO+cO/NWVlw5y9dt+cK9wKb
UtlGjBHGlzAJjAh1vHy7pxVyi1KdsSMIVepHxeIzeUuq4RHnZvrsjsnvXsSITMWb
wef1NbLh5Y9FdP8/ostxbTDs1PkZmO4nneHjlA300uGlrzuTCT6FOM+65XhtUL7N
pvi0GLDjmRvp1togzMZWBPBBYzfGC/nGN30/GLowoMJ4Z/32Z3w=
=UtCa
-----END PGP SIGNATURE-----

--sg3igiwhncn6se2f--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

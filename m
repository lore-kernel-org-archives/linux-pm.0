From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v5 9/9] power: supply: sbs-manager: Add alert callback
 and battery change notification
Date: Mon, 1 May 2017 15:50:33 +0200
Message-ID: <20170501135033.vwx6ibwxj2hfyhtl@earth>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
 <1493628599-30552-10-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gsxw4z3epynttkgo"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493628599-30552-10-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--gsxw4z3epynttkgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 01, 2017 at 04:49:59PM +0800, Phil Reid wrote:
> This adds smb alert support via the smbus_alert driver to generate
> power_supply_changed notifications when either external power is
> removed / applied or a battery inserted / removed.
> Use the i2c alert callback to notify the attached battery driver that a
> change has occurred.
>
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> ---
>  drivers/power/supply/Kconfig       |   1 +
>  drivers/power/supply/sbs-manager.c | 129 +++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 127 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 8aa5324..a25359c 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -536,6 +536,7 @@ config AXP20X_POWER
>  config MANAGER_SBS
>  	tristate "Smart Battery System Manager"
>  	depends on I2C && I2C_MUX
> +	select I2C_SMBUS

I guess we also need to depend on GPIO stuff?

>  	help
>  	  Say Y here to include support for Smart Battery System Manager
>  	  ICs. The driver reports online and charging status via sysfs.
> diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sb=
s-manager.c
> index adf9e41..d7f7a92 100644
> --- a/drivers/power/supply/sbs-manager.c
> +++ b/drivers/power/supply/sbs-manager.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
> +#include <linux/gpio.h>
>  #include <linux/power_supply.h>
> =20
>  #define SBSM_MAX_BATS  4
> @@ -30,14 +31,22 @@
>  #define SBSM_CMD_BATSYSINFO      0x04
>  #define SBSM_CMD_LTC             0x3c
> =20
> +#define SBSM_BIT_AC_PRESENT      BIT(0)
> +
>  struct sbsm_data {
>  	struct i2c_client *client;
>  	struct i2c_mux_core *muxc;
> =20
>  	struct power_supply *psy;
> =20
> +	struct gpio_chip chip;
> +
>  	int cur_chan;         /* currently selected channel */
>  	bool is_ltc1760;      /* special capabilities */
> +
> +	unsigned int supported_bats;
> +	unsigned int last_state;
> +	unsigned int last_state_cont;
>  };
> =20
>  static enum power_supply_property sbsm_props[] =3D {
> @@ -184,6 +193,116 @@ static int sbsm_select(struct i2c_mux_core *muxc, u=
32 chan)
>  	return ret;
>  }
> =20
> +static int sbsm_gpio_get_value(struct gpio_chip *gc, unsigned off)
> +{
> +	struct sbsm_data *data =3D gpiochip_get_data(gc);
> +	int ret;
> +
> +	ret =3D sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret & BIT(off);
> +}
> +
> +/*
> + * This needs to be defined or the GPIO lib fails to register the pin.
> + * But the 'gpio' is always an input.
> + */
> +static int sbsm_gpio_direction_input(struct gpio_chip *gc, unsigned off)
> +{
> +	return 0;
> +}
> +
> +static int sbsm_do_alert(struct device *dev, void *d)
> +{
> +	struct i2c_client *client =3D i2c_verify_client(dev);
> +	struct i2c_driver *driver;
> +
> +	if (!client || client->addr !=3D 0x0b)
> +		return 0;
> +
> +	device_lock(dev);
> +	if (client->dev.driver) {
> +		driver =3D to_i2c_driver(client->dev.driver);
> +		if (driver->alert)
> +			driver->alert(client, I2C_PROTOCOL_SMBUS_ALERT, 0);
> +		else
> +			dev_warn(&client->dev, "no driver alert()!\n");
> +	} else
> +		dev_dbg(&client->dev, "alert with no driver\n");
> +	device_unlock(dev);
> +
> +	return -EBUSY;
> +}
> +
> +static void sbsm_alert(struct i2c_client *client, enum i2c_alert_protoco=
l prot,
> +		       unsigned int d)
> +{
> +	struct sbsm_data *sbsm =3D i2c_get_clientdata(client);
> +
> +	int ret, i, irq_bat =3D 0;
> +
> +	ret =3D sbsm_read_word(sbsm->client, SBSM_CMD_BATSYSSTATE);
> +	if (ret >=3D 0)
> +		irq_bat =3D ret ^ sbsm->last_state;
> +	sbsm->last_state =3D ret;
> +
> +	ret =3D sbsm_read_word(sbsm->client, SBSM_CMD_BATSYSSTATECONT);
> +	if ((ret >=3D 0) &&
> +	    ((ret ^ sbsm->last_state_cont) & SBSM_BIT_AC_PRESENT)) {
> +		irq_bat |=3D sbsm->supported_bats;
> +		power_supply_changed(sbsm->psy);
> +	}
> +	sbsm->last_state_cont =3D ret;
> +
> +	for (i =3D 0; i < SBSM_MAX_BATS; i++) {
> +		if (irq_bat & BIT(i)) {
> +			device_for_each_child(&sbsm->muxc->adapter[i]->dev,
> +					      NULL, sbsm_do_alert);
> +		}
> +	}
> +}
> +
> +static int sbsm_gpio_setup(struct sbsm_data *data)
> +{
> +	struct gpio_chip *gc =3D &data->chip;
> +	struct i2c_client *client =3D data->client;
> +	struct device *dev =3D &client->dev;
> +	struct device_node *of_node =3D client->dev.of_node;
> +	int ret;
> +
> +	if (!of_get_property(of_node, "gpio-controller", NULL))
> +		return 0;

#include <linux/property.h>

if (!device_property_present(dev, "gpio-controller"))
    return 0;

(and remove of_node from this function)

> +	ret  =3D sbsm_read_word(client, SBSM_CMD_BATSYSSTATE);
> +	if (ret < 0)
> +		return ret;
> +	data->last_state =3D ret;
> +
> +	ret  =3D sbsm_read_word(client, SBSM_CMD_BATSYSSTATECONT);
> +	if (ret < 0)
> +		return ret;
> +	data->last_state_cont =3D ret;
> +
> +	gc->get =3D sbsm_gpio_get_value;
> +	gc->direction_input  =3D sbsm_gpio_direction_input;
> +	gc->can_sleep =3D true;
> +	gc->base =3D -1;
> +	gc->ngpio =3D SBSM_MAX_BATS;
> +	gc->label =3D client->name;
> +	gc->parent =3D dev;
> +	gc->owner =3D THIS_MODULE;
> +
> +	ret =3D devm_gpiochip_add_data(dev, gc, data);
> +	if (ret) {
> +		dev_err(dev, "devm_gpiochip_add_data failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  #if defined(CONFIG_OF)
> =20
>  #include <linux/of_device.h>
> @@ -214,7 +333,7 @@ static int sbsm_probe(struct i2c_client *client,
>  	struct device *dev =3D &client->dev;
>  	struct power_supply_desc *psy_desc;
>  	struct power_supply_config psy_cfg =3D {};
> -	int ret =3D 0, i, supported_bats;
> +	int ret =3D 0, i;
> =20
>  	/* Device listens only at address 0x0a */
>  	if (client->addr !=3D 0x0a)
> @@ -235,7 +354,7 @@ static int sbsm_probe(struct i2c_client *client,
>  	ret  =3D sbsm_read_word(client, SBSM_CMD_BATSYSINFO);
>  	if (ret < 0)
>  		return ret;
> -	supported_bats =3D le16_to_cpu(ret) & 0xf;
> +	data->supported_bats =3D le16_to_cpu(ret) & 0xf;
> =20
>  	data->muxc =3D i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
>  				   I2C_MUX_LOCKED, &sbsm_select, NULL);
> @@ -248,7 +367,7 @@ static int sbsm_probe(struct i2c_client *client,
> =20
>  	/* register muxed i2c channels. One for each supported battery */
>  	for (i =3D 0; i < SBSM_MAX_BATS; ++i) {
> -		if ((1 << i) & supported_bats) {
> +		if ((1 << i) & data->supported_bats) {
>  			ret =3D i2c_mux_add_adapter(data->muxc, 0, i + 1, 0);
>  			if (ret) {
>  				dev_err(dev,
> @@ -273,6 +392,9 @@ static int sbsm_probe(struct i2c_client *client,
>  		ret =3D -ENOMEM;
>  		goto err_psy;
>  	}
> +	ret =3D sbsm_gpio_setup(data);
> +	if (ret < 0)
> +		goto err_psy;
> =20
>  	psy_cfg.drv_data =3D data;
>  	data->psy =3D devm_power_supply_register(dev, psy_desc, &psy_cfg);
> @@ -316,6 +438,7 @@ static int sbsm_remove(struct i2c_client *client)
>  	},
>  	.probe		=3D sbsm_probe,
>  	.remove		=3D sbsm_remove,
> +	.alert		=3D sbsm_alert,
>  	.id_table	=3D sbsm_ids
>  };
>  module_i2c_driver(sbsm_driver);

-- Sebastian

--gsxw4z3epynttkgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHPSkACgkQ2O7X88g7
+ppM6w//aLpAcKL5m7+HwVVUv6ohdombqYjQNhLMCENILPsXFPQ56mlJ5+cNzgJH
GVV1QwmKeAFZyBzNITujWghmuryclp6zaMCC2HULt01wAsV+rrqZf1W29i3Tnl/X
yq+m0FtsfrcG5/XKDTw8YCQWeFUGku82dC2FhxvYj1VCNdnmmecv5wmjnFy6LbTa
HYKQxtYS/nl0lK75EVNKLa3DJ7+OUO8DtHTaNn4i7pPUOk+xv8vXybkVGS6IOP+u
MdqVREWL9UVEo5op4Kl3pblZi5d1pn0KNdMBDR33YNXA5QT+JXtQFzho00UszqLv
ZQijZmat+iHFE+35NTpN439BucBcLwsJd78dI8PdPXXNNBWyITaapfZ6Tp4wnnYH
kOZJfZmVGn05qzkto/H357E+dgIrKJASGEI2JmJ6c643I3uMpLJwhj9NDHPNKjgQ
oqk6B+2e1nvZFcTJvj9F7Abd8KWmJPuYiKXrHNPCXZOs/IivQDWGwKLaZGfJx6lb
fCjCVYFwxgYmxbmC5KuyrEvK4C9KVQpk9BHIP/Ej8Z5lF1SeM0W1Iv/Lqp0DUTV/
6uGf66bAN3yrBvGpuVh7UhiAh02F/tLJHDc6CFhTXuPEkTDcbd316dhx9IXhwxq8
NIvfylaSpj3f23jdas27ggn+dXjW2FkhqFFFJ7eGWdC8m1U9C+Y=
=4SF3
-----END PGP SIGNATURE-----

--gsxw4z3epynttkgo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

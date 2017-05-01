From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v5 7/9] power: Adds support for Smart Battery System
 Manager
Date: Mon, 1 May 2017 15:41:36 +0200
Message-ID: <20170501134136.u2tebw77xcirvaqx@earth>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
 <1493628599-30552-8-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cianceuoovy34tmf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493628599-30552-8-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--cianceuoovy34tmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 01, 2017 at 04:49:57PM +0800, Phil Reid wrote:
> From: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
>=20
> This patch adds support for Smart Battery System Manager.
> A SBSM is a device listening at I2C/SMBus address 0x0a and is capable of
> communicating up to four I2C smart battery devices. All smart battery
> devices are listening at address 0x0b, so the SBSM muliplexes between
> them. The driver makes use of the I2C-Mux framework to allow smart
> batteries to be bound via device tree, i.e. the sbs-battery driver.
>=20
> Via sysfs interface the online state and charge type are presented. If
> the driver is bound as ltc1760 (an implementation of a Dual Smart Battery
> System Manager) the charge type can also be changed from trickle to fast.
>=20
> Tested-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> Reviewed-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> Signed-off-by: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> ---
>  drivers/power/supply/Kconfig       |  13 ++
>  drivers/power/supply/Makefile      |   1 +
>  drivers/power/supply/sbs-manager.c | 325 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 339 insertions(+)
>  create mode 100644 drivers/power/supply/sbs-manager.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index da54ac8..8aa5324 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -533,4 +533,17 @@ config AXP20X_POWER
>  	  This driver provides support for the power supply features of
>  	  AXP20x PMIC.
> =20
> +config MANAGER_SBS
> +	tristate "Smart Battery System Manager"
> +	depends on I2C && I2C_MUX
> +	help
> +	  Say Y here to include support for Smart Battery System Manager
> +	  ICs. The driver reports online and charging status via sysfs.
> +	  It presents itself also as I2C mux which allows to bind
> +	  smart battery driver to its ports.
> +	  Supported is for example LTC1760.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called sbs-manager.
> +

Let's move add this directly next to CHARGER_SBS.

>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 3789a2c..4f53c98 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -74,3 +74,4 @@ obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> +obj-$(CONFIG_MANAGER_SBS)	+=3D sbs-manager.o

same here.

> diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sb=
s-manager.c
> new file mode 100644
> index 0000000..adf9e41
> --- /dev/null
> +++ b/drivers/power/supply/sbs-manager.c
> @@ -0,0 +1,325 @@
> +/*
> + * Driver for SBS compliant Smart Battery System Managers
> + *
> + * The device communicates via i2c at address 0x0a and multiplexes acces=
s to up
> + * to four smart batteries at address 0x0b.
> + *
> + * Via sysfs interface the online state and charge type are presented.
> + *
> + * Datasheet SBSM:    http://sbs-forum.org/specs/sbsm100b.pdf
> + * Datasheet LTC1760: http://cds.linear.com/docs/en/datasheet/1760fb.pdf
> + *
> + * Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-mux.h>
> +#include <linux/power_supply.h>
> +
> +#define SBSM_MAX_BATS  4
> +#define SBSM_RETRY_CNT 3
> +
> +/* registers addresses */
> +#define SBSM_CMD_BATSYSSTATE     0x01
> +#define SBSM_CMD_BATSYSSTATECONT 0x02
> +#define SBSM_CMD_BATSYSINFO      0x04
> +#define SBSM_CMD_LTC             0x3c
> +
> +struct sbsm_data {
> +	struct i2c_client *client;
> +	struct i2c_mux_core *muxc;
> +
> +	struct power_supply *psy;
> +
> +	int cur_chan;         /* currently selected channel */

u8?

> +	bool is_ltc1760;      /* special capabilities */
> +};
> +
> +static enum power_supply_property sbsm_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +};
> +
> +static int sbsm_read_word(struct i2c_client *client, u8 address)
> +{
> +	int reg, retries =3D SBSM_RETRY_CNT;
> +
> +	while (retries > 0) {
> +		reg =3D i2c_smbus_read_word_data(client, address);
> +		if (reg >=3D 0)
> +			break;
> +		--retries;
> +	}

for (retries =3D SBSM_RETRY_CNT; retries > 0; retries--)

> +
> +	if (reg < 0) {
> +		dev_err(&client->dev, "failed to read register %i\n",
> +			(int)address);

dev_err(&client->dev, "failed to read register 0x%02x\n", address);

> +		return reg;
> +	}
> +
> +	return le16_to_cpu(reg);

This is already done by i2c_smbus_read_word_data() and doing it
again will result in incorrect values on big endian architectures.

> +}
> +
> +static int sbsm_write_word(struct i2c_client *client, u8 address, u16 wo=
rd)
> +{
> +	int ret, retries =3D SBSM_RETRY_CNT;
> +
> +	word =3D cpu_to_le16(word);

Same as for read_word: This is already done by the i2c-core.

> +	while (retries > 0) {
> +		ret =3D i2c_smbus_write_word_data(client, address, word);
> +		if (ret >=3D 0)
> +			break;
> +		--retries;
> +	}

for (retries =3D SBSM_RETRY_CNT; retries > 0; retries--)

> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to write to register %i\n",
> +			(int)address);

dev_err(&client->dev, "failed to read register 0x%02x\n", address);

> +
> +	return ret;
> +}
> +
> +static int sbsm_get_property(struct power_supply *psy,
> +			     enum power_supply_property psp,
> +			     union power_supply_propval *val)
> +{
> +	struct sbsm_data *data =3D power_supply_get_drvdata(psy);
> +	int regval =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		regval =3D sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATECONT);
> +		if (regval < 0)
> +			return regval;
> +		val->intval =3D !!(regval & 0x1);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		regval =3D sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATE);
> +		if (regval < 0)
> +			return regval;
> +
> +		if ((regval & 0x00f0) =3D=3D 0) {
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +			return 0;
> +		}
> +		val->intval =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +
> +		if (data->is_ltc1760) {
> +			/* charge mode fast if turbo is active */
> +			regval =3D sbsm_read_word(data->client, SBSM_CMD_LTC);
> +			if (regval < 0)
> +				return regval;
> +			else if (regval & 0x80)
> +				val->intval =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		}
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sbsm_prop_is_writeable(struct power_supply *psy,
> +				  enum power_supply_property psp)
> +{
> +	struct sbsm_data *data =3D power_supply_get_drvdata(psy);
> +
> +	return (psp =3D=3D POWER_SUPPLY_PROP_CHARGE_TYPE) && data->is_ltc1760;
> +}
> +
> +static int sbsm_set_property(struct power_supply *psy,
> +			     enum power_supply_property psp,
> +			     const union power_supply_propval *val)
> +{
> +	struct sbsm_data *data =3D power_supply_get_drvdata(psy);
> +	int ret =3D -EINVAL;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		/* write 1 to TURBO if type fast is given */
> +		if (data->is_ltc1760) {
> +			u16 regval =3D val->intval =3D=3D
> +			POWER_SUPPLY_CHARGE_TYPE_FAST ? (0x1 << 7) : 0;
> +			ret =3D sbsm_write_word(data->client, SBSM_CMD_LTC,
> +					      regval);
> +		}

That's not nicely indented. Try doing it this way to
reduce indention:

if (data->is_ltc1760)
    break;
u16 regval =3D ...

> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Switch to battery
> + * Parameter chan is directly the content of SMB_BAT* nibble
> + */
> +static int sbsm_select(struct i2c_mux_core *muxc, u32 chan)
> +{
> +	struct sbsm_data *data =3D i2c_mux_priv(muxc);
> +	int ret =3D 0;
> +	u16 reg;
> +
> +	if (data->cur_chan =3D=3D chan)
> +		return ret;
> +
> +	/* chan goes from 1 ... 4 */
> +	reg =3D 1 << (11 + chan);
> +	ret =3D sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
> +	if (ret)
> +		dev_err(&data->client->dev, "Failed to select channel %i\n",
> +			chan);

Add

struct device *dev =3D &data->client->dev;

at the beginning of the function and use it here to avoid line
break.

> +	else
> +		data->cur_chan =3D chan;
> +
> +	return ret;
> +}
> +
> +#if defined(CONFIG_OF)
> +
> +#include <linux/of_device.h>

Move include to top of file. You can include it unconditionally.

> +static const struct of_device_id sbsm_dt_ids[] =3D {
> +	{ .compatible =3D "sbs,sbs-manager" },
> +	{ .compatible =3D "lltc,ltc1760" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sbsm_dt_ids);

This can go next to the other MODULE_DEVICE_TABLE.

> +#endif
> +
> +static const struct power_supply_desc sbsm_default_psy_desc =3D {
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D sbsm_props,
> +	.num_properties =3D ARRAY_SIZE(sbsm_props),
> +	.get_property =3D &sbsm_get_property,
> +	.set_property =3D &sbsm_set_property,
> +	.property_is_writeable =3D &sbsm_prop_is_writeable,
> +};
> +
> +static int sbsm_probe(struct i2c_client *client,
> +		      const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
> +	struct sbsm_data *data;
> +	struct device *dev =3D &client->dev;
> +	struct power_supply_desc *psy_desc;
> +	struct power_supply_config psy_cfg =3D {};
> +	int ret =3D 0, i, supported_bats;
> +
> +	/* Device listens only at address 0x0a */
> +	if (client->addr !=3D 0x0a)
> +		return -ENODEV;

I guess EINVAL makes more sense?

> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EPFNOSUPPORT;
> +
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +
> +	data->client =3D client;
> +	data->is_ltc1760 =3D !!strstr(id->name, "ltc1760");
> +
> +	ret  =3D sbsm_read_word(client, SBSM_CMD_BATSYSINFO);
> +	if (ret < 0)
> +		return ret;
> +	supported_bats =3D le16_to_cpu(ret) & 0xf;

How often do you want to convert endianess? :)
Drop this.

> +	data->muxc =3D i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
> +				   I2C_MUX_LOCKED, &sbsm_select, NULL);
> +	if (!data->muxc) {
> +		dev_err(dev, "failed to alloc i2c mux\n");
> +		ret =3D -ENOMEM;
> +		goto err_mux_alloc;
> +	}
> +	data->muxc->priv =3D data;
> +
> +	/* register muxed i2c channels. One for each supported battery */
> +	for (i =3D 0; i < SBSM_MAX_BATS; ++i) {
> +		if ((1 << i) & supported_bats) {

This can be written more readable as

if (supported_bats & BIT(i))

> +			ret =3D i2c_mux_add_adapter(data->muxc, 0, i + 1, 0);
> +			if (ret) {
> +				dev_err(dev,
> +					"failed to register i2c mux channel %d\n",
> +					i + 1);
> +				goto err_mux_register;
> +			}
> +		}
> +	}
> +
> +	psy_desc =3D devm_kmemdup(dev, &sbsm_default_psy_desc,
> +				sizeof(struct power_supply_desc),
> +				GFP_KERNEL);
> +	if (!psy_desc) {
> +		ret =3D -ENOMEM;
> +		goto err_psy;
> +	}
> +
> +	psy_desc->name =3D devm_kasprintf(dev, GFP_KERNEL, "sbsm-%s",
> +					dev_name(&client->dev));
> +	if (!psy_desc->name) {
> +		ret =3D -ENOMEM;
> +		goto err_psy;
> +	}
> +
> +	psy_cfg.drv_data =3D data;

Please add:

psy_cfg->of_node =3D dev->of_node;

> +	data->psy =3D devm_power_supply_register(dev, psy_desc, &psy_cfg);
> +	if (IS_ERR(data->psy)) {
> +		ret =3D PTR_ERR(data->psy);
> +		dev_err(dev, "failed to register power supply %s\n",
> +			psy_desc->name);
> +		goto err_psy;
> +	}
> +
> +	dev_info(dev, "sbsm registered\n");
> +	return 0;
> +
> +err_psy:
> +err_mux_register:
> +	i2c_mux_del_adapters(data->muxc);
> +
> +err_mux_alloc:
> +	return ret;
> +}
> +
> +static int sbsm_remove(struct i2c_client *client)
> +{
> +	struct sbsm_data *data =3D i2c_get_clientdata(client);
> +
> +	i2c_mux_del_adapters(data->muxc);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id sbsm_ids[] =3D {
> +	{ "sbs-manager", 0 },
> +	{ "ltc1760",     0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sbsm_ids);
> +
> +static struct i2c_driver sbsm_driver =3D {
> +	.driver =3D {
> +		.name =3D "sbsm",
> +		.owner =3D THIS_MODULE,

Please drop .owner assignment. It will be done by i2c-core.
But you should add the following:

=2Eof_match_table =3D of_match_ptr(sbsm_dt_ids),

> +	},
> +	.probe		=3D sbsm_probe,
> +	.remove		=3D sbsm_remove,
> +	.id_table	=3D sbsm_ids
> +};
> +module_i2c_driver(sbsm_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>");
> +MODULE_DESCRIPTION("SBSM Smart Battery System Manager");

-- Sebastian

--cianceuoovy34tmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHOw0ACgkQ2O7X88g7
+ppDpA/8CxnRVYdDAoWW3ckPk95tKonB2rgoRmZp3X5zFU6ktxFKjZWG+a/Nb0CS
VwyM9jO9U8FoXTFsrqtmN+BiMu1FAc0+ODODzex99HQApR8/bhlTsm6AO45Ow9FF
RkDOhxU5cFjw1ZKvKiQ17FGMPYQ9KVju2y7hrX4NmtOx2Pl70dW5X0VgarPw44OU
Pf1rquLLV9YTxf3smnbFg1ZM2hU8+nNwutliJv2rFZvOb19GyM4JHuGHiiobH+eq
vrMPfZsGoOygwOUbE5Hj3CG3+RFmnPpliKGWJsmkpbANc7TylWbfjwTswFqUvTZe
zVrV1wlXNUEdCWYsSfuX9WxRPia7MQE98oZ4PPgabi5wwIoGLXx7avxjapITy7IZ
XMsbE1CAyjExcrhef8mwWMmBuueB6RVRC/cffAUluHx5sOzbeqSzPDtrIqANW9oO
Ia8gauM1jkW/FkG7Yks52KQLAJkl4ohjHvt8bz715iUynMs0DuYmYpY2L4VTXqtM
xm3H9KibvP+PDwPTD/Rh0oGIwK4RQLIIgocJOBgxQffM4AYWLeUMGFXLDPvhzHtZ
5m/U41fqQaDAwbEQa/n2mjT5ksIOCWinVWM6bJNV9kKDAFxRreGAnzFtFzjqN1Go
M5aVxKLZ4bgXfZCPdnMl1BY8XYfg9MeLebQmSzd3tBM0sbvDtM4=
=utoX
-----END PGP SIGNATURE-----

--cianceuoovy34tmf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

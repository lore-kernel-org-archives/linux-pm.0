From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v6 7/8] power: Adds support for Smart Battery System
 Manager
Date: Thu, 4 May 2017 17:18:19 +0200
Message-ID: <20170504151819.suycktllzsnuj4nf@earth>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
 <1493716346-58517-8-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xp3jzfrqptlub7oq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37146 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbdEDPSY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 11:18:24 -0400
Content-Disposition: inline
In-Reply-To: <1493716346-58517-8-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>


--xp3jzfrqptlub7oq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

I spotted a few more small issues.

On Tue, May 02, 2017 at 05:12:25PM +0800, Phil Reid wrote:
> From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
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
> Tested-by: Phil Reid <preid@electromag.com.au>
> Reviewed-by: Phil Reid <preid@electromag.com.au>
> Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/power/supply/Kconfig       |  13 ++
>  drivers/power/supply/Makefile      |   1 +
>  drivers/power/supply/sbs-manager.c | 317 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 331 insertions(+)
>  create mode 100644 drivers/power/supply/sbs-manager.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index da54ac8..a435415 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -170,6 +170,19 @@ config CHARGER_SBS
>          help
>  	  Say Y to include support for SBS compilant battery chargers.
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
>  config BATTERY_BQ27XXX
>  	tristate "BQ27xxx battery driver"
>  	help
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 3789a2c..350c0bb 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_batter=
y.o
>  obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
>  obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
>  obj-$(CONFIG_CHARGER_SBS)	+=3D sbs-charger.o
> +obj-$(CONFIG_MANAGER_SBS)	+=3D sbs-manager.o
>  obj-$(CONFIG_BATTERY_BQ27XXX)	+=3D bq27xxx_battery.o
>  obj-$(CONFIG_BATTERY_BQ27XXX_I2C) +=3D bq27xxx_battery_i2c.o
>  obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
> diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sb=
s-manager.c
> new file mode 100644
> index 0000000..8842f6e
> --- /dev/null
> +++ b/drivers/power/supply/sbs-manager.c
> @@ -0,0 +1,317 @@
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
> + * Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-mux.h>
> +#include <linux/of_device.h>

I think you do not need of_device.h.

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
> +	u8 cur_chan;          /* currently selected channel */
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
> +	int reg, retries;
> +
> +	for (retries =3D SBSM_RETRY_CNT; retries > 0; retries--) {
> +		reg =3D i2c_smbus_read_word_data(client, address);
> +		if (reg >=3D 0)
> +			break;
> +	}
> +
> +	if (reg < 0) {
> +		dev_err(&client->dev, "failed to read register 0x%02x\n",
> +			address);
> +	}
> +
> +	return reg;
> +}
> +
> +static int sbsm_write_word(struct i2c_client *client, u8 address, u16 wo=
rd)
> +{
> +	int ret, retries;
> +
> +	for (retries =3D SBSM_RETRY_CNT; retries > 0; retries--) {
> +		ret =3D i2c_smbus_write_word_data(client, address, word);
> +		if (ret >=3D 0)
> +			break;
> +	}
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to write to register 0x%02x\n",
> +			address);
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

Please add a define for 0x1 and use BIT(0).

> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		regval =3D sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATE);
> +		if (regval < 0)
> +			return regval;
> +
> +		if ((regval & 0x00f0) =3D=3D 0) {

Please add a define for 0x00f0.

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

Please add a define for 0x80 and use BIT(7).

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
> +	u16 regval;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		/* write 1 to TURBO if type fast is given */
> +		if (!data->is_ltc1760)
> +			break;
> +		regval =3D val->intval =3D=3D
> +			 POWER_SUPPLY_CHARGE_TYPE_FAST ? (0x1 << 7) : 0;

Use the same define here. Also is it ok to reset the other bits
to 0?

> +		ret =3D sbsm_write_word(data->client, SBSM_CMD_LTC, regval);
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
> +	struct device *dev =3D &data->client->dev;
> +	int ret =3D 0;
> +	u16 reg;
> +
> +	if (data->cur_chan =3D=3D chan)
> +		return ret;
> +
> +	/* chan goes from 1 ... 4 */
> +	reg =3D 1 << (11 + chan);

use BIT macro and add define for 11.

> +	ret =3D sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
> +	if (ret)
> +		dev_err(dev, "Failed to select channel %i\n", chan);
> +	else
> +		data->cur_chan =3D chan;
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id sbsm_dt_ids[] =3D {
> +	{ .compatible =3D "sbs,sbs-manager" },
> +	{ .compatible =3D "lltc,ltc1760" },
> +	{ }
> +};

No need to have this here, so move it down next to the i2c
device id table.

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
> +		return -EINVAL;
> +
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
> +	supported_bats =3D ret & 0xf;

Let's also have a define for this 0xf.

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
> +		if (supported_bats & BIT(i)) {
> +			ret =3D i2c_mux_add_adapter(data->muxc, 0, i + 1, 0);
> +			if (ret) {
> +				dev_err(dev,
> +					"failed to register i2c mux channel %d\n",
> +					i + 1);
> +				goto err_mux_register;
> +			}

how about

if (ret)
    break;

and then after the for loop

if (ret) {
    dev_err(dev, ...);
    goto err_mux_register;
}

that way the dev_err should fit into one line.

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
> +	psy_cfg.of_node =3D dev->of_node;
> +	data->psy =3D devm_power_supply_register(dev, psy_desc, &psy_cfg);
> +	if (IS_ERR(data->psy)) {
> +		ret =3D PTR_ERR(data->psy);
> +		dev_err(dev, "failed to register power supply %s\n",
> +			psy_desc->name);
> +		goto err_psy;
> +	}
> +
> +	dev_info(dev, "sbsm registered\n");

No need to spam boot log. Drop or use dev_dbg.

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
> +MODULE_DEVICE_TABLE(of, sbsm_dt_ids);

You can put MODULE_DEVICE_TABLE(of, sbsm_dt_ids) together
with the actual table inside of #ifdef CONFIG_OF to save
some bytes on architectures not using device tree.

> +static struct i2c_driver sbsm_driver =3D {
> +	.driver =3D {
> +		.name =3D "sbsm",
> +		.of_match_table =3D of_match_ptr(sbsm_dt_ids),
> +	},
> +	.probe		=3D sbsm_probe,
> +	.remove		=3D sbsm_remove,
> +	.id_table	=3D sbsm_ids
> +};
> +module_i2c_driver(sbsm_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Karl-Heinz Schneider <karl-heinz@schneider-inet.de>");
> +MODULE_DESCRIPTION("SBSM Smart Battery System Manager");

-- Sebastian

--xp3jzfrqptlub7oq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkLRjgACgkQ2O7X88g7
+prnBA/+OHHJKcTDlsLGzeiH/py3mdHrD99C+ZXgtjWVo9lIRw+lpQB+brO6MFwW
zjI/hj+1lGYRpdY/13uBz9+6XY9OI+S3bOvI+FCqeQ30g1vqzEcVOHM/TDuKi6cF
eJyHVE4yoiI2PwkPevnfcF1JXwHQ9+/O5Av/98OEwRfNZh4FFaE/K6cGy71jdXf0
PLgJhHEG1Y1xRHULjOFY6nbC6H9Oe57y5ifdagAOqr6Y6308eStkqb3JsoVSMmOm
P+Y6TOaddS62RrqYuAErJV0mRm12tEDPwoqDtdBoh2XyvbRPB237OOYEDMdpWsJM
mmFkrEIoBQRi7r0/eIOsk/5H8u+GynyA7RZIB0L6xgQkemueoxpYVYNYgcu0hvtr
FFGvb9MSOLNQf+HMFWcJqK5drm36yk/fY3DjZxkhJokH5XWp25Nvvmx1sCJ2erbN
3sWmdhVaUMKS415zPPFBLsCEdJrfJKMOGZpz+oDxXSPw321STNbhtNIL0B/36lPp
YcBFhT2jV2gz8d64xrpORgMlJ6gSllHujqv5dUTOoAnXFB5cseS7xtKU+TsDK+s0
wpn6UtMZByxSnRbB6cSJ6Bb3tvI6gsRoNDB48XJP0u8Tv9tjinL5f3VJUapPJmSc
YIe8ZGJGYK0oWvcwg7xJ6allOsCtG0XSh9k2OyaLltpUFOEw64A=
=HyTx
-----END PGP SIGNATURE-----

--xp3jzfrqptlub7oq--

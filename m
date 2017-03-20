From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 10/15] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Mon, 20 Mar 2017 05:52:21 +0100
Message-ID: <20170320045221.j25we3brb3mtloss@earth>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <20170317095527.10487-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pqqyszwiwknurfqv"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317095527.10487-11-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pqqyszwiwknurfqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 17, 2017 at 10:55:22AM +0100, Hans de Goede wrote:
> Add support for monitoring an extcon device with SDP/CDP/DCP and HOST
> cables and adjust ilimit and enable/disable the 5v boost converter
> accordingly. This is necessary on systems where the PSEL pin is hardwired
> high and ILIM needs to be set by software based on the detected charger
> type.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> ---
>  drivers/power/supply/Kconfig           |  1 +
>  drivers/power/supply/bq24190_charger.c | 85 ++++++++++++++++++++++++++++=
++++++
>  include/linux/power/bq24190_charger.h  |  1 +
>  3 files changed, 87 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f8b6e64..fd93110 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -442,6 +442,7 @@ config CHARGER_BQ2415X
>  config CHARGER_BQ24190
>  	tristate "TI BQ24190 battery charger driver"
>  	depends on I2C
> +	depends on EXTCON
>  	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y to enable support for the TI BQ24190 battery charger.
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 82cb33d..03990e2 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -11,10 +11,12 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/extcon.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/power_supply.h>
> +#include <linux/workqueue.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
> =20
> @@ -39,6 +41,8 @@
>  #define BQ24190_REG_POC_WDT_RESET_SHIFT		6
>  #define BQ24190_REG_POC_CHG_CONFIG_MASK		(BIT(5) | BIT(4))
>  #define BQ24190_REG_POC_CHG_CONFIG_SHIFT	4
> +#define BQ24190_REG_POC_CHG_CONFIG_CHARGE	1
> +#define BQ24190_REG_POC_CHG_CONFIG_OTG		2
>  #define BQ24190_REG_POC_SYS_MIN_MASK		(BIT(3) | BIT(2) | BIT(1))
>  #define BQ24190_REG_POC_SYS_MIN_SHIFT		1
>  #define BQ24190_REG_POC_BOOST_LIM_MASK		BIT(0)
> @@ -152,6 +156,9 @@ struct bq24190_dev_info {
>  	struct power_supply		*charger;
>  	struct power_supply		*battery;
>  	struct bq24190_platform_data	*pdata;
> +	struct extcon_dev		*extcon;
> +	struct notifier_block		extcon_nb;
> +	struct work_struct		extcon_work;
>  	char				model_name[I2C_NAME_SIZE];
>  	kernel_ulong_t			model;
>  	struct mutex			f_reg_lock;
> @@ -167,6 +174,11 @@ struct bq24190_dev_info {
>   * number at that index in the array is the real-world value that it
>   * represents.
>   */
> +
> +/* REG00[2:0] (IINLIM) in uAh */
> +static const int bq24190_iinlim_values[] =3D {
> +	100000, 150000, 500000, 900000, 1200000, 1500000, 2000000, 3000000 };
> +
>  /* REG02[7:2] (ICHG) in uAh */
>  static const int bq24190_ccc_ichg_values[] =3D {
>  	 512000,  576000,  640000,  704000,  768000,  832000,  896000,  960000,
> @@ -1290,6 +1302,61 @@ static irqreturn_t bq24190_irq_handler_thread(int =
irq, void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void bq24190_extcon_work(struct work_struct *work)
> +{
> +	struct bq24190_dev_info *bdi =3D
> +		container_of(work, struct bq24190_dev_info, extcon_work);
> +	int ret, iinlim =3D 0;
> +
> +	if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_SDP) =3D=3D 1)
> +		iinlim =3D 500000;
> +	else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_CDP) =3D=3D 1 ||
> +		 extcon_get_state(bdi->extcon, EXTCON_CHG_USB_ACA) =3D=3D 1)
> +		iinlim =3D 1500000;
> +	else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_DCP) =3D=3D 1)
> +		iinlim =3D 2000000;
> +
> +	if (iinlim) {
> +		ret =3D bq24190_set_field_val(bdi, BQ24190_REG_ISC,
> +				BQ24190_REG_ISC_IINLIM_MASK,
> +				BQ24190_REG_ISC_IINLIM_SHIFT,
> +				bq24190_iinlim_values,
> +				ARRAY_SIZE(bq24190_iinlim_values),
> +				iinlim);
> +		if (ret)
> +			dev_err(bdi->dev, "Can't set IINLIM: %d\n", ret);
> +	}
> +
> +	/*
> +	 * If no charger has been detected and host mode is requested, activate
> +	 * the 5V boost converter, otherwise deactivate it.
> +	 */
> +	if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) =3D=3D 1)=
 {
> +		ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
> +					 BQ24190_REG_POC_CHG_CONFIG_MASK,
> +					 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
> +					 BQ24190_REG_POC_CHG_CONFIG_OTG);
> +	} else {
> +		ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
> +					 BQ24190_REG_POC_CHG_CONFIG_MASK,
> +					 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
> +					 BQ24190_REG_POC_CHG_CONFIG_CHARGE);
> +	}
> +	if (ret)
> +		dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", ret);
> +}
> +
> +static int bq24190_extcon_event(struct notifier_block *nb, unsigned long=
 event,
> +				void *param)
> +{
> +	struct bq24190_dev_info *bdi =3D
> +		container_of(nb, struct bq24190_dev_info, extcon_nb);
> +
> +	schedule_work(&bdi->extcon_work);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>  {
>  	u8 v;
> @@ -1375,6 +1442,12 @@ static int bq24190_probe(struct i2c_client *client,
>  			return -EPROBE_DEFER;
>  	}
> =20
> +	if (bdi->pdata && bdi->pdata->extcon_name) {
> +		bdi->extcon =3D extcon_get_extcon_dev(bdi->pdata->extcon_name);
> +		if (!bdi->extcon)
> +			return -EPROBE_DEFER;
> +	}
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_resume(dev);
> =20
> @@ -1423,6 +1496,18 @@ static int bq24190_probe(struct i2c_client *client,
>  		goto out4;
>  	}
> =20
> +	if (bdi->extcon) {
> +		INIT_WORK(&bdi->extcon_work, bq24190_extcon_work);
> +		bdi->extcon_nb.notifier_call =3D bq24190_extcon_event;
> +		ret =3D devm_extcon_register_notifier(dev, bdi->extcon, -1,
> +						    &bdi->extcon_nb);
> +		if (ret)
> +			goto out4;
> +
> +		/* Sync initial cable state */
> +		schedule_work(&bdi->extcon_work);
> +	}
> +
>  	return 0;
> =20
>  out4:
> diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/=
bq24190_charger.h
> index 02d248b..909c5b9 100644
> --- a/include/linux/power/bq24190_charger.h
> +++ b/include/linux/power/bq24190_charger.h
> @@ -13,6 +13,7 @@
> =20
>  struct bq24190_platform_data {
>  	bool no_register_reset;
> +	const char *extcon_name;
>  	int (*get_ext_bat_property)(enum power_supply_property prop,
>  				    union power_supply_propval *val);
>  };
> --=20
> 2.9.3
>=20

--pqqyszwiwknurfqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPYAUACgkQ2O7X88g7
+ppmWBAApnBld0Wi/TVmBwXwnn42zIo/UXy41SPGmf6c/g4aRU4i8JLHE0SIQSKz
2yO8BNyJIaYgjyLBZrSybmsiUaba9GYjO7q/AJomrdsCOYnRpppDxlPoWt9kEBD0
PgS1pDYj1ecK5VZNvLZNJA0qxDzkZWCcbl7UvyBrt76cPwk+awK791aWNezOWHXS
V/ggubDJ16Em/6e8m7v1Bja8WcLFWyJGbGyzLMeCwyel8+KqtgeLZkAtP7IQshyA
rRNnVOAWiUwy/QnbZif8/yZMKEiKKCZJYlsUtr/skSwEQwGuvskSDJMikochAx3R
tjgcb1BFAjPg2X9Y53+RMN0M1qUvycxjFIzYp/mZ76iSrDIhpKZY7inVR5DTvItB
QHFyyB3Lp8dEf2VsilAEidMx4qDeea9igl0I2lZ/jYvHhMh9eY6hst/dbd2oPq8r
rH4c3QvMP1LLdaU3YvuPnWWf8xSgD2ZnYJc0n2ascpVdf7Wkw8vyvhtEzhyl1ETp
ooeOao7VhrBQ03vDnmuk4nWDh2VTZBpn5dImHklqneE1lPOW1CJ3g5FaqOvyxp4l
RzGIeMfw+nMGyHODyiUr74hD7Fen5y8C1HILqWzQ9XJ/M+xPGyar9ZkLO9AZnRaQ
W5CXUKNcqDtx6adAg7KG1lLLRZ2BM65LDrehHffEav281LZ4Z/I=
=fBdQ
-----END PGP SIGNATURE-----

--pqqyszwiwknurfqv--

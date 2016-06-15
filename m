From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v11 4/4] power: wm831x_power: Support USB charger
 current limit management
Date: Wed, 15 Jun 2016 10:38:09 +0100
Message-ID: <20160615093809.GC4948@dell>
References: <cover.1465807514.git.baolin.wang@linaro.org>
 <1fbd873e23a904f9857b80c2404391744fa5aabc.1465807514.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1fbd873e23a904f9857b80c2404391744fa5aabc.1465807514.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh@kernel.org, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Jun 2016, Baolin Wang wrote:

> Integrate with the newly added USB charger interface to limit the cur=
rent
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from =
high
> current inputs without drawing more current than specified from other=
s.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Acked-by: Peter Chen <peter.chen@freescale.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/power/wm831x_power.c     |   69 ++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/wm831x/pdata.h |    3 ++

=46or the MFD change:
  Acked-by: Lee Jones <lee.jones@linaro.org>
 =20
>  2 files changed, 72 insertions(+)
>=20
> diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_powe=
r.c
> index 7082301..cef1812 100644
> --- a/drivers/power/wm831x_power.c
> +++ b/drivers/power/wm831x_power.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> +#include <linux/usb/charger.h>
> =20
>  #include <linux/mfd/wm831x/core.h>
>  #include <linux/mfd/wm831x/auxadc.h>
> @@ -31,6 +32,8 @@ struct wm831x_power {
>  	char usb_name[20];
>  	char battery_name[20];
>  	bool have_battery;
> +	struct usb_charger *usb_charger;
> +	struct notifier_block usb_notify;
>  };
> =20
>  static int wm831x_power_check_online(struct wm831x *wm831x, int supp=
ly,
> @@ -125,6 +128,43 @@ static enum power_supply_property wm831x_usb_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
> =20
> +/* In milliamps */
> +static const unsigned int wm831x_usb_limits[] =3D {
> +	0,
> +	2,
> +	100,
> +	500,
> +	900,
> +	1500,
> +	1800,
> +	550,
> +};
> +
> +static int wm831x_usb_limit_change(struct notifier_block *nb,
> +				   unsigned long limit, void *data)
> +{
> +	struct wm831x_power *wm831x_power =3D container_of(nb,
> +							 struct wm831x_power,
> +							 usb_notify);
> +	unsigned int i, best;
> +
> +	/* Find the highest supported limit */
> +	best =3D 0;
> +	for (i =3D 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
> +		if (limit >=3D wm831x_usb_limits[i] &&
> +		    wm831x_usb_limits[best] < wm831x_usb_limits[i])
> +			best =3D i;
> +	}
> +
> +	dev_dbg(wm831x_power->wm831x->dev,
> +		"Limiting USB current to %umA", wm831x_usb_limits[best]);
> +
> +	wm831x_set_bits(wm831x_power->wm831x, WM831X_POWER_STATE,
> +		        WM831X_USB_ILIM_MASK, best);
> +
> +	return 0;
> +}
> +
>  /*******************************************************************=
**
>   *		Battery properties
>   *******************************************************************=
**/
> @@ -607,8 +647,31 @@ static int wm831x_power_probe(struct platform_de=
vice *pdev)
>  		}
>  	}
> =20
> +	if (wm831x_pdata && wm831x_pdata->usb_gadget) {
> +		power->usb_charger =3D
> +			usb_charger_find_by_name(wm831x_pdata->usb_gadget);
> +		if (IS_ERR(power->usb_charger)) {
> +			ret =3D PTR_ERR(power->usb_charger);
> +			dev_err(&pdev->dev,
> +				"Failed to find USB gadget: %d\n", ret);
> +			goto err_bat_irq;
> +		}
> +
> +		power->usb_notify.notifier_call =3D wm831x_usb_limit_change;
> +
> +		ret =3D usb_charger_register_notify(power->usb_charger,
> +						  &power->usb_notify);
> +		if (ret !=3D 0) {
> +			dev_err(&pdev->dev,
> +				"Failed to register notifier: %d\n", ret);
> +			goto err_usb_charger;
> +		}
> +	}
> +
>  	return ret;
> =20
> +err_usb_charger:
> +	/* put_device on charger */
>  err_bat_irq:
>  	--i;
>  	for (; i >=3D 0; i--) {
> @@ -637,6 +700,12 @@ static int wm831x_power_remove(struct platform_d=
evice *pdev)
>  	struct wm831x *wm831x =3D wm831x_power->wm831x;
>  	int irq, i;
> =20
> +	if (wm831x_power->usb_charger) {
> +		usb_charger_unregister_notify(wm831x_power->usb_charger,
> +					      &wm831x_power->usb_notify);
> +		/* Free charger */
> +	}
> +
>  	for (i =3D 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
>  		irq =3D wm831x_irq(wm831x,=20
>  				 platform_get_irq_byname(pdev,
> diff --git a/include/linux/mfd/wm831x/pdata.h b/include/linux/mfd/wm8=
31x/pdata.h
> index dcc9631..5af8399 100644
> --- a/include/linux/mfd/wm831x/pdata.h
> +++ b/include/linux/mfd/wm831x/pdata.h
> @@ -126,6 +126,9 @@ struct wm831x_pdata {
>  	/** The driver should initiate a power off sequence during shutdown=
 */
>  	bool soft_shutdown;
> =20
> +	/** dev_name of USB charger gadget to integrate with */
> +	const char *usb_gadget;
> +
>  	int irq_base;
>  	int gpio_base;
>  	int gpio_defaults[WM831X_GPIO_NUM];

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

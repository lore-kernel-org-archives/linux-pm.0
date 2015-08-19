From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 5/5] power: wm831x_power: Support USB charger current
 limit management
Date: Wed, 19 Aug 2015 10:56:48 +0100
Message-ID: <20150819095648.GI6180@x1>
References: <cover.1439974219.git.baolin.wang@linaro.org>
 <a29a038d7ebee931855cbaa065b055db5c5cfef3.1439974219.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38510 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbHSJ4x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 05:56:53 -0400
Received: by wicja10 with SMTP id ja10so3114752wic.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 02:56:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a29a038d7ebee931855cbaa065b055db5c5cfef3.1439974219.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@ti.com, broonie@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org

On Wed, 19 Aug 2015, Baolin Wang wrote:

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
> ---
>  drivers/power/wm831x_power.c     |   69 ++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/wm831x/pdata.h |    3 ++

I'm not going to keep reviewing this.  You should carry forward any
Acks received onto subsequent submissions yourself.

>  2 files changed, 72 insertions(+)
>=20
> diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_powe=
r.c
> index db11ae6..72c661f 100644
> --- a/drivers/power/wm831x_power.c
> +++ b/drivers/power/wm831x_power.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> +#include <linux/usb/usb_charger.h>
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
> +/* In miliamps */
> +static unsigned int wm831x_usb_limits[] =3D {
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
> +	int i, best;
> +
> +	/* Find the highest supported limit */
> +	best =3D 0;
> +	for (i =3D 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
> +		if (limit < wm831x_usb_limits[i] &&
> +		    wm831x_usb_limits[best] < wm831x_usb_limits[i])
> +			best =3D i;
> +	}
> +
> +	dev_dbg(wm831x_power->wm831x->dev,
> +		"Limiting USB current to %dmA", wm831x_usb_limits[best]);
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
> @@ -606,8 +646,31 @@ static int wm831x_power_probe(struct platform_de=
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
> +	usb_charger_put(power->usb_charger);
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
> +		usb_charger_put(wm831x_power->usb_charger);
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

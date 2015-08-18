From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 18 Aug 2015 12:43:45 +0100
Message-ID: <20150818114345.GE6180@x1>
References: <cover.1439866451.git.baolin.wang@linaro.org>
 <4e3447ef209fbbdc3ee1c82428be2bc19c30bd30.1439866451.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4e3447ef209fbbdc3ee1c82428be2bc19c30bd30.1439866451.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Aug 2015, Baolin Wang wrote:

> Integrate with the newly added USB charger interface to limit the cur=
rent
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from =
high
> current inputs without drawing more current than specified from other=
s.
>=20
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/power/wm831x_power.c     |   69 ++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/wm831x/pdata.h |    3 ++

MFD:
  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

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
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

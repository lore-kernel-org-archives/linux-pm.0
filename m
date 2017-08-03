From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Thu, 3 Aug 2017 14:16:58 -0500
Message-ID: <20170803191658.fksnm5iknwxlck7l@rob-hp-laptop>
References: <cover.1501132171.git.baolin.wang@linaro.org>
 <b25c3a5e595716c701091d848188585dbd95bb20.1501132173.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38678 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdHCTRB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2017 15:17:01 -0400
Content-Disposition: inline
In-Reply-To: <b25c3a5e595716c701091d848188585dbd95bb20.1501132173.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Jul 27, 2017 at 01:14:38PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/mfd/wm831x.txt |    1 +
>  drivers/power/supply/wm831x_power.c              |   72 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/wm831x.txt b/Documentation/devicetree/bindings/mfd/wm831x.txt
> index 9f8b743..4e3bc07 100644
> --- a/Documentation/devicetree/bindings/mfd/wm831x.txt
> +++ b/Documentation/devicetree/bindings/mfd/wm831x.txt
> @@ -31,6 +31,7 @@ Required properties:
>      ../interrupt-controller/interrupts.txt
>  
>  Optional sub-nodes:
> +  - usb-phy : Contains a phandle to the USB PHY.

Use the phy binding ("phys") instead.

>    - regulators : Contains sub-nodes for each of the regulators supplied by
>      the device. The regulators are bound using their names listed below:
>  
> diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
> index 7082301..dff6473 100644
> --- a/drivers/power/supply/wm831x_power.c
> +++ b/drivers/power/supply/wm831x_power.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> +#include <linux/usb/phy.h>
>  
>  #include <linux/mfd/wm831x/core.h>
>  #include <linux/mfd/wm831x/auxadc.h>
> @@ -31,6 +32,8 @@ struct wm831x_power {
>  	char usb_name[20];
>  	char battery_name[20];
>  	bool have_battery;
> +	struct usb_phy *usb_phy;
> +	struct notifier_block usb_notify;
>  };
>  
>  static int wm831x_power_check_online(struct wm831x *wm831x, int supply,
> @@ -125,6 +128,43 @@ static int wm831x_usb_get_prop(struct power_supply *psy,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
>  
> +/* In milliamps */
> +static const unsigned int wm831x_usb_limits[] = {
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
> +	struct wm831x_power *wm831x_power = container_of(nb,
> +							 struct wm831x_power,
> +							 usb_notify);
> +	unsigned int i, best;
> +
> +	/* Find the highest supported limit */
> +	best = 0;
> +	for (i = 0; i < ARRAY_SIZE(wm831x_usb_limits); i++) {
> +		if (limit >= wm831x_usb_limits[i] &&
> +		    wm831x_usb_limits[best] < wm831x_usb_limits[i])
> +			best = i;
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
>  /*********************************************************************
>   *		Battery properties
>   *********************************************************************/
> @@ -607,6 +647,33 @@ static int wm831x_power_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	power->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
> +	ret = PTR_ERR_OR_ZERO(power->usb_phy);
> +
> +	switch (ret) {
> +	case 0:
> +		power->usb_notify.notifier_call = wm831x_usb_limit_change;
> +		ret = usb_register_notifier(power->usb_phy, &power->usb_notify);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register notifier: %d\n",
> +				ret);
> +			goto err_bat_irq;
> +		}
> +		break;
> +	case -EINVAL:
> +	case -ENODEV:
> +		/* ignore missing usb-phy, it's optional */
> +		power->usb_phy = NULL;
> +		ret = 0;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
> +		/* fall-through */
> +	case -EPROBE_DEFER:
> +		goto err_bat_irq;
> +		break;
> +	}
> +
>  	return ret;
>  
>  err_bat_irq:
> @@ -637,6 +704,11 @@ static int wm831x_power_remove(struct platform_device *pdev)
>  	struct wm831x *wm831x = wm831x_power->wm831x;
>  	int irq, i;
>  
> +	if (wm831x_power->usb_phy) {
> +		usb_unregister_notifier(wm831x_power->usb_phy,
> +					&wm831x_power->usb_notify);
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
>  		irq = wm831x_irq(wm831x, 
>  				 platform_get_irq_byname(pdev,
> -- 
> 1.7.9.5
> 

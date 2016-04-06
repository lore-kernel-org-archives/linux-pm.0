From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Wed, 6 Apr 2016 08:26:45 +0000
Message-ID: <AM4PR04MB2130AD03DCB2121336E95869899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-am1on0083.outbound.protection.outlook.com ([157.56.112.83]:6325
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753160AbcDFJBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 05:01:48 -0400
In-Reply-To: <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Cc: "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi

> -----Original Message-----
> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
> owner@vger.kernel.org] On Behalf Of Baolin Wang
> Sent: Friday, April 01, 2016 3:22 PM
> To: balbi@kernel.org; gregkh@linuxfoundation.org; sre@kernel.org;
> dbaryshkov@gmail.com; dwmw2@infradead.org
> Cc: peter.chen@freescale.com; stern@rowland.harvard.edu;
> r.baldyga@samsung.com; yoshihiro.shimoda.uh@renesas.com;
> lee.jones@linaro.org; broonie@kernel.org;
> ckeepax@opensource.wolfsonmicro.com; patches@opensource.wolfsonmicro.com;
> baolin.wang@linaro.org; linux-pm@vger.kernel.org; linux-
> usb@vger.kernel.org; device-mainlining@lists.linuxfoundation.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v9 1/4] gadget: Introduce the usb charger framework
> 

...

> +/*
> + * usb_charger_get_type() - get the usb charger type with lock protection.
> + * @uchger - usb charger device
> + *
> + * Users can get the charger type by this safe API, rather than using
> +the
> + * usb_charger structure directly.
> + */
> +enum usb_charger_type usb_charger_get_type(struct usb_charger *uchger)
> +{
> +	enum usb_charger_type type;
> +
> +	mutex_lock(&uchger->lock);
> +	type = uchger->type;
> +	mutex_unlock(&uchger->lock);
> +
> +	return type;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_get_type);
> +
> +/*
> + * usb_charger_detect_type() - detect the charger type manually.
> + * @uchger - usb charger device
> + *
> + * Note: You should ensure you need to detect the charger type manually
> +on your
> + * platform.
> + * You should call it at the right gadget state to avoid affecting
> +gadget
> + * enumeration.
> + */
> +int usb_charger_detect_type(struct usb_charger *uchger) {
> +	enum usb_charger_type type;
> +
> +	if (WARN(!uchger->charger_detect,
> +		 "charger detection method should not be NULL"))
> +		return -EINVAL;
> +
> +	type = uchger->charger_detect(uchger);
> +
> +	mutex_lock(&uchger->lock);
> +	uchger->type = type;
> +	mutex_unlock(&uchger->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_detect_type);
> +
> +/*
> + * usb_charger_get_type_by_others() - Get the usb charger type by the
> +callback
> + * which is implemented by users.
> + * @uchger - the usb charger device.
> + *
> + * Note: This function is just used for getting the charger type, not
> +for
> + * detecting charger type which might affect the DP/DM line when gadget
> +is on
> + * enumeration state.
> + */
> +static enum usb_charger_type
> +usb_charger_get_type_by_others(struct usb_charger *uchger) {
> +	if (uchger->type != UNKNOWN_TYPE)
> +		return uchger->type;
> +
> +	if (uchger->psy) {
> +		union power_supply_propval val;
> +
> +		power_supply_get_property(uchger->psy,
> +					  POWER_SUPPLY_PROP_CHARGE_TYPE,
> +					  &val);
> +		switch (val.intval) {
> +		case POWER_SUPPLY_TYPE_USB:
> +			uchger->type = SDP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_DCP:
> +			uchger->type = DCP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_CDP:
> +			uchger->type = CDP_TYPE;
> +			break;
> +		case POWER_SUPPLY_TYPE_USB_ACA:
> +			uchger->type = ACA_TYPE;
> +			break;
> +		default:
> +			uchger->type = UNKNOWN_TYPE;
> +			break;
> +		}
> +	} else if (uchger->get_charger_type) {
> +		uchger->type = uchger->get_charger_type(uchger);
> +	} else {
> +		uchger->type = UNKNOWN_TYPE;
> +	}
> +
> +	return uchger->type;
> +}
> +

I think we may don't need this usb_charger_get_type_by_others().
"uchger->type" is set in one place is enough, that is: by
uchger->charger_detect() in usb_charger_detect_type(), then
usb_charger_get_type_by_others() is replaced by usb_charger_get_type().

uchger->charger_detect() can have diff implementations no matter
what kind of mechanism is used, for your PMIC case, you can just
directly get the type value by power_supply_get_property();
with that, we can have one central place to set uchger->type.
After uchger->type is set, charger type detection is no need to be
involved until charger type changes.

Then next question is where is to call usb_charger_detect_type(),
We need make sure it finished before usb gadget connect.

Ideal is with your framework, diff users only need implement
uchger->charger_detect(). :)

Li Jun

> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

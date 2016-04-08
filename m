From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v10 1/4] gadget: Introduce the usb charger framework
Date: Fri, 8 Apr 2016 08:04:20 +0000
Message-ID: <AM4PR04MB2130F2C3DA7EA7140578A46289910@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <cover.1460029375.git.baolin.wang@linaro.org>
 <6b323d5168c10ccb47882687b1251c31b6cad587.1460029375.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b323d5168c10ccb47882687b1251c31b6cad587.1460029375.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Cc: "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Baolin

> -----Original Message-----
> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
> owner@vger.kernel.org] On Behalf Of Baolin Wang
> Sent: Thursday, April 07, 2016 7:49 PM
> To: balbi@kernel.org; gregkh@linuxfoundation.org; sre@kernel.org;
> dbaryshkov@gmail.com; dwmw2@infradead.org
> Cc: peter.chen@freescale.com; stern@rowland.harvard.edu;
> r.baldyga@samsung.com; yoshihiro.shimoda.uh@renesas.com;
> lee.jones@linaro.org; broonie@kernel.org;
> ckeepax@opensource.wolfsonmicro.com; patches@opensource.wolfsonmicro.com;
> baolin.wang@linaro.org; linux-pm@vger.kernel.org; linux-
> usb@vger.kernel.org; device-mainlining@lists.linuxfoundation.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v10 1/4] gadget: Introduce the usb charger framework
> 
> This patch introduces the usb charger driver based on usb gadget that
> makes an enhancement to a power driver. It works well in practice but that
> requires a system with suitable hardware.
> 
> The basic conception of the usb charger is that, when one usb charger is
> added or removed by reporting from the usb gadget state change or the
> extcon device state change, the usb charger will report to power user to
> set the current limitation.
> 
> The usb charger will register notifiees on the usb gadget or the extcon
> device to get notified the usb charger state. It also supplies the
> notification mechanism to userspace When the usb charger state is changed.
> 
> Power user will register a notifiee on the usb charger to get notified by
> status changes from the usb charger. It will report to power user to set
> the current limitation when detecting the usb charger is added or removed
> from extcon device state or usb gadget state.
> 
> This patch doesn't yet integrate with the gadget code, so some functions
> which rely on the 'gadget' are not completed, that will be implemented in
> the following patches.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/usb/gadget/Kconfig       |    7 +
>  drivers/usb/gadget/udc/Makefile  |    1 +
>  drivers/usb/gadget/udc/charger.c |  729
> ++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/charger.h      |  173 +++++++++
>  include/uapi/linux/usb/charger.h |   31 ++
>  5 files changed, 941 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/charger.c  create mode 100644
> include/linux/usb/charger.h  create mode 100644
> include/uapi/linux/usb/charger.h
> 

...

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

I still recommend have a central place to call usb_charger_detect_type()
to cover real charger detection instead of leaving this question open to
diff users. This can be done after vbus-on is detected and before do gadget
connect. I don't think this will make your framework complicated.

Hi Felipe, what do you think of this?

Li Jun

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

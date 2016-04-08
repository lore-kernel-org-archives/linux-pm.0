From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v10 1/4] gadget: Introduce the usb charger framework
Date: Fri, 8 Apr 2016 17:56:13 +0800
Message-ID: <CAMz4ku+kriz1biMx6dK3fWfDymJ12FXe+p_Fx+mvLJVQiMz7_g@mail.gmail.com>
References: <cover.1460029375.git.baolin.wang@linaro.org>
	<6b323d5168c10ccb47882687b1251c31b6cad587.1460029375.git.baolin.wang@linaro.org>
	<AM4PR04MB2130F2C3DA7EA7140578A46289910@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36862 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbcDHJ4P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 05:56:15 -0400
Received: by mail-yw0-f179.google.com with SMTP id o66so37496296ywc.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2016 02:56:14 -0700 (PDT)
In-Reply-To: <AM4PR04MB2130F2C3DA7EA7140578A46289910@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlini>

Hi Jun,

On 8 April 2016 at 16:04, Jun Li <jun.li@nxp.com> wrote:
> Hi, Baolin
>
>> +/*
>> + * usb_charger_detect_type() - detect the charger type manually.
>> + * @uchger - usb charger device
>> + *
>> + * Note: You should ensure you need to detect the charger type manually
>> +on your
>> + * platform.
>> + * You should call it at the right gadget state to avoid affecting
>> +gadget
>> + * enumeration.
>> + */
>> +int usb_charger_detect_type(struct usb_charger *uchger) {
>> +     enum usb_charger_type type;
>> +
>> +     if (WARN(!uchger->charger_detect,
>> +              "charger detection method should not be NULL"))
>> +             return -EINVAL;
>> +
>> +     type = uchger->charger_detect(uchger);
>> +
>> +     mutex_lock(&uchger->lock);
>> +     uchger->type = type;
>> +     mutex_unlock(&uchger->lock);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_charger_detect_type);
>
> I still recommend have a central place to call usb_charger_detect_type()
> to cover real charger detection instead of leaving this question open to
> diff users. This can be done after vbus-on is detected and before do gadget
> connect. I don't think this will make your framework complicated.

This API is used for detecting the charger type manually (software
charger detection), so if user's udc driver is needed to do this, then
they can issue it at their right place to make it more flexible. But
let us see other people's suggestion. Thanks.

>
> Hi Felipe, what do you think of this?
>
> Li Jun
>
>> +
>> +/*
>> + * usb_charger_get_type_by_others() - Get the usb charger type by the
>> +callback
>> + * which is implemented by users.
>> + * @uchger - the usb charger device.
>> + *
>> + * Note: This function is just used for getting the charger type, not
>> +for
>> + * detecting charger type which might affect the DP/DM line when gadget
>> +is on
>> + * enumeration state.
>> + */
>> +static enum usb_charger_type
>> +usb_charger_get_type_by_others(struct usb_charger *uchger) {
>> +     if (uchger->type != UNKNOWN_TYPE)
>> +             return uchger->type;
>> +
>> +     if (uchger->psy) {
>> +             union power_supply_propval val;
>> +
>> +             power_supply_get_property(uchger->psy,
>> +                                       POWER_SUPPLY_PROP_CHARGE_TYPE,
>> +                                       &val);
>> +             switch (val.intval) {
>> +             case POWER_SUPPLY_TYPE_USB:
>> +                     uchger->type = SDP_TYPE;
>> +                     break;
>> +             case POWER_SUPPLY_TYPE_USB_DCP:
>> +                     uchger->type = DCP_TYPE;
>> +                     break;
>> +             case POWER_SUPPLY_TYPE_USB_CDP:
>> +                     uchger->type = CDP_TYPE;
>> +                     break;
>> +             case POWER_SUPPLY_TYPE_USB_ACA:
>> +                     uchger->type = ACA_TYPE;
>> +                     break;
>> +             default:
>> +                     uchger->type = UNKNOWN_TYPE;
>> +                     break;
>> +             }
>> +     } else if (uchger->get_charger_type) {
>> +             uchger->type = uchger->get_charger_type(uchger);
>> +     } else {
>> +             uchger->type = UNKNOWN_TYPE;
>> +     }
>> +
>> +     return uchger->type;
>> +}
>> +



-- 
Baolin.wang
Best Regards

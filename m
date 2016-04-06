From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Wed, 6 Apr 2016 19:31:11 +0800
Message-ID: <CAMz4kuJmQTEXSjL55+fEm0-RO6N3isS60kPmD1XaXxGNumTpXg@mail.gmail.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
	<6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org>
	<AM4PR04MB2130AD03DCB2121336E95869899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR04MB2130AD03DCB2121336E95869899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlini>
List-Id: linux-pm@vger.kernel.org

On 6 April 2016 at 16:26, Jun Li <jun.li@nxp.com> wrote:
> Hi
>
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
>
> I think we may don't need this usb_charger_get_type_by_others().
> "uchger->type" is set in one place is enough, that is: by
> uchger->charger_detect() in usb_charger_detect_type(), then
> usb_charger_get_type_by_others() is replaced by usb_charger_get_type().
>
> uchger->charger_detect() can have diff implementations no matter
> what kind of mechanism is used, for your PMIC case, you can just
> directly get the type value by power_supply_get_property();
> with that, we can have one central place to set uchger->type.
> After uchger->type is set, charger type detection is no need to be
> involved until charger type changes.
>
> Then next question is where is to call usb_charger_detect_type(),
> We need make sure it finished before usb gadget connect.

Yeah, that's the point: where? It is hard for usb charger framework to
control, which will make it more complicated. The
'usb_charger_detect_type()' is used for detecting the charger type
manually on user's platform, and user should call it at the right time
to avoid affecting gadget enumeration. Otherwise user can implement
some callbacks showed in 'usb_charger_get_type_by_others()' function
to get charger type. I think this is controllable and simple for the
usb charger framework.

>
> Ideal is with your framework, diff users only need implement
> uchger->charger_detect(). :)
>

-- 
Baolin.wang
Best Regards

From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v10 1/4] gadget: Introduce the usb charger framework
Date: Fri, 8 Apr 2016 19:00:25 +0800
Message-ID: <CAMz4kuJvCSHpDtRqsO9OcPHbmwH_2iABfeshbs-94aUEo3sKXg@mail.gmail.com>
References: <cover.1460029375.git.baolin.wang@linaro.org>
	<6b323d5168c10ccb47882687b1251c31b6cad587.1460029375.git.baolin.wang@linaro.org>
	<AM4PR04MB2130F2C3DA7EA7140578A46289910@AM4PR04MB2130.eurprd04.prod.outlook.com>
	<CAMz4ku+kriz1biMx6dK3fWfDymJ12FXe+p_Fx+mvLJVQiMz7_g@mail.gmail.com>
	<AM4PR04MB21300E3BA9D6DAC2836C9BE689910@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34868 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbcDHLA0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 07:00:26 -0400
Received: by mail-yw0-f175.google.com with SMTP id i84so124012030ywc.2
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2016 04:00:26 -0700 (PDT)
In-Reply-To: <AM4PR04MB21300E3BA9D6DAC2836C9BE689910@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlini>

Hi Jun,

>> >> +/*
>> >> + * usb_charger_detect_type() - detect the charger type manually.
>> >> + * @uchger - usb charger device
>> >> + *
>> >> + * Note: You should ensure you need to detect the charger type
>> >> +manually on your
>> >> + * platform.
>> >> + * You should call it at the right gadget state to avoid affecting
>> >> +gadget
>> >> + * enumeration.
>> >> + */
>> >> +int usb_charger_detect_type(struct usb_charger *uchger) {
>> >> +     enum usb_charger_type type;
>> >> +
>> >> +     if (WARN(!uchger->charger_detect,
>> >> +              "charger detection method should not be NULL"))
>> >> +             return -EINVAL;
>> >> +
>> >> +     type = uchger->charger_detect(uchger);
>> >> +
>> >> +     mutex_lock(&uchger->lock);
>> >> +     uchger->type = type;
>> >> +     mutex_unlock(&uchger->lock);
>> >> +
>> >> +     return 0;
>> >> +}
>> >> +EXPORT_SYMBOL_GPL(usb_charger_detect_type);
>> >
>> > I still recommend have a central place to call
>> > usb_charger_detect_type() to cover real charger detection instead of
>> > leaving this question open to diff users. This can be done after
>> > vbus-on is detected and before do gadget connect. I don't think this
>> will make your framework complicated.
>>
>> This API is used for detecting the charger type manually (software charger
>> detection), so if user's udc driver is needed to do this, then they can
>> issue it at their right place to make it more flexible. But let us see
>> other people's suggestion. Thanks.
>
> Ok, actually this API can be used for what ever charger detection
> type, user can implement any method(manual detection, directly read
> result from some HW...what ever) in uchger->charger_detect(), target is

But reading result from some HW dose not means *detect*, actually is
*get*. We can not mix them together with the different semantics.

> to have the charger type and set uchger->type, then you no need to add the comments/description to limit it usage. Also I do see there is possible
> central place to do this.
>

-- 
Baolin.wang
Best Regards

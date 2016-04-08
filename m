From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v10 1/4] gadget: Introduce the usb charger framework
Date: Fri, 8 Apr 2016 19:51:12 +0800
Message-ID: <CAMz4kuJVtfxyXuSeq9kEZF-fhvcK9hYhNoj9g-vBD9GF5XVRgA@mail.gmail.com>
References: <cover.1460029375.git.baolin.wang@linaro.org>
	<6b323d5168c10ccb47882687b1251c31b6cad587.1460029375.git.baolin.wang@linaro.org>
	<AM4PR04MB2130F2C3DA7EA7140578A46289910@AM4PR04MB2130.eurprd04.prod.outlook.com>
	<CAMz4ku+kriz1biMx6dK3fWfDymJ12FXe+p_Fx+mvLJVQiMz7_g@mail.gmail.com>
	<AM4PR04MB21300E3BA9D6DAC2836C9BE689910@AM4PR04MB2130.eurprd04.prod.outlook.com>
	<CAMz4kuJvCSHpDtRqsO9OcPHbmwH_2iABfeshbs-94aUEo3sKXg@mail.gmail.com>
	<AM4PR04MB2130BB1F1E1FEA35B86DAE7B89910@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33214 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbcDHLvN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 07:51:13 -0400
Received: by mail-yw0-f169.google.com with SMTP id t10so131414729ywa.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2016 04:51:13 -0700 (PDT)
In-Reply-To: <AM4PR04MB2130BB1F1E1FEA35B86DAE7B89910@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlini>

On 8 April 2016 at 19:27, Jun Li <jun.li@nxp.com> wrote:
>
>
>> -----Original Message-----
>> From: Baolin Wang [mailto:baolin.wang@linaro.org]
>> Sent: Friday, April 08, 2016 7:00 PM
>> To: Jun Li <jun.li@nxp.com>
>> Cc: balbi@kernel.org; gregkh@linuxfoundation.org; sre@kernel.org;
>> dbaryshkov@gmail.com; dwmw2@infradead.org; peter.chen@freescale.com;
>> stern@rowland.harvard.edu; r.baldyga@samsung.com;
>> yoshihiro.shimoda.uh@renesas.com; lee.jones@linaro.org; broonie@kern=
el.org;
>> ckeepax@opensource.wolfsonmicro.com; patches@opensource.wolfsonmicro=
=2Ecom;
>> linux-pm@vger.kernel.org; linux-usb@vger.kernel.org; device-
>> mainlining@lists.linuxfoundation.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v10 1/4] gadget: Introduce the usb charger frame=
work
>>
>> Hi Jun,
>>
>> >> >> +/*
>> >> >> + * usb_charger_detect_type() - detect the charger type manual=
ly.
>> >> >> + * @uchger - usb charger device
>> >> >> + *
>> >> >> + * Note: You should ensure you need to detect the charger typ=
e
>> >> >> +manually on your
>> >> >> + * platform.
>> >> >> + * You should call it at the right gadget state to avoid
>> >> >> +affecting gadget
>> >> >> + * enumeration.
>> >> >> + */
>> >> >> +int usb_charger_detect_type(struct usb_charger *uchger) {
>> >> >> +     enum usb_charger_type type;
>> >> >> +
>> >> >> +     if (WARN(!uchger->charger_detect,
>> >> >> +              "charger detection method should not be NULL"))
>> >> >> +             return -EINVAL;
>> >> >> +
>> >> >> +     type =3D uchger->charger_detect(uchger);
>> >> >> +
>> >> >> +     mutex_lock(&uchger->lock);
>> >> >> +     uchger->type =3D type;
>> >> >> +     mutex_unlock(&uchger->lock);
>> >> >> +
>> >> >> +     return 0;
>> >> >> +}
>> >> >> +EXPORT_SYMBOL_GPL(usb_charger_detect_type);
>> >> >
>> >> > I still recommend have a central place to call
>> >> > usb_charger_detect_type() to cover real charger detection inste=
ad
>> >> > of leaving this question open to diff users. This can be done a=
fter
>> >> > vbus-on is detected and before do gadget connect. I don't think
>> >> > this
>> >> will make your framework complicated.
>> >>
>> >> This API is used for detecting the charger type manually (softwar=
e
>> >> charger detection), so if user's udc driver is needed to do this,
>> >> then they can issue it at their right place to make it more flexi=
ble.
>> >> But let us see other people's suggestion. Thanks.
>> >
>> > Ok, actually this API can be used for what ever charger detection
>> > type, user can implement any method(manual detection, directly rea=
d
>> > result from some HW...what ever) in uchger->charger_detect(), targ=
et
>> > is
>>
>> But reading result from some HW dose not means *detect*, actually is=
 *get*.
>> We can not mix them together with the different semantics.
>
> It doesn=E2=80=99t matter here, you already define the _get_ API for =
just read
> the charger type from the saved value(uchger->type), so we can think
> the API to make uchger->type from UNKNOW to ONE KNOWN type is *detect=
*,
> because we don't need 2 separate API one for *get* type from HW and a=
nother
> one for *detect* from HW, only one API involve HW access is enough.

But another issue is some users may need to get the charger type from
power supply by "power_supply_get_property()" function, we need to
integrate with the power supply things in the usb charger framework,
not user to implement that.

>
> - Detect: (write to and) read from HW to get the charger type,
>   save to uchger->type;
> - Get: read the charger type from uchger->type.
>
>>
>> > to have the charger type and set uchger->type, then you no need to=
 add
>> > the comments/description to limit it usage. Also I do see there is
>> possible central place to do this.
>> >
>>
>> --
>> Baolin.wang
>> Best Regards



--=20
Baolin.wang
Best Regards

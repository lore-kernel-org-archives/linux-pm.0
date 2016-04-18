From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v10 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 16:57:24 +0800
Message-ID: <CAMz4ku+cJ85wn71sf==2UkaaLK_U_GXZGBZy34m0hVuVaKojdg@mail.gmail.com>
References: <cover.1460029375.git.baolin.wang@linaro.org>
	<6b323d5168c10ccb47882687b1251c31b6cad587.1460029375.git.baolin.wang@linaro.org>
	<AM4PR04MB2130F2C3DA7EA7140578A46289910@AM4PR04MB2130.eurprd04.prod.outlook.com>
	<CAMz4ku+kriz1biMx6dK3fWfDymJ12FXe+p_Fx+mvLJVQiMz7_g@mail.gmail.com>
	<AM4PR04MB21300E3BA9D6DAC2836C9BE689910@AM4PR04MB2130.eurprd04.prod.outlook.com>
	<CAMz4kuJvCSHpDtRqsO9OcPHbmwH_2iABfeshbs-94aUEo3sKXg@mail.gmail.com>
	<AM4PR04MB2130BB1F1E1FEA35B86DAE7B89910@AM4PR04MB2130.eurprd04.prod.outlook.com>
	<CAMz4kuJVtfxyXuSeq9kEZF-fhvcK9hYhNoj9g-vBD9GF5XVRgA@mail.gmail.com>
	<AM4PR04MB2130B1F3D1C9B4DE5CD6B92989940@AM4PR04MB2130.eurprd04.prod.outlook.com>
	<CAMz4kuKGLor6t74TuwuS7ZCXH=Mu+UuC_6s5MUCVQB+8RPFafQ@mail.gmail.com>
	<AM4PR04MB21301A33C5EC5D57D122E189896B0@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR04MB21301A33C5EC5D57D122E189896B0@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlini>
List-Id: linux-pm@vger.kernel.org

Hi Jun,

On 18 April 2016 at 16:27, Jun Li <jun.li@nxp.com> wrote:
>> >>
>> >> But another issue is some users may need to get the charger type from
>> >> power supply by "power_supply_get_property()" function, we need to
>> >> integrate with the power supply things in the usb charger framework,
>> >> not user to implement that.
>> >
>> > Why this user(your case) can't put the charger type get by
>> > "power_supply_get_property()" in its uchger->charger_detect(), any
>> > special reason prevent you doing it? I am not sure if this case is
>> > very common, even if it is, you also can put it in
>> > usb_charger_detect_type()
>> >
>> > usb_charger_detect_type()
>> > {
>> >         If can get from power_supply_get_property()
>> >                 ...
>> >         else if uchger->charger_detect
>> >                 uchger->charger_detect();
>> >         ...
>> > }
>>
>> If user want to implement above method, they need to get the
>> 'power_supply' structure to do this action, which maybe can not get in
>> some contexts. So we need to integrate with the power supply things to
>> avoid this situation. IIRC, Felipe suggested me to flesh out the charger
>> getting method.
>>
>
> Okay, then I agree with you to let user do that with more flexibility,
> I tried to enable usb charger detection on one NXP i.mx platform based on
> this framework, works fine, thanks!

That's great. Thanks.

-- 
Baolin.wang
Best Regards

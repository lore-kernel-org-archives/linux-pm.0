From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 29 Mar 2016 17:48:46 +0800
Message-ID: <CAMz4kuKkZ1GAjEoi7KB8EwjPQvW2Lf28VPzMgW2QdD=Ro4jzSQ@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<AM4PR04MB1665C9DAC2519CDCFEF92DDC89870@AM4PR04MB1665.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35305 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbcC2Jsr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 05:48:47 -0400
Received: by mail-yw0-f178.google.com with SMTP id g127so11464921ywf.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 02:48:47 -0700 (PDT)
In-Reply-To: <AM4PR04MB1665C9DAC2519CDCFEF92DDC89870@AM4PR04MB1665.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

On 29 March 2016 at 16:45, Jun Li <jun.li@nxp.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
>> owner@vger.kernel.org] On Behalf Of Baolin Wang
>> Sent: Monday, March 28, 2016 2:52 PM
>> To: Peter Chen <hzpeterchen@gmail.com>
>> Cc: Felipe Balbi <balbi@kernel.org>; Greg KH <gregkh@linuxfoundation.org>;
>> Sebastian Reichel <sre@kernel.org>; Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com>; David Woodhouse <dwmw2@infradead.org>; Peter Chen
>> <peter.chen@freescale.com>; Alan Stern <stern@rowland.harvard.edu>;
>> r.baldyga@samsung.com; Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com>; Lee Jones <lee.jones@linaro.org>; Mark
>> Brown <broonie@kernel.org>; Charles Keepax
>> <ckeepax@opensource.wolfsonmicro.com>; patches@opensource.wolfsonmicro.com;
>> Linux PM list <linux-pm@vger.kernel.org>; USB <linux-usb@vger.kernel.org>;
>> device-mainlining@lists.linuxfoundation.org; LKML <linux-
>> kernel@vger.kernel.org>
>> Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with
>> the usb gadget power negotation
>>
>> On 25 March 2016 at 15:09, Peter Chen <hzpeterchen@gmail.com> wrote:
>> > On Thu, Mar 24, 2016 at 08:35:53PM +0800, Baolin Wang wrote:
>> >> Currently the Linux kernel does not provide any standard integration
>> >> of this feature that integrates the USB subsystem with the system
>> >> power regulation provided by PMICs meaning that either vendors must
>> >> add this in their kernels or USB gadget devices based on Linux (such
>> >> as mobile phones) may not behave as they should. Thus provide a
>> standard framework for doing this in kernel.
>> >>
>> >> Now introduce one user with wm831x_power to support and test the usb
>> >> charger, which is pending testing. Moreover there may be other
>> >> potential users will use it in future.
>> >>
>> >
>> > I am afraid I still not find the user (udc driver) for this framework,
>> > I would like to see how udc driver block the enumeration until the
>> > charger detection has finished, or am I missing something?
>>
>> It is not for udc driver but for power users who want to negotiate with
>> USB subsystem.
>>
>
> Seems you don't want to guarantee charger type detection is done before
> gadget connection(pullup DP), right?
> I see you call usb_charger_detect_type() in each gadget usb state changes.

I am not sure I get your point correctly, please correct me if I
misunderstand you.
We need to check the charger type at every event comes from the usb
gadget state changes or the extcon device state changes, which means a
new charger plugin or pullup.

>
> Li Jun
>> >
>> > --
>> > Best Regards,
>> > Peter Chen
>>
>>
>>
>> --
>> Baolin.wang
>> Best Regards
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html



-- 
Baolin.wang
Best Regards

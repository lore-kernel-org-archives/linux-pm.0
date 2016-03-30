From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 30 Mar 2016 17:30:50 +0800
Message-ID: <CAMz4kuLY8vO5qnkuY+kv91zKpdxBBSDeLZXFvD1LjnS3R3UccA@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<AM4PR04MB1665C9DAC2519CDCFEF92DDC89870@AM4PR04MB1665.eurprd04.prod.outlook.com>
	<CAMz4kuKkZ1GAjEoi7KB8EwjPQvW2Lf28VPzMgW2QdD=Ro4jzSQ@mail.gmail.com>
	<AM4PR04MB16657BE747BA7451511420D189980@AM4PR04MB1665.eurprd04.prod.outlook.com>
	<CAMz4kuLh9XfuL7kK4v2eJMU=QpdZx3d8KpMfH5Df2iZK=PLCqQ@mail.gmail.com>
	<AM4PR04MB1665F6673ABDDD08AAF68CE489980@AM4PR04MB1665.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35270 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcC3Jav (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 05:30:51 -0400
Received: by mail-yw0-f174.google.com with SMTP id g127so50814459ywf.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 02:30:51 -0700 (PDT)
In-Reply-To: <AM4PR04MB1665F6673ABDDD08AAF68CE489980@AM4PR04MB1665.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

On 30 March 2016 at 16:07, Jun Li <jun.li@nxp.com> wrote:
> Hi

>> On 30 March 2016 at 10:54, Jun Li <jun.li@nxp.com> wrote:
>> >> >> It is not for udc driver but for power users who want to negotiate
>> >> >> with USB subsystem.
>> >> >>
>> >> >
>> >> > Seems you don't want to guarantee charger type detection is done
>> >> > before gadget connection(pullup DP), right?
>> >> > I see you call usb_charger_detect_type() in each gadget usb state
>> >> changes.
>> >>
>> >> I am not sure I get your point correctly, please correct me if I
>> >> misunderstand you.
>> >> We need to check the charger type at every event comes from the usb
>> >> gadget state changes or the extcon device state changes, which means
>> >> a new charger plugin or pullup.
>> >>
>> >
>> > According to usb charger spec, my understanding is you can't do real
>> > charger detection procedure *after* gadget _connection_(pullup DP),
>> > also I don't
>>
>> Why can not? Charger detection is usually from PMIC.
>
> Charger detection process will impact DP/DM line state, see usb charger
> spec v1.2 for detail detection process, section 4.6.3 says:
>
> "A PD is allowed to *disconnect* and repeat the charger detection process
> multiple times while attached. The PD is required to wait for a time of at
> least TCP_VDM_EN max between disconnecting and restarting the charger
> detection process."
>
> As Peter mentioned, the charger detection should happen between VBUS
> detection and gadget pull up DP for first plug in case. So when&after
> gadget connect (pullup DP), you should already know the charger type.

Make sense. In our company's solution, charger detection can be done
by hardware from PMIC at first, then it will not affect the DP/DM line
when gadget starts to enumeration. In the 'usb_charger_detect_type()',
it usually get the charger type from type registers has been done by
hardware from PMIC, which can not affect the DP/DM line.

>
> Li Jun
>
>>
>> > think it's necessary to check charger type at every event from usb
>> gadget.
>>
>> My meaning is not every event from usb gadget. When the usb gadget state
>> changes or the extcon device (maybe GPIO detection) state changes, which
>> means charger plugin or pullup, we need to check the charger type to set
>> current.
>
> From your below code, you call usb_charger_notify_others() in
> every state change.

I think it does not matter. In case the usb charger missed some gadget
state changes. Or I replace it with 'USB_STATE_CONFIGURED' state.
Thanks.

>
> if (uchger->old_gadget_state != state) {
>         uchger->old_gadget_state = state;
>
>         if (state >= USB_STATE_ATTACHED)
>                 uchger_state = USB_CHARGER_PRESENT;
>         else if (state == USB_STATE_NOTATTACHED)
>                 uchger_state = USB_CHARGER_REMOVE;
>         else
> /* this else will never happen */
>                 uchger_state = USB_CHARGER_DEFAULT;
>
>         usb_charger_notify_others(uchger, uchger_state);
> }
>
>>
>> > Something in gadget driver you can utilize is only vbus detection, and
>> > report diff current by diff usb state if it's a SDP.
>>
>> --
>> Baolin.wang
>> Best Regards



-- 
Baolin.wang
Best Regards

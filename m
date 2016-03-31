From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 31 Mar 2016 13:33:24 +0800
Message-ID: <CAMz4kuJhrfE_6s2y9Cdo8t3Z3mvKf9rYs-kkRfBFD_SNL7pv=g@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<AM4PR04MB1665C9DAC2519CDCFEF92DDC89870@AM4PR04MB1665.eurprd04.prod.outlook.com>
	<CAMz4kuKkZ1GAjEoi7KB8EwjPQvW2Lf28VPzMgW2QdD=Ro4jzSQ@mail.gmail.com>
	<AM4PR04MB16657BE747BA7451511420D189980@AM4PR04MB1665.eurprd04.prod.outlook.com>
	<CAMz4kuLh9XfuL7kK4v2eJMU=QpdZx3d8KpMfH5Df2iZK=PLCqQ@mail.gmail.com>
	<AM4PR04MB1665F6673ABDDD08AAF68CE489980@AM4PR04MB1665.eurprd04.prod.outlook.com>
	<CAMz4kuLY8vO5qnkuY+kv91zKpdxBBSDeLZXFvD1LjnS3R3UccA@mail.gmail.com>
	<AM4PR04MB1665E85D823D5AB59B54B56D89980@AM4PR04MB1665.eurprd04.prod.outlook.com>
	<878u10jjie.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35671 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbcCaFdZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 01:33:25 -0400
Received: by mail-yw0-f175.google.com with SMTP id g127so85147411ywf.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 22:33:25 -0700 (PDT)
In-Reply-To: <878u10jjie.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Jun Li <jun.li@nxp.com>, Peter Chen <hzpeterchen@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

On 30 March 2016 at 19:24, Felipe Balbi <balbi@kernel.org> wrote:
>>> >> >> >
>>> >> >> > Seems you don't want to guarantee charger type detection is done
>>> >> >> > before gadget connection(pullup DP), right?
>>> >> >> > I see you call usb_charger_detect_type() in each gadget usb
>>> >> >> > state
>>> >> >> changes.
>>> >> >>
>>> >> >> I am not sure I get your point correctly, please correct me if I
>>> >> >> misunderstand you.
>>> >> >> We need to check the charger type at every event comes from the
>>> >> >> usb gadget state changes or the extcon device state changes, which
>>> >> >> means a new charger plugin or pullup.
>>> >> >>
>>> >> >
>>> >> > According to usb charger spec, my understanding is you can't do
>>> >> > real charger detection procedure *after* gadget _connection_(pullup
>>> >> > DP), also I don't
>>> >>
>>> >> Why can not? Charger detection is usually from PMIC.
>>> >
>>> > Charger detection process will impact DP/DM line state, see usb
>>> > charger spec v1.2 for detail detection process, section 4.6.3 says:
>>> >
>>> > "A PD is allowed to *disconnect* and repeat the charger detection
>>> > process multiple times while attached. The PD is required to wait for
>>> > a time of at least TCP_VDM_EN max between disconnecting and restarting
>>> > the charger detection process."
>>> >
>>> > As Peter mentioned, the charger detection should happen between VBUS
>>> > detection and gadget pull up DP for first plug in case. So when&after
>>> > gadget connect (pullup DP), you should already know the charger type.
>>>
>>> Make sense. In our company's solution, charger detection can be done by
>>> hardware from PMIC at first, then it will not affect the DP/DM line when
>>> gadget starts to enumeration.
>>
>> I see, charger type detection is done automatically by PMIC when VBUS
>> is detected in your case, you just assume the process is complete
>
> assuming this finishes before gadget starts is a bad idea. It would've
> been much more robust to delay usb_gadget_connect() until we KNOW
> charger detection has completed.

It is hardware action to detect the charger type quickly. It actually
*gets* the charger type and does not means *detect* charger type in
'usb_charger_detect_type()' function. Maybe I need to change the
function name as 'usb_charger_get_type()'.

If some udc drivers want to detect charger type in
'gadget->ops->get_charger_type()' callback, they should avoid
impacting DP/DM line state at the right gadget state. Thanks.

>
> --
> balbi



-- 
Baolin.wang
Best Regards

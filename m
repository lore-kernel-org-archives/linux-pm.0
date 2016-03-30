From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 30 Mar 2016 14:15:01 +0800
Message-ID: <CAMz4kuLh9XfuL7kK4v2eJMU=QpdZx3d8KpMfH5Df2iZK=PLCqQ@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<20160325070937.GA22398@peterchendt>
	<CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
	<AM4PR04MB1665C9DAC2519CDCFEF92DDC89870@AM4PR04MB1665.eurprd04.prod.outlook.com>
	<CAMz4kuKkZ1GAjEoi7KB8EwjPQvW2Lf28VPzMgW2QdD=Ro4jzSQ@mail.gmail.com>
	<AM4PR04MB16657BE747BA7451511420D189980@AM4PR04MB1665.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33052 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbcC3GPD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 02:15:03 -0400
Received: by mail-yw0-f173.google.com with SMTP id h65so46547847ywe.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 23:15:02 -0700 (PDT)
In-Reply-To: <AM4PR04MB16657BE747BA7451511420D189980@AM4PR04MB1665.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

On 30 March 2016 at 10:54, Jun Li <jun.li@nxp.com> wrote:
>> >> It is not for udc driver but for power users who want to negotiate
>> >> with USB subsystem.
>> >>
>> >
>> > Seems you don't want to guarantee charger type detection is done
>> > before gadget connection(pullup DP), right?
>> > I see you call usb_charger_detect_type() in each gadget usb state
>> changes.
>>
>> I am not sure I get your point correctly, please correct me if I
>> misunderstand you.
>> We need to check the charger type at every event comes from the usb gadget
>> state changes or the extcon device state changes, which means a new
>> charger plugin or pullup.
>>
>
> According to usb charger spec, my understanding is you can't do real charger
> detection procedure *after* gadget _connection_(pullup DP), also I don't

Why can not? Charger detection is usually from PMIC.

> think it's necessary to check charger type at every event from usb gadget.

My meaning is not every event from usb gadget. When the usb gadget
state changes or the extcon device (maybe GPIO detection) state
changes, which means charger plugin or pullup, we need to check the
charger type to set current.

> Something in gadget driver you can utilize is only vbus detection, and
> report diff current by diff usb state if it's a SDP.

-- 
Baolin.wang
Best Regards

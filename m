From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 31 Mar 2016 14:37:30 +0800
Message-ID: <CAMz4ku+Vdnv9aeE944=V=cx1rAHBVMvUehwA-ZLCNr6vzvyQgg@mail.gmail.com>
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
	<CAMz4kuLxfEr_cOa0F-Qh+Mo+dEVGWx+YPZ_=yb9FVwWdJd8viQ@mail.gmail.com>
	<HE1PR04MB167436923F9920CB4417FD5989990@HE1PR04MB1674.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <HE1PR04MB167436923F9920CB4417FD5989990@HE1PR04MB1674.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 31 March 2016 at 14:12, Jun Li <jun.li@nxp.com> wrote:
> Hi
>
>> -----Original Message-----
>> From: Baolin Wang [mailto:baolin.wang@linaro.org]
>> Sent: Thursday, March 31, 2016 1:23 PM
>> To: Jun Li <jun.li@nxp.com>
>> Cc: Peter Chen <hzpeterchen@gmail.com>; Felipe Balbi <balbi@kernel.org>;
>> Greg KH <gregkh@linuxfoundation.org>; Sebastian Reichel <sre@kernel.org>;
>> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>; David Woodhouse
>> <dwmw2@infradead.org>; Peter Chen <peter.chen@freescale.com>; Alan Stern
>> <stern@rowland.harvard.edu>; r.baldyga@samsung.com; Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com>; Lee Jones <lee.jones@linaro.org>; Mark
>> Brown <broonie@kernel.org>; Charles Keepax
>> <ckeepax@opensource.wolfsonmicro.com>; patches@opensource.wolfsonmicro.com;
>> Linux PM list <linux-pm@vger.kernel.org>; USB <linux-usb@vger.kernel.org>;
>> device-mainlining@lists.linuxfoundation.org; LKML <linux-
>> kernel@vger.kernel.org>
>> Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with
>> the usb gadget power negotation
>>
>> On 30 March 2016 at 18:58, Jun Li <jun.li@nxp.com> wrote:
>> >> >> >> > Seems you don't want to guarantee charger type detection is
>> >> >> >> > done before gadget connection(pullup DP), right?
>> >> >> >> > I see you call usb_charger_detect_type() in each gadget usb
>> >> >> >> > state
>> >> >> >> changes.
>> >> >> >>
>> >> >> >> I am not sure I get your point correctly, please correct me if
>> >> >> >> I misunderstand you.
>> >> >> >> We need to check the charger type at every event comes from the
>> >> >> >> usb gadget state changes or the extcon device state changes,
>> >> >> >> which means a new charger plugin or pullup.
>> >> >> >>
>> >> >> >
>> >> >> > According to usb charger spec, my understanding is you can't do
>> >> >> > real charger detection procedure *after* gadget
>> >> >> > _connection_(pullup DP), also I don't
>> >> >>
>> >> >> Why can not? Charger detection is usually from PMIC.
>> >> >
>> >> > Charger detection process will impact DP/DM line state, see usb
>> >> > charger spec v1.2 for detail detection process, section 4.6.3 says:
>> >> >
>> >> > "A PD is allowed to *disconnect* and repeat the charger detection
>> >> > process multiple times while attached. The PD is required to wait
>> >> > for a time of at least TCP_VDM_EN max between disconnecting and
>> >> > restarting the charger detection process."
>> >> >
>> >> > As Peter mentioned, the charger detection should happen between
>> >> > VBUS detection and gadget pull up DP for first plug in case. So
>> >> > when&after gadget connect (pullup DP), you should already know the
>> charger type.
>> >>
>> >> Make sense. In our company's solution, charger detection can be done
>> >> by hardware from PMIC at first, then it will not affect the DP/DM
>> >> line when gadget starts to enumeration.
>> >
>> > I see, charger type detection is done automatically by PMIC when VBUS
>> > is detected in your case, you just assume the process is complete
>> > before SW do gadget connect. To make the framework common, you may do
>> one time charger type check when vbus is on, and save it to avoid repeat
>> charger type check.
>>
>> OK. I'll add one judgement to check if the charger type is set in
>> 'usb_charger_detect_type()' function.
>
> Just adding a judgement isn't enough here, your framework should make sure
> usb_charger_detect_type() is called before gadget connect, with that, the
> existing caller place just gets the charger type from the saved value.
> The real charger type detection done by usb_charger_detect_type() can
> be called only when vbus is on.
> e.g. maybe in usb_udc_vbus_handler() before usb_udc_connect_control().

Yeah, Like Felipe suggested, I think we need to introduce one
'charger_detect()' method to do the SW charger type detection at the
right gadget state. Thanks for your comments.

>>
>> --
>> Baolin.wang
>> Best Regards



-- 
Baolin.wang
Best Regards

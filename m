From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 31 Mar 2016 16:24:44 +0800
Message-ID: <CAMz4kuK_DYxs=-gr5nFFTMdoR9mnNhg4B6jtejat2skFatt6Jg@mail.gmail.com>
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
	<CAMz4ku+Vdnv9aeE944=V=cx1rAHBVMvUehwA-ZLCNr6vzvyQgg@mail.gmail.com>
	<87egargj1y.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87egargj1y.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 31 March 2016 at 16:15, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> Hi Baolin,
>
> Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>>> >> Make sense. In our company's solution, charger detection can be done
>>>> >> by hardware from PMIC at first, then it will not affect the DP/DM
>>>> >> line when gadget starts to enumeration.
>>>> >
>>>> > I see, charger type detection is done automatically by PMIC when VBUS
>>>> > is detected in your case, you just assume the process is complete
>>>> > before SW do gadget connect. To make the framework common, you may do
>>>> one time charger type check when vbus is on, and save it to avoid repeat
>>>> charger type check.
>>>>
>>>> OK. I'll add one judgement to check if the charger type is set in
>>>> 'usb_charger_detect_type()' function.
>>>
>>> Just adding a judgement isn't enough here, your framework should make sure
>>> usb_charger_detect_type() is called before gadget connect, with that, the
>>> existing caller place just gets the charger type from the saved value.
>>> The real charger type detection done by usb_charger_detect_type() can
>>> be called only when vbus is on.
>>> e.g. maybe in usb_udc_vbus_handler() before usb_udc_connect_control().
>>
>> Yeah, Like Felipe suggested, I think we need to introduce one
>> 'charger_detect()' method to do the SW charger type detection at the
>> right gadget state. Thanks for your comments.
>
> Just to be clear, we add ->charger_detect() when we know of a platform
> which needs to manually detect the charger type. Until then, we ignore
> that situation. It might be a good idea, however, do document this in
> comments on your structure definition stating that if we need to detect
> charger type, a new method should be added ;-)

Make sense. Thanks.

>
> cheers
>
> --
> balbi



-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

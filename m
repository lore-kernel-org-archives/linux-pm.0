From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v9 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 5 Apr 2016 19:06:01 +0800
Message-ID: <CAMz4kuKcy6Kw0jCizYk3PyP0AAv=te5ZceK1qJbkoJu7ZNC-rw@mail.gmail.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
	<20160405064637.GA31351@shlinux2.ap.freescale.net>
	<CAMz4kuKWpFLbYJM+m3syT+aMNVxjBipU_3=qwz=X0L_oB5bR0w@mail.gmail.com>
	<20160405081222.GC31351@shlinux2.ap.freescale.net>
	<CAMz4kuJAq0RGsqz5XoKOft_DKGTDXscwenPp97Drbm79ON49=w@mail.gmail.com>
	<20160405094320.GA6301@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33719 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779AbcDELGD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 07:06:03 -0400
Received: by mail-yw0-f178.google.com with SMTP id t10so11811622ywa.0
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2016 04:06:02 -0700 (PDT)
In-Reply-To: <20160405094320.GA6301@shlinux2.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 5 April 2016 at 17:43, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Tue, Apr 05, 2016 at 05:34:02PM +0800, Baolin Wang wrote:
>> On 5 April 2016 at 16:12, Peter Chen <hzpeterchen@gmail.com> wrote:
>> > On Tue, Apr 05, 2016 at 03:54:31PM +0800, Baolin Wang wrote:
>> >> Hi Peter,
>> >>
>> >> On 5 April 2016 at 14:46, Peter Chen <hzpeterchen@gmail.com> wrote:
>> >> >
>> >> > We are thinking USB charger framework for Freescale i.mx SoC series,
>> >> > since our internal framework is not good enough.
>> >> > So I have more questions for your framework since there are many
>> >> > different USB charger designs, and I hope it is universal.
>> >>
>> >> Great, thanks for your attention and suggestions.
>> >>
>> >> >
>> >> > - I would like to see your all code to let the charger work, eg
>> >> > you have said the charger detection is done by PMIC automatically,
>> >> > but I did not find your PMIC code to read charger type.
>> >>
>> >> Yeah, this patchset did not give an example to read charger type from
>> >> PMIC registers. (Cause now the user 'wm831x_power' don't need this.)
>> >> But I think user can get it easily by implementing below callbacks.
>> >> (1) gadget->ops->get_charger_type();
>> >> (2) power_supply_get_property(uchger->psy, POWER_SUPPLY_PROP_CHARGE_TYPE, &val);
>> >> (3) uchger->get_charger_type();
>> >>
>> >
>> > I just would like if you can have this, then, we (you) can test it, eg,
>> > you can test if the wm831x can charge more than 1500mA for DCP.
>>
>> Mark, could you please address Peter's comments about if the the
>> wm831x can charge more than 1500mA for DCP? (I have no environment to
>> test wm831x) Thanks.
>>
>
> I don't want you or Mark to test at hardware, I just would like to see
> some code that how PMIC, wm831x, and USB gadget driver work together.

The whole code are in this patchset.

>
>> >> >
>> >> > Besides, how you can make sure the charger detection has finished
>> >> > before the framework handles USB_CHARGER_PRESENT event?
>> >>
>> >> I think we don't need to care about this situation. If the charger
>> >> type is 'UNKNOWN_TYPE' (maybe charger detection is not finished yet),
>> >> the charger framework will not set current (current is 0) for power
>> >> driver.
>> >
>> > Then, when we notify the charger IC for larger current, eg, for DCP.
>>
>> I suppose If the usb charger framework gets the charger type, then
>> notify the charger IC for larger current.
>
> It is no problem for software detection, but for hardware one, it must
> make sure it sends "USB_CHARGER_PRESENT" event after detection has
> finished, otherwise no one will notify charger framework for DCP.

Yeah, the hardware detection should guarantee charger detection will
be finished firstly.

>
>>
>> >
>> >>
>> >> >
>> >> > - I commented the current limit at different situations for USB
>> >> > charger last time, but I have not seen your further comments.
>> >> > I would like give it again. For DCP, you can notify charger IC
>> >> > once you get the charger type. But for CDP/SDP, you need to
>> >> > notify charger IC after set configuration has finished, since
>> >> > the host may still not be ready to give high current.
>> >>
>> >> As my understanding, if the usb charger framework get the charger
>> >> type, it means we can notify the power driver to set the current. If
>> >> you don't ready for setting current, please don't give the charger
>> >> type to usb charger framework.
>> >>
>> >> The framework does not want to focus on charger detection too much,
>> >> and just supplies one callback '->charger_detect()' for user to be
>> >> implemented if they ensure they need to do the SW charger detection
>> >> manually (Note: must at the right time to do the SW detection.). So
>> >> the usb charger just focus on dealing with the usb gadget power
>> >> negotiation, and it does not need to care much how to do charger
>> >> detection on your platform.
>> >
>> > No, this comment is common one, but only for SW detection. Eg, when
>> > the PMIC tells you it is a SDP, you can't notify to charger IC about
>> > 500mA at once, you need to do it after host allows you to do it.
>>
>> Well. Sounds reasonable. I just give an ugly example to implement the
>> 'gadget->ops->get_charger_type()' method to get the charger type.
>>
>> enum usb_charger_type get_charger_type(struct usb_gadget *gadget)
>> {
>>         if (host is allowed)
>>                 read charger type from PMIC;
>>         else
>>                 return UNKNOWN_TYPE;
>> }
>>
>> So that will makes usb charger do not need to care about too much to
>> make things more complicated. Or do you have any other good
>> suggestions? Thanks.
>>
>
> Since it is a USB charger, you had to be involved with USB stuffs:).

OK. Maybe I need to do some investigation about that. Thanks.

>
> --
>
> Best Regards,
> Peter Chen



-- 
Baolin.wang
Best Regards

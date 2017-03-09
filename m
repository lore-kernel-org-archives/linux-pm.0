From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 9 Mar 2017 14:10:51 +0800
Message-ID: <CAMz4kuJ31wVhbYOV+LB9tu=Wb7x9gRifcUnQPMiQSqRUjER_kQ@mail.gmail.com>
References: <cover.1487578977.git.baolin.wang@linaro.org> <87zih3m73h.fsf@notabene.neil.brown.name>
 <CAMz4ku+98HAgVnMoCg0YaPpcY1NvdKdbK6AuDyzgNOrcbpaz9A@mail.gmail.com> <AM5PR04MB29614C707DE344E5A05FAB3889210@AM5PR04MB2961.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34363 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdCIGTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2017 01:19:42 -0500
Received: by mail-oi0-f48.google.com with SMTP id m124so31715019oig.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2017 22:19:03 -0800 (PST)
In-Reply-To: <AM5PR04MB29614C707DE344E5A05FAB3889210@AM5PR04MB2961.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: NeilBrown <neilb@suse.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "robh@kernel.org" <robh@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfson>

Hi,

On 9 March 2017 at 09:50, Jun Li <jun.li@nxp.com> wrote:
> Hi,
>
>> -----Original Message-----
>> From: Baolin Wang [mailto:baolin.wang@linaro.org]
>> Sent: Tuesday, March 07, 2017 5:39 PM
>> To: NeilBrown <neilb@suse.com>
>> Cc: Felipe Balbi <balbi@kernel.org>; Greg KH <gregkh@linuxfoundation.org>;
>> Sebastian Reichel <sre@kernel.org>; Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com>; David Woodhouse <dwmw2@infradead.org>;
>> robh@kernel.org; Jun Li <jun.li@nxp.com>; Marek Szyprowski
>> <m.szyprowski@samsung.com>; Ruslan Bilovol <ruslan.bilovol@gmail.com>;
>> Peter Chen <peter.chen@freescale.com>; Alan Stern
>> <stern@rowland.harvard.edu>; grygorii.strashko@ti.com; Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com>; Lee Jones <lee.jones@linaro.org>;
>> Mark Brown <broonie@kernel.org>; John Stultz <john.stultz@linaro.org>;
>> Charles Keepax <ckeepax@opensource.wolfsonmicro.com>;
>> patches@opensource.wolfsonmicro.com; Linux PM list <linux-
>> pm@vger.kernel.org>; USB <linux-usb@vger.kernel.org>; device-
>> mainlining@lists.linuxfoundation.org; LKML <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with
>> the usb gadget power negotation
>>
>> On 3 March 2017 at 10:23, NeilBrown <neilb@suse.com> wrote:
>> > On Mon, Feb 20 2017, Baolin Wang wrote:
>> >
>> >> Currently the Linux kernel does not provide any standard integration
>> >> of this feature that integrates the USB subsystem with the system
>> >> power regulation provided by PMICs meaning that either vendors must
>> >> add this in their kernels or USB gadget devices based on Linux (such
>> >> as mobile phones) may not behave as they should. Thus provide a
>> standard framework for doing this in kernel.
>> >>
>> >> Now introduce one user with wm831x_power to support and test the usb
>> charger.
>> >> Another user introduced to support charger detection by Jun Li:
>> >> https://www.spinics.net/lists/linux-usb/msg139425.html
>> >> Moreover there may be other potential users will use it in future.
>> >>
>> >> 1. Before v19 patchset we've fixed below issues in extcon subsystem
>> >> and usb phy driver, now all were merged. (Thanks for Neil's
>> >> suggestion)
>> >> (1) Have fixed the inconsistencies with USB connector types in extcon
>> >> subsystem by following links:
>> >> https://lkml.org/lkml/2016/12/21/13
>> >> https://lkml.org/lkml/2016/12/21/15
>> >> https://lkml.org/lkml/2016/12/21/79
>> >> https://lkml.org/lkml/2017/1/3/13
>> >>
>> >> (2) Instead of using 'set_power' callback in phy drivers, we will
>> >> introduce USB charger to set PMIC current drawn from USB
>> >> configuration, moreover some 'set_power' callbacks did not implement
>> >> anything to set PMIC current, thus remove them by following links:
>> >> https://lkml.org/lkml/2017/1/18/436
>> >> https://lkml.org/lkml/2017/1/18/439
>> >> https://lkml.org/lkml/2017/1/18/438
>> >> Now only two phy drivers (phy-isp1301-omap.c and phy-gpio-vbus-usb.c)
>> >> still used 'set_power' callback to set current, we can remove them in
>> >> future. (I have no platform with enabling these two phy drivers, so I
>> >> can not test them if I converted 'set_power' callback to USB
>> >> charger.)
>> >>
>> >> 2. Some issues pointed by Neil Brown were sill kept in this v19
>> >> patchset, and I expalined each issue and may be need discuss again:
>> >> (1) Change all usb phys to register an extcon and to send appropriate
>> notifications.
>> >> Firstly, now only 3 USB phy drivers (phy-qcom-8x16-usb.c,
>> >> phy-omap-otg.c and
>> >> phy-msm-usb.c) had registered an extcon, mostly did not. I can not
>> >> change all usb phys to register an extcon, since there are no extcon
>> >> device to register for these different phy drivers.
>> >
>> > You don't have to change every driver.  You just need to make it easy
>> > and obvious how to change drivers in a consistent coherent way.
>> > For a start you would add a 'struct extcon_dev' to 'struct usb_phy',
>> > and possibly add or extend some 'static inline's in linux/usb/phy.h to
>> > send notification on that extcon (if it is non-NULL).
>> > e.g. usb_phy_vbus_on() could send an extcon notification.
>> >
>> > Then any phy driver which adds support for setting phy->extcon_dev
>> > appropriately, immediately gets the relevant notifications sent.
>>
>> OK. We can make these extcon related code into phy common part.
>>
>
> Will generic phy need add extcon as well?

Yes, will add a 'struct extcon_dev*' in 'struct usb_phy', which will
be common code.

>
>> >
>> >> Secondly, I also agreed with Peter's comments: Not only USB PHY to
>> >> register an extcon, but also for the drivers which can detect USB
>> >> charger type, it may be USB controller driver, USB type-c driver,
>> >> pmic driver, and these drivers may not have an extcon device since
>> >> the internal part can finish the vbus detect.
>> >
>> > Whichever part can detect vbus, the driver for that part must be able
>> > to find the extcon and trigger a notification.
>> > Maybe one part can detect VBUS, another can measure the resistance on
>> > ID and a third can work through the state machine to determine if D+
>> > and D- are shorted together.
>> > Somehow these three need to work together to determine what is
>> plugged
>> > in to the external connection port.  Somewhere there much an 'extcon'
>> > device which represents that port and which the three devices can find
>> > and can interact with.
>> > I think it makes sense for the usb_phy to be the connection point.
>> > Each of the devices can get to the phy, and the phy can get to the extcon.
>> > It doesn't matter very much if the usb phy driver creates the extcon,
>> > or if something else creates the extcon and the phy driver performs a
>> > lookup to find it (e.g. based on devicetree info).
>> >
>> > The point is that there is obviously an external physical connection,
>> > and so there should be an 'extcon' device that represents it.
>>
>> Peter & Jun, is it OK for you every phy has one extcon device to receive VBUS
>> notification, especially for detecting the charger type by software?
>>
>
> My understanding is phy/usb_phy as the connection point, will send the notification
> to PMIC driver which actually control the charge current, also this will be done in
> your common framework, right?

Not in USB charger framework. If we are all agree every usb_phy can
register one extcon device, can get correct charger type and send out
correct vbus_draw information, then we don't need USB charger
framework as Neil suggested. So this will be okay for your case
(especially for detecting the charger type by software) ?

>> >
>> >>
>> >> (2) Change the notifier of usb_phy to be used consistently.
>> >> Now only 3 phy drivers (phy-generic.c, phy-ab8500-usb.c and
>> >> phy-gpio-vbus-usb.c) used the notifier of usb_phy. phy-generic.c and
>> >> phy-gpio-vbus-usb.c were used to send out the connect events, and
>> >> phy-ab8500-usb.c also was used to send out the MUSB connect events.
>> >> There are no phy drivers will notify 'vbus_draw' information by the
>> notifier of usb_phy, which was used consistently now.
>> >> Moreover it is difficult to change the notifier of usb_phy to be used
>> >> only to communicate the 'vbus_draw' information, since we need to
>> >> refactor and test these related phy drivers, power drivers or some
>> >> mfd drivers, which is a huge workload.
>> >
>> > You missed drivers/usb/musb/omap2430.c in you list, but that hardly
>> > matters.
>>
>> But it did not use the notifier of usb_phy.
>>
>> > phy-ab8500-usb.c appears to send vbus_draw information.
>>
>> Users will not use the vbus_draw information send from phy-ab8500-usb.c
>>
>> >
>> > I understand your reluctance to change drivers that you cannot test.
>> > An alternative it do change all the
>> >   atomic_notifier_call_chain(.*notifier,
>> > calls that don't pass a pointer to vbus_draw to pass NULL, and to
>> > declare the passing of NULL to be deprecated (so hopefully people
>> > won't use it in new code).
>> > Then any notification callback that expects a current can just ignore
>> > calls where the pointer is NULL.
>>
>> I am afraid if it is enough to send out vbus draw information from USB phy
>> driver, for example you will miss super speed (900mA), which need get the
>> speed information from gadget driver.
>>
>> >
>> > The one difficulty with this is drivers/usb/gadget/udc/pxa27x_udc.c
>> > It is the only driver which expects a 'gadget', and it doesn't really
>> > need to as it already knows the gadget.
>> > The patch below fixes this.
>> > With that in place, phy-generic and phy-gpio-vbus-usb can be changed
>> > to pass NULL.  When we can safely use the notifier to pass vbus_draw
>> > information uniformly.
>> >
>> >>
>> >> (3) Still keep charger_type_show() API.
>> >> Firstly I think we should combine all charger related information
>> >> into one place for users, which is convenient.
>> >
>> > convenience is very much a secondary issue.
>> >
>> >> Secondly not only we get charger type from extcon, but also in some
>> >> scenarios we can get charger type from USB controller driver, USB
>> >> type-c driver, pmic driver, we should also need one place to export the
>> charger type.
>> >
>> > As I have said, all of these sources of information should feed into
>> > the extcon.
>> >
>> > There are ultimately two possible sources of information about the
>> > current available from the usb port.
>> > One is the physical properties of the cable, such as resistance of ID,
>> > any short between D+ and D- etc.  Being properties of the cable, they
>> > should be reported through the extcon.
>> >
>> > The other is information gathered during the USB protocol handshake.
>> > For USB2, this is the requested current of the profile that the host
>> > activates.  This should be reported though the USB gadget device.
>> >
>> > I don't know how USB3 and/or type-C work but I would be surprised if
>> > they don't fit into the two cases above.  If you think otherwise,
>> > please surprise me.  I'm always keen to learn.
>> >
>> > If the extcon reports the type of cable detected, and the gadget
>> > reports the result of any negotiation, then that is enough to
>> > determine the charger type.  It doesn't need to be more convenient than
>> that.
>>
>> If we are all agree we did not need the USB charger, then we can add
>> 'current' attribute of USB gadget device.
>> Thanks for your suggestion.
>>
>> --
>> Baolin.wang
>> Best Regards



-- 
Baolin.wang
Best Regards

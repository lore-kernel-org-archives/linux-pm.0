From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 7 Mar 2017 17:38:41 +0800
Message-ID: <CAMz4ku+98HAgVnMoCg0YaPpcY1NvdKdbK6AuDyzgNOrcbpaz9A@mail.gmail.com>
References: <cover.1487578977.git.baolin.wang@linaro.org> <87zih3m73h.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87zih3m73h.fsf-wvvUuzkyo1HefUI2i7LXDhCRmIWqnp/j@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 3 March 2017 at 10:23, NeilBrown <neilb-IBi9RG/b67k@public.gmane.org> wrote:
> On Mon, Feb 20 2017, Baolin Wang wrote:
>
>> Currently the Linux kernel does not provide any standard integration of this
>> feature that integrates the USB subsystem with the system power regulation
>> provided by PMICs meaning that either vendors must add this in their kernels
>> or USB gadget devices based on Linux (such as mobile phones) may not behave
>> as they should. Thus provide a standard framework for doing this in kernel.
>>
>> Now introduce one user with wm831x_power to support and test the usb charger.
>> Another user introduced to support charger detection by Jun Li:
>> https://www.spinics.net/lists/linux-usb/msg139425.html
>> Moreover there may be other potential users will use it in future.
>>
>> 1. Before v19 patchset we've fixed below issues in extcon subsystem and usb
>> phy driver, now all were merged. (Thanks for Neil's suggestion)
>> (1) Have fixed the inconsistencies with USB connector types in extcon subsystem
>> by following links:
>> https://lkml.org/lkml/2016/12/21/13
>> https://lkml.org/lkml/2016/12/21/15
>> https://lkml.org/lkml/2016/12/21/79
>> https://lkml.org/lkml/2017/1/3/13
>>
>> (2) Instead of using 'set_power' callback in phy drivers, we will introduce
>> USB charger to set PMIC current drawn from USB configuration, moreover some
>> 'set_power' callbacks did not implement anything to set PMIC current, thus
>> remove them by following links:
>> https://lkml.org/lkml/2017/1/18/436
>> https://lkml.org/lkml/2017/1/18/439
>> https://lkml.org/lkml/2017/1/18/438
>> Now only two phy drivers (phy-isp1301-omap.c and phy-gpio-vbus-usb.c) still
>> used 'set_power' callback to set current, we can remove them in future. (I
>> have no platform with enabling these two phy drivers, so I can not test them
>> if I converted 'set_power' callback to USB charger.)
>>
>> 2. Some issues pointed by Neil Brown were sill kept in this v19 patchset, and
>> I expalined each issue and may be need discuss again:
>> (1) Change all usb phys to register an extcon and to send appropriate notifications.
>> Firstly, now only 3 USB phy drivers (phy-qcom-8x16-usb.c, phy-omap-otg.c and
>> phy-msm-usb.c) had registered an extcon, mostly did not. I can not change all
>> usb phys to register an extcon, since there are no extcon device to register
>> for these different phy drivers.
>
> You don't have to change every driver.  You just need to make it easy
> and obvious how to change drivers in a consistent coherent way.
> For a start you would add a 'struct extcon_dev' to 'struct usb_phy', and
> possibly add or extend some 'static inline's in linux/usb/phy.h to send
> notification on that extcon (if it is non-NULL).
> e.g. usb_phy_vbus_on() could send an extcon notification.
>
> Then any phy driver which adds support for setting phy->extcon_dev
> appropriately, immediately gets the relevant notifications sent.

OK. We can make these extcon related code into phy common part.

>
>> Secondly, I also agreed with Peter's comments: Not only USB PHY to register
>> an extcon, but also for the drivers which can detect USB charger type, it may
>> be USB controller driver, USB type-c driver, pmic driver, and these drivers
>> may not have an extcon device since the internal part can finish the vbus
>> detect.
>
> Whichever part can detect vbus, the driver for that part must be able to
> find the extcon and trigger a notification.
> Maybe one part can detect VBUS, another can measure the resistance on ID
> and a third can work through the state machine to determine if D+ and D-
> are shorted together.
> Somehow these three need to work together to determine what is plugged
> in to the external connection port.  Somewhere there much an 'extcon'
> device which represents that port and which the three devices can find
> and can interact with.
> I think it makes sense for the usb_phy to be the connection point.  Each
> of the devices can get to the phy, and the phy can get to the extcon.
> It doesn't matter very much if the usb phy driver creates the extcon, or
> if something else creates the extcon and the phy driver performs a
> lookup to find it (e.g. based on devicetree info).
>
> The point is that there is obviously an external physical connection,
> and so there should be an 'extcon' device that represents it.

Peter & Jun, is it OK for you every phy has one extcon device to
receive VBUS notification, especially for detecting the charger type
by software?

>
>>
>> (2) Change the notifier of usb_phy to be used consistently.
>> Now only 3 phy drivers (phy-generic.c, phy-ab8500-usb.c and phy-gpio-vbus-usb.c)
>> used the notifier of usb_phy. phy-generic.c and phy-gpio-vbus-usb.c were used to
>> send out the connect events, and phy-ab8500-usb.c also was used to send out the
>> MUSB connect events. There are no phy drivers will notify 'vbus_draw' information
>> by the notifier of usb_phy, which was used consistently now.
>> Moreover it is difficult to change the notifier of usb_phy to be used only to
>> communicate the 'vbus_draw' information, since we need to refactor and test these
>> related phy drivers, power drivers or some mfd drivers, which is a
>> huge workload.
>
> You missed drivers/usb/musb/omap2430.c in you list, but that hardly
> matters.

But it did not use the notifier of usb_phy.

> phy-ab8500-usb.c appears to send vbus_draw information.

Users will not use the vbus_draw information send from phy-ab8500-usb.c

>
> I understand your reluctance to change drivers that you cannot test.
> An alternative it do change all the
>   atomic_notifier_call_chain(.*notifier,
> calls that don't pass a pointer to vbus_draw to pass NULL, and to
> declare the passing of NULL to be deprecated (so hopefully people won't
> use it in new code).
> Then any notification callback that expects a current can just ignore
> calls where the pointer is NULL.

I am afraid if it is enough to send out vbus draw information from USB
phy driver, for example you will miss super speed (900mA), which need
get the speed information from gadget driver.

>
> The one difficulty with this is drivers/usb/gadget/udc/pxa27x_udc.c
> It is the only driver which expects a 'gadget', and it doesn't really
> need to as it already knows the gadget.
> The patch below fixes this.
> With that in place, phy-generic and phy-gpio-vbus-usb can be changed to
> pass NULL.  When we can safely use the notifier to pass vbus_draw
> information uniformly.
>
>>
>> (3) Still keep charger_type_show() API.
>> Firstly I think we should combine all charger related information into one
>> place for users, which is convenient.
>
> convenience is very much a secondary issue.
>
>> Secondly not only we get charger type from extcon, but also in some scenarios
>> we can get charger type from USB controller driver, USB type-c driver, pmic
>> driver, we should also need one place to export the charger type.
>
> As I have said, all of these sources of information should feed into the
> extcon.
>
> There are ultimately two possible sources of information about the
> current available from the usb port.
> One is the physical properties of the cable, such as resistance of ID,
> any short between D+ and D- etc.  Being properties of the cable, they
> should be reported through the extcon.
>
> The other is information gathered during the USB protocol handshake.
> For USB2, this is the requested current of the profile that the host
> activates.  This should be reported though the USB gadget device.
>
> I don't know how USB3 and/or type-C work but I would be surprised if they
> don't fit into the two cases above.  If you think otherwise, please
> surprise me.  I'm always keen to learn.
>
> If the extcon reports the type of cable detected, and the gadget reports
> the result of any negotiation, then that is enough to determine the
> charger type.  It doesn't need to be more convenient than that.

If we are all agree we did not need the USB charger, then we can add
'current' attribute of USB gadget device.
Thanks for your suggestion.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

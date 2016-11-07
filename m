From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 7 Nov 2016 16:14:24 +0800
Message-ID: <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
 <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <87a8dls7yn.fsf@notabene.neil.brown.name> <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
 <871sytqrqh.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871sytqrqh.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 3 November 2016 at 09:25, NeilBrown <neilb@suse.com> wrote:
> On Tue, Nov 01 2016, Baolin Wang wrote:
>
>
>>> So I won't be responding on this topic any further until I see a genuine
>>> attempt to understand and resolve the inconsistencies with
>>> usb_register_notifier().
>>
>> Any better solution?
>
> I'm not sure exactly what you are asking, so I'll assume you are asking
> the question I want to answer :-)
>
> 1/ Liase with the extcon developers to resolve the inconsistencies
>   with USB connector types.
>   e.g. current there is both "EXTCON_USB" and "EXTCON_CHG_USB_SDP"
>   which both seem to suggest a standard downstream port.  There is no
>   documentation describing how these relate, and no consistent practice
>   to copy.
>   I suspect the intention is that
>     EXTCON_USB and EXTCON_USB_HOST indicated that data capabilities of
>     the cable, while EXTCON_CHG_USB* indicate the power capabilities of
>     the cable.
>     So EXTCON_CHG_USB_SDP should always appear together with EXTCON_USB
>     while EXTCON_CHG_USB_DCP would not, and EXTCON_CHG_USB_ACA
>     would normally appear with EXTCON_USB_HOST (I think).
>   Some drivers follow this model, particularly extcon-max14577.c
>   but it is not consistent.
>
>   This policy should be well documented and possibly existing drivers
>   should be updated to follow it.
>
>   At the same time it would make sense to resolve EXTCON_CHG_USB_SLOW
>   and EXTCON_CHG_USB_FAST.  These names don't mean much.
>   They were recently removed from drivers/power/axp288_charger.c
>   which is good, but are still used in drivers/extcon/extcon-max*
>   Possibly they should be changed to names from the standard, or
>   possibly they should be renamed to identify the current they are
>   expected to provide. e.g. EXTCON_CHG_USB_500MA and EXTCON_CHG_USB_1A
>
> 2/ Change all usb phys to register an extcon and to send appropriate
>    notifications.  Many already do, but I don't think it is universal.
>    It is probable that the extcon should be registered using common code
>    instead of each phy driver having its own
>    extcon_get_edev_by_phandle()
>    or whatever.
>    If the usb phy driver needs to look at battery charger registers to
>    know what sort of cable was connected (which I believe is the case
>    for the chips you are interested in), then it should do that.
>
> 3/ Currently some USB controllers discover that a cable was connected by
>    listening on an extcon, and some by registering for a usb_notifier
>    (described below) ... though there seem to only be 2 left which do that.
>    Now that all USB phys send connection information via extcon (see 2),
>    the USB controllers should be changed to all find out about the cable
>    using extcon.
>
> 4/ struct usb_phy contains:
>         /* for notification of usb_phy_events */
>         struct atomic_notifier_head     notifier;
>
>   This is used inconsistently.  Sometimes the argument passed
>   is NULL, sometimes it is a pointer to 'vbus_draw' - the current
>   limited negotiated via USB, sometimes it is a pointer the the gadget
>   though as far as I can tell, that last one is never used.
>
>   This should be changed to be consistent.  This notifier is no longer
>   needed to tell the USB controller that a cable was connected (extcon
>   now does that, see 3) so it is only used to communicate the
>   'vbus_draw' information.
>   So it should be changed to *only* send a notification when vbus_draw
>   is known, and it should carry that information.
>   This should probably be done in common code, and removed
>   from individual drivers.
>
> 5/ Now that all cable connection notifications are sent over extcon and
>    all vbus_draw notifications are sent over the usb_phy notifier, write
>    some support code that a power supply client can use to be told what
>    power is available.
>    e.g. a battery charger driver would call:
>        register_power_client(.....)
>    or similar, providing a phandle (or similar) for the usb phy and a
>    function to call back when the available current changes (or maybe a
>    work_struct containing the function pointer)
>
>    register_power_client() would then register with extcon and separately
>    with the usb_phy notifier.  When the different events arrive it
>    calculates what ranges of currents are expected and calls the
>    call-back function with those details.
>
> 6/ Any battery charger that needs to know the available current can now
>    call register_power_client() and get the information delivered.

I agree with your most opinions, but these are optimization. Firstly I
think we should upstream the USB charger driver. What I want to ask is
how can we notify power driver if we don't set the
usb_register_notifier(), then I think you give the answer is: power
driver can register by 'struct usb_phy->notifier'. But why usb phy
should notify the power driver how much current should be drawn, and I
still think we should notify the current in usb charger driver which
is better, and do not need to notify current for power driver in usb
phy driver.

-- 
Baolin.wang
Best Regards

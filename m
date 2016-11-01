From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 1 Nov 2016 20:54:41 +0800
Message-ID: <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
 <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <87a8dls7yn.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33048 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423019AbcKAMym (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 08:54:42 -0400
Received: by mail-yw0-f181.google.com with SMTP id r204so65000758ywb.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2016 05:54:42 -0700 (PDT)
In-Reply-To: <87a8dls7yn.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>

Hi,

On 31 October 2016 at 08:00, NeilBrown <neilb@suse.com> wrote:
> On Fri, Oct 28 2016, Baolin Wang wrote:
>
>>>
>>> 3/ usb_charger_notify_state() does nothing if the state doesn't change.
>>>   When the extcon detects an SDP, it will be called to set the state
>>>   to USB_CHARGER_PRESENT.  The value of cur.sdp_max will be whatever
>>>   it happened to be before, which is probably wrong.
>>
>> Sorry, I did not get your points here, could you please explain it explicitly?
>
> usb_charger_get_current() is used to get the min/max current that is
> supported.
> In the case that an SDP (non-super-speed) has been detected it will
> report the values sdp_min and sdp_max.  Ignoring usb_charger_set_current(),
> sdp_max is set
>  - to DEFAULT_SDP_CUR_MAX (500) at initializaion
>  - to cur_limit when usb_charger_set_cur_limit_by_gadget() is called
>      which happens after USB negotiation, once an allowed vbus_draw is
>      negotiated.
>
> This means that the first time you plug in an SDP cable, the reported
> max will be 500, even though nothing has been negotiated.   The maximum
> before negotiation is much less than that  - I don't remember exactly
> how much.
>
> If negotiation completes, the sdp_max will be set to whatever was
> negotiated.  Maybe 200mA.
> If you unplug, and then plug another SDP cable in, the sdp_max will
> still be 200mA - different from the first time, but still not correct.
> It will remain incorrect until (and unless) USB negotiation completes.

Yes. I need some modification to reset current to default values when
cable unplugged.

>
>>
>>>   When after USB negotiation completes,
>>>   usb_charger_set_cur_limit_by_gadget()
>>>   will call into usb_charger_notify_state() to set USB_CHARGER_PRESENT
>>>   again, but with a new current.  This will be ignored, as the state is
>>>   already USB_CHARGER_PRESENT.
>>
>> No, we will notify the user the current has been changed by one work.
>
> I can see no evidence in the code to justify this assertion, and you
> didn't even try to provide any.

We have one work to notify the user the current has been changed,
please see usb_charger_notify_work().

>
>>
>>>
>>> 4/ I still strongly object to the ->get_charger_type() interface.
>>>  You previously said:
>>>
>>>      No. User can implement the get_charger_type() method to access the
>>>      PMIC registers to get the charger type, which is one very common method.
>>>
>>>  I suggest that if the PMIC registers report the charger type, then the
>>>  PMIC driver should register an EXTCON and report the charger type
>>>  through that.  Then the information would be directly available to
>>>  user-space, and the usb-charger framework would have a single uniform
>>>  mechanism for being told the cable type.
>>
>> We just access only one PMIC register to get the charger type, which
>> is no need add one driver for that and there are no any events for
>> extcon. Some sample code in power driver can be like below:
>
> If there are no events, then how do you know when a charger has been
> plugged in?  Do you poll?

We just monitor the plug-in and plug-out events by extcon,  and get
the charger type by accessing PMIC registers when one cable is
plugged.

>
> In any case, one of the major values provided by using an OS like Linux
> is uniform interfaces.  If a device can detect what sort of cable is
> inserted, then that information should be presented as an EXTCON.

Fine. I can remove this callback. We can add it if we need it in future.

>
>>>
>>>  Related:  I don't like charger_type_show().  I don't think
>>>  the usb-charger should export that information to user-space because
>>>  extcon already does that, and duplication is confusing and pointless.
>>
>> I think we should combine all charger related information into one
>> place for user. Moreover if we don't get charger type from extcon, we
>> should also need one place to export the charger type.
>
> Yes and no.
>
> Certainly a uniform consistent interface should be presented.
> "a usb charger" is not the right abstraction.  It is not a thing that
> should have independent existence.  To everybody else in the world, a
> "usb charger" in a box that you plug into the wall, and which has a
> cable to plug into your device.  It is not part of the device itself.
> In general, you cannot point to any component in a device that is the
> "usb charger" so it isn't clear that Linux should even know about a "usb
> charger".

Yes,  we agree that 'usb charger' is not one actual device, and 'usb
charger' is depended on gadget device. Moreover these charger
information is associated with actual gadget device, not virtual usb
charger device.

>
> There is a battery-charger which can take whatever current is available
> and feed it to the battery.  It may well be appropriate for user-space
> to have fine control of the current that this uses quite independently
> of whatever is plugged in (I have a board which can get the current via
> USB or via a more direct connection).
>
> There is also a USB PHY which can detect when a cable is plugged in
> (possibly just because 5V appears on VBUS) and can usually detect some
> details of the cable.  It should report, via the EXTCON interface, the
> presence and type of the cable.
>
> Maybe these are all in the one integrated circuit, maybe not. On the
> board I have, the one IC includes the USB phy, the battery charger, the
> audio codec, some regulators, some GPIOs and other stuff.  We have
> separate drivers for each logical component, unified by an "mfd" driver.
>
> From the interface design perspective, the number of ICs doesn't matter
> at all.  The interface presented, both within the kernel and out to
> user-space, should be consistent.  Every USB port should present with an
> EXTCON, and if it can detect types of cables, those cable types should
> be visible in the extcon.
>
>>
>>>
>>>  And I just noticed you have a ->charger_detect() too, which seems
>>>  identical to ->get_charger_type().  There is no documentation
>>>  explaining the difference.
>>
>> I think the kernel doc have explained that, but I like to explain it
>> again. Since we can detect the charger by software or hardware (like
>> PMIC), if you need to detect your charger type by software, then you
>> can implement this callback, you can refer to Jun's patch:
>> http://www.spinics.net/lists/linux-usb/msg139808.html
>
> The kernel-doc says:
>
>  + * @get_charger_type: User can get charger type by implementing this callback.
>  + * @charger_detect: Charger detection method can be implemented if you need to
>  + * manually detect the charger type.
>
> To me, that doesn't say anything useful.  What is the difference between
> "get charger type" and "manually detect the charger type" ??
>
> I don't want to have to refer to some extra set of patches to guess how
> something is supposed to work.  It needs to be clearly and
> unambiguously documented.

OK. I will update the kernel doc to make it clear.

>
> However, I'm very quickly losing interest in this whole debate, partly
> because it misses a key point.  As I have said, I strongly feel that
> resolving the current inconsistencies in the use of
> usb_register_notifier() is an important preliminary to resolve this
> issue, as that is *already* sometimes used to communication available
> current.
>
> So I won't be responding on this topic any further until I see a genuine
> attempt to understand and resolve the inconsistencies with
> usb_register_notifier().

Any better solution?

-- 
Baolin.wang
Best Regards

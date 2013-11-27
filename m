From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] PM / Sleep: Add pm_generic functions to re-use runtime
 PM callbacks
Date: Wed, 27 Nov 2013 17:06:51 +0100
Message-ID: <CAPDyKFoL8TseDdKHfm1KqhPUMaWRLpX3+i15a7jFsisZ9m0FHQ@mail.gmail.com>
References: <2026361.IiCVpVNYkW@vostro.rjw.lan>
	<3028580.oiUVTDjyao@vostro.rjw.lan>
	<CAPDyKFow3Y7bWAWNxQyrKeHizk0TSoCuPLHD=p_1D=CAYQpm9A@mail.gmail.com>
	<18994672.4q6Ofp2t01@vostro.rjw.lan>
	<CAPDyKFp5gz8Jku=g9OqRiE6tojcmodaCdYaFWqnrzYwThhDMog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFp5gz8Jku=g9OqRiE6tojcmodaCdYaFWqnrzYwThhDMog-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 27 November 2013 17:05, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>
>> We first need to clarify the terminology as that seems to be the source of
>> the confusion to some extent at least.
>>
>> When I (or Alan presumably too) say "a subsystem", I mean a bus type, a device
>> type or a device class as represented by struct bus_type, struct device_type
>> and struct class, respectively.  So "a subsystem callback" means the specific
>> callback defined in the given bus type, device type or device class object.
>> You can think about that as of "subsystem level" if that's easier.  So that's
>> what we mean when we talk about subsystems, not the whole collection of drivers
>> and the code above them.
>
> Thanks, this makes it perfectly clear now. I will try to improve while
> communicating.
>
> So we have subsystems, power domains and drivers to consider.
>
>>
>> Now, say you have a bus type.  Usually, the bus type's PM callbacks will run
>> device drivers' PM callbacks.  Quite often they will do things to hardware
>> in addition to what the drivers do.  But if your driver's .suspend_late()
>> depends on the runtime PM status of the device, then the bus type's .suspend()
>> needs to preserve that status.  That is, it cannot do anything to the hardware
>> that may cause the runtime PM status of the device to become stale.  That makes
>> the .suspend() somewhat special, doesn't it?
>

can -> can't

> I agree, but I can see why this should be a problem for each and every
> driver/bus.
>
> Do note that idea here is only to provide the option of allowing
> runtime PM callbacks to be executed as a part of the suspend_late ->
> resume_early sequence. It is not a rule, it will have to be decided
> for each subsystem/driver it they can benefit from this set up.
>
>>
>> Now I *guess* that your goal is something like "if that device has been
>> runtime suspended, don't touch it", which is a reasonable goal to have.  I'd
>> like to implement something like that too, but I think that it needs to be done
>> differently.
>
> That is just a minor important part, but nice to have. Please have
> look at the recently submitted patch set, "[PATCH 0/5] PM: Enable
> option of re-use runtime PM callbacks at system suspend", I hope the
> "cover letter" will describe my intention better.
>
>>
>> Actually, my idea is to allow the subsystem-level .prepare() callback to let
>> the core know if the device needs to be handled during the given suspend/resume
>> cycle.  It may be arranged, for example, so that if the subsystem-level (e.g.
>> bus type) .prepare() returns a positive number, the core will put the device
>> into a special list and it won't take it into consideration at all during the
>> whole cycle.
>>
>> Why this way?  Because subsystems have much better ways to determine whether
>> or not it is necessary to access the device during the upcoming system
>> suspend/resume cycle than the core does.
>
> I am not sure I understand how this will solve my issues (except the
> minor "if that device has been runtime suspended, don't touch it" -
> thing).
>
> I will still have to have a complex power domain and still
> drivers/buses need wrapper functions around their the runtime PM
> callbacks to invoke them during system suspend, if they need them.
>
> In my view, I don't think your idea is conflict or can replace what I
> suggest. Both can improve the situation, but maybe for different
> scenarios.
>
> Kind regards
> Ulf Hansson
>
>>
>> Thanks!
>>
>> --
>> I speak only for myself.
>> Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

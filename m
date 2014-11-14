From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the need_restore flag
Date: Fri, 14 Nov 2014 11:16:49 -0800
Message-ID: <7hh9y1619a.fsf@deeprootsystems.com>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
	<20141107215751.GA4439@dtor-ws>
	<CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
	<2882656.Dm8xnxDtKM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50635 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965580AbaKNTQw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 14:16:52 -0500
Received: by mail-pa0-f50.google.com with SMTP id eu11so17934656pac.23
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2014 11:16:51 -0800 (PST)
In-Reply-To: <2882656.Dm8xnxDtKM@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Thu, 13 Nov 2014 03:52:23 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> [CC list trimmed]
>
> On Monday, November 10, 2014 04:18:50 PM Ulf Hansson wrote:
>> [...]
>> 
>> > I guess we do need it for 3.18, but when we are talking about 3.19,
>> > before we make any more changes can we outline how power domains are
>> > supposed to work?
>> >
>> > 1. How do we attach a device to power domain? Right now it seems that
>> > individual buses are responsible for attaching their devices to power
>> > domains. Should we move it into driver core (device_pm_add?) so that
>> > device starts its life in its proper power domain?
>> 
>> That was the initial approach.
>> 
>> To my understanding, Rafael's primary reason for not accepting that
>> was that it's not common, but it's platform-specific.
>> http://marc.info/?l=linux-pm&m=140243462304669&w=2
>
> For the record, I still believe this is platform-specific.
>
> I also think that the knowledge about what power (or generally PM) domain
> a device should belong to is not in a bus type or in the driver core.  That
> knowledge is in the code that enumerates devices.
>
> I wonder, then, if we could set the PM domain pointer at about the time
> when we set the bus type pointer?  Things will be consistent all the way
> through the entire device life cycle then.
>
>> Now, even if we would reconsider doing as you propose, what would the
>> actual benefit be? Obviously, we would get less amount of code to
>> maintain, which is one reason, but are there more?
>
> The same set of subsystem-level PM callbacks will be present for the device
> throughout its life cycle.
>
>> > 2. When do we power up the devices (and the domains)? Right now devices
>> > in ACPI power domain are powered when they are attached to the power
>> > domain (which coincides with probing), but generic power domains do not
>> > do that. Can we add a separate API to explicitly power up the device (and
>> > its domain if it is powered down) and do it again, either in device core
>> > or in individual buses. This way, regardless of runtime PM or not, we
>> > will have devices powered on when driver tries to bind to them. If
>> > binding fails we can power down the device.
>> 
>> Isn't that exactly what I implemented in [1], what am I missing?
>
> Not really.  Dmitry is talking about a generic interface independent of
> PM domains.
>
> If we have pm_power_up(dev)/pm_power_down(dev), then the PM core could use it
> around really_probe() for all devices.  In theory.  But that's what we
> started with when we were working on the runtime PM framework and we ended
> up with what we have today.

OK, I'll admit it. I'm getting confused. 

In the context of PM domains, what does it mean for a device to be
"powered"?  Isn't it the domain that is powered up or down?  Devices
within the domain can be runtime resumed or suspended but the domain is
what is powered.

That being the case, I'm not seing the point of a per-device
power_up/power_down API.  As you said, it seems to basically duplicate
the runtime PM API.

> Problem is, pm_power_up() would probably end up being pretty much the same as
> pm_runtime_resume() without executing driver callbacks and similarly for
> pm_power_down().  That's why I was thinking about running pm_runtime_resume()
> at the time we know that driver callbacks are not present, just for the
> purpose of powering up the device.  [That has a problem of working with
> CONFIG_PM_RUNTIME unset, but let me set this one aside for a while.]

I think I'm tending o agree with Alan[1], that this is really best
handled by the sybsystem or bus-type, not the core.

> Now, Grygorii seems to be claiming that some drivers *require* their
> .runtime_resume() callbacks to be executed during .probe() pretty much
> before anything else which won't happen if pm_runtime_resume() is done
> before really_probe().  I'm wondering, then, which drivers those are.

Well, it's not technically a requirement, but an assumption that when a
_get_sync() is done in a driver's ->probe, it's ->runtime_resume() will
be called.

> Essentially, the "power up" operation will depend on the PM domain and
> bus type, so they'll need to provide callbacks that will most likely
> duplicate runtime PM callbacks.  And those callbacks need to be available
> when we do the "power up" thing.

Yuck.  More callbacks.  Just what we need. ;)

I think I'm still not quite getting the fundamental problem being
addressed.  Why isn't a pm_runtime_get_sync() by the first device in a
PM domain sufficient for powering on the domain?  

Yes, I understand there are some issues around *keeping* the domain
powered, but I think that's a separate problem.

> How can we address that?
>
> We seem to be dealing with a case in which PM is needed on some systems just to
> make them work at the basic level and not for energy saving, which was what
> runtime PM was designed for.

I think they're the same thing.  Power is needed for devices to work at
a basic level, and cutting power is needed for energy savings.  Runtime
PM is designed for that.  :)

Kevin

[1] http://marc.info/?l=linux-pm&m=141511953314249&w=2

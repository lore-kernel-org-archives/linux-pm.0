From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the need_restore
 flag
Date: Thu, 13 Nov 2014 21:14:45 +0200
Message-ID: <54650325.7040207@ti.com>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>	<20141107215751.GA4439@dtor-ws>	<CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>	<2882656.Dm8xnxDtKM@vostro.rjw.lan> <CAPDyKFry2QCBrEWJW-CVVzvpjKu9bYyaQs8o3b-nYfu9=ezpqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35689 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933902AbaKMTPI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 14:15:08 -0500
In-Reply-To: <CAPDyKFry2QCBrEWJW-CVVzvpjKu9bYyaQs8o3b-nYfu9=ezpqA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 11/13/2014 06:40 PM, Ulf Hansson wrote:
> [...]
>
>>>
>>> To my understanding, Rafael's primary reason for not accepting that
>>> was that it's not common, but it's platform-specific.
>>> http://marc.info/?l=linux-pm&m=140243462304669&w=2
>>
>> For the record, I still believe this is platform-specific.
>>
>> I also think that the knowledge about what power (or generally PM) domain
>> a device should belong to is not in a bus type or in the driver core.  That
>> knowledge is in the code that enumerates devices.
>>
>> I wonder, then, if we could set the PM domain pointer at about the time
>> when we set the bus type pointer?  Things will be consistent all the way
>> through the entire device life cycle then.
>
> Could you maybe give some examples of where such code should be
> invoked from then?
>
> I do see some difficulties in your suggestion, primarily since we
> would need all PM domains to be initialized prior "device
> enumeration". That in combination with doing PM domain initialization
> from SOC specific code, could be a bit tricky to sort out.
>
>>
>>> Now, even if we would reconsider doing as you propose, what would the
>>> actual benefit be? Obviously, we would get less amount of code to
>>> maintain, which is one reason, but are there more?
>>
>> The same set of subsystem-level PM callbacks will be present for the device
>> throughout its life cycle.
>
> I also do like the consistency this would bring us.
>
>>
>>>> 2. When do we power up the devices (and the domains)? Right now devices
>>>> in ACPI power domain are powered when they are attached to the power
>>>> domain (which coincides with probing), but generic power domains do not
>>>> do that. Can we add a separate API to explicitly power up the device (and
>>>> its domain if it is powered down) and do it again, either in device core
>>>> or in individual buses. This way, regardless of runtime PM or not, we
>>>> will have devices powered on when driver tries to bind to them. If
>>>> binding fails we can power down the device.
>>>
>>> Isn't that exactly what I implemented in [1], what am I missing?
>>
>> Not really.  Dmitry is talking about a generic interface independent of
>> PM domains.
>>
>> If we have pm_power_up(dev)/pm_power_down(dev), then the PM core could use it
>> around really_probe() for all devices.  In theory.  But that's what we
>> started with when we were working on the runtime PM framework and we ended
>> up with what we have today.
>>
>> Problem is, pm_power_up() would probably end up being pretty much the same as
>> pm_runtime_resume() without executing driver callbacks and similarly for
>> pm_power_down().  That's why I was thinking about running pm_runtime_resume()
>> at the time we know that driver callbacks are not present, just for the
>> purpose of powering up the device.  [That has a problem of working with
>> CONFIG_PM_RUNTIME unset, but let me set this one aside for a while.]
>
> I take this as we are aligned on using the runtime PM API from the
> driver core isn't a solution to the problem, right?
>
> I think Alan in the other thread [1] also had some valuable points to
> why we shouldn't use runtime PM from the driver core to power on PM
> domains.
>
> To that I would also like to add, that I really don't think the driver
> core should enable runtime PM, that's up to each an every
> subsystem/driver to decide when/if to do. Using pm_runtime_resume() or
> any of the pm_runtime_get*() API from the driver core would have
> required that as well.
>
>>
>> Now, Grygorii seems to be claiming that some drivers *require* their
>> .runtime_resume() callbacks to be executed during .probe() pretty much
>> before anything else which won't happen if pm_runtime_resume() is done
>> before really_probe().  I'm wondering, then, which drivers those are.
>
> I have looked around and there are certainly hole bunch of such drivers.
>
> I guess the most important reason to why these drivers behave as
> stated, is because that's been the common solution to make sure the PM
> domain stays powered during probe. It's unfortunate that no one cared
> about this until now.

PM domain is smth. relatively new :) Initial intention is to
execute Bus's PM callbacks and wake up parent devices.

regards,
-grygorii



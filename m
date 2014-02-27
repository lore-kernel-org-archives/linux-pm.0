From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/8] PM / Sleep / Runtime: Fixup some driver's system suspend
Date: Thu, 27 Feb 2014 09:18:34 +0100
Message-ID: <CAPDyKFp_ugRytLGR4fGXvdZEMRohg6uWPykcFJ7Co_wipJujDA@mail.gmail.com>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
	<7htxblx2eo.fsf@paris.lan>
	<12123949.qNoh3vhWUc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:33010 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbaB0ISf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 03:18:35 -0500
Received: by mail-qc0-f175.google.com with SMTP id m20so2211608qcx.34
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2014 00:18:35 -0800 (PST)
In-Reply-To: <12123949.qNoh3vhWUc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>

On 27 February 2014 02:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, February 26, 2014 08:30:07 AM Kevin Hilman wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>> > Patch 1 -> 2:
>> > These patches provides two new runtime PM helper functions which intend to be
>> > used from system suspend/resume callbacks, to make sure devices are put into low
>> > power state during system suspend and brought back to full power at system
>> > resume.
>> >
>> > The prerequisite is to have all levels of a device's runtime PM callbacks to be
>> > defined through the SET_PM_RUNTIME_PM_OPS macro, which means these are available
>> > for CONFIG_PM.
>> >
>> > By using the new runtime PM helper functions especially the two scenarios below
>> > will be addressed.
>> >
>> > 1) The PM core prevents .runtime_suspend callbacks from being invoked during
>> > system suspend. That means even for a runtime PM centric subsystem and driver,
>> > the device needs to be put into low power state from a system suspend callback.
>> > Otherwise it may very well be left in full power state (runtime resumed) while
>> > the system is suspended. By using the new helper functions, we make sure to walk
>> > the hierarchy of a device's power domain, subsystem and driver.
>>
>> I thought it was the case that runtime PM was only disabled during the
>> 'late' phase now.  Isn't that enough to allow runtime callbacks in the
>> normal suspend/resume hooks now?   /me looks.
>>
>> oh, wait.  Ee still have the _get_noresume() in device_prepare().  hmm
>>
>> Either way, I'm not not a big fan of new functions.  Personally, I think
>> subsystems/busses/pm_domains should be able to opt out of the PM core
>> behavior that blocks runtime PM transitions during system suspend.
>> Something like the (untested) hack below.  That way, we could avoid the
>> need for new helper functions.
>
> And if one of the subsystems in question is the platform bus type, then
> adding the flag doesn't really make sense, because that means that on
> many system it will be set for the majority of devices. :-)
>
> That said I'm tired of this stuff already.  If you really really want to
> remove the bumping up and dropping of the usage counter during system
> suspend/resume by the core, please feel free to submit a patch for that
> and I'll apply it.  However, if it causes any regressions to happen
> anywhere, it will be dropped and we'll never talk about this again.
>
> Deal?

No deal. I prefer the runtime PM helpers, I think that is the right
approach. I also believe this is what Alan Stern also would prefer,
right!? So let's convince Kevin instead. :-)

Let's just be clear of why I don't think Kevin suggested solution is
the way to go:

1. The runtime PM sysfs interface. Userspace may prevent
->runtime_suspend callbacks from being invoked anyway. So, it doesn't
matter if PM core does it too.

2. Currently we have CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP. Subsystem
and driver, must cope with both. I know there were a discussion about
combining them as one define, but we rejected that - at least for now.
Anyway, my point is, subsystem/driver must not rely on PM runtime core
(like pm_runtime_put_sync) from the system suspend callback to put
their devices into low power state.

Kind regards
Uffe

>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

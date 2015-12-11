From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce pm_runtime_get_noidle
Date: Fri, 11 Dec 2015 16:59:45 +0100
Message-ID: <CAPDyKFqxwbG+UmpPXw=-mA8J3yiZwiZfyMzmOkPLYjM7nt=G6Q@mail.gmail.com>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com>
	<5590453.QflIsWdzXr@vostro.rjw.lan>
	<CAPDyKFr+3-OMmjU0VEywhUa1RWt_aHu6ycLaQ325ds8rygWKyQ@mail.gmail.com>
	<2506520.FpRqP1NHQ0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36690 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbLKP7p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 10:59:45 -0500
Received: by qkht125 with SMTP id t125so44282407qkh.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2015 07:59:45 -0800 (PST)
In-Reply-To: <2506520.FpRqP1NHQ0@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: imre.deak@intel.com, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11 December 2015 at 16:13, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, December 11, 2015 01:03:50 PM Ulf Hansson wrote:
>> [...]
>>
>> >> >
>> >> > Which basically means you can call pm_runtime_resume() just fine,
>> >> > because it will do nothing if the status is RPM_ACTIVE already.
>> >> >
>> >> > So really, why don't you use pm_runtime_get_sync()?
>> >>
>> >> The difference would be that if the status is not RPM_ACTIVE already we
>> >> would drop the reference and report error. The caller would in this
>> >> case forego of doing something, since we the device is suspended or on
>> >> the way to being suspended. One example of such a scenario is a
>> >> watchdog like functionality: the watchdog work would
>> >> call pm_runtime_get_noidle() and check if the device is ok by doing
>> >> some HW access, but only if the device is powered. Otherwise the work
>> >> item would do nothing (meaning it also won't reschedule itself). The
>> >> watchdog work would get rescheduled next time the device is woken up
>> >> and some work is submitted to the device.
>> >
>> > So first of all the name "pm_runtime_get_noidle" doesn't make sense.
>> >
>> > I guess what you need is something like
>> >
>> > bool pm_runtime_get_if_active(struct device *dev)
>> > {
>> >         unsigned log flags;
>> >         bool ret;
>> >
>> >         spin_lock_irqsave(&dev->power.lock, flags);
>> >
>> >         if (dev->power.runtime_status == RPM_ACTIVE) {
>> >                 atomic_inc(&dev->power.usage_count);
>> >                 ret = true;
>> >         } else {
>> >                 ret = false;
>> >         }
>> >
>> >         spin_unlock_irqrestore(&dev->power.lock, flags);
>> > }
>> >
>> > and the caller will simply bail out if "false" is returned, but if "true"
>> > is returned, it will have to drop the usage count, right?
>> >
>> > Thanks,
>> > Rafael
>> >
>>
>> Why not just:
>>
>> pm_runtime_get_noresume():
>> if (RPM_ACTIVE)
>>   "do some actions"
>> pm_runtime_put();
>
> Because that's racy?

Right, that was too easy. :-)

>
> What if the rpm_suspend() is running for the device, but it hasn't changed
> the status yet?

So if we can add a pm_runtime_barrier() or even simplifier, just hold
the spin_lock when checking if the rpm status is RPM_ACTIVE.

Kind regards
Uffe

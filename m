From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for
 cpufreq_suspended set
Date: Thu, 7 Apr 2016 13:44:14 +0200
Message-ID: <CAJZ5v0g6zHT8yq-s+FkSb+ZE9K5vw_y0GX1nHaSLjOQXfsUquw@mail.gmail.com>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan>
	<20160407042820.GA14903@vireshk-i7>
	<CAJZ5v0gfadfuSdkoitFJAZfYXLJhed+1w2wiq1O3VnVK+fGYzA@mail.gmail.com>
	<20160407113226.GE3201@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34044 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952AbcDGLoQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 07:44:16 -0400
In-Reply-To: <20160407113226.GE3201@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Thu, Apr 7, 2016 at 1:32 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 07-04-16, 13:22, Rafael J. Wysocki wrote:
>> On Thu, Apr 7, 2016 at 6:28 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 07-04-16, 03:29, Rafael J. Wysocki wrote:
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >>
>> >> Since governor operations are generally skipped if cpufreq_suspended
>> >> is set, do nothing at all in cpufreq_start_governor() and
>> >> cpufreq_exit_governor() in that case.
>> >>
>> >> In particular, this prevents fast frequency switching from being
>> >> disabled after a suspend-to-RAM cycle on all CPUs except for the
>> >> boot one.
>> >
>> > static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
>> > {
>> >         int ret;
>> >
>> >         /* Don't start any governor operations if we are entering suspend */
>> >         if (cpufreq_suspended)
>> >                 return 0;
>> >
>> >         ...
>> >
>> > }
>> >
>> > Above already guarantees that we would start/stop governors. Why do we
>> > need this change then ?
>>
>> Because we do extra stuff in cpufreq_start_governor() and
>> cpufreq_exit_governor() that *also* shouldn't be done if
>> cpufreq_suspended is set.
>
> The only extra thing done by cpufreq_exit_governor() is
> cpufreq_disable_fast_switch(), which just plays with
> cpufreq_fast_switch_count and policy->fast_switch_enabled.
>
> That should be done even if we have started to suspend.

Well, no.

The problem here is that fast switch is enabled by the governor init
and that's not called if cpufreq_suspend is set.

> The exit-governor path is be called while we hot-unplug all non-boot
> CPUs during suspend. Which would eventually mean that at least
> cpufreq_fast_switch_count will stay positive for ever now, and we just
> can't recover from this situation.

I'm not sure I'm following.

Without this patch fast switch is disabled when we offline the nonboot
CPUs during suspend, because cpufreq_exit_governor() runs then, but
the cpufreq_governor() called by it does nothing.  Also
cpufreq_governor() during nonboot CPUs online does nothing.

That has to be made consistent somehow.  This patch is one way.
Another way would be to disable fast switch from the governor ->exit
callback, but the net result would be the same.

> Similarly for cpufreq_start_governor(), we call
> cpufreq_update_current_freq(). I think we should move the check to
> this routine instead.
>
> IOW, we are using this cpufreq_suspended flag to return early in cases
> where its not safe to try to access the hardware registers, as they
> might be accessible via a device that has suspended now, like I2C or
> SPI.

Right.  So checking cpufreq_suspended upfront in
cpufreq_start_governor() and cpufreq_exit_governor() addresses that.

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for
 cpufreq_suspended set
Date: Thu, 7 Apr 2016 17:02:26 +0530
Message-ID: <20160407113226.GE3201@vireshk-i7>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan>
 <20160407042820.GA14903@vireshk-i7>
 <CAJZ5v0gfadfuSdkoitFJAZfYXLJhed+1w2wiq1O3VnVK+fGYzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35371 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973AbcDGLcb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 07:32:31 -0400
Received: by mail-pa0-f45.google.com with SMTP id td3so53475807pab.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 04:32:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gfadfuSdkoitFJAZfYXLJhed+1w2wiq1O3VnVK+fGYzA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 07-04-16, 13:22, Rafael J. Wysocki wrote:
> On Thu, Apr 7, 2016 at 6:28 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 07-04-16, 03:29, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Since governor operations are generally skipped if cpufreq_suspended
> >> is set, do nothing at all in cpufreq_start_governor() and
> >> cpufreq_exit_governor() in that case.
> >>
> >> In particular, this prevents fast frequency switching from being
> >> disabled after a suspend-to-RAM cycle on all CPUs except for the
> >> boot one.
> >
> > static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
> > {
> >         int ret;
> >
> >         /* Don't start any governor operations if we are entering suspend */
> >         if (cpufreq_suspended)
> >                 return 0;
> >
> >         ...
> >
> > }
> >
> > Above already guarantees that we would start/stop governors. Why do we
> > need this change then ?
> 
> Because we do extra stuff in cpufreq_start_governor() and
> cpufreq_exit_governor() that *also* shouldn't be done if
> cpufreq_suspended is set.

The only extra thing done by cpufreq_exit_governor() is
cpufreq_disable_fast_switch(), which just plays with
cpufreq_fast_switch_count and policy->fast_switch_enabled.

That should be done even if we have started to suspend.

The exit-governor path is be called while we hot-unplug all non-boot
CPUs during suspend. Which would eventually mean that at least
cpufreq_fast_switch_count will stay positive for ever now, and we just
can't recover from this situation.

Similarly for cpufreq_start_governor(), we call
cpufreq_update_current_freq(). I think we should move the check to
this routine instead.

IOW, we are using this cpufreq_suspended flag to return early in cases
where its not safe to try to access the hardware registers, as they
might be accessible via a device that has suspended now, like I2C or
SPI.

-- 
viresh

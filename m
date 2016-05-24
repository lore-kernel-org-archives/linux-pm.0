From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU offline/online locked
Date: Tue, 24 May 2016 14:13:53 +0200
Message-ID: <2500818.MtOb9b1ZsB@vostro.rjw.lan>
References: <19792191.esL3UuyORb@vostro.rjw.lan> <CAJZ5v0h-1rqishrGAJXnvzyKjxoAxMcitW64LCZqtGC6vTRmCg@mail.gmail.com> <20160524045630.GP17585@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41470 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753437AbcEXMKP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 08:10:15 -0400
In-Reply-To: <20160524045630.GP17585@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tuesday, May 24, 2016 10:26:30 AM Viresh Kumar wrote:
> On 23-05-16, 22:47, Rafael J. Wysocki wrote:
> > Assuming that the loops are over online CPUs and not over possible
> > CPUs I suppose?
> 
> I wasn't focussing on that loop lately but the policy->rwsem :)
> 
> > Anyway, if you are talking about the code without the patch (which I
> > guess is the case), the reason why it is racy is because, if
> > cpufreq_stats_init() runs in parallel with CPU online, the CPU going
> > online may be missed by it.  To my eyes that happens if
> > cpufreq_online() has already advanced beyond the point where the
> > notifier would have been invoked, but hasn't returned yet when the
> > for_each_online_cpu() loop in cpufreq_stats_init() is executed.
> 
> Yes. That's a race we need to fix. I agree.
> 
> > Worse yet, if a CPU goes offline when cpufreq_stats_exit() is running
> > and that happens exactly between the notifier unregistration and the
> > for_each_online_cpu() loop, the stats table will never be freed for
> > that CPU (say the policy isn't shared).
> 
> Same here.
> 
> > Switching over to loops over possible CPUs doesn't address those races
> > (at least not the second one), and I'm not really sure why I thought
> > it would address them, but adding CPU online/offline locking to
> > cpufreq_stats_init/exit() can address them, so it looks like the very
> > first version of my patch (ie.
> > https://patchwork.kernel.org/patch/9128509/) was actually correct,
> > because it didn't put too much code under the CPU offline/online
> > locking. :-)
> 
> Well, I think there is one more way of getting all this fixed, which may
> eventually look much more cleaner.
> 
> What if we update cpufreq core instead of stats with something like this:

The problem is in the stats module, so it needs to be addressed in there.

We can modify the core too if there are other problems with notifiers that
need to be addressed.

For now, I'm going to apply https://patchwork.kernel.org/patch/9128509/
unless you point out a technical problem with it.

> -------------------------8<-------------------------
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 24 May 2016 10:16:25 +0530
> Subject: [PATCH] cpufreq: Initiate notifiers for existing policy
> 
> Races are possible in the init/exit paths of the cpufreq-stats layer,
> which may lead to 'stats' sysfs directory not getting created or removed
> for some of the policies. This can happen while the policy is getting
> created while cpufreq_stats_init/exit() are getting called.
> 
> To avoid adding unnecessary locks in the init/exit paths of the

I don't really get it why you don't like get/put_online_cpus() so much.

Quite arguably, they aren't unnecessary in the stats code, because
looping over online CPUs without ensuring that the mask won't change
when the loop is in progress is sort of buggy anyway.

> cpufreq-stats layer, update the policy notifier register/unregister
> routines to send notifications for any existing cpufreq policies.
> 
> Also make sure (with help of cpufreq_driver_lock) that
> CPUFREQ_CREATE/REMOVE notifiers aren't getting issued in parallel from
> the policy creation/removal paths.

So you add a lot of complexity to the core just in order to avoid the
extra get/put_online_cpus() invocations?  And what about people trying
to understand why the hell the code is not racy in the future?

No, sorry.

Thanks,
Rafael


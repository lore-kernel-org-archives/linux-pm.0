From: Arto Jantunen <viiru@iki.fi>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Sun, 28 Feb 2016 17:43:46 +0200
Message-ID: <87egbwn8lp.fsf@iki.fi>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
	<87a8mv9ujm.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
	<87egc6zc2q.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
	<56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>
	<20160222061637.GF28226@vireshk-i7> <871t84vgvq.fsf@iki.fi>
	<20160222164114.GU28226@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:58646 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757608AbcB1Pny (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 28 Feb 2016 10:43:54 -0500
In-Reply-To: <20160222164114.GU28226@vireshk-i7> (Viresh Kumar's message of
	"Mon, 22 Feb 2016 22:11:14 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rik van Riel <riel@redhat.com>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 22-02-16, 18:39, Arto Jantunen wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> 
>> > On 21-02-16, 22:33, Arto Jantunen wrote:
>> >> I have tested both available governors, and see the same behavior either
>> >> way. The kernel I have defaults to performance, I think I'll try
>> >> building another one which defaults to powersave to see if that changes
>> >> anything (perhaps both governors actually work but it isn't possible to
>> >> switch between them at runtime?). The Debian userspace defaults to
>> >> ondemand, which doesn't exist for intel_pstate.
>> >
>> > I took a close look at git log between 4.4 and 4.5-rc1 for intel-pstate and it
>> > had only three patches:
>> >
>> > 157386b6fc14 cpufreq: intel_pstate: Configurable algorithm to get target pstate
>> > e70eed2b6454 cpufreq: intel_pstate: Account for non C0 time
>> > 63d1d656a523 cpufreq: intel_pstate: Account for IO wait time
>> >
>> > The first one creates special routines based on the CPU model you have, yours is
>> > 94, i.e. 5e, which means we are going to use: core_params in your case. And so
>> > you will be using get_target_pstate_use_performance() for .get_target_pstate().
>> >
>> > The two later patches doesn't make any changes to the working of core_params()
>> > and so shouldn't have changed anything for skylake.
>> >
>> > Anyway, Please trying reverting the above three patches to see if there is a bug
>> > somewhere there. So you need to do:
>> >
>> > git revert 63d1d656a523
>> > git revert e70eed2b6454
>> > git revert 157386b6fc14
>> 
>> Thanks. I tried this, and somewhat surprisingly it doesn't change the
>> result. I guess we are back to doing a full bisect?
>
> Good. That was kind of what I expected, so no surprise :)
>
> I think bisect wouldn't be that difficult, please try :)

Bisect comes up with this commit:

commit a9ceb78bc75ca47972096372ff3d48648b16317a
Author: Rik van Riel <riel@redhat.com>
Date:   Tue Nov 3 17:34:18 2015 -0500

    cpuidle,menu: use interactivity_req to disable polling
    
    The menu governor carefully figures out how much time we typically
    sleep for an estimated sleep interval, or whether there is a repeating
    pattern going on, and corrects that estimate for the CPU load.
    
    Then it proceeds to ignore that information when determining whether
    or not to consider polling. This is not a big deal on most x86 CPUs,
    which have very low C1 latencies, and the patch should not have any
    effect on those CPUs.
    
    However, certain CPUs (eg. Atom) have much higher C1 latencies, and
    it would be good to not waste performance and power on those CPUs if
    we are expecting a very low wakeup latency.
    
    Disable polling based on the estimated interactivity requirement, not
    on the time to the next timer interrupt.
    
    Signed-off-by: Rik van Riel <riel@redhat.com>
    Acked-by: Arjan van de Ven <arjan@linux.intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I verified the result by reverting
9c4b2867ed7c8c8784dd417ffd16e705e81eb145 and
a9ceb78bc75ca47972096372ff3d48648b16317a from 4.5-rc5, the resulting
kernel does not have the bug.

Since this is about cpuidle, I'll also mention that this hardware
requires idle=nomwait on the command line, otherwise the kernel will not
boot.

-- 
Arto Jantunen

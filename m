From: Arto Jantunen <viiru@iki.fi>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Mon, 22 Feb 2016 18:39:37 +0200
Message-ID: <871t84vgvq.fsf@iki.fi>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
	<87a8mv9ujm.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
	<87egc6zc2q.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
	<56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>
	<20160222061637.GF28226@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:43546 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145AbcBVQjk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Feb 2016 11:39:40 -0500
In-Reply-To: <20160222061637.GF28226@vireshk-i7> (Viresh Kumar's message of
	"Mon, 22 Feb 2016 11:46:37 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 21-02-16, 22:33, Arto Jantunen wrote:
>> I have tested both available governors, and see the same behavior either
>> way. The kernel I have defaults to performance, I think I'll try
>> building another one which defaults to powersave to see if that changes
>> anything (perhaps both governors actually work but it isn't possible to
>> switch between them at runtime?). The Debian userspace defaults to
>> ondemand, which doesn't exist for intel_pstate.
>
> I took a close look at git log between 4.4 and 4.5-rc1 for intel-pstate and it
> had only three patches:
>
> 157386b6fc14 cpufreq: intel_pstate: Configurable algorithm to get target pstate
> e70eed2b6454 cpufreq: intel_pstate: Account for non C0 time
> 63d1d656a523 cpufreq: intel_pstate: Account for IO wait time
>
> The first one creates special routines based on the CPU model you have, yours is
> 94, i.e. 5e, which means we are going to use: core_params in your case. And so
> you will be using get_target_pstate_use_performance() for .get_target_pstate().
>
> The two later patches doesn't make any changes to the working of core_params()
> and so shouldn't have changed anything for skylake.
>
> Anyway, Please trying reverting the above three patches to see if there is a bug
> somewhere there. So you need to do:
>
> git revert 63d1d656a523
> git revert e70eed2b6454
> git revert 157386b6fc14

Thanks. I tried this, and somewhat surprisingly it doesn't change the
result. I guess we are back to doing a full bisect?

-- 
Arto Jantunen

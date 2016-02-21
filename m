From: Arto Jantunen <viiru@iki.fi>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Sun, 21 Feb 2016 22:33:01 +0200
Message-ID: <87lh6du7lu.fsf@iki.fi>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
	<87a8mv9ujm.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
	<87egc6zc2q.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
	<56CA17D4.8080802@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:41894 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbcBUUdF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 21 Feb 2016 15:33:05 -0500
In-Reply-To: <56CA17D4.8080802@linux.intel.com> (Srinivas Pandruvada's message
	of "Sun, 21 Feb 2016 12:02:28 -0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>>> Powersave:
>>> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
>>> /sys/devices/system/cpu/intel_pstate/min_perf_pct:22
>>>
>>> Performance:
>>> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
>>> /sys/devices/system/cpu/intel_pstate/min_perf_pct:100
>>>
>>> Also, adding intel_pstate=no_hwp to the command line does not change the
>>> result. Changing that to intel_pstate=disable does fix the problem, so the
>>> bug seems to be somewhere in intel_pstate instead of cpufreq core.
> You have Skylake, which is not compatible with legacy ACPI P states with _PSS
> tables, so not running without intel_pstate is not much use. It may be running
> at at low P-state by disabling.
>
> Is Debian use default mode as performance? I think Ubuntu uses performance
> mode as default.
> What is the output of
> cat cpu*/cpufreq/scaling_governor

I have tested both available governors, and see the same behavior either
way. The kernel I have defaults to performance, I think I'll try
building another one which defaults to powersave to see if that changes
anything (perhaps both governors actually work but it isn't possible to
switch between them at runtime?). The Debian userspace defaults to
ondemand, which doesn't exist for intel_pstate.

-- 
Arto Jantunen

From: Arto Jantunen <viiru@iki.fi>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Sun, 21 Feb 2016 10:45:17 +0200
Message-ID: <87egc6zc2q.fsf@iki.fi>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
	<87a8mv9ujm.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:41751 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbcBUSNH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 21 Feb 2016 13:13:07 -0500
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
	(Yu C. Chen's message of "Sat, 20 Feb 2016 18:03:34 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

"Chen, Yu C" <yu.c.chen@intel.com> writes:

>> -----Original Message-----
>> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>> owner@vger.kernel.org] On Behalf Of Arto Jantunen
>> Sent: Sunday, February 21, 2016 1:11 AM
>> To: Doug Smythies
>> Cc: 'Rafael J. Wysocki'; 'Viresh Kumar'; linux-pm@vger.kernel.org; 'Srinivas
>> Pandruvada'
>> Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on
>> 4.5-rc4
>> 
>> "Doug Smythies" <dsmythies@telus.net> writes:
>> 
>> > On 2106.02.20 00:50 Arto Jantunen wrote:
>> >> I can force the frequency down manually with cpufreq-set, so the
>> >> problem doesn't seem to be with the actual frequency changing.
>  cpufreq-set modifies the value of scaling_max_freq, it looks like
> your system always demands for the max freq, can you provide:
> grep . /sys/devices/system/cpu/intel_pstate/*perf_pct
> under powersave and performance?

Powersave:
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:22

Performance:
/sys/devices/system/cpu/intel_pstate/max_perf_pct:100
/sys/devices/system/cpu/intel_pstate/min_perf_pct:100

Also, adding intel_pstate=no_hwp to the command line does not change the
result. Changing that to intel_pstate=disable does fix the problem, so
the bug seems to be somewhere in intel_pstate instead of cpufreq core.

-- 
Arto Jantunen

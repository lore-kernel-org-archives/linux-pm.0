From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Sun, 21 Feb 2016 12:02:28 -0800
Message-ID: <56CA17D4.8080802@linux.intel.com>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
 <87a8mv9ujm.fsf@iki.fi>
 <36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
 <87egc6zc2q.fsf@iki.fi>
 <36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9961 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcBUUCI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 21 Feb 2016 15:02:08 -0500
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>, Arto Jantunen <viiru@iki.fi>
Cc: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 02/21/2016 12:52 AM, Chen, Yu C wrote:
>> -----Original Message-----
>> From: Arto Jantunen [mailto:viiru@iki.fi]
>> Sent: Sunday, February 21, 2016 4:45 PM
>> To: Chen, Yu C
>> Cc: Doug Smythies; 'Rafael J. Wysocki'; 'Viresh Kumar'; linux-
>> pm@vger.kernel.org; 'Srinivas Pandruvada'
>> Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on
>> 4.5-rc4
>>
>> "Chen, Yu C" <yu.c.chen@intel.com> writes:
>>
>>>> -----Original Message-----
>>>> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>>>> owner@vger.kernel.org] On Behalf Of Arto Jantunen
>>>> Sent: Sunday, February 21, 2016 1:11 AM
>>>> To: Doug Smythies
>>>> Cc: 'Rafael J. Wysocki'; 'Viresh Kumar'; linux-pm@vger.kernel.org;
>>>> 'Srinivas Pandruvada'
>>>> Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum
>>>> on
>>>> 4.5-rc4
>>>>
>>>> "Doug Smythies" <dsmythies@telus.net> writes:
>>>>
>>>>> On 2106.02.20 00:50 Arto Jantunen wrote:
>>>>>> I can force the frequency down manually with cpufreq-set, so the
>>>>>> problem doesn't seem to be with the actual frequency changing.
>>>   cpufreq-set modifies the value of scaling_max_freq, it looks like
>>> your system always demands for the max freq, can you provide:
>>> grep . /sys/devices/system/cpu/intel_pstate/*perf_pct
>>> under powersave and performance?
>> Powersave:
>> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
>> /sys/devices/system/cpu/intel_pstate/min_perf_pct:22
>>
>> Performance:
>> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
>> /sys/devices/system/cpu/intel_pstate/min_perf_pct:100
>>
>> Also, adding intel_pstate=no_hwp to the command line does not change the
>> result. Changing that to intel_pstate=disable does fix the problem, so the
>> bug seems to be somewhere in intel_pstate instead of cpufreq core.
You have Skylake, which is not compatible with legacy ACPI P states with 
_PSS tables, so not running without intel_pstate is not much use. It may 
be running at at low P-state by disabling.

Is Debian use default mode as performance? I think Ubuntu uses 
performance mode as default.
What is the output of
cat cpu*/cpufreq/scaling_governor

Thanks,
Srinivas
> 1.It would be nice if a git bisect is used to find the commit causing this problem.
>
> 2.
> # cd /sys/kernel/debug/tracing/
> # echo 1 > events/power/pstate_sample/enable
> # echo 1 > events/power/cpu_frequency/enable
> # cat trace
>


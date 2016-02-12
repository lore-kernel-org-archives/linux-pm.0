From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Sat, 13 Feb 2016 00:21:50 +0100
Message-ID: <CAJZ5v0iJbEQicJuwEdTfucC9-BeRCeCJ0gC-NL85MR+Q0Q1twg@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<2111826.yKEUOzphHC@vostro.rjw.lan>
	<008201d16458$69b2a4f0$3d17eed0$@net>
	<7442347.PCmPlrAvBe@vostro.rjw.lan>
	<002101d1651e$8ff027c0$afd07740$@net>
	<002601d16566$88455610$98d00230$@net>
	<CAJZ5v0h=CNVwEe4VQTreUvPucUnpkpndrUSU89vUCf7hkuEg-A@mail.gmail.com>
	<001601d165bb$7bf4de30$73de9a90$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001601d165bb$7bf4de30$73de9a90$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 12, 2016 at 6:33 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2016.02.12 05:39 Rafael J. Wysocki wrote:
>> On Fri, Feb 12, 2016 at 8:25 AM, Doug Smythies <dsmythies@telus.net> wrote:
>>> On 2016.02.11 14:50 Doug Smythies wrote:
>>>> On 2016.02.10 22:03 Srinivas Pandruvada wrote:
>>>>> On Wednesday, February 10, 2016 03:11:43 PM Doug Smythies wrote:
>>>
>>>>>> My test computer has an older model i7 (Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz)
>>>> Thanks Doug. If you have specific workloads, please compare performance.
>>>
>>>> My work so far has been testing functionality, with unrealistic workloads specifically
>>>> designed to exaggerate issues, in this case the duration problem.
>>>>
>>>> I'll look at some real world workload scenarios.
>>>
>>> Turbostat used for package power, starts before Phoronix tests starts,
>>> and ends after Phoronix test ends.
>>>
>>> Control Sample: Kernel 4.5-rc3:
>>> Phoronix ffmpeg: turbostat 180 Sec. 12.07 Sec. Ave. 27.14 Watts.
>>> Phoronix apache: turbostat 200 Sec. 19797.0 R.P.S. Ave. 34.01 Watts.
>>> Phoronix kernel: turbostat 180 Sec. 139.93 Sec. 49.09 Watts.
>>> Phoronix Postmark (Disk Test): turbostat 200 Sec. 5813 T.P.S. Ave. 21.33 Watts.
>>>
>>> Kernel 4.5-rc3 + RJW 3 patch set version 7:
>>> Phoronix ffmpeg: turbostat 180 Sec. 11.67 Sec. Ave. 27.35 Watts.
>>> Phoronix apache: turbostat 200 Sec. 19430.7 R.P.S. Ave. 34.18 Watts.
>>> Phoronix kernel: turbostat 180 Sec. 139.81 Sec. 48.80 Watts.
>>> Phoronix Postmark (Disk Test): turbostat 200 Sec. 5683 T.P.S. Ave. 22.41 Watts.
>
>> Thanks for the results!
>>
>> The Postmark result is somewhat below expectations (especially with
>> respect to the energy consumption), but we should be able to improve
>> that by using the util numbers intelligently.
>>
>> Do you have full turbostat reports from those runs by any chance?  I'm
>> wondering what happens to the idle state residencies, for example.
>
> I did not keep the turbostat output, however it is easy enough to
> re-do the tests. I'll send you the stuff off-list, and copy
> Srinivas.

Thanks!

> By the way, there is an anomaly in my 2 hour idle data (v7), where
> CPU 7 should have had sample passes through the intel_pstate driver.
> It did not, rather hitting the 4 second time limit instead.

That most likely means that we had not scheduled anything on that CPU
for that time.  Not entirely unlikely if the system was generally
mostly idle.

The CPU activity you observed might be related to interrupts in which
case we wouldn't receive updates from the scheduler.

> 10 occurrences in 7200 seconds. I sent you an off-list html format
> e-mail with more details. There may be other anomalies I didn't
> find yet.

Well, I guess we'll see.

Thanks,
Rafael

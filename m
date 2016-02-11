From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v6 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Thu, 11 Feb 2016 14:50:08 -0800
Message-ID: <002101d1651e$8ff027c0$afd07740$@net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <2111826.yKEUOzphHC@vostro.rjw.lan> <008201d16458$69b2a4f0$3d17eed0$@net> <7442347.PCmPlrAvBe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta15.telus.net ([209.171.16.88]:59946 "EHLO cmta15.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbcBKWuM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Feb 2016 17:50:12 -0500
In-Reply-To: <7442347.PCmPlrAvBe@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
Cc: 'Linux PM list' <linux-pm@vger.kernel.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Thomas Gleixner' <tglx@linutronix.de>

On 2016.02.10 15:18 Rafael J. Wysocki wrote:
> On Wednesday, February 10, 2016 03:11:43 PM Doug Smythies wrote:
>> On 2016.02.10 07:17 Rafael J. Wysocki wrote:
>>> On Friday, January 29, 2016 11:52:15 PM Rafael J. Wysocki wrote:
>>>> 
>> This patch set solves a long standing issue with the intel_pstate driver.

> Good to hear that, thanks!

>> The issue began with the introduction of the "duration" method for deciding
>> if the CPU had been idle for a long time resulting in forcing the
>> target pstate downwards. Often this was the correct action, but sometimes this
>> was the wrong thing to do, because the cpu was actually very busy, but just so
>> happened to be idle on jiffy boundaries (perhaps similar to what Steve Muckle
>> was referring to on another branch of this thread).

>> I have a bunch of graphs, if anyone wants to see the supporting data.

> It would be good to see how the data with and without the patchset compare
> to each other if you have that.

Please see:
double u double u double u dot smythies dot com /~doug/linux/intel_pstate/rjw_patch_set/index.html

Specific duration tests graphs are posted, and also a bunch of idle tests graphs are posted.
The references section includes links to all raw and post processed data.

Note that on my 2 hour idle tests, I had a few 300 second durations
on CPU 6 with the v5 patch set.
(likely what Steve Muckle was referring to.)
Such long durations did not occur in v6 or v7 2 hour idle tests.

Very interesting patterns in the 2 hour idle tests durations for
individual CPUs.

On 2016.02.10 22:03 Srinivas Pandruvada wrote:

>> My test computer has an older model i7 (Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz)
> Thanks Doug. If you have specific workloads, please compare performance.

My work so far has been testing functionality, with unrealistic workloads specifically
designed to exaggerate issues, in this case the duration problem.

I'll look at some real world workload scenarios.

What I do have from my 2 hour idle tests is the of total number of passes through
the intel_pstate driver:

Control sample: Kernel 4.3-rc3: 37949 passes.
Kernel 4.3-rc3 + rjw 3 patch set v5: 180355 passes
Kernel 4.3-rc3 + rjw 3 patch set v6: 201307 passes
Kernel 4.3-rc3 + rjw 3 patch set v7: 203619 passes

While I should have, I did not run turbostat to get idle energy and/or power.
However, a 1 hour idle test with turbostat gave (Package Joules):
Control sample: Kernel 4.3-rc3: 13788 J or 3.83 Watts
Kernel 4.3-rc3 + rjw 3 patch set v7: 13929 J or 3.87 Watts

... Doug



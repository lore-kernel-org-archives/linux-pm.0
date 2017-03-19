From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 2/2] cpufreq: schedutil: Force max frequency on busy CPUs
Date: Sun, 19 Mar 2017 22:42:28 +0100
Message-ID: <1806807.jsYc59y1La@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan> <135462462.sTWZ8TCakW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51089 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750937AbdCSVsA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Mar 2017 17:48:00 -0400
In-Reply-To: <135462462.sTWZ8TCakW@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Sunday, March 19, 2017 10:24:24 PM Rafael J. Wysocki wrote:
> On Sunday, March 19, 2017 02:34:32 PM Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The PELT metric used by the schedutil governor underestimates the
> > CPU utilization in some cases.  The reason for that may be time spent
> > in interrupt handlers and similar which is not accounted for by PELT.
> > 
> > That can be easily demonstrated by running kernel compilation on
> > a Sandy Bridge Intel processor, running turbostat in parallel with
> > it and looking at the values written to the MSR_IA32_PERF_CTL
> > register.  Namely, the expected result would be that when all CPUs
> > were 100% busy, all of them would be requested to run in the maximum
> > P-state, but observation shows that this clearly isn't the case.
> > The CPUs run in the maximum P-state for a while and then are
> > requested to run slower and go back to the maximum P-state after
> > a while again.  That causes the actual frequency of the processor to
> > visibly oscillate below the sustainable maximum in a jittery fashion
> > which clearly is not desirable.
> 
> In case you are wondering about the actual numbers, attached are two turbostat
> log files from two runs of the same workload, without (before.txt) and with (after.txt)
> the patch applied.
> 
> The workload is essentially "make -j 5" in the kernel source tree and the
> machine has an SSD storage and a quad-core Intel Sandy Bridge processor.
> The P-states available for each core are between 8 and 31 (0x1f) corresponding
> to 800 MHz and 3.1 GHz, respectively.  All cores can run sustainably at 2.9 GHz
> at the same time, although that is not a guaranteed sustainable frequency
> (it may be dropped occasionally for thermal reasons, for example).
> 
> The interesting columns are Bzy_MHz (and specifically the rows with "-" under
> CPU that correspond to the entire processor), which is the avreage frequency
> between iterations based on the numbers read from feedback registers, and
> the rightmost one, which is the values written to the P-state request register
> (the 3rd and 4th hex digits from the right represent the requested P-state).
> 
> The turbostat data collection ran every 2 seconds and I looked at the last 30
> iterations in each case corresponding to about 1 minute of the workload run
> during which all of the cores were around 100% busy.
> 
> Now, if you look at after.txt (the run with the patch applied), you'll notice that
> during those last 30 iterations P-state 31 (0x1f) had been requested on all
> cores pretty much 100% of the time (meaning: as expected in that case) and
> the average processor frequency (computed by taking the average from
> all of the 30 "-" rows) was 2899.33 MHz (apparently, the hardware decided to
> drop it from 2.9 GHz occasionally).
> 
> In the before.txt case (without the patch) the average frequency over the last
> 30 iterations was 2896.90 MHz which is about 0.8% slower than with the patch
> applied (on the average).

0.08% of course, sorry.  Still visible, though. :-)

Thanks,
Rafael

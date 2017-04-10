From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely
 since 4.6
Date: Mon, 10 Apr 2017 22:51:38 +0200
Message-ID: <CAJZ5v0jXGtZwx5m72fkFwjU6PTnv8uak+G4j1T9LK-kUgzr28Q@mail.gmail.com>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

Hi Mel,

On Mon, Apr 10, 2017 at 10:41 AM, Mel Gorman
<mgorman@techsingularity.net> wrote:
> Hi Rafael,
>
> Since kernel 4.6, performance of the low CPU intensity workloads was dropped
> severely.  netperf UDP_STREAM has about 15-20% CPU utilisation has regressed
> about 10% relative to 4.4 anad about 6-9% running TCP_STREAM. sockperf has
> similar utilisation fixes but I won't go into these in detail as they were
> running loopback and are sensitive to a lot of factors.
>
> It's far more obvious when looking at the git test suite and the length
> of time it takes to run. This is a shellscript and git intensive workload
> whose CPU utilisatiion is very low but is less sensitive to multiple
> factors than netperf and sockperf.

First, thanks for the data.

Nobody has reported anything similar to these results so far.

> Bisection indicates that the regression started with commit ffb810563c0c
> ("intel_pstate: Avoid getting stuck in high P-states when idle").  However,
> it's no longer the only relevant commit as the following results will show

Well, that was an attempt to salvage the "Core" P-state selection
algorithm which is problematic overall and reverting this now would
reintroduce the issue addressed by it, unfortunately.

>                                  4.4.0                 4.5.0                 4.6.0            4.11.0-rc5            4.11.0-rc5
>                                vanilla               vanilla               vanilla               vanilla           revert-v1r1
> User    min          1786.44 (  0.00%)     1613.72 (  9.67%)     3302.19 (-84.85%)     3487.46 (-95.22%)     2701.84 (-51.24%)
> User    mean         1788.35 (  0.00%)     1616.47 (  9.61%)     3304.14 (-84.76%)     3488.12 (-95.05%)     2715.80 (-51.86%)
> User    stddev          1.43 (  0.00%)        1.75 (-21.84%)        1.12 ( 22.10%)        0.57 ( 60.14%)        7.13 (-397.62%)
> User    coeffvar        0.08 (  0.00%)        0.11 (-34.80%)        0.03 ( 57.83%)        0.02 ( 79.56%)        0.26 (-227.68%)
> User    max          1790.14 (  0.00%)     1618.73 (  9.58%)     3305.40 (-84.64%)     3489.01 (-94.90%)     2721.66 (-52.04%)
> System  min           218.44 (  0.00%)      202.58 (  7.26%)      407.51 (-86.55%)      269.92 (-23.57%)      196.85 (  9.88%)
> System  mean          219.05 (  0.00%)      203.62 (  7.04%)      408.38 (-86.43%)      270.83 (-23.64%)      197.99 (  9.61%)
> System  stddev          0.60 (  0.00%)        0.64 ( -6.30%)        0.77 (-28.89%)        0.59 (  1.47%)        0.87 (-44.72%)
> System  coeffvar        0.27 (  0.00%)        0.31 (-14.35%)        0.19 ( 30.86%)        0.22 ( 20.31%)        0.44 (-60.11%)
> System  max           219.92 (  0.00%)      204.36 (  7.08%)      409.81 (-86.35%)      271.56 (-23.48%)      199.07 (  9.48%)
> Elapsed min          2017.05 (  0.00%)     1827.70 (  9.39%)     3701.00 (-83.49%)     3749.00 (-85.87%)     2904.36 (-43.99%)
> Elapsed mean         2018.83 (  0.00%)     1830.72 (  9.32%)     3703.20 (-83.43%)     3750.20 (-85.76%)     2919.33 (-44.60%)
> Elapsed stddev          1.79 (  0.00%)        2.18 (-21.93%)        1.47 ( 17.90%)        0.75 ( 58.20%)        7.66 (-328.12%)
> Elapsed coeffvar        0.09 (  0.00%)        0.12 (-34.46%)        0.04 ( 55.24%)        0.02 ( 77.50%)        0.26 (-196.07%)
> Elapsed max          2021.41 (  0.00%)     1833.91 (  9.28%)     3705.00 (-83.29%)     3751.00 (-85.56%)     2926.13 (-44.76%)
> CPU     min            99.00 (  0.00%)       99.00 (  0.00%)      100.00 ( -1.01%)      100.00 ( -1.01%)       99.00 (  0.00%)
> CPU     mean           99.00 (  0.00%)       99.00 (  0.00%)      100.00 ( -1.01%)      100.00 ( -1.01%)       99.00 (  0.00%)
> CPU     stddev          0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)
> CPU     coeffvar        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)
> CPU     max            99.00 (  0.00%)       99.00 (  0.00%)      100.00 ( -1.01%)      100.00 ( -1.01%)       99.00 (  0.00%)
>
>                4.4.0       4.5.0       4.6.0  4.11.0-rc5  4.11.0-rc5
>              vanilla     vanilla     vanilla     vanilla revert-v1r1
> User        10819.50     9790.02    19914.22    21021.12    16392.80
> System       1327.78     1234.01     2465.45     1635.85     1197.03
> Elapsed     12138.54    11008.49    22247.35    22528.79    17543.60

Well, yes, that doesn't look good. :-/

> This is showing the user and system CPU usage as well as the elapsed time
> to run a single iteration of the git test suite with total times at bottom
> report. Overall time takes over 3 hours longer moving from 4.4 to 4.11-rc5
> and reverting the commit does not fully address the problem. It's doing
> a warmup run whose results are discarded and then 5 iterations.
>
> The test shows it took 2018 seconds on average to complete a single iteration
> on 4.4 and 3750 seconds to complete on 4.11-rc5. The major drop is between
> 4.5 and 4.6 where it went from 1830 seconds to 3703 seconds and has not
> recovered. A bisection was clean and pointed to the commit mentioned above.
>
> The results show that it's not the only source as a revert (last column)
> doesn't fix the damage although it goes from 3750 seconds (4.11-rc5 vanilla)
> to 2919 seconds (with a revert).

OK

So if you revert the commit in question on top of 4.6.0, the numbers
go back to the 4.5.0 levels, right?

Anyway, as I said the "Core" P-state selection algorithm is sort of on
the way out and I think that we have a reasonable replacement for it.

Would it be viable to check what happens with
https://patchwork.kernel.org/patch/9640261/ applied?  Depending on the
ACPI system PM profile of the test machine, this is likely to cause it
to use the new algo.

I guess that you have a pstate_snb directory under /sys/kernel/debug/
(if this is where debugfs is mounted)?  It should not be there any
more with the new algo (as that does not use the PID controller any
more).

> The machine is a relatively old desktop-class machine with a i7-3770 CPU @
> 3.40GHz (IvyBridge). It is definitely using intel_pstate
>
> analyzing CPU 0:
>   driver: intel_pstate
>   CPUs which run at the same hardware frequency: 0
>   CPUs which need to have their frequency coordinated by software: 0
>   maximum transition latency:  Cannot determine or is not supported.
>   hardware limits: 1.60 GHz - 3.90 GHz
>   available cpufreq governors: performance powersave
>   current policy: frequency should be within 1.60 GHz and 3.90 GHz.
>                   The governor "powersave" may decide which speed to use
>                   within this range.
>   current CPU frequency: 1.60 GHz (asserted by call to hardware)
>   boost state support:
>     Supported: yes
>     Active: yes
>     3700 MHz max turbo 4 active cores
>     3800 MHz max turbo 3 active cores
>     3900 MHz max turbo 2 active cores
>     3900 MHz max turbo 1 active cores
>
> No special boot parameters are specified.
>
> I didn't poke around too much as the last time I tried, there were too
> many conflicting opinions and requirements so here are the observations.
>
> CPU usage is roughly 10% for the full duratiion of the test.
> Context switches, interrupt activity is not altered by the revert although it has changed substantially since 4.4
> turbostat confirms that busy time is roughtly 10% across the whole machine
> turbostat shows that average MHz is roughly halved in 4.11-rc5-vanilla versus 4.4
> turbostat shows that average MHz is slightly higher with the revert applied
> benchmark in question is doing IO but not a lot. Mostly below 100K/sec writes with small bursts of 6000K/sec
>
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL is *NOT* set. This is deliberate as when
> I evaluated schedutil shortly after it was merged, I found that at best
> it performed comparably with the old code across a range of workloads
> and machines while having higher system CPU usage. I know a lot of
> the recent work has been schedutil-focused so I could find no patch on
> recent discussions that might relevant to this problem. I've not looked
> at schedutil recently but not everyone will be switching to it so the old
> setup is still relevant.

intel_pstate in the active mode (which you are using) is orthogonal to
schedutil.  It has its own P-state selection logic and that evidently
has changed to affect the workload.

[BTW, I have posted a documentation patch for intel_pstate, but it
applies to the code in linux-next ATM
(https://patchwork.kernel.org/patch/9655107/).  It is worth looking at
anyway I think, though.]

At this point I'm not sure what has changed in addition to the commit
you have found and while this is sort of interesting, I'm not sure how
relevant it is.

Unfortunately, the P-state selection algorithm used so far on your
test system is quite fundamentally unstable and tends to converge to
either the highest or the lowest P-state in various conditions.  If
the workload is sufficiently "light", it generally ends up in the
minimum P-state most of the time which probably happens here.

I would really not like to try to "fix" that algorithm as this is
pretty much hopeless and most likely will lead to regressions
elsewhere.  Instead, I'd prefer to migrate away from it altogether and
then tune things so that they work for everybody reasonably well
(which should be doable with the new algorithm).  But let's see how
far we can get with that.

> While I accept the logic that CPUs should not remain at the highest
> frequency if completely idle for prolonged periods of time, it appears to
> be too agressive on older CPUs. Low utilisation tasks should still be able
> to get to the higher frequencies for the short bursts they are active for.

Totally agreed.

> I hope the data and the bisection is enough to have some ideas on how
> it can be addressed without impacting Haswell and Jorg's setup that the
> commit was originally intended for.

Well, as I said. :-)

Cheers,
Rafael

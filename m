From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely
 since 4.6
Date: Tue, 11 Apr 2017 11:02:34 +0100
Message-ID: <20170411100234.tkvdf2o5jklitdns@techsingularity.net>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>
 <CAJZ5v0jXGtZwx5m72fkFwjU6PTnv8uak+G4j1T9LK-kUgzr28Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jXGtZwx5m72fkFwjU6PTnv8uak+G4j1T9LK-kUgzr28Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, =?iso-8859-15?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 10, 2017 at 10:51:38PM +0200, Rafael J. Wysocki wrote:
> Hi Mel,
> 
> On Mon, Apr 10, 2017 at 10:41 AM, Mel Gorman
> <mgorman@techsingularity.net> wrote:
> > Hi Rafael,
> >
> > Since kernel 4.6, performance of the low CPU intensity workloads was dropped
> > severely.  netperf UDP_STREAM has about 15-20% CPU utilisation has regressed
> > about 10% relative to 4.4 anad about 6-9% running TCP_STREAM. sockperf has
> > similar utilisation fixes but I won't go into these in detail as they were
> > running loopback and are sensitive to a lot of factors.
> >
> > It's far more obvious when looking at the git test suite and the length
> > of time it takes to run. This is a shellscript and git intensive workload
> > whose CPU utilisatiion is very low but is less sensitive to multiple
> > factors than netperf and sockperf.
> 
> First, thanks for the data.
> 
> Nobody has reported anything similar to these results so far.
> 

It's possible that it's due to the CPU being IvyBridge or it may be due
to the fact that people don't spot problems with low CPU utilisation
workloads.

> > Bisection indicates that the regression started with commit ffb810563c0c
> > ("intel_pstate: Avoid getting stuck in high P-states when idle").  However,
> > it's no longer the only relevant commit as the following results will show
> 
> Well, that was an attempt to salvage the "Core" P-state selection
> algorithm which is problematic overall and reverting this now would
> reintroduce the issue addressed by it, unfortunately.
> 

I'm not suggesting that we should revert this patch. I accept that it
would reintroduce the regression reported by Jorg if nothing else

> > This is showing the user and system CPU usage as well as the elapsed time
> > to run a single iteration of the git test suite with total times at bottom
> > report. Overall time takes over 3 hours longer moving from 4.4 to 4.11-rc5
> > and reverting the commit does not fully address the problem. It's doing
> > a warmup run whose results are discarded and then 5 iterations.
> >
> > The test shows it took 2018 seconds on average to complete a single iteration
> > on 4.4 and 3750 seconds to complete on 4.11-rc5. The major drop is between
> > 4.5 and 4.6 where it went from 1830 seconds to 3703 seconds and has not
> > recovered. A bisection was clean and pointed to the commit mentioned above.
> >
> > The results show that it's not the only source as a revert (last column)
> > doesn't fix the damage although it goes from 3750 seconds (4.11-rc5 vanilla)
> > to 2919 seconds (with a revert).
> 
> OK
> 
> So if you revert the commit in question on top of 4.6.0, the numbers
> go back to the 4.5.0 levels, right?
> 

Not quite, it restores a lot of the performance but not all.

> Anyway, as I said the "Core" P-state selection algorithm is sort of on
> the way out and I think that we have a reasonable replacement for it.
> 
> Would it be viable to check what happens with
> https://patchwork.kernel.org/patch/9640261/ applied?  Depending on the
> ACPI system PM profile of the test machine, this is likely to cause it
> to use the new algo.
> 

Yes. The following is a comparison using 4.5 as a baseline as it is the
best known kernel and it reduces the width


gitsource
                                 4.5.0                 4.6.0                 4.6.0            4.11.0-rc5            4.11.0-rc5
                               vanilla               vanilla      revert-v4.6-v1r1               vanilla        loadbased-v1r1
User    min          1613.72 (  0.00%)     3302.19 (-104.63%)     1935.46 (-19.94%)     3487.46 (-116.11%)     2296.87 (-42.33%)
User    mean         1616.47 (  0.00%)     3304.14 (-104.40%)     1937.83 (-19.88%)     3488.12 (-115.79%)     2299.33 (-42.24%)
User    stddev          1.75 (  0.00%)        1.12 ( 36.06%)        1.42 ( 18.54%)        0.57 ( 67.28%)        1.79 ( -2.73%)
User    coeffvar        0.11 (  0.00%)        0.03 ( 68.72%)        0.07 ( 32.05%)        0.02 ( 84.84%)        0.08 ( 27.78%)
User    max          1618.73 (  0.00%)     3305.40 (-104.20%)     1939.84 (-19.84%)     3489.01 (-115.54%)     2302.01 (-42.21%)
System  min           202.58 (  0.00%)      407.51 (-101.16%)      244.03 (-20.46%)      269.92 (-33.24%)      203.79 ( -0.60%)
System  mean          203.62 (  0.00%)      408.38 (-100.56%)      245.24 (-20.44%)      270.83 (-33.01%)      205.19 ( -0.77%)
System  stddev          0.64 (  0.00%)        0.77 (-21.25%)        0.97 (-52.52%)        0.59 (  7.31%)        0.75 (-18.12%)
System  coeffvar        0.31 (  0.00%)        0.19 ( 39.54%)        0.40 (-26.64%)        0.22 ( 30.31%)        0.37 (-17.21%)
System  max           204.36 (  0.00%)      409.81 (-100.53%)      246.85 (-20.79%)      271.56 (-32.88%)      206.06 ( -0.83%)
Elapsed min          1827.70 (  0.00%)     3701.00 (-102.49%)     2186.22 (-19.62%)     3749.00 (-105.12%)     2501.05 (-36.84%)
Elapsed mean         1830.72 (  0.00%)     3703.20 (-102.28%)     2190.03 (-19.63%)     3750.20 (-104.85%)     2503.27 (-36.74%)
Elapsed stddev          2.18 (  0.00%)        1.47 ( 32.67%)        2.25 ( -3.23%)        0.75 ( 65.72%)        1.28 ( 41.43%)
Elapsed coeffvar        0.12 (  0.00%)        0.04 ( 66.71%)        0.10 ( 13.71%)        0.02 ( 83.26%)        0.05 ( 57.16%)
Elapsed max          1833.91 (  0.00%)     3705.00 (-102.03%)     2193.26 (-19.59%)     3751.00 (-104.54%)     2504.54 (-36.57%)
CPU     min            99.00 (  0.00%)      100.00 ( -1.01%)       99.00 (  0.00%)      100.00 ( -1.01%)      100.00 ( -1.01%)
CPU     mean           99.00 (  0.00%)      100.00 ( -1.01%)       99.00 (  0.00%)      100.00 ( -1.01%)      100.00 ( -1.01%)
CPU     stddev          0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)
CPU     coeffvar        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)        0.00 (  0.00%)
CPU     max            99.00 (  0.00%)      100.00 ( -1.01%)       99.00 (  0.00%)      100.00 ( -1.01%)      100.00 ( -1.01%)

               4.5.0       4.6.0       4.6.0  4.11.0-rc5  4.11.0-rc5
             vanilla     vanillarevert-v4.6-v1r1     vanillaloadbased-v1r1
User         9790.02    19914.22    11713.58    21021.12    13888.63
System       1234.01     2465.45     1485.99     1635.85     1242.37
Elapsed     11008.49    22247.35    13162.72    22528.79    15044.76

As you can see, 4.6 is running twice as long as 4.5 (3703 seconds to
comlete vs 1830 seconds). Reverting (revert-v4.6-v1r1) restores some of
the performance and is 19.63% slower on average. 4.11-rc5 is as bad as
4.6 but applying your patch runs for 2503 seconds (36.74% slower). This
is still pretty bad but it's a big step in the right direction.

> I guess that you have a pstate_snb directory under /sys/kernel/debug/
> (if this is where debugfs is mounted)?  It should not be there any
> more with the new algo (as that does not use the PID controller any
> more).
> 

Yes.

> > <SNIP>
> > CONFIG_CPU_FREQ_GOV_SCHEDUTIL is *NOT* set. This is deliberate as when
> > I evaluated schedutil shortly after it was merged, I found that at best
> > it performed comparably with the old code across a range of workloads
> > and machines while having higher system CPU usage. I know a lot of
> > the recent work has been schedutil-focused so I could find no patch on
> > recent discussions that might relevant to this problem. I've not looked
> > at schedutil recently but not everyone will be switching to it so the old
> > setup is still relevant.
> 
> intel_pstate in the active mode (which you are using) is orthogonal to
> schedutil.  It has its own P-state selection logic and that evidently
> has changed to affect the workload.
> 

Understood.

> [BTW, I have posted a documentation patch for intel_pstate, but it
> applies to the code in linux-next ATM
> (https://patchwork.kernel.org/patch/9655107/).  It is worth looking at
> anyway I think, though.]
> 

Ok, this is helpful for getting a better handle on intel_pstate in
general. Thanks.

> At this point I'm not sure what has changed in addition to the commit
> you have found and while this is sort of interesting, I'm not sure how
> relevant it is.
> 
> Unfortunately, the P-state selection algorithm used so far on your
> test system is quite fundamentally unstable and tends to converge to
> either the highest or the lowest P-state in various conditions.  If
> the workload is sufficiently "light", it generally ends up in the
> minimum P-state most of the time which probably happens here.
> 
> I would really not like to try to "fix" that algorithm as this is
> pretty much hopeless and most likely will lead to regressions
> elsewhere.  Instead, I'd prefer to migrate away from it altogether and
> then tune things so that they work for everybody reasonably well
> (which should be doable with the new algorithm).  But let's see how
> far we can get with that.
> 

Other than altering min_perf_pct, is there a way of tuning intel_pstate
such that it delays entering lower p-states for longer? It would
increase power consumption but at least it would be an option for
low-utilisation workloads and probably beneficial in general for those
that need to reduce latency of wakups while still allowing at least the
C1 state.

-- 
Mel Gorman
SUSE Labs

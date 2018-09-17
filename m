From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
Date: Mon, 17 Sep 2018 11:07:09 +0200
Message-ID: <CAJZ5v0j5TWT-6+PcbQ3ohbfA4rNkJ83PO-YxRG9hK1q61=C4EA@mail.gmail.com>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com>
 <23293649.J1qzPCXian@aspire.rjw.lan> <87in3c7x9o.fsf@riseup.net>
 <2646540.WJ9HbOajLd@aspire.rjw.lan> <87pnxf6zhe.fsf@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pnxf6zhe.fsf@riseup.net>
Sender: linux-kernel-owner@vger.kernel.org
To: currojerez@riseup.net
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, eero.t.tamminen@intel.com, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mel Gorman <mgorman@techsingularity.net>, Giovanni Gherdovich <ggherdovich@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 15, 2018 at 8:53 AM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>
> > On Tuesday, September 11, 2018 7:35:15 PM CEST Francisco Jerez wrote:
> >>
> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> >>
> >> > On Thursday, September 6, 2018 6:20:08 AM CEST Francisco Jerez wrote:
> >> >
> >> >> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
> >> >>=20
> >> >> > [...]
> >> >> >
> >> >> >> > >=3D20
> >> >> >> > > This patch causes a number of statistically significant
> >> >> >> > > regressions
> >> >> >> > > (with significance of 1%) on the two systems I've tested it
> >> >> >> > > on.  On
> >> >> >> > > my
> >> >> >> >=3D20
> >> >> >> > Sure. These patches are targeted to Atom clients where some of
> >> >> >> > these
> >> >> >> > server like workload may have some minor regression on few watts
> >> >> >> > TDP
> >> >> >> > parts.
> >> >> >>=3D20
> >> >> >> Neither the 36% regression of fs-mark, the 21% regression of sqlite,
> >> >> >> nor
> >> >> >> the 10% regression of warsaw qualify as small.  And most of the test
> >> >> >> cases on the list of regressions aren't exclusively server-like, if
> >> >> >> at
> >> >> >> all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
> >> >> >> benchmarks -- Latency is as important if not more for interactive
> >> >> >> workloads than it is for server workloads.  In the case of a conflict
> >> >> >> like the one we're dealing with right now between optimizing for
> >> >> >> throughput (e.g. for the maximum number of requests per second) and
> >> >> >> optimizing for latency (e.g. for the minimum request duration), you
> >> >> >> are
> >> >> >> more likely to be concerned about the former than about the latter in
> >> >> >> a
> >> >> >> server setup.
> >> >> >
> >> >> > Eero,
> >> >> > Please add your test results here.
> >> >> >
> >> >> > No matter which algorithm you do, there will be variations. So you have
> >> >> > to look at the platforms which you are targeting. For this platform=3D=
> >> 20
> >> >> > number one item is use of less turbo and hope you know why?
> >> >>=20
> >> >> Unfortunately the current controller uses turbo frequently on Atoms for
> >> >> TDP-limited graphics workloads regardless of IOWAIT boosting.  IOWAIT
> >> >> boosting simply exacerbated the pre-existing energy efficiency problem.
> >> >
> >> > My current understanding of the issue at hand is that using IOWAIT boosti=
> >> ng
> >> > on Atoms is a regression relative to the previous behavior.
> >>
> >> Not universally.  IOWAIT boosting helps under roughly the same
> >> conditions on Atom as it does on big core, so applying this patch will
> >> necessarily cause regressions too (see my reply from Sep. 3 for some
> >> numbers), and won't completely restore the previous behavior since it
> >> simply decreases the degree of IOWAIT boosting applied without being
> >> able to avoid it (c.f. the series I'm working on that does something
> >> similar to IOWAIT boosting when it's able to determine it's actually
> >> CPU-bound, which prevents energy inefficient behavior for non-CPU-bound
> >> workloads that don't benefit from a higher CPU clock frequency anyway).
> >
> > Well, OK.  That doesn't seem to be a clear-cut regression situation, then,
> > since getting back is not desirable, apparently.
> >
> > Or would it restore the previous behavior if we didn't do any IOWAIT
> > boosting on Atoms at all?
> >
> >> > That is what Srinivas is trying to address here AFAICS.
> >> >
> >> > Now, you seem to be saying that the overall behavior is suboptimal and the
> >> > IOWAIT boosting doesn't matter that much,
> >>
> >> I was just saying that IOWAIT boosting is less than half of the energy
> >> efficiency problem, and this patch only partially addresses that half of
> >> the problem.
> >
> > Well, fair enough, but there are two things to consider here, the general
> > energy-efficiency problem and the difference made by IOWAIT boosting.
> >
> > If the general energy-efficiency problem had existed for a relatively long
> > time, but it has got worse recently due to the IOWAIT boosting, it still
> > may be desirable to get the IOWAIT boosting out of the picture first
> > and then get to the general problem.
> >
>
> IMHO what is needed in order to address the IOWAIT boosting energy
> efficiency problem is roughly the same we need in order to address the
> other energy efficiency problem: A mechanism along the lines of [1]
> allowing us to determine whether the workload is IO-bound or not.  In
> the former case IOWAIT boosting won't be able to improve the performance
> of the workload since the limiting factor is the IO throughput, so it
> will only increase the energy usage, potentially exacerbating the
> bottleneck if the IO device is an integrated GPU.  In the latter case
> where the CPU and IO devices being waited on are both underutilized it
> makes sense to optimize for low latency more aggressively (certainly
> more aggressively than this patch does) which will increase the
> utilization of the IO devices until at least one IO device becomes a
> bottleneck, at which point the throughput of the system becomes roughly
> independent of the CPU frequency and we're back to the former case.
>
> [1] https://patchwork.kernel.org/patch/10312259/

I remember your argumentation above from the previous posts and I'm
not questioning it.  I don't see much point in repeating arguments
that have been given already.

My question was whether or not there was a regression related
specifically to adding the IOWAIT boosting mechanism that needed to be
addressed separately.  I gather from the discussion so far that this
is not the case.

Thanks,
Rafael

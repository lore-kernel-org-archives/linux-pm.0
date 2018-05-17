From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Date: Thu, 17 May 2018 12:59:07 +0200
Message-ID: <20180517105907.GC22493@localhost.localdomain>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516151925.GO28366@localhost.localdomain>
 <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516163105.GP28366@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16/05/18 18:31, Juri Lelli wrote:
> On 16/05/18 17:47, Peter Zijlstra wrote:
> > On Wed, May 16, 2018 at 05:19:25PM +0200, Juri Lelli wrote:
> > 
> > > Anyway, FWIW I started testing this on a E5-2609 v3 and I'm not seeing
> > > hackbench regressions so far (running with schedutil governor).
> > 
> > https://en.wikipedia.org/wiki/Haswell_(microarchitecture)#Server_processors
> > 
> > Lists the E5 2609 v3 as not having turbo at all, which is basically a
> > best case scenario for this patch.
> > 
> > As I wrote earlier today; when turbo exists, like say the 2699, then
> > when we're busy we'll run at U=2.3/3.6 ~ .64, which might confuse
> > things.
> 
> Indeed. I was mostly trying to see if adding this to the tick might
> introduce noticeable overhead.

Blindly testing on an i5-5200U (2.2/2.7 GHz) gave the following

# perf bench sched messaging --pipe --thread --group 2 --loop 20000

                      count       mean       std     min     50%       95%       99%     max
hostname kernel                                                                             
i5-5200U test_after    30.0  13.843433  0.590605  12.369  13.810  14.85635  15.08205  15.127
         test_before   30.0  13.571167  0.999798  12.228  13.302  15.57805  16.40029  16.690

It might be interesting to see what happens when using a single CPU
only?

Also, I will look at how the util signals look when a single CPU is
busy..

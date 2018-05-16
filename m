From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Date: Wed, 16 May 2018 18:31:05 +0200
Message-ID: <20180516163105.GP28366@localhost.localdomain>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516151925.GO28366@localhost.localdomain>
 <20180516154733.GF12198@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516154733.GF12198@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16/05/18 17:47, Peter Zijlstra wrote:
> On Wed, May 16, 2018 at 05:19:25PM +0200, Juri Lelli wrote:
> 
> > Anyway, FWIW I started testing this on a E5-2609 v3 and I'm not seeing
> > hackbench regressions so far (running with schedutil governor).
> 
> https://en.wikipedia.org/wiki/Haswell_(microarchitecture)#Server_processors
> 
> Lists the E5 2609 v3 as not having turbo at all, which is basically a
> best case scenario for this patch.
> 
> As I wrote earlier today; when turbo exists, like say the 2699, then
> when we're busy we'll run at U=2.3/3.6 ~ .64, which might confuse
> things.

Indeed. I was mostly trying to see if adding this to the tick might
introduce noticeable overhead.

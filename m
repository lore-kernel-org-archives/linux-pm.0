From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Date: Wed, 16 May 2018 09:29:29 +0200
Message-ID: <20180516072929.GN12235@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516071640.GU12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516071640.GU12217@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 16, 2018 at 09:16:40AM +0200, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 09:49:03PM -0700, Srinivas Pandruvada wrote:
> > intel_pstate has two operating modes: active and passive. In "active"
> > mode, the in-built scaling governor is used and in "passive" mode,
> > the driver can be used with any governor like "schedutil". In "active"
> > mode the utilization values from schedutil is not used and there is
> > a requirement from high performance computing use cases, not to read
> > any APERF/MPERF MSRs. In this case no need to use CPU cycles for
> > frequency invariant accounting by reading APERF/MPERF MSRs.
> > With this change frequency invariant account is only enabled in
> > "passive" mode.
> 
> WTH is active/passive? Is passive when we select performance governor?

Bah, I cannot read it seems. active is when we use the intel_pstate
governor and passive is when we use schedutil and only use intel_pstate
as a driver.

> Also; you have to explain why using APERF/MPERF is bad in that case. Why
> do they care if we read those MSRs during the tick?

That still stands.. this needs to be properly explained.

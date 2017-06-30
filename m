From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/4] intel_pstate: Ignore scheduler cpufreq callbacks
 on remote CPUs
Date: Fri, 30 Jun 2017 08:57:41 +0530
Message-ID: <20170630032741.GT29665@vireshk-i7>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
 <a33ba3746dacce67a7c2e17b64e54ee89f64a3bc.1498712046.git.viresh.kumar@linaro.org>
 <1498771438.7952.118.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498771438.7952.118.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 29-06-17, 14:23, Srinivas Pandruvada wrote:
> On Thu, 2017-06-29 at 10:56 +0530, Viresh Kumar wrote:
> > From: Steve Muckle <smuckle.linux@gmail.com>
> > 
> > In preparation for the scheduler cpufreq callback happening on remote
> > CPUs, check for this case in intel_pstate which currently requires
> > the
> > callback run on the local CPU. Such callbacks are ignored for now.
> Is it possible that we miss a chance to calculate load periodically at
> a predefined interval (10ms default), because the callback happened on
> a different CPU?

We aren't updating cpu->sample.time for remote callbacks here, so no
we shouldn't miss anything.

-- 
viresh

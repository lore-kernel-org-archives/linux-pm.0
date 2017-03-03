From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: move cached_raw_freq to struct
 sugov_policy
Date: Fri, 3 Mar 2017 08:37:06 +0530
Message-ID: <20170303030706.GE13760@vireshk-i7>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
 <0ee63c640d47281997d544d05f9dd543aef80588.1488437503.git.viresh.kumar@linaro.org>
 <1692186.fFRXBJz7b4@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1692186.fFRXBJz7b4@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 02-03-17, 23:05, Rafael J. Wysocki wrote:
> On Thursday, March 02, 2017 02:03:20 PM Viresh Kumar wrote:
> > cached_raw_freq applies to the entire cpufreq policy and not individual
> > CPUs. Apart from wasting per-cpu memory, it is actually wrong to keep it
> > in struct sugov_cpu as we may end up comparing next_freq with a stale
> > cached_raw_freq of a random CPU.
> > 
> > Move cached_raw_freq to struct sugov_policy.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Any chance for a Fixes: tag?

Fixes: 5cbea46984d6 ("cpufreq: schedutil: map raw required frequency
to driver frequency")

Sorry to miss that in the first place.

-- 
viresh

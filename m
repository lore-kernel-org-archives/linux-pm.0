From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 16:04:03 +0100
Message-ID: <20170321150403.GU3093@worktop>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <3429350.K2FUBgvcIK@aspire.rjw.lan>
 <20170321143842.GE11054@e110439-lin>
 <1844525.jBn1oKmyb6@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1844525.jBn1oKmyb6@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 21, 2017 at 03:46:07PM +0100, Rafael J. Wysocki wrote:
> @@ -207,6 +212,8 @@ static void sugov_update_single(struct u
>  	if (!sugov_should_update_freq(sg_policy, time))
>  		return;
>  
> +	sg_policy->overload = this_rq()->rd->overload;
> +

Same problem as before; rd->overload is set if _any_ CPU in the root
domain has more than 1 runnable task at a random point in history (when
we ran the load balance tick -- and since that is the same tick used for
timers, there's a bias to over-account there).

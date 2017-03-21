From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 18:00:17 +0100
Message-ID: <20170321170017.tqxcwmtolsqkc4ui@hirez.programming.kicks-ass.net>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <1844525.jBn1oKmyb6@aspire.rjw.lan>
 <20170321150403.GU3093@worktop>
 <2131318.dozmYt7JVU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2131318.dozmYt7JVU@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 21, 2017 at 04:18:52PM +0100, Rafael J. Wysocki wrote:
> +static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> +{
> +	unsigned long idle_calls = tick_nohz_get_idle_calls();
> +	bool not_idle = idle_calls == sg_cpu->saved_idle_calls;
> +
> +	sg_cpu->saved_idle_calls = idle_calls;
> +	return not_idle && this_rq()->rd->overload;
> +}

So I really don't understand the rd->overload thing. What is it supposed
to do here?

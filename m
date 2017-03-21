From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 16:18:27 +0100
Message-ID: <20170321151827.GW3093@worktop>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <3429350.K2FUBgvcIK@aspire.rjw.lan>
 <20170321143842.GE11054@e110439-lin>
 <1844525.jBn1oKmyb6@aspire.rjw.lan>
 <20170321150820.GF11054@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321150820.GF11054@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org


Seriously people, trim your replies.

On Tue, Mar 21, 2017 at 03:08:20PM +0000, Patrick Bellasi wrote:

> And than we can move this bit into an inline function, something like e.g.:
> 
>    static inline bool sugov_this_cpu_is_busy()
>    {
>            return this_rq()->rd->overloaded
>    }

No, that's just entirely and utterly wrong. It being in rd means its
very much not about _this_ CPU in any way.

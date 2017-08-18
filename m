From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Don't send callback pointer to
 cpufreq_add_update_util_hook()
Date: Fri, 18 Aug 2017 09:49:44 +0530
Message-ID: <20170818041944.GH24299@vireshk-i7>
References: <fb914a5aef386f7c3ae6ea5ed53e1fc299f47869.1502971486.git.viresh.kumar@linaro.org>
 <2692371.TLU4a4PDeX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2692371.TLU4a4PDeX@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17-08-17, 17:31, Rafael J. Wysocki wrote:
> On Thursday, August 17, 2017 2:04:48 PM CEST Viresh Kumar wrote:
> > The callers already have the structure (struct update_util_data) where
> > the function pointer is saved by cpufreq_add_update_util_hook(). And its
> > better if the callers fill it themselves, as they can do it from the
> > governor->init() callback then, which is called only once per policy
> > lifetime rather than doing it from governor->start which can get called
> > multiple times.
> 
> So what problem exactly is this addressing?

Its not fixing any problem really, but is rather just a cleanup patch.
I had a look at include/linux/sched/cpufreq.h and got confused for a
moment:

struct update_util_data {
       void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
};

void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
                       void (*func)(struct update_util_data *data, u64 time,
                                    unsigned int flags));


It wasn't quite straight-forward to understand why we needed to pass
both "data" and "func", while "data" should already have "func" set
within it. And then I realized that cpufreq_add_update_util_hook() is
actually setting that field.

Filling the pointer from the callers is probably better because:
- It makes it more readable.
- We have to pass one less argument and the function prototype becomes
  quite short.
- The callers don't have to set the data->func pointer from the
  governor->start() callback now and can do it only once from
  governor->init(). ->start(), stop() callbacks can get called a lot,
  for example with CPU hotplug.

But yeah, its all trivial stuff. No big problem solved.

-- 
viresh

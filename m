From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v2 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Wed, 18 Apr 2018 08:57:43 +0100
Message-ID: <20180418075742.GA3943@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
 <20180417153944.GD18509@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180417153944.GD18509@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Leo,

On Tuesday 17 Apr 2018 at 23:39:44 (+0800), Leo Yan wrote:
> > +	for_each_freq_domain(fd) {
> > +		unsigned long spare_cap, max_spare_cap = 0;
> > +		int max_spare_cap_cpu = -1;
> > +		unsigned long util;
> > +
> > +		/* Find the CPU with the max spare cap in the freq. dom. */
> > +		for_each_cpu_and(cpu, freq_domain_span(fd), sched_domain_span(sd)) {
> > +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> > +				continue;
> > +
> > +			if (cpu == prev_cpu)
> > +				continue;
> > +
> > +			util = cpu_util_wake(cpu, p);
> > +			cpu_cap = capacity_of(cpu);
> > +			if (!util_fits_capacity(util + task_util, cpu_cap))
> > +				continue;
> > +
> > +			spare_cap = cpu_cap - util;
> > +			if (spare_cap > max_spare_cap) {
> > +				max_spare_cap = spare_cap;
> > +				max_spare_cap_cpu = cpu;
> > +			}
> > +		}
> 
> If have two clusters, and if firstly iterate the big cluster, then
> max_spare_cap is a big value for big cluster and later LITTLE cluster
> has no chance to have higher value for spare_cap.  For this case, the
> LITTLE CPU will be skipped for energy computation?

max_spare_cap is reset to 0 at the top of the for_each_freq_domain()
loop above so that shouldn't happen.

Thanks,
Quentin

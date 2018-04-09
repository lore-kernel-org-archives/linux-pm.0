From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Mon, 9 Apr 2018 18:30:29 +0200
Message-ID: <20180409163029.GJ4064@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-6-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 06, 2018 at 04:36:06PM +0100, Dietmar Eggemann wrote:
>  	if (sd_flag & SD_BALANCE_WAKE) {
>  		record_wakee(p);
> +		want_energy = wake_energy(p, prev_cpu);
>  		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> -			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> +			      && cpumask_test_cpu(cpu, &p->cpus_allowed)
> +			      && !want_energy;

Could you please fix that and put the operators at the end of the
previous line?

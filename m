From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Sun, 25 Mar 2018 02:38:35 +0100
Message-ID: <20180325013833.GA1803@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
 <20180323160059.GQ4589@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180323160059.GQ4589@e105550-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Joel Fernandes <joelaf@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

On Friday 23 Mar 2018 at 16:00:59 (+0000), Morten Rasmussen wrote:
> On Thu, Mar 22, 2018 at 09:27:43AM -0700, Joel Fernandes wrote:
> > Hi,
> > 
> > On Tue, Mar 20, 2018 at 2:43 AM, Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:

[...]

> > Is it possible that before the wakeup, the task's affinity is changed
> > so that p->cpus_allowed no longer contains prev_cpu ? In that case
> > prev_energy wouldn't matter since previous CPU is no longer an option?
> 
> It is possible to wake-up with a disallowed prev_cpu. In fact
> select_idle_sibling() may happily return a disallowed cpu in that case.
> The mistake gets fixed in select_task_rq() which uses
> select_fallback_rq() to find an allowed cpu instead.
> 
> Could we fix the issue in find_energy_efficient_cpu() by a simple test
> like below
> 
> if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> 	prev_energy = best_energy = compute_energy(p, prev_cpu);
> else
> 	prev_energy = best_energy = ULONG_MAX;

Right, that should work. I'll change this in v2.

Thanks,
Quentin

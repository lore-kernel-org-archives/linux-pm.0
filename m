From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps related to preempt_count leakage in keventd
Date: Mon, 9 Nov 2009 16:47:54 +0100
Message-ID: <200911091647.54171.rjw__17794.0697562464$1257781734$gmane$org@sisk.pl>
References: <200911091250.31626.rjw@sisk.pl> <200911091527.12249.rjw@sisk.pl>
	<1257777040.6365.15.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1257777040.6365.15.camel@marge.simson.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Galbraith <efault@gmx.de>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 09 November 2009, Mike Galbraith wrote:
> On Mon, 2009-11-09 at 15:27 +0100, Rafael J. Wysocki wrote:
> > On Monday 09 November 2009, Mike Galbraith wrote:
> > > On Mon, 2009-11-09 at 15:02 +0100, Thomas Gleixner wrote:
> > > > On Mon, 9 Nov 2009, Ingo Molnar wrote:
> > > > > 
> > > 
> > > > > ok, then my observation should not apply.
> > > > 
> > > > I think it _IS_ releated because the worker_thread is CPU affine and
> > > > the debug_smp_processor_id() check does:
> > > > 
> > > >     if (cpumask_equal(&current->cpus_allowed, cpumask_of(this_cpu)))
> > > > 
> > > > which prevents that usage of smp_processor_id() in ksoftirqd and
> > > > keventd in preempt enabled regions is warned on.
> > > > 
> > > > We saw exaclty the same back trace with fd21073 (sched: Fix affinity
> > > > logic in select_task_rq_fair()).
> > > > 
> > > > Rafael, can you please add a printk to debug_smp_processor_id() so we
> > > > can see on which CPU we are running ? I suspect we are on the wrong
> > > > one.
> > > 
> > > I wonder if that's not intimately related to the problem I had, namely
> > > newidle balancing offline CPUs as they're coming up, making a mess of
> > > cpu enumeration.
> > 
> > Very likely.  What did you do to fix it?
> 
> You don't really wanna know.  In 31 with newidle enabled, the below
> fixed it.  It won't fix 32, though it might cure the resume problem.

OK, I'll give it a try.

> diff --git a/kernel/sched.c b/kernel/sched.c
> index 1b59e26..6e71932 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -4032,7 +4049,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  	unsigned long flags;
>  	struct cpumask *cpus = __get_cpu_var(load_balance_tmpmask);
>  
> -	cpumask_setall(cpus);
> +	cpumask_copy(cpus, cpu_online_mask);
>  
>  	/*
>  	 * When power savings policy is enabled for the parent domain, idle
> @@ -4195,7 +4212,7 @@ load_balance_newidle(int this_cpu, struct rq *this_rq, struct sched_domain *sd)
>  	int all_pinned = 0;
>  	struct cpumask *cpus = __get_cpu_var(load_balance_tmpmask);
>  
> -	cpumask_setall(cpus);
> +	cpumask_copy(cpus, cpu_online_mask);
>  
>  	/*
>  	 * When power savings policy is enabled for the parent domain, idle

Thanks,
Rafael

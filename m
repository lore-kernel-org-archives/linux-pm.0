From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/4] timers: framework for migration
	between CPU
Date: Fri, 20 Feb 2009 19:44:15 +0530
Message-ID: <20090220141415.GA27381__8990.19972789592$1235139304$gmane$org@dirshya.in.ibm.com>
References: <20090220125516.GB10232@linux.vnet.ibm.com>
	<20090220132145.GF26418@elte.hu>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090220132145.GF26418@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, arun@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Ingo Molnar <mingo@elte.hu> [2009-02-20 14:21:45]:

> 
> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:
> 
> > Hi,
> > 
> > 
> > In an SMP system, tasks are scheduled on different CPUs by the 
> > scheduler, interrupts are managed by irqbalancer daemon, but 
> > timers are still stuck to the CPUs that they have been 
> > initialised.  Timers queued by tasks gets re-queued on the CPU 
> > where the task gets to run next, but timers from IRQ context 
> > like the ones in device drivers are still stuck on the CPU 
> > they were initialised.  This framework will help move all 
> > 'movable timers' from one CPU to any other CPU of choice using 
> > a sysfs interface.
> 
> hm, the intention is good, the concept of migrating timers to 
> their target CPU is good as well. We already do some of that for 
> regular timers.
> 
> But the whole sysfs interface you implemented here is not 
> particularly clean nor is it efficient.
> 
> The main problem is that timers are really fast-moving entities, 
> and so are the tasks they are related to.
> 
> Your implementation completely ties the direction of migration 
> (the timer scheduling) to a clumsy sysfs interface:
> 
> +	if (sscanf(buf, "%d", &target_cpu) && cpu_online(target_cpu)) {
> +               ret = count;
> +               per_cpu(enable_timer_migration, cpu->sysdev.id) = target_cpu;
> +	}
> 
> That doesnt really scale and i doubt it works in practice. We 
> should not schedule timers via sysfs, we should let the kernel 
> do it auomatically. [*]

Hi Ingo,

Thanks for comments on the overall goal.  Having an in-kernel
framework to attract the 'movable' timers will be ideal.
 
> So what i'd suggest instead is extend the scheduler power-saving 
> code, which already identifies a 'load balancer CPU', to also 
> attract all attractable sources of timers - automatically. See 
> the 'load_balancer' CPU logic in kernel/sched.c.
> 
> Does that sound OK to you? I think the end result might even 
> give better numbers - and out of box.

I would agree that we can atleast try that approach and compare
how we score.

> I'd also suggest to not do that rather ugly 
> enable_timer_migration per-cpu variable, but simply reuse the 
> existing nohz.load_balancer as a target CPU.

This is a good idea to automatically bias the timers.  But this
nohz.load_balancer is a very fast moving target and we will need some
heuristics to estimate overall system idleness before moving the
timers.

I would agree that the power saving load balancer has a good view of
the system and can potentially guide the timer biasing framework.

--Vaidy

> Also, please base your patches on the latest timer tree (which 
> already modified some of this code in this cycle):
> 
>   http://people.redhat.com/mingo/tip.git/README
> 
> Btw., could you please also fix your mailer to not do this to 
> us:
> 
> Mail-Followup-To: linux-kernel@vger.kernel.org,
>         linux-pm@lists.linux-foundation.org, a.p.zijlstra@chello.nl,
>         ego@in.ibm.com, tglx@linutronix.de, mingo@elte.hu,
>         andi@firstfloor.org, venkatesh.pallipadi@intel.com,
>         vatsa@linux.vnet.ibm.com, arjan@infradead.org
> 
> it messes up the replies.
> 
> 	Ingo
> 
> [*] IRQ migration (where you possibly got the sysfs idea from) 
>     is a special case where 'slow scheduling' via a user-space 
>     daemon is possible: they are an external source of events 
>     and they are concentrators of work. The same concept does 
>     not apply to timers, most of which are inherently 
>     task-generated.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

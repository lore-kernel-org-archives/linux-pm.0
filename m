From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/4] timers: framework for migration
	between CPU
Date: Mon, 23 Feb 2009 13:29:25 +0530
Message-ID: <20090223075924.GA8165__27293.1731575683$1235376264$gmane$org@linux.vnet.ibm.com>
References: <20090220125516.GB10232@linux.vnet.ibm.com>
	<20090220132145.GF26418@elte.hu>
Reply-To: arun@linux.vnet.ibm.com
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
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
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
> 
> So what i'd suggest instead is extend the scheduler power-saving 
> code, which already identifies a 'load balancer CPU', to also 
> attract all attractable sources of timers - automatically. See 
> the 'load_balancer' CPU logic in kernel/sched.c.
> 
> Does that sound OK to you? I think the end result might even 
> give better numbers - and out of box.
> 
> I'd also suggest to not do that rather ugly 
> enable_timer_migration per-cpu variable, but simply reuse the 
> existing nohz.load_balancer as a target CPU.
>

Hi Ingo,

Thanks a lot for your comments.
Sure, what you are suggesting makes sense. Having an in-kernel method
to move timers is much better than exposing the interface to the user.
I will give this a shot.

--arun

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
> 

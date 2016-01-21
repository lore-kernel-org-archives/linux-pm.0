From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Thu, 21 Jan 2016 14:54:34 +0100
Message-ID: <56A0E31A.6020001@linaro.org>
References: <alpine.DEB.2.11.1601201634520.3575@nanos>
 <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.11.1601201856040.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601201856040.3575@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/20/2016 08:49 PM, Thomas Gleixner wrote:

[ ... ]

Thanks for all your comments. I agree with them.

One question below.

>> +static void sched_irq_timing_free(unsigned int irq)
>> +{
>> +	struct wakeup *w;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +
>> +		w =3D per_cpu(wakeups[irq], cpu);
>> +		if (!w)
>> +			continue;
>> +
>> +		per_cpu(wakeups[irq], cpu) =3D NULL;
>> +		kfree(w);
>
> Your simple array does not work. You need a radix_tree to handle SPAR=
SE_IRQ
> and you need proper protection against teardown.
>
> So we can avoid all that stuff and simply stick that data into irqdes=
c and let
> the core handle it. That allows us to use proper percpu allocations a=
nd avoid
> that for_each_possible_cpu() sillyness.
>
> That leaves the iterator, but that's a solvable problem. We simply ca=
n have an
> iterator function in the irq core, which gives you the next sample
> structure. Something like this:
>
> struct irqtiming_sample *irqtiming_get_next(int *irq)
> {
> 	struct irq_desc *desc;
> 	int next;
>
> 	/* Do a racy lookup of the next allocated irq */
> 	next =3D irq_get_next_irq(*irq);
> 	if (next >=3D nr_irqs)
> 	   	 return NULL;
>
> 	*irq =3D next + 1;
>
> 	/* Now lookup the descriptor. It's RCU protected. */
> 	desc =3D irq_to_desc(next);
> 	if (!desc || !desc->irqtimings || !(desc->istate & IRQS_TIMING))
> 	   	 return NULL;
>
> 	return this_cpu_ptr(&desc->irqtimings);
> }
>
> And that needs to be called rcu protected;
>
>      	 next =3D 0;
>      	 rcu_read_lock();
> 	 sample =3D irqtiming_get_next(&next);
> 	 while (sample) {
> 	       ....
> 	       sample =3D irqtiming_get_next(&next);
> 	 }
>      	 rcu_read_unlock();
>
> So the interrupt part becomes:
>
>           if (desc->istate & IRQS_TIMING)
> 	       	 irqtimings_handle(__this_cpu_ptr(&desc->irqtimings));
>
> So now for the allocation/free of that data. We simply allocate/free =
it along
> with the irq descriptor. That IRQS_TIMING bit gets set in __setup_irq=
() except
> for timer interrupts. That's simple and avoid _all_ the issues.

Indeed, making this as part of the irq code makes everything much more=20
simple and self contained. For the shared interrupts, shouldn't we put=20
the timings samples into the irqaction structure instead of the irqdesc=
=20
structure ?

eg.

#define IRQT_MAX_VALUES 4

struct irqaction {
	...
#ifdef CONFIG_IRQ_TIMINGS
	u32 irqtimings_samples[IRQT_MAX_VALUES];
#endif
	...
};

So we don't have to deal with the allocation/free under locks. The=20
drawback is the array won't be used in the case of the timers.

Does it make sense ?

Thanks Thomas for your help, your time and your suggestions.




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

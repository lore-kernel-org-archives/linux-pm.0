From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/6] sched: idle: cpuidle: Check the latency req before
 idle
Date: Wed, 12 Nov 2014 18:52:35 +0100
Message-ID: <54639E63.8090706@linaro.org>
References: <20141110124111.GN3337@twins.programming.kicks-ass.net> <5460D5EF.2000805@linaro.org> <20141110152803.GX10501@worktop.programming.kicks-ass.net> <5460E0A5.9040508@linaro.org> <20141110161530.GB10501@worktop.programming.kicks-ass.net> <5460F386.1050109@linaro.org> <20141110194820.GD10501@worktop.programming.kicks-ass.net> <54613A5F.7060107@linaro.org> <20141111102058.GI10501@worktop.programming.kicks-ass.net> <54636646.6080709@linaro.org> <20141112150254.GD21343@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141112150254.GD21343@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, preeti@linux.vnet.ibm.com, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/12/2014 04:02 PM, Peter Zijlstra wrote:
> On Wed, Nov 12, 2014 at 02:53:10PM +0100, Daniel Lezcano wrote:
>
>>>> The governors are just ignoring it, except for a small timer optim=
ization in
>>>> menu.c (and I am still not convinced it is worth to have it). I do=
n't see
>>>> the point to add a state we don't want to use.
>>>
>>> The ignoring it is _wrong_. Make that go away and you'll get rid of=
 most
>>> of the STATE_START crap.
>>>
>>> The governors are the place where we combine the QoS constraints wi=
th
>>> idle predictors and pick an idle state, polling is a valid state to
>>> pick, and given QoS constraints it might be the only state to pick.
>>
>> Well, I understand your point of view but I still disagree. IMO, the=
 poll
>> loop shouldn't be considered as a valid idle state for different rea=
sons:
>>
>> 0. thermal issue if wrongly selected from any of the governor
>
> That seems like a QoS issue and should be fixed there, no?

It could be seen as a QoS issue if we stick the poll loop with the zero=
=20
latency req. But as soon as we introduce the poll loop in the cpuidle=20
framework, the issue could have multiple sources (see below at the end=20
of the message).

>> 1. a polling loop does not have a valid time measurements even if th=
e
>> TIME_VALID flag has been added
>
> Ah, right you are. It does not. We _could_ fix that, not sure its wor=
th
> the hassle but see below.
>
>> 2. entering the idle governors is not free, especially the menu gove=
rnor,
>> which is contradictory with zero latency req
>
> Well, you could add this 'fast' path to the cpuidle code (before call=
ing
> into the actual governors) too. Also, since the governors actually us=
e
> this state it makes sense for it to be available.

Actually the governors do not use this state or do whatever they can to=
=20
prevent to use it. The ladder governor just ignore it, and the menu=20
governor will default to C1 (not poll) if no state is found. It will us=
e=20
the poll loop only if a timer is about to expire within 5us and all thi=
s=20
dance is around this micro optimization.

You are suggesting to add the fast in the cpuidle framework. IIUC we=20
should have:

int cpuidle_select(drv, dev)
{
	...
	if (latency_req =3D=3D 0)
		return ????;
}

The '????' suggests we duplicate everywhere an 0th idle state (more tha=
n=20
17 drivers and that breaks the idle states DT binding.

>> 3. what is the meaning of having a zero latency (target + exit) idle=
 state ?
>> We know it will always succeed if the other fails
>
> Not quite sure I follow; you seem to have answered your own question?

Yeah, right :)

>> 4. IIUC, you are suggesting to add the poll loop for all the cpuidle
>> drivers. This is a *lot* of changes, I am not afraid about the work =
to do
>> but there is a significant code impact and the entire behavior of th=
e
>> cpuidle framework for all the arch will be changed.
>
> I'm not sure it would be a lot of work, add it in the common cpuidle
> code before calling the driver init?



>> So given the points above, why not have one poll function, generic, =
and if
>> we fail to find an idle state or if the req is zero, then fallback t=
o the
>> poll loop ?
>
> I could agree but only if we keep the poll loop generic, we cannot go
> add yet more arch hooks there.

I understand. The arch hook just give an opportunity to specify an=20
arch's specific poll loop, that does not imply it has to.

>>> Because the latter is actually arch specific, whereas the idle
>>> polling thing is not.  You can _always_ poll idle, its generic, its
>>> valid, and its guaranteed the most responsive method.
>>
>> I agree with this point but this kind of loop is hardware optimized =
for x86.
>
> well 'optimized' is a strong word there, the rep nop, or pause
> instruction isn't really much at all and is mostly a SMT hint afaik.
> ia64, sparc64 and ppc64 have similar magic and s390 and hexagon use a=
 vm
> yield like construct.



>> On the other arch, where today this loop is never used, if we change=
 the
>> behavior of the cpuidle framework and introduces this loop, it may b=
e
>> selected and stay on this state for a long time (resulting from a ba=
d
>> prediction), I am afraid that can lead to some thermal issues.
>
> Because of 1), right? Yes that's a problem.

Well, 1) won't help, but also for different reasons:

By removing the STATE_START macro and adding the poll as the 0th idle s=
tate:

ladder governor: it was never, ever, using the poll loop, just ignoring=
=20
the 0th idle state by using the STATE_START macro to stop demoting. Tha=
t=20
won't be the case anymore, and we may fall in the poll loop

menu governor: it was almost never using the poll state. With the chang=
e=20
it will select the state. If the prediction is bad and the poll idle=20
loop is selected but the cpu stays idle longer (that could be several=20
seconds). That can happens with a bad predictions or task migration whe=
n=20
this one is doing a lot of IO.

On the ARM embedded systems where the poll loop is not used, except whe=
n=20
specified in the kernel command line. That may lead to some thermal=20
issues and big troubles.

I like your patch below that will help to re-evaluate the idle state bu=
t=20
I am not sure it will solve the issue introduced with the generic idle=20
loop as the 0th idle state.

Thanks Peter by taking the time to review this patch.

   -- Daniel

> ---
>   kernel/sched/idle.c | 6 +++++-
>   kernel/softirq.c    | 7 +++++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index c47fce75e666..9c76ae92650f 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -42,12 +42,16 @@ static int __init cpu_idle_nopoll_setup(char *__u=
nused)
>   __setup("hlt", cpu_idle_nopoll_setup);
>   #endif
>
> +DEFINE_PER_CPU(unsigned int, int_seq);
> +
>   static inline int cpu_idle_poll(void)
>   {
> +	unsigned int seq =3D this_cpu_read(int_seq);
> +
>   	rcu_idle_enter();
>   	trace_cpu_idle_rcuidle(0, smp_processor_id());
>   	local_irq_enable();
> -	while (!tif_need_resched())
> +	while (!tif_need_resched() && seq =3D=3D this_cpu_read(int_seq))
>   		cpu_relax();
>   	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
>   	rcu_idle_exit();
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 0699add19164..bc8d43545964 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -370,6 +370,8 @@ static inline void tick_irq_exit(void)
>   #endif
>   }
>
> +DECLARE_PER_CPU(unsigned int, int_seq);
> +
>   /*
>    * Exit an interrupt context. Process softirqs if needed and possib=
le:
>    */
> @@ -386,6 +388,11 @@ void irq_exit(void)
>   	if (!in_interrupt() && local_softirq_pending())
>   		invoke_softirq();
>
> +#ifdef TIG_POLLING_NRFLAG
> +	if (test_thread_flag(TIF_POLLING_NRFLAG))
> +#endif
> +		this_cpu_inc(int_seq);
> +
>   	tick_irq_exit();
>   	rcu_irq_exit();
>   	trace_hardirq_exit(); /* must be last! */
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

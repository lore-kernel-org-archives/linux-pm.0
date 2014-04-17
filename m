From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Thu, 17 Apr 2014 15:53:32 +0200
Message-ID: <534FDCDC.6000806@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

On 04/02/2014 05:05 AM, Nicolas Pitre wrote:
> On Fri, 28 Mar 2014, Daniel Lezcano wrote:
>
>> As we know in which idle state the cpu is, we can investigate the fo=
llowing:
>>
>> 1. when did the cpu entered the idle state ? the longer the cpu is i=
dle, the
>> deeper it is idle
>> 2. what exit latency is ? the greater the exit latency is, the deepe=
r it is
>>
>> With both information, when all cpus are idle, we can choose the idl=
est cpu.
>>
>> When one cpu is not idle, the old check against weighted load applie=
s.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> There seems to be some problems with the implementation.
>
>> @@ -4336,20 +4337,53 @@ static int
>>   find_idlest_cpu(struct sched_group *group, struct task_struct *p, =
int this_cpu)
>>   {
>>   	unsigned long load, min_load =3D ULONG_MAX;
>> -	int idlest =3D -1;
>> +	unsigned int min_exit_latency =3D UINT_MAX;
>> +	u64 idle_stamp, min_idle_stamp =3D ULONG_MAX;
>
> I don't think you really meant to assign an u64 variable with ULONG_M=
AX.
> You probably want ULLONG_MAX here.  And probably not in fact (more
> later).
>
>> +
>> +	struct rq *rq;
>> +	struct cpuidle_power *power;
>> +
>> +	int cpu_idle =3D -1;
>> +	int cpu_busy =3D -1;
>>   	int i;
>>
>>   	/* Traverse only the allowed CPUs */
>>   	for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p))=
 {
>> -		load =3D weighted_cpuload(i);
>>
>> -		if (load < min_load || (load =3D=3D min_load && i =3D=3D this_cpu=
)) {
>> -			min_load =3D load;
>> -			idlest =3D i;
>> +		if (idle_cpu(i)) {
>> +
>> +			rq =3D cpu_rq(i);
>> +			power =3D rq->power;
>> +			idle_stamp =3D rq->idle_stamp;
>> +
>> +			/* The cpu is idle since a shorter time */
>> +			if (idle_stamp < min_idle_stamp) {
>> +				min_idle_stamp =3D idle_stamp;
>> +				cpu_idle =3D i;
>> +				continue;
>
> Don't you want the highest time stamp in order to select the most
> recently idled CPU?  Favoring the CPU which has been idle the longest
> makes little sense.
>
>> +			}
>> +
>> +			/* The cpu is idle but the exit_latency is shorter */
>> +			if (power && power->exit_latency < min_exit_latency) {
>> +				min_exit_latency =3D power->exit_latency;
>> +				cpu_idle =3D i;
>> +				continue;
>> +			}
>
> I think this is wrong.  This gives priority to CPUs which have been i=
dle
> for a (longer... although this should have been) shorter period of ti=
me
> over those with a shallower idle state.  I think this should rather b=
e:
>
> 	if (power && power->exit_latency < min_exit_latency) {
> 		min_exit_latency =3D power->exit_latency;
> 		latest_idle_stamp =3D idle_stamp;
> 	       	cpu_idle =3D i;
> 	} else if ((!power || power->exit_latency =3D=3D min_exit_latency) &=
&
> 		   idle_stamp > latest_idle_stamp) {
> 		latest_idle_stamp =3D idle_stamp;
> 		cpu_idle =3D i;
> 	}
>
> So the CPU with the shallowest idle state is selected in priority, an=
d
> if many CPUs are in the same state then the time stamp is used to
> select the most recent one. Whenever
> a shallower idle state is found then the latest_idle_stamp is reset f=
or
> that state even if it is further in the past.
>
>> +		} else {
>> +
>> +			load =3D weighted_cpuload(i);
>> +
>> +			if (load < min_load ||
>> +			    (load =3D=3D min_load && i =3D=3D this_cpu)) {
>> +				min_load =3D load;
>> +				cpu_busy =3D i;
>> +				continue;
>> +			}
>>   		}
>
> I think this is wrong to do an if-else based on idle_cpu() here.  Wha=
t
> if a CPU is heavily loaded, but for some reason it happens to be idle=
 at
> this very moment?  With your patch it could be selected as an idle CP=
U
> while it would be discarded as being too busy otherwise.
>
> It is important to determine both cpu_busy and cpu_idle for all CPUs.
>
> And cpu_busy is a bad name for this.  Something like least_loaded wou=
ld
> be more self explanatory.  Same thing for cpu_idle which could be
> clearer if named shalloest_idle.
>
>> -	return idlest;
>> +	/* Busy cpus are considered less idle than idle cpus ;) */
>> +	return cpu_busy !=3D -1 ? cpu_busy : cpu_idle;
>
> And finally it is a policy decision whether or not we want to return
> least_loaded over shallowest_idle e.g do we pack tasks on non idle CP=
Us
> first or not.  That in itself needs more investigation.  To keep the
> existing policy unchanged for now the above condition should have its
> variables swapped.


Ok, refreshed the patchset but before sending it out I would to discuss=
=20
about the rational of the changes and the policy, and change the=20
patchset consequently.

What order to choose if the cpu is idle ?

Let's assume all cpus are idle on a dual socket quad core.

Also, we can reasonably do the hypothesis if the cluster is in low powe=
r=20
mode, the cpus belonging to the same cluster are in the same idle state=
=20
(putting apart the auto-promote where we don't have control on).

If the policy you talk above is 'aggressive power saving', we can follo=
w=20
the rules with decreasing priority:

1. We want to prevent to wakeup the entire cluster
	=3D> as the cpus are in the same idle state, by choosing a cpu in shal=
low=20
state, we should have the guarantee we won't wakeup a cluster (except i=
f=20
no shallowest idle cpu are found).

2. We want to prevent to wakeup a cpu which did not reach the target=20
residency time (will need some work to unify cpuidle idle time and idle=
=20
task run time)
	=3D> with the target residency and, as a first step, with the idle sta=
mp,=20
we can determine if the cpu slept enough

3. We want to prevent to wakeup a cpu in deep idle state
	=3D> by looking for the cpu in shallowest idle state

4. We want to prevent to wakeup a cpu where the exit latency is longer=20
than the expected run time of the task (and the time to migrate the tas=
k ?)

Concerning the policy, I would suggest to create an entry in
/proc/sys/kernel/sched_power, where a couple of values could be=20
performance - power saving (0 / 1).

Does it make sense ? Any ideas ?

Thanks
   -- Daniel




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

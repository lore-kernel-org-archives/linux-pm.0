From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] sched: fair: Fix wrong idle timestamp usage
Date: Thu, 07 May 2015 17:31:25 +0200
Message-ID: <554B854D.9060109@linaro.org>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org> <1429092024-20498-3-git-send-email-daniel.lezcano@linaro.org> <20150415121831.GU5029@twins.programming.kicks-ass.net> <552E8715.4060601@linaro.org> <20150415160200.GU23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33493 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbbEGPba (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 11:31:30 -0400
Received: by wgin8 with SMTP id n8so47375989wgi.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 08:31:28 -0700 (PDT)
In-Reply-To: <20150415160200.GU23123@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org, Ingo Molnar <mingo@redhat.com>

On 04/15/2015 06:02 PM, Peter Zijlstra wrote:
> On Wed, Apr 15, 2015 at 05:43:17PM +0200, Daniel Lezcano wrote:
>> On 04/15/2015 02:18 PM, Peter Zijlstra wrote:
>>> On Wed, Apr 15, 2015 at 12:00:24PM +0200, Daniel Lezcano wrote:
>>>> The find_idlest_cpu is assuming the rq->idle_stamp information ref=
lects when
>>>> the cpu entered the idle state. This is wrong as the cpu may exit =
and enter
>>>> the idle state several times without the rq->idle_stamp being upda=
ted.
>>>
>>> Sure, but you forgot to tell us why it matters.
>>
>> Yes, right. Thanks for pointing this out.
>>
>> Assuming we are in the situation where there are several idle cpus i=
n the
>> same idle state.
>>
>> With the current code, the function find_idlest_cpu will choose a cp=
u with
>> the shortest idle duration. This information is based on the rq->idl=
e_stamp
>> variable and is correct until one of the idle cpu is exiting the
>> cpuidle_enter function and re-entering it again. As soon as this hap=
pen, the
>> rq->idle_stamp value is no longer a reliable information.
>>
>> Example:
>>
>>   * CPU0 and CPU1 are running
>>   * CPU2 and CPU3 are in the C3 state.
>>   * CPU2 entered idle at T2
>>   * CPU3 entered idle at T3
>>   * T2 < T3
>>
>> The function find_idlest_cpu will choose CPU3 because it has a short=
er idle
>> duration.
>>
>> Then CPU3 is woken up by an interrupt, process it and re-enter idle =
C3.
>>
>> The information will still give the out to date information T2 < T3 =
and
>> find_idlest_cpu will choose CPU2 instead of CPU3.
>>
>> Even if that shouldn't have a big impact on the performance and ener=
gy side,
>> we are dealing with a wrong information preventing us to improve the=
 energy
>> side later (eg. prevent to wakeup a cpu which did not reach its targ=
et
>> residency yet).
>
> Right, I figured as much; but no tangible results or behavioural fail
> observed.
>
>>> Urgh, you made horrid code more horrible.
>>>
>>> And all without reason.
>>
>> Ok. What is horrible ? The 'if then else' blocks or the algorithm it=
self ?
>
> Yeah the amount and depth of branches. I briefly tried to see if it
> could be fixed but came up empty. Maybe I should try harder :-)

Here's a try here (patch below based on top of this patchset).

There is a cpumask for the idle cpus being set / cleared when entering =
/=20
exiting the idle loop.

The function find_idlest_cpu uses this mask to separate idle cpus from=20
running cpus.

So the benefit of this approach is we don't lookup on all sched_group's=
=20
cpus but just a subset.


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b44f1ad..b6f671e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4686,67 +4686,89 @@ find_idlest_group(struct sched_domain *sd,=20
struct task_struct *p,
  	return idlest;
  }

-/*
- * find_idlest_cpu - find the idlest cpu among the cpus in group.
- */
-static int
-find_idlest_cpu(struct sched_group *group, struct task_struct *p, int=20
this_cpu)
+struct cpumask idle_cpus_mask;
+
+static int find_shallowest_idle_cpu(struct cpumask *cpus)
  {
-	unsigned long load, min_load =3D ULONG_MAX;
-	unsigned int min_exit_latency =3D UINT_MAX;
  	u64 latest_idle_timestamp =3D 0;
-	int least_loaded_cpu =3D this_cpu;
-	int shallowest_idle_cpu =3D -1;
-	int i;
+	unsigned min_exit_latency =3D UINT_MAX;
+	int i, cpu =3D -1;

-	/* Traverse only the allowed CPUs */
-	for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) {
-		if (idle_cpu(i)) {
-			struct rq *rq =3D cpu_rq(i);
-			struct cpuidle_state *idle =3D idle_get_state(rq);
-
-			if (idle) {
-				if (idle->exit_latency < min_exit_latency) {
-					/*
-					 * We give priority to a CPU
-					 * whose idle state has the
-					 * smallest exit latency
-					 * irrespective of any idle
-					 * timestamp.
-					 */
-					min_exit_latency =3D idle->exit_latency;
-					latest_idle_timestamp =3D idle->idle_stamp;
-					shallowest_idle_cpu =3D i;
-				} else if (idle->exit_latency =3D=3D min_exit_latency &&
-					   idle->idle_stamp > latest_idle_timestamp) {
-					/*
-					 * If the CPU is in the same
-					 * idle state, choose the more
-					 * recent one as it might have
-					 * a warmer cache
-					 */
-					latest_idle_timestamp =3D idle->idle_stamp;
-					shallowest_idle_cpu =3D i;
-				}
-			} else if (rq->idle_stamp > latest_idle_timestamp) {
-				/*
-				 * If no active idle state, then the
-				 * most recent idled CPU might have a
-				 * warmer cache
-				 */
+	for_each_cpu(i, cpus) {
+
+		struct rq *rq =3D cpu_rq(i);
+		struct cpuidle_state *state =3D idle_get_state(rq);
+
+		if (!state) {
+
+			if (rq->idle_stamp > latest_idle_timestamp) {
  				latest_idle_timestamp =3D rq->idle_stamp;
-				shallowest_idle_cpu =3D i;
-			}
-		} else if (shallowest_idle_cpu =3D=3D -1) {
-			load =3D weighted_cpuload(i);
-			if (load < min_load || (load =3D=3D min_load && i =3D=3D this_cpu))=
 {
-				min_load =3D load;
-				least_loaded_cpu =3D i;
+				cpu =3D i;
  			}
+
+			continue;
+		}
+
+		if (state->exit_latency < min_exit_latency) {
+			/*
+			 * We give priority to a CPU whose idle state
+			 * has the smallest exit latency irrespective
+			 * of any idle timestamp.
+			 */
+			min_exit_latency =3D state->exit_latency;
+			cpu =3D i;
+
+			continue;
+		}
+
+		if (state->exit_latency =3D=3D min_exit_latency &&
+		    state->idle_stamp > latest_idle_timestamp) {
+			/*
+			 * If the CPU is in the same idle state,
+			 * choose the more recent one as it might have
+			 * a warmer cache
+			 */
+			cpu =3D i;
+		}
+	}
+
+	return cpu;
+}
+
+static int find_least_loaded_cpu(struct cpumask *cpus)
+{
+	int i, cpu, this_cpu;
+	int min_load =3D ULONG_MAX, load =3D weighted_cpuload(cpu);
+
+	cpu =3D this_cpu =3D smp_processor_id();
+
+	for_each_cpu(i, cpus) {
+		if (load < min_load || (load =3D=3D min_load && i =3D=3D this_cpu)) =
{
+			min_load =3D load;
+			cpu =3D i;
  		}
  	}

-	return shallowest_idle_cpu !=3D -1 ? shallowest_idle_cpu : least_load=
ed_cpu;
+	return cpu;
+}
+
+/*
+ * find_idlest_cpu - find the idlest cpu among the cpus in group.
+ */
+static int
+find_idlest_cpu(struct sched_group *group, struct task_struct *p)
+{
+	struct cpumask tmp, idle_cpus, running_cpus;
+
+	cpumask_and(&tmp, sched_group_cpus(group), tsk_cpus_allowed(p));
+
+	cpumask_and(&idle_cpus, &idle_cpus_mask, &tmp);
+
+	cpumask_andnot(&running_cpus, &idle_cpus_mask, &tmp);
+
+	return !cpumask_empty(&idle_cpus) ?
+		find_shallowest_idle_cpu(&idle_cpus) :
+		find_least_loaded_cpu(&running_cpus);
  }

  /*
@@ -4887,7 +4909,7 @@ select_task_rq_fair(struct task_struct *p, int=20
prev_cpu, int sd_flag, int wake_f
  			continue;
  		}

-		new_cpu =3D find_idlest_cpu(group, p, cpu);
+		new_cpu =3D find_idlest_cpu(group, p);
  		if (new_cpu =3D=3D -1 || new_cpu =3D=3D cpu) {
  			/* Now try balancing at a lower domain level of cpu */
  			sd =3D sd->child;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80014a1..b2aa008 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -217,6 +217,8 @@ use_default:
   */
  static void cpu_idle_loop(void)
  {
+	int cpu =3D smp_processor_id();
+
  	while (1) {
  		/*
  		 * If the arch has a polling bit, we maintain an invariant:
@@ -230,6 +232,8 @@ static void cpu_idle_loop(void)
  		__current_set_polling();
  		tick_nohz_idle_enter();

+		cpumask_set_cpu(cpu, &idle_cpus_mask);
+
  		while (!need_resched()) {
  			check_pgt_cache();
  			rmb();
@@ -257,6 +261,8 @@ static void cpu_idle_loop(void)
  			arch_cpu_idle_exit();
  		}

+		cpumask_clear_cpu(cpu, &idle_cpus_mask);
+
  		/*
  		 * Since we fell out of the loop above, we know
  		 * TIF_NEED_RESCHED must be set, propagate it into
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e0e1299..a14d833 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -544,6 +544,8 @@ struct root_domain {

  extern struct root_domain def_root_domain;

+extern struct cpumask idle_cpus_mask;
+
  #endif /* CONFIG_SMP */

  /*




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


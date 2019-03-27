From: Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 3/7] smp: Poke the cores before requesting IPI
Date: Wed, 27 Mar 2019 13:21:11 +0000
Message-ID: <1553692845-20983-4-git-send-email-abel.vesa@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

Try poking the specified core(s) every time before requesting IPI,
this way allowing the cpuidle driver to do its magic for the current
idle state of the specified core(s), if there is such a need.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 kernel/irq_work.c            | 19 ++++++++++++++++---
 kernel/sched/core.c          | 16 +++++++++++-----
 kernel/smp.c                 | 10 +++++++++-
 kernel/time/tick-broadcast.c |  4 ++++
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 6b7cdf1..deca898 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/cpuidle.h>
 #include <asm/processor.h>
=20
=20
@@ -76,8 +77,12 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
=20
-	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
+	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu))) {
+		/* Poke the cpu through cpuidle first */
+		cpuidle_poke(cpumask_of(cpu));
+
 		arch_send_call_function_single_ipi(cpu);
+	}
=20
 #else /* #ifdef CONFIG_SMP */
 	irq_work_queue(work);
@@ -99,11 +104,19 @@ bool irq_work_queue(struct irq_work *work)
 	/* If the work is "lazy", handle it from next tick if any */
 	if (work->flags & IRQ_WORK_LAZY) {
 		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
+		    tick_nohz_tick_stopped()) {
+			/* Poke the cpus through cpuidle first */
+			cpuidle_poke(cpumask_of(smp_processor_id()));
+
 			arch_irq_work_raise();
+		}
 	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list))) {
+			/* Poke the cpus through cpuidle first */
+			cpuidle_poke(cpumask_of(smp_processor_id()));
+
 			arch_irq_work_raise();
+		}
 	}
=20
 	preempt_enable();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48..7be9dba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -126,6 +126,12 @@ struct rq *task_rq_lock(struct task_struct *p, struct =
rq_flags *rf)
 	}
 }
=20
+static void smp_poke_and_send_reschedule(int cpu)
+{
+	cpuidle_poke(cpumask_of(cpu));
+	smp_send_reschedule(cpu);
+}
+
 /*
  * RQ-clock updating methods:
  */
@@ -511,7 +517,7 @@ void resched_curr(struct rq *rq)
 	}
=20
 	if (set_nr_and_not_polling(curr))
-		smp_send_reschedule(cpu);
+		smp_poke_and_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
 }
@@ -583,7 +589,7 @@ static void wake_up_idle_cpu(int cpu)
 		return;
=20
 	if (set_nr_and_not_polling(rq->idle))
-		smp_send_reschedule(cpu);
+		smp_poke_and_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
 }
@@ -1471,7 +1477,7 @@ void kick_process(struct task_struct *p)
 	preempt_disable();
 	cpu =3D task_cpu(p);
 	if ((cpu !=3D smp_processor_id()) && task_curr(p))
-		smp_send_reschedule(cpu);
+		smp_poke_and_send_reschedule(cpu);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kick_process);
@@ -1836,7 +1842,7 @@ static void ttwu_queue_remote(struct task_struct *p, =
int cpu, int wake_flags)
=20
 	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
-			smp_send_reschedule(cpu);
+			smp_poke_and_send_reschedule(cpu);
 		else
 			trace_sched_wake_idle_without_ipi(cpu);
 	}
@@ -1857,7 +1863,7 @@ void wake_up_if_idle(int cpu)
 	} else {
 		rq_lock_irqsave(rq, &rf);
 		if (is_idle_task(rq->curr))
-			smp_send_reschedule(cpu);
+			smp_poke_and_send_reschedule(cpu);
 		/* Else CPU is not idle, do nothing here: */
 		rq_unlock_irqrestore(rq, &rf);
 	}
diff --git a/kernel/smp.c b/kernel/smp.c
index f4cf1b0..f6b2ce7 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -17,6 +17,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/sched.h>
+#include <linux/cpuidle.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
=20
@@ -175,8 +176,12 @@ static int generic_exec_single(int cpu, call_single_da=
ta_t *csd,
 	 * locking and barrier primitives. Generic code isn't really
 	 * equipped to do the right thing...
 	 */
-	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
+	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu))) {
+		/* Poke the cpus through cpuidle first */
+		cpuidle_poke(cpumask_of(cpu));
+
 		arch_send_call_function_single_ipi(cpu);
+	}
=20
 	return 0;
 }
@@ -457,6 +462,9 @@ void smp_call_function_many(const struct cpumask *mask,
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
=20
+	/* Poke the cpus through cpuidle first */
+	cpuidle_poke(cfd->cpumask_ipi);
+
 	/* Send a message to all CPUs in the map */
 	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
=20
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 0283523..8bb7b2b 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/cpuidle.h>
=20
 #include "tick-internal.h"
=20
@@ -286,6 +287,9 @@ static bool tick_do_broadcast(struct cpumask *mask)
 	}
=20
 	if (!cpumask_empty(mask)) {
+		/* Poke the cpus through cpuidle first */
+		cpuidle_poke(mask);
+
 		/*
 		 * It might be necessary to actually check whether the devices
 		 * have different broadcast functions. For now, just use the
--=20
2.7.4

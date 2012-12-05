From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 07/10] kick_process(),
 cpu-hotplug: Prevent offlining of target CPU properly
Date: Thu, 06 Dec 2012 00:14:14 +0530
Message-ID: <20121205184412.3750.98544.stgit@srivatsabhat.in.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, oleg@redhat.com
Cc: sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, srivatsa.bhat@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() to prevent CPUs from going offline from under us.

Use the get/put_online_cpus_atomic_light() APIs to prevent changes to the
cpu_online_mask, while invoking from atomic context.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c9a331e..84a8579 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1091,11 +1091,11 @@ void kick_process(struct task_struct *p)
 {
 	int cpu;
 
-	preempt_disable();
+	get_online_cpus_atomic_light();
 	cpu = task_cpu(p);
 	if ((cpu != smp_processor_id()) && task_curr(p))
 		smp_send_reschedule(cpu);
-	preempt_enable();
+	put_online_cpus_atomic_light();
 }
 EXPORT_SYMBOL_GPL(kick_process);
 #endif /* CONFIG_SMP */

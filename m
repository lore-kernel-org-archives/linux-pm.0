From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH 10/10] cpu: No more __stop_machine() in _cpu_down()
Date: Tue, 04 Dec 2012 14:26:21 +0530
Message-ID: <20121204085615.25919.98054.stgit@srivatsabhat.in.ibm.com>
References: <20121204085149.25919.29920.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:36883 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab2LDI5u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Dec 2012 03:57:50 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 4 Dec 2012 18:53:07 +1000
In-Reply-To: <20121204085149.25919.29920.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org
Cc: sbw@mit.edu, tj@kernel.org, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, srivatsa.bhat@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Paul E. McKenney <paul.mckenney@linaro.org>

The _cpu_down() function invoked as part of the CPU-hotplug offlining
process currently invokes __stop_machine(), which is slow and inflicts
substantial real-time latencies on the entire system.  This patch
substitutes stop_cpus() for __stop_machine() in order to improve
both performance and real-time latency.

This is currently unsafe, because there are a number of uses of
preempt_disable() that are intended to block CPU-hotplug offlining.
These will be fixed by using get/put_online_cpus_stable_atomic(), but in the
meantime, this commit is one way to help locate them.

Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ Srivatsa: Refer to get/put_online_cpus_stable_atomic() in the changelog ]
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/cpu.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aaf2393..59592e5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -352,15 +352,20 @@ static int __ref take_cpu_down(void *_param)
 {
 	struct take_cpu_down_param *param = _param;
 	int err, cpu = (long)(param->hcpu);
+	unsigned long flags;
 
 	prepare_cpu_take_down(cpu);
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
+	local_irq_save(flags);
 	err = __cpu_disable();
-	if (err < 0)
+	if (err < 0) {
+		local_irq_restore(flags);
 		return err;
+	}
 
 	cpu_notify(CPU_DYING | param->mod, param->hcpu);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -393,7 +398,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
 	}
 	smpboot_park_threads(cpu);
 
-	err = __stop_machine(take_cpu_down, &tcd_param, cpumask_of(cpu));
+	err = stop_cpus(cpumask_of(cpu), take_cpu_down, &tcd_param);
 	if (err) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		smpboot_unpark_threads(cpu);


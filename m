From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] irq_work: unhide irq_work_queue_on declaration on non-SMP
Date: Wed, 10 Feb 2016 16:07:20 +0100
Message-ID: <4447865.IoQjlk8ngP@wuerfel>
References: <E1aTQoy-0005cH-Tr@optimist> <20160210095252.GS13270@sirena.org.uk> <CAJZ5v0iamr-b5h=eS1SWo6WMj_NNOqnXoxnC6R03VmtLBG5dEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57607 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbcBJPIG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 10:08:06 -0500
In-Reply-To: <CAJZ5v0iamr-b5h=eS1SWo6WMj_NNOqnXoxnC6R03VmtLBG5dEA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linaro-kernel@lists.linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kernel-build-reports@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org

The cpufreq code uses 'if (IS_ENABLED(CONFIG_SMP))' to check
whether it should queue a task on the local CPU or a remote
one, however the irq_work_queue_on() function is not declared
when CONFIG_SMP is not set:

drivers/cpufreq/cpufreq_governor.c: In function 'gov_queue_irq_work':
drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]
   irq_work_queue_on(&policy_dbs->irq_work, smp_processor_id());

This changes the conditional declaration so that irq_work_queue_on
just queues the irq work on the only available CPU when CONFIG_SMP
is not set, which is presumably what most people need anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0144fa03ef46 ("cpufreq: governor: Replace timers with utilization update callbacks")

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 47b9ebd4a74f..c9bde50ef317 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -33,9 +33,13 @@ void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 #define DEFINE_IRQ_WORK(name, _f) struct irq_work name = { .func = (_f), }
 
 bool irq_work_queue(struct irq_work *work);
-
 #ifdef CONFIG_SMP
 bool irq_work_queue_on(struct irq_work *work, int cpu);
+#else
+static inline bool irq_work_queue_on(struct irq_work *work, int cpu)
+{
+	return irq_work_queue(work);
+}
 #endif
 
 void irq_work_tick(void);


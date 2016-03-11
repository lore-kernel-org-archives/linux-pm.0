From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH v2] cpufreq: Make cpufreq_quick_get() safe to call.
Date: Fri, 11 Mar 2016 09:43:07 +0100
Message-ID: <1457685787-6046-1-git-send-email-rcochran@linutronix.de>
References: <CAJZ5v0gDkVyHyQ-4YPV5SYz5ppbc+OT6xm-zaAVfMdponS4L8A@mail.gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36058 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935365AbcCKInO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2016 03:43:14 -0500
In-Reply-To: <CAJZ5v0gDkVyHyQ-4YPV5SYz5ppbc+OT6xm-zaAVfMdponS4L8A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

The function, cpufreq_quick_get, accesses the global 'cpufreq_driver' and
its fields without taking the associated lock, cpufreq_driver_lock.

Without the locking, nothing guarantees that 'cpufreq_driver' remains
consistent during the call.  This patch fixes the issue by taking the lock
before accessing the data structure.

Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/cpufreq/cpufreq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e979ec7..053aa1f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1457,9 +1457,17 @@ unsigned int cpufreq_quick_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
 	unsigned int ret_freq = 0;
+	unsigned long flags;
 
-	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
-		return cpufreq_driver->get(cpu);
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
+
+	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get) {
+		ret_freq = cpufreq_driver->get(cpu);
+		read_unlock_irqrestore(&cpufreq_driver_lock, flags);
+		return ret_freq;
+	}
+
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	policy = cpufreq_cpu_get(cpu);
 	if (policy) {
-- 
2.1.4


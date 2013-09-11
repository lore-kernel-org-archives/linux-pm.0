From: tianyu.lan@intel.com
Subject: [PATCH] Cpufreq: Acquire read lock in the cpufreq_policy_restore() rather than write lock
Date: Wed, 11 Sep 2013 15:05:05 +0800
Message-ID: <1378883105-1411-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58136 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab3IKHOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Sep 2013 03:14:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, viresh.kumar@linaro.org, srivatsa.bhat@linux.vnet.ibm.com
Cc: Lan Tianyu <tianyu.lan@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

In the cpufreq_policy_restore(), policy before system suspend is read from
from percpu's cpufreq_cpu_data_fallback. It's read operation rather than
write operation. So convert write lock to read lock

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 81ceea6..b762f9b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -912,11 +912,11 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	struct cpufreq_policy *policy;
 	unsigned long flags;
 
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
 	policy = per_cpu(cpufreq_cpu_data_fallback, cpu);
 
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	return policy;
 }
-- 
1.8.4.rc0.1.g8f6a3e5.dirty


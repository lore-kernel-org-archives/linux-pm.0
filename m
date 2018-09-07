From: Igor Stoppa <igor.stoppa@gmail.com>
Subject: [PATCH] cpufreq: remove unnecessary unlikely()
Date: Fri,  7 Sep 2018 19:09:55 +0300
Message-ID: <20180907160955.23291-1-igor.stoppa@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f53fb41efb7b..7aa3dcad2175 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -403,7 +403,7 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_transition_begin);
 void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 		struct cpufreq_freqs *freqs, int transition_failed)
 {
-	if (unlikely(WARN_ON(!policy->transition_ongoing)))
+	if (WARN_ON(!policy->transition_ongoing))
 		return;
 
 	cpufreq_notify_post_transition(policy, freqs, transition_failed);
-- 
2.17.1

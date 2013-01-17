From: dirk.brandewie@gmail.com
Subject: [PATCH] cpufreq: handle cpufreq being disabled for all exported function.
Date: Thu, 17 Jan 2013 08:22:21 -0800
Message-ID: <1358439741-16100-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:57818 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab3AQQWc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jan 2013 11:22:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
Cc: rjw@sisk.pl, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

When disable_cpufreq() is called some exported functions are still
being used that do not have a check for cpufreq being disabled.

Add a disabled check into cpufreq_cpu_get() to return NULL if
cpufreq is disabled this covers most of the exported functions. For
the exported functions that do not call cpufreq_cpu_get() add an
explicit check.

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---

Updated sign-off 

 drivers/cpufreq/cpufreq.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1f93dbd..b7663f7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -180,6 +180,9 @@ err_out:
 
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 {
+	if (cpufreq_disabled())
+		return NULL;
+
 	return __cpufreq_cpu_get(cpu, false);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
@@ -198,6 +201,9 @@ static void __cpufreq_cpu_put(struct cpufreq_policy *data, bool sysfs)
 
 void cpufreq_cpu_put(struct cpufreq_policy *data)
 {
+	if (cpufreq_disabled())
+		return;
+
 	__cpufreq_cpu_put(data, false);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
@@ -264,6 +270,9 @@ void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
 
 	BUG_ON(irqs_disabled());
 
+	if (cpufreq_disabled())
+		return;
+
 	freqs->flags = cpufreq_driver->flags;
 	pr_debug("notification %u of frequency transition to %u kHz\n",
 		state, freqs->new);
@@ -1408,6 +1417,9 @@ int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list)
 {
 	int ret;
 
+	if (cpufreq_disabled())
+		return -EINVAL;
+
 	WARN_ON(!init_cpufreq_transition_notifier_list_called);
 
 	switch (list) {
@@ -1442,6 +1454,9 @@ int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
 {
 	int ret;
 
+	if (cpufreq_disabled())
+		return -EINVAL;
+
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
 		ret = srcu_notifier_chain_unregister(
@@ -1522,6 +1537,9 @@ int __cpufreq_driver_getavg(struct cpufreq_policy *policy, unsigned int cpu)
 {
 	int ret = 0;
 
+	if (cpufreq_disabled())
+		return ret;
+
 	if (!(cpu_online(cpu) && cpufreq_driver->getavg))
 		return 0;
 
-- 
1.7.7.6


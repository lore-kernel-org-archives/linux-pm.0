From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Increase the verbosity of OCC console messages
Date: Thu, 27 Aug 2015 14:41:44 +0530
Message-ID: <1440666704-10666-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:49330 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbH0JMH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 05:12:07 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Thu, 27 Aug 2015 14:42:04 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: stewart@linux.vnet.ibm.com, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Modify the OCC reset/load/active event message to make it clearer for
the user to understand the event and effect of the event.

Suggested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
This patch is based on top of linux-next/master

 drivers/cpufreq/powernv-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 546e056..64994e1 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -465,6 +465,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 	switch (omsg.type) {
 	case OCC_RESET:
 		occ_reset = true;
+		pr_info("OCC (On Chip Controller - enforces hard thermal/power limits) Resetting\n");
 		/*
 		 * powernv_cpufreq_throttle_check() is called in
 		 * target() callback which can detect the throttle state
@@ -474,12 +475,12 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		 */
 		if (!throttled) {
 			throttled = true;
-			pr_crit("CPU Frequency is throttled\n");
+			pr_crit("CPU frequency is throttled for duration\n");
 		}
-		pr_info("OCC: Reset\n");
+
 		break;
 	case OCC_LOAD:
-		pr_info("OCC: Loaded\n");
+		pr_info("OCC Loading, CPU frequency is throttled until OCC is started\n");
 		break;
 	case OCC_THROTTLE:
 		omsg.chip = be64_to_cpu(msg->params[1]);
@@ -488,7 +489,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		if (occ_reset) {
 			occ_reset = false;
 			throttled = false;
-			pr_info("OCC: Active\n");
+			pr_info("OCC Active, CPU frequency is no longer throttled\n");
 
 			for (i = 0; i < nr_chips; i++) {
 				chips[i].restore = true;
-- 
1.9.3


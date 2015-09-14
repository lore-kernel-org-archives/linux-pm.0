From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq : powernv: Report Pmax throttling if capped below nominal frequency
Date: Mon, 14 Sep 2015 10:47:54 +0530
Message-ID: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:51453 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbbINFSM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 01:18:12 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Mon, 14 Sep 2015 10:48:10 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Log a 'critical' message if the max frequency is reduced below nominal
frequency. We already log 'info' message if the max frequency is
capped below turbo frequency. CPU should guarantee atleast nominal
frequency, but not turbo frequency in all system configurations and
environments. So report the pmax throttling with severity when Pmax is
dipped below nominal frequency.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 64994e1..2d9ed42 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -327,8 +327,13 @@ static void powernv_cpufreq_throttle_check(void *data)
 		if (chips[i].throttled)
 			goto next;
 		chips[i].throttled = true;
-		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
-			chips[i].id, pmsr_pmax);
+		if (pmsr_pmax < powernv_pstate_info.nominal)
+			pr_crit("CPU %d on Chip %u has Pmax reduced to %d\n",
+				cpu, chips[i].id, pmsr_pmax);
+		else
+			pr_info("CPU %d on Chip %u has Pmax reduced to %d\n",
+				cpu, chips[i].id, pmsr_pmax);
+
 	} else if (chips[i].throttled) {
 		chips[i].throttled = false;
 		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
-- 
1.9.3


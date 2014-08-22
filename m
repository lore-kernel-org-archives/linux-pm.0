From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] intel_idle: add idle values for Cherrytrail/Braswell
Date: Fri, 22 Aug 2014 14:39:00 +0300
Message-ID: <1408707540-12393-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1408701508-13636-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55491 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbaHVLjD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Aug 2014 07:39:03 -0400
In-Reply-To: <1408701508-13636-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Kumar P Mahesh <mahesh.kumar.p@intel.com>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mahesh Kumar P <mahesh.kumar.p@intel.com>

Cherrytrail/Braswell is a successor of Intel Baytrail but has slighly
different CPU idle values and latencies.

Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
I learned from Mahesh that C1e, C4 and S0i2 states are deprecated so those
are now removed.

 drivers/idle/intel_idle.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9b7ee7e427df..e472580c1826 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -197,6 +197,42 @@ static struct cpuidle_state snb_cstates[] = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state cht_cstates[] = {
+	{ /* MWAIT C1 */
+		.name = "C1-CHT",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 1,
+		.target_residency = 4,
+		.enter = &intel_idle },
+	{ /* MWAIT C6 */
+		.name = "C6-CHT",
+		.desc = "MWAIT 0x52",
+		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TIME_VALID
+						| CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 140,
+		.target_residency = 560,
+		.enter = &intel_idle },
+	{ /* MWAIT C7-S0i1 */
+		.name = "S0i1-CHT",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TIME_VALID
+						| CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 1200,
+		.target_residency = 4000,
+		.enter = &intel_idle },
+	{ /* MWAIT C9-S0i3 */
+		.name = "S0i3-CHT",
+		.desc = "MWAIT 0x64",
+		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TIME_VALID
+						| CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 10000,
+		.target_residency = 20000,
+		.enter = &intel_idle },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state byt_cstates[] = {
 	{
 		.name = "C1-BYT",
@@ -677,6 +713,11 @@ static const struct idle_cpu idle_cpu_byt = {
 	.byt_auto_demotion_disable_flag = true,
 };
 
+static const struct idle_cpu idle_cpu_cht = {
+	.state_table = cht_cstates,
+	.disable_promotion_to_c1e = true,
+};
+
 static const struct idle_cpu idle_cpu_ivb = {
 	.state_table = ivb_cstates,
 	.disable_promotion_to_c1e = true,
@@ -725,6 +766,7 @@ static const struct x86_cpu_id intel_idle_ids[] = {
 	ICPU(0x3f, idle_cpu_hsw),
 	ICPU(0x45, idle_cpu_hsw),
 	ICPU(0x46, idle_cpu_hsw),
+	ICPU(0x4c, idle_cpu_cht),
 	ICPU(0x4d, idle_cpu_avn),
 	ICPU(0x3d, idle_cpu_bdw),
 	ICPU(0x4f, idle_cpu_bdw),
-- 
2.1.0


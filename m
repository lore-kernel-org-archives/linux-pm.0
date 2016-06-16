From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] idle/intel: add denverton
Date: Thu, 16 Jun 2016 09:42:29 -0700
Message-ID: <1466095349-5381-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10635 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbcFPQoM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 12:44:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c966492..633fc35 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -827,6 +827,35 @@ static struct cpuidle_state bxt_cstates[] = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state dnv_cstates[] = {
+	{
+		.name = "C1-DNV",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 2,
+		.target_residency = 2,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C1E-DNV",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01),
+		.exit_latency = 10,
+		.target_residency = 20,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C6-DNV",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 50,
+		.target_residency = 500,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.enter = NULL }
+};
+
 /**
  * intel_idle
  * @dev: cpuidle_device
@@ -1016,6 +1045,11 @@ static const struct idle_cpu idle_cpu_bxt = {
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_dnv = {
+	.state_table = dnv_cstates,
+	.disable_promotion_to_c1e = true,
+};
+
 #define ICPU(model, cpu) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
 
@@ -1052,6 +1086,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x55, idle_cpu_skx),
 	ICPU(0x57, idle_cpu_knl),
 	ICPU(0x5c, idle_cpu_bxt),
+	ICPU(0x5f, idle_cpu_dnv),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
-- 
1.9.1


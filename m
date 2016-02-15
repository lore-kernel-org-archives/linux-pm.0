From: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Subject: [PATCH] intel_idle: Support for Intel Xeon Phi Processor x200 Product Family
Date: Mon, 15 Feb 2016 17:34:43 +0100
Message-ID: <1455554083-10376-1-git-send-email-hubert.chrzaniuk@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40950 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbcBOQfL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Feb 2016 11:35:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, hubert.chrzaniuk@intel.com, lukasz.anaczkowski@intel.com, len.brown@intel.com, dasaratharaman.chandramouli@intel.com, linux-pm@vger.kernel.org, micah.barany@intel.com

From: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>

Enables "Intel(R) Xeon Phi(TM) Processor x200 Product Family" support,
formerly code-named KNL. It is based on modified Intel Atom Silvermont
microarchitecture.

Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
[micah.barany@intel.com: adjusted values of residency and latency]
Signed-off-by: Micah Barany <micah.barany@intel.com>
[hubert.chrzaniuk@intel.com: removed deprecated CPUIDLE_FLAG_TIME_VALID flag]
Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
---
 drivers/idle/intel_idle.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cd4510a..1665f47 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -716,6 +716,24 @@ static struct cpuidle_state avn_cstates[] = {
 	{
 		.enter = NULL }
 };
+static struct cpuidle_state knl_cstates[] = {
+	{
+		.name = "C1-KNL",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 1,
+		.target_residency = 2,
+		.enter = &intel_idle },
+	{
+		.name = "C6-KNL",
+		.desc = "MWAIT 0x10",
+		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 120,
+		.target_residency = 500,
+		.enter = &intel_idle },
+	{
+		.enter = NULL }
+};
 
 /**
  * intel_idle
@@ -890,6 +908,10 @@ static const struct idle_cpu idle_cpu_avn = {
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_knl = {
+	.state_table = knl_cstates,
+};
+
 #define ICPU(model, cpu) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
 
@@ -921,6 +943,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x56, idle_cpu_bdw),
 	ICPU(0x4e, idle_cpu_skl),
 	ICPU(0x5e, idle_cpu_skl),
+	ICPU(0x57, idle_cpu_knl),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
-- 
1.8.3.1


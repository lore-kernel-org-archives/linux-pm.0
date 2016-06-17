From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] idle_intel: Add Denverton
Date: Fri, 17 Jun 2016 01:28:34 -0400
Message-ID: <264f6eef366c0669cf9c8b1850977e13be85160a.1466141080.git.len.brown@intel.com>
References: <20160617052834.26064-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617052834.26064-1-lenb@kernel.org>
In-Reply-To: <cf53e700fa10ffcc6fb2333057e88bac01821040.1466141080.git.len.brown@intel.com>
References: <cf53e700fa10ffcc6fb2333057e88bac01821040.1466141080.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Denverton is an Intel Atom based micro server which shares the same
Goldmont architecture as Broxton. The available C-states on
Denverton is a subset of Broxton with only C1, C1e, and C6.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f93788f..46fed5a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -825,6 +825,35 @@ static struct cpuidle_state bxt_cstates[] = {
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
@@ -1014,6 +1043,11 @@ static const struct idle_cpu idle_cpu_bxt = {
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_dnv = {
+	.state_table = dnv_cstates,
+	.disable_promotion_to_c1e = true,
+};
+
 #define ICPU(model, cpu) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
 
@@ -1050,6 +1084,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x55, idle_cpu_skx),
 	ICPU(0x57, idle_cpu_knl),
 	ICPU(0x5c, idle_cpu_bxt),
+	ICPU(0x5f, idle_cpu_dnv),
 	{}
 };
 
-- 
2.9.0

From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/7] intel_idle: Skylake Client Support
Date: Sat, 15 Aug 2015 23:25:48 -0400
Message-ID: <493f133f47750aa5566fafa9403617e3f0506f8c.1439695194.git.len.brown@intel.com>
References: <1439695548-21174-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439695548-21174-1-git-send-email-lenb@kernel.org>
In-Reply-To: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
References: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Skylake Client CPU idle Power states (C-states)
are similar to the previous generation, Broadwell.
However, Skylake does get its own table with updated
worst-case latency and average energy-break-even residency values.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 008e943..3a3738f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -591,6 +591,67 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state skl_cstates[] = {
+	{
+		.name = "C1-SKL",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 2,
+		.target_residency = 2,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C1E-SKL",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01),
+		.exit_latency = 10,
+		.target_residency = 20,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C3-SKL",
+		.desc = "MWAIT 0x10",
+		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 70,
+		.target_residency = 100,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C6-SKL",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 75,
+		.target_residency = 200,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C7s-SKL",
+		.desc = "MWAIT 0x33",
+		.flags = MWAIT2flg(0x33) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 124,
+		.target_residency = 800,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C8-SKL",
+		.desc = "MWAIT 0x40",
+		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 174,
+		.target_residency = 800,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C10-SKL",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 890,
+		.target_residency = 5000,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state atom_cstates[] = {
 	{
 		.name = "C1E-ATM",
@@ -810,6 +871,12 @@ static const struct idle_cpu idle_cpu_bdw = {
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_skl = {
+	.state_table = skl_cstates,
+	.disable_promotion_to_c1e = true,
+};
+
+
 static const struct idle_cpu idle_cpu_avn = {
 	.state_table = avn_cstates,
 	.disable_promotion_to_c1e = true,
@@ -844,6 +911,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x47, idle_cpu_bdw),
 	ICPU(0x4f, idle_cpu_bdw),
 	ICPU(0x56, idle_cpu_bdw),
+	ICPU(0x4e, idle_cpu_skl),
+	ICPU(0x5e, idle_cpu_skl),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
-- 
2.5.0.330.g130be8e

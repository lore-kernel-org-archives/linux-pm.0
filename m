From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/13] intel_idle: Add SKX support
Date: Wed,  6 Apr 2016 17:00:58 -0400
Message-ID: <39dfffab84fd5f3693f0b96865ec2fef2e338e9f.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34743 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbcDFVBu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:01:50 -0400
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

SKX is similar to BDX

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7575699..d0ec343 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -660,6 +660,35 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state skx_cstates[] = {
+	{
+		.name = "C1-SKX",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 2,
+		.target_residency = 2,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C1E-SKX",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01),
+		.exit_latency = 10,
+		.target_residency = 20,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C6-SKX",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 133,
+		.target_residency = 600,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state atom_cstates[] = {
 	{
 		.name = "C1E-ATM",
@@ -968,6 +997,10 @@ static const struct idle_cpu idle_cpu_skl = {
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_skx = {
+	.state_table = skx_cstates,
+	.disable_promotion_to_c1e = true,
+};
 
 static const struct idle_cpu idle_cpu_avn = {
 	.state_table = avn_cstates,
@@ -1014,6 +1047,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x56, idle_cpu_bdw),
 	ICPU(0x4e, idle_cpu_skl),
 	ICPU(0x5e, idle_cpu_skl),
+	ICPU(0x55, idle_cpu_skx),
 	ICPU(0x57, idle_cpu_knl),
 	ICPU(0x5c, idle_cpu_bxt),
 	{}
-- 
2.8.0.rc4.16.g56331f8


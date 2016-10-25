From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/1] x86/intel_idle: Add CPU model 0x4a (Atom Z34xx series)
Date: Tue, 25 Oct 2016 17:11:39 +0300
Message-ID: <20161025141139.83436-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32026 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbcJYONe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Oct 2016 10:13:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Add CPU ID for Atom Z34xx processors. Datasheets indicate support for this,
detailed information about potential quirks or limitations are missing, though.
So we just reuse the definition from official BSP code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
In v3:
- take the states and values from official BSP for Edison
 drivers/idle/intel_idle.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 4466a2f..5ded9b2 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -724,6 +724,50 @@ static struct cpuidle_state atom_cstates[] = {
 	{
 		.enter = NULL }
 };
+static struct cpuidle_state tangier_cstates[] = {
+	{
+		.name = "C1-TNG",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 1,
+		.target_residency = 4,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C4-TNG",
+		.desc = "MWAIT 0x30",
+		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 100,
+		.target_residency = 400,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C6-TNG",
+		.desc = "MWAIT 0x52",
+		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 140,
+		.target_residency = 560,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C7-TNG",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 1200,
+		.target_residency = 4000,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C9-TNG",
+		.desc = "MWAIT 0x64",
+		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 10000,
+		.target_residency = 20000,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.enter = NULL }
+};
 static struct cpuidle_state avn_cstates[] = {
 	{
 		.name = "C1-AVN",
@@ -978,6 +1022,10 @@ static const struct idle_cpu idle_cpu_atom = {
 	.state_table = atom_cstates,
 };
 
+static const struct idle_cpu idle_cpu_tangier = {
+	.state_table = tangier_cstates,
+};
+
 static const struct idle_cpu idle_cpu_lincroft = {
 	.state_table = atom_cstates,
 	.auto_demotion_disable_flags = ATM_LNC_C6_AUTO_DEMOTE,
@@ -1066,6 +1114,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		idle_cpu_snb),
 	ICPU(INTEL_FAM6_ATOM_CEDARVIEW,		idle_cpu_atom),
 	ICPU(INTEL_FAM6_ATOM_SILVERMONT1,	idle_cpu_byt),
+	ICPU(INTEL_FAM6_ATOM_MERRIFIELD,	idle_cpu_tangier),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		idle_cpu_cht),
 	ICPU(INTEL_FAM6_IVYBRIDGE,		idle_cpu_ivb),
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		idle_cpu_ivt),
-- 
2.9.3


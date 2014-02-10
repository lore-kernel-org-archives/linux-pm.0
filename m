From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] powercap/intel_rapl: spell out soc names
Date: Mon, 10 Feb 2014 06:11:52 -0800
Message-ID: <1392041512-15769-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1392041512-15769-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37364 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbaBJWLY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 10 Feb 2014 17:11:24 -0500
In-Reply-To: <1392041512-15769-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: vince@deater.net, Jacob Pan <jacob.jun.pan@linux.intel.com>

Spell out names for supported SOCs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 0e37fe1..61b51e1 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -834,7 +834,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 }
 
 static const struct x86_cpu_id energy_unit_quirk_ids[] = {
-	{ X86_VENDOR_INTEL, 6, 0x37},/* VLV */
+	{ X86_VENDOR_INTEL, 6, 0x37},/* Valleyview */
 	{}
 };
 
@@ -947,11 +947,11 @@ static void package_power_limit_irq_restore(int package_id)
 }
 
 static const struct x86_cpu_id rapl_ids[] = {
-	{ X86_VENDOR_INTEL, 6, 0x2a},/* SNB */
-	{ X86_VENDOR_INTEL, 6, 0x2d},/* SNB EP */
-	{ X86_VENDOR_INTEL, 6, 0x37},/* VLV */
-	{ X86_VENDOR_INTEL, 6, 0x3a},/* IVB */
-	{ X86_VENDOR_INTEL, 6, 0x45},/* HSW */
+	{ X86_VENDOR_INTEL, 6, 0x2a},/* Sandy Bridge */
+	{ X86_VENDOR_INTEL, 6, 0x2d},/* Sandy Bridge EP */
+	{ X86_VENDOR_INTEL, 6, 0x37},/* Valleyview */
+	{ X86_VENDOR_INTEL, 6, 0x3a},/* Ivy Bridge */
+	{ X86_VENDOR_INTEL, 6, 0x45},/* Haswell */
 	/* TODO: Add more CPU IDs after testing */
 	{}
 };
-- 
1.8.1.2


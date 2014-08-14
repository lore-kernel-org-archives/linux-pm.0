From: Jason Baron <jbaron@akamai.com>
Subject: [PATCH] powercap/rapl: add support for cpu model 0x3f
Date: Thu, 14 Aug 2014 14:26:08 +0000 (GMT)
Message-ID: <20140814142608.5A9A38004B@prod-mail-relay07.akamai.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from prod-mail-xrelay07.akamai.com ([72.246.2.115]:50366 "EHLO
	prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932088AbaHNO0J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Aug 2014 10:26:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, durgadoss.r@intel.com, srinivas.pandruvada@linux.intel.com

I've confirmed that monitoring the package power usage as well as setting power
limits appear to be working as expected. Supports the package and dram domains.

Tested aginst cpu:

Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index b1cda6f..a362dcc 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -953,6 +953,7 @@ static const struct x86_cpu_id rapl_ids[] = {
 	{ X86_VENDOR_INTEL, 6, 0x3a},/* Ivy Bridge */
 	{ X86_VENDOR_INTEL, 6, 0x3c},/* Haswell */
 	{ X86_VENDOR_INTEL, 6, 0x3d},/* Broadwell */
+	{ X86_VENDOR_INTEL, 6, 0x3f},/* Haswell */
 	{ X86_VENDOR_INTEL, 6, 0x45},/* Haswell ULT */
 	/* TODO: Add more CPU IDs after testing */
 	{}
-- 
1.8.2.rc2


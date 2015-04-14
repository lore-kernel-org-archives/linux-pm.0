From: Brian Bian <brian.bian@intel.com>
Subject: [PATCH] Intel RAPL: Add support to Skylake processors
Date: Tue, 14 Apr 2015 10:53:35 -0700
Message-ID: <1429034015-14848-1-git-send-email-brian.bian@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54893 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbbDNR6n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Apr 2015 13:58:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Brian Bian <brian.bian@intel.com>

Signed-off-by: Brian Bian <brian.bian@intel.com>
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 63d4033..7e36859 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1063,6 +1063,7 @@ static const struct x86_cpu_id rapl_ids[] = {
 	RAPL_CPU(0x3d, rapl_defaults_core),/* Broadwell */
 	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell servers */
 	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
+	RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake */
 	RAPL_CPU(0x4C, rapl_defaults_atom),/* Braswell */
 	RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
 	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
-- 
1.9.1


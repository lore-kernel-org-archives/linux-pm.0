From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/44] tools/power turbostat: show package number, even without --debug
Date: Wed,  1 Mar 2017 00:27:44 -0500
Message-ID: <7da6e3e2125d24040b3648ddc61edf70eb533849.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34020 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdCAF5T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:57:19 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

On multi-package systems, the "Package" column was being displayed
only if --debug was used.  Show it always.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 596259f48f50..2c674ad5ab80 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4294,7 +4294,7 @@ void topology_probe()
 	if (debug > 1)
 		fprintf(outf, "max_package_id %d, sizing for %d packages\n",
 			max_package_id, topo.num_packages);
-	if (debug && !summary_only && topo.num_packages > 1)
+	if (!summary_only && topo.num_packages > 1)
 		BIC_PRESENT(BIC_Package);
 
 	topo.num_threads_per_core = max_siblings;
-- 
2.11.0.161.g6610af872

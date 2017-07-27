From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH] turbostat: fix Skylake server package C-states reporting
Date: Thu, 27 Jul 2017 14:41:39 +0300
Message-ID: <1501155699.2643.9.camel@linux.intel.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:61525 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbdG0Llt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jul 2017 07:41:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch fixes the problem of turbostat not reporting any package C-states on
Skylake Xeon processor when the deepest package C-stated is configured as "no
limit" in the UEFI firmware configuration menu.

The lowest 3 bits of the MSR_PKG_CST_CONFIG_CONTROL (0x000000e2) register
contain 7 in this case, meaning "No Package C state limits" (see Intel SDM, vol
4, Table 2-41 - MSRs Supported by Intel® Xeon® Processor Scalable Family with
DisplayFamily_DisplayModel 06_55H).

The problem was that turbostat's internal array of supported package C-sates
(skx_pkg_cstate_limits) marked position #7 as "PCLRSV" (reserved), instead of
"PCLUNL" (not limited). Instead, position #8 was incorrectly marked as "PCLUNL"
(probably due to a typo).

This patch fixes the issue by marking position #7 as "not limited", and
position #8 as "reserved".

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/turbostat.c b/turbostat.c
index 6c185a9..1c4d3e2 100644
--- a/turbostat.c
+++ b/turbostat.c
@@ -1816,7 +1816,7 @@ int slv_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV,
 int amt_pkg_cstate_limits[16] = {PCLUNL, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int bxt_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
-int skx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int skx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 
 
 static void
-- 
2.9.3

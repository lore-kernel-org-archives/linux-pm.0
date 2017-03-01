From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/44] tools/power turbostat: update MSR_PKG_CST_CONFIG_CONTROL decoding
Date: Wed,  1 Mar 2017 00:27:10 -0500
Message-ID: <f2642888476d7faefa9695bbebb2abbaeb3685d8.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

AMT value 0 is unlimited, not PC0

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9b35c9bb0489..aedfaddbad30 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1534,7 +1534,7 @@ int nhm_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCL__3, PCL__6, PCL__7, PCLRSV,
 int snb_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCL__7, PCL_7S, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int hsw_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL__3, PCL__6, PCL__7, PCL_7S, PCL__8, PCL__9, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int slv_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCLRSV, PCLRSV, PCL__4, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
-int amt_pkg_cstate_limits[16] = {PCL__0, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
+int amt_pkg_cstate_limits[16] = {PCLUNL, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int bxt_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int skx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
-- 
2.11.0.161.g6610af872

From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/44] intel_idle: use new name for MSR_PKG_CST_CONFIG_CONTROL
Date: Wed,  1 Mar 2017 00:27:12 -0500
Message-ID: <6cfb2374f83bc70b8acb0ddb989988ba3f140b61.1488345270.git.len.brown@intel.com>
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

previously known as  MSR_NHM_SNB_PKG_CST_CFG_CTL

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7d8ea3d5fda6..930537da76d4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -961,9 +961,9 @@ static void auto_demotion_disable(void)
 {
 	unsigned long long msr_bits;
 
-	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 	msr_bits &= ~(icpu->auto_demotion_disable_flags);
-	wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
+	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 }
 static void c1e_promotion_disable(void)
 {
@@ -1273,7 +1273,7 @@ static void sklh_idle_state_table_update(void)
 	if ((mwait_substates & (0xF << 28)) == 0)
 		return;
 
-	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr);
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
 
 	/* PC10 is not enabled in PKG C-state limit */
 	if ((msr & 0xF) != 8)
-- 
2.11.0.161.g6610af872

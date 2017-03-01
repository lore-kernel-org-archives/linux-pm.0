From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/44] x86: msr-index.h: Define MSR_PKG_CST_CONFIG_CONTROL
Date: Wed,  1 Mar 2017 00:27:11 -0500
Message-ID: <40496c8ee73a5ca4fa581badf2247418980586b1.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

define MSR_PKG_CST_CONFIG_CONTROL (0xE2),
which is the string used by Intel Documentation.

We use this MSR in intel_idle and turbostat by a previous name,
to be updated in the next patch.

Cc: x86@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 710273c617b8..975f23eefe14 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -47,6 +47,7 @@
 #define MSR_PLATFORM_INFO		0x000000ce
 
 #define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
+#define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
 #define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)
-- 
2.11.0.161.g6610af872

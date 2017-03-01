From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/44] x86 msr-index.h: Define Atom specific core ratio MSR locations
Date: Wed,  1 Mar 2017 00:27:18 -0500
Message-ID: <8a34fd0226eaae64d61ff9a113d276e28acb6b5c.1488345270.git.len.brown@intel.com>
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

These MSRs are currently used by the intel_pstate driver,
using a local definition.

Cc: x86@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 079db99f6560..83bc672c225c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -209,6 +209,12 @@
 #define MSR_CC6_DEMOTION_POLICY_CONFIG	0x00000668
 #define MSR_MC6_DEMOTION_POLICY_CONFIG	0x00000669
 
+#define MSR_ATOM_CORE_RATIOS		0x0000066a
+#define MSR_ATOM_CORE_VIDS		0x0000066b
+#define MSR_ATOM_CORE_TURBO_RATIOS	0x0000066c
+#define MSR_ATOM_CORE_TURBO_VIDS	0x0000066d
+
+
 #define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
 #define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
 #define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
-- 
2.11.0.161.g6610af872

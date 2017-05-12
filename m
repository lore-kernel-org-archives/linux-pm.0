From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/5] x86: msr-index.h: define EPB mid-points
Date: Thu, 11 May 2017 22:00:19 -0400
Message-ID: <d0117a0e2780f7803fe55d543ab119416d7582e6.1494552477.git.len.brown@intel.com>
References: <20170512020023.23204-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170512020023.23204-1-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

These are currently open-coded into intel_pstate.c

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 710273c617b8..a92d9bd154f6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -462,9 +462,11 @@
 #define MSR_MISC_PWR_MGMT		0x000001aa
 
 #define MSR_IA32_ENERGY_PERF_BIAS	0x000001b0
-#define ENERGY_PERF_BIAS_PERFORMANCE	0
-#define ENERGY_PERF_BIAS_NORMAL		6
-#define ENERGY_PERF_BIAS_POWERSAVE	15
+#define ENERGY_PERF_BIAS_PERFORMANCE		0
+#define ENERGY_PERF_BIAS_BALANCE_PERFORMANCE	4
+#define ENERGY_PERF_BIAS_NORMAL			6
+#define ENERGY_PERF_BIAS_BALANCE_POWERSAVE	8
+#define ENERGY_PERF_BIAS_POWERSAVE		15
 
 #define MSR_IA32_PACKAGE_THERM_STATUS		0x000001b1
 
-- 
2.11.0.161.g6610af872

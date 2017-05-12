From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] x86: msr-index.h: define HWP.EPP values
Date: Thu, 11 May 2017 22:00:20 -0400
Message-ID: <8d84e906f5db80540510e448226f2718a686eb2a.1494552477.git.len.brown@intel.com>
References: <20170512020023.23204-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170512020023.23204-1-lenb@kernel.org>
In-Reply-To: <d0117a0e2780f7803fe55d543ab119416d7582e6.1494552477.git.len.brown@intel.com>
References: <d0117a0e2780f7803fe55d543ab119416d7582e6.1494552477.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The Hardware Performance State request MSR has a field
to express the "Energy Performance Preference" (HWP.EPP).

Decode that field so the definition may be shared by
by the intel_pstate driver and any utilities that
decode the same register.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a92d9bd154f6..50c0c3204a92 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -239,6 +239,10 @@
 #define HWP_MAX_PERF(x) 		((x & 0xff) << 8)
 #define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
 #define HWP_ENERGY_PERF_PREFERENCE(x)	((x & 0xff) << 24)
+#define HWP_EPP_PERFORMANCE		0x00
+#define HWP_EPP_BALANCE_PERFORMANCE	0x80
+#define HWP_EPP_BALANCE_POWERSAVE	0xC0
+#define HWP_EPP_POWERSAVE		0xFF
 #define HWP_ACTIVITY_WINDOW(x)		((x & 0xff3) << 32)
 #define HWP_PACKAGE_CONTROL(x)		((x & 0x1) << 42)
 
-- 
2.11.0.161.g6610af872

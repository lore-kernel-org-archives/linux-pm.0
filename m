From: dbasehore@chromium.org
Subject: [PATCH v3 1/5] x86: stub out pmc function
Date: Wed,  8 Jun 2016 20:08:54 -0700
Message-ID: <1465441738-7972-2-git-send-email-dbasehore@chromium.org>
References: <1465441738-7972-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465441738-7972-1-git-send-email-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de, gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org
List-Id: linux-pm@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This creates an inline function of intel_pmc_slp_s0_counter_read for
!CONFIG_INTEL_PMC_CORE.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 arch/x86/include/asm/pmc_core.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pmc_core.h b/arch/x86/include/asm/pmc_core.h
index d4855f1..786e526 100644
--- a/arch/x86/include/asm/pmc_core.h
+++ b/arch/x86/include/asm/pmc_core.h
@@ -22,6 +22,10 @@
 #define _ASM_PMC_CORE_H
 
 /* API to read SLP_S0_RESIDENCY counter */
-int intel_pmc_slp_s0_counter_read(u32 *data);
+#ifdef CONFIG_INTEL_PMC_CORE
+extern int intel_pmc_slp_s0_counter_read(u32 *data);
+#else
+static inline int intel_pmc_slp_s0_counter_read(u32 *data) { return -ENOSYS; }
+#endif
 
 #endif /* _ASM_PMC_CORE_H */
-- 
2.8.0.rc3.226.g39d4020

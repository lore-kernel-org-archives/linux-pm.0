From: dbasehore@chromium.org
Subject: [PATCH v2 1/5] x86: stub out pmc function
Date: Wed,  8 Jun 2016 17:43:33 -0700
Message-ID: <1465433017-13602-2-git-send-email-dbasehore@chromium.org>
References: <1465433017-13602-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34698 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbcFIAnq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 20:43:46 -0400
Received: by mail-pa0-f51.google.com with SMTP id bz2so7236589pad.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2016 17:43:45 -0700 (PDT)
In-Reply-To: <1465433017-13602-1-git-send-email-dbasehore@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de, gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org

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


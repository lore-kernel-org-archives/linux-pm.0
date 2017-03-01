From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/44] x86 msr_index.h: Define MSR_MISC_FEATURE_CONTROL
Date: Wed,  1 Mar 2017 00:27:22 -0500
Message-ID: <98af74599ea0757098a5776ea29e581b661dcf6f.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34991 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdCAFjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:39:32 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, x86@kernel.org

From: Len Brown <len.brown@intel.com>

This non-architectural MSR has disable bits
for various prefetchers on modern processors.

While these bits are generally touched only by the BIOS,
say, via BIOS SETUP, it is useful to dump them
when examining options that can alter performance.

Cc: x86@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 83bc672c225c..312fb7e14cdd 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -467,6 +467,7 @@
 
 #define MSR_IA32_TEMPERATURE_TARGET	0x000001a2
 
+#define MSR_MISC_FEATURE_CONTROL	0x000001a4
 #define MSR_MISC_PWR_MGMT		0x000001aa
 
 #define MSR_IA32_ENERGY_PERF_BIAS	0x000001b0
-- 
2.11.0.161.g6610af872

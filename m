From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] x86: msr-index.h: fix shifts to ULL results in HWP macros.
Date: Thu, 11 May 2017 22:00:21 -0400
Message-ID: <2fc49cb0b508947bf048ecb0f5710169e62ce68e.1494552477.git.len.brown@intel.com>
References: <20170512020023.23204-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36321 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757588AbdELCA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 22:00:59 -0400
In-Reply-To: <20170512020023.23204-1-lenb@kernel.org>
In-Reply-To: <d0117a0e2780f7803fe55d543ab119416d7582e6.1494552477.git.len.brown@intel.com>
References: <d0117a0e2780f7803fe55d543ab119416d7582e6.1494552477.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

x = 1
ulong_long = x << 32;

results in:

warning: left shift count >= width of type

x = 8
ulong_long = x << 24;

results in a sign extended ulong_long

Cast x to unsigned long long in these macros
to prevent these errors.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 50c0c3204a92..6da2b30781ff 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -238,13 +238,13 @@
 #define HWP_MIN_PERF(x) 		(x & 0xff)
 #define HWP_MAX_PERF(x) 		((x & 0xff) << 8)
 #define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
-#define HWP_ENERGY_PERF_PREFERENCE(x)	((x & 0xff) << 24)
+#define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long) x & 0xff) << 24)
 #define HWP_EPP_PERFORMANCE		0x00
 #define HWP_EPP_BALANCE_PERFORMANCE	0x80
 #define HWP_EPP_BALANCE_POWERSAVE	0xC0
 #define HWP_EPP_POWERSAVE		0xFF
-#define HWP_ACTIVITY_WINDOW(x)		((x & 0xff3) << 32)
-#define HWP_PACKAGE_CONTROL(x)		((x & 0x1) << 42)
+#define HWP_ACTIVITY_WINDOW(x)		((unsigned long long)(x & 0xff3) << 32)
+#define HWP_PACKAGE_CONTROL(x)		((unsigned long long)(x & 0x1) << 42)
 
 /* IA32_HWP_STATUS */
 #define HWP_GUARANTEED_CHANGE(x)	(x & 0x1)
-- 
2.11.0.161.g6610af872

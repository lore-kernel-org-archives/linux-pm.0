From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] x86: correct spelling for hwp_notify flag
Date: Tue, 22 Sep 2015 10:51:36 -0700
Message-ID: <1442944296-11737-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35328 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759108AbbIVRvy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 13:51:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, hpa@zytor.com
Cc: linux-pm@vger.kernel.org, x86@kernel.org

Because noitification just isn't right.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/include/asm/cpufeature.h | 2 +-
 arch/x86/kernel/cpu/scattered.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 3d6606f..ae372cd 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -191,7 +191,7 @@
 #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_HWP		( 7*32+ 10) /* "hwp" Intel HWP */
-#define X86_FEATURE_HWP_NOITFY	( 7*32+ 11) /* Intel HWP_NOTIFY */
+#define X86_FEATURE_HWP_NOTIFY	( 7*32+ 11) /* Intel HWP_NOTIFY */
 #define X86_FEATURE_HWP_ACT_WINDOW ( 7*32+ 12) /* Intel HWP_ACT_WINDOW */
 #define X86_FEATURE_HWP_EPP	( 7*32+13) /* Intel HWP_EPP */
 #define X86_FEATURE_HWP_PKG_REQ ( 7*32+14) /* Intel HWP_PKG_REQ */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 3d423a1..608fb26 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -37,7 +37,7 @@ void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
 		{ X86_FEATURE_PLN,		CR_EAX, 4, 0x00000006, 0 },
 		{ X86_FEATURE_PTS,		CR_EAX, 6, 0x00000006, 0 },
 		{ X86_FEATURE_HWP,		CR_EAX, 7, 0x00000006, 0 },
-		{ X86_FEATURE_HWP_NOITFY,	CR_EAX, 8, 0x00000006, 0 },
+		{ X86_FEATURE_HWP_NOTIFY,	CR_EAX, 8, 0x00000006, 0 },
 		{ X86_FEATURE_HWP_ACT_WINDOW,	CR_EAX, 9, 0x00000006, 0 },
 		{ X86_FEATURE_HWP_EPP,		CR_EAX,10, 0x00000006, 0 },
 		{ X86_FEATURE_HWP_PKG_REQ,	CR_EAX,11, 0x00000006, 0 },
-- 
2.4.3


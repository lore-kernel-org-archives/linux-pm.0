From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/16] x86 msr-index: Simplify syntax for HWP fields
Date: Sat, 27 Feb 2016 04:00:57 -0500
Message-ID: <670e27d809a9a29943e1d2e45823fa4fc16c29f0.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35962 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0JBu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:50 -0500
Received: by mail-yw0-f194.google.com with SMTP id h80so5308272ywc.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:49 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

syntax only, no functional change

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 690b402..5c5e7e5 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -230,10 +230,10 @@
 #define HWP_PACKAGE_LEVEL_REQUEST_BIT	(1<<11)
 
 /* IA32_HWP_CAPABILITIES */
-#define HWP_HIGHEST_PERF(x)		(x & 0xff)
-#define HWP_GUARANTEED_PERF(x)		((x & (0xff << 8)) >>8)
-#define HWP_MOSTEFFICIENT_PERF(x)	((x & (0xff << 16)) >>16)
-#define HWP_LOWEST_PERF(x)		((x & (0xff << 24)) >>24)
+#define HWP_HIGHEST_PERF(x)		(((x) >> 0) & 0xff)
+#define HWP_GUARANTEED_PERF(x)		(((x) >> 8) & 0xff)
+#define HWP_MOSTEFFICIENT_PERF(x)	(((x) >> 16) & 0xff)
+#define HWP_LOWEST_PERF(x)		(((x) >> 24) & 0xff)
 
 /* IA32_HWP_REQUEST */
 #define HWP_MIN_PERF(x) 		(x & 0xff)
-- 
2.7.1.339.g0233b80


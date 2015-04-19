From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/12] x86 msr-index: define MSR_TURBO_RATIO_LIMIT,1,2
Date: Sat, 18 Apr 2015 20:40:19 -0400
Message-ID: <c4d30668da689de2f27bb0b19de4430d6c95d7cf.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34911 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbDSAkt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:49 -0400
Received: by qkhg7 with SMTP id g7so172803575qkh.2
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:48 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org

From: Len Brown <len.brown@intel.com>

MSR_TURBO_RATIO_LIMIT has grown into a set of three registers.
Add the documented names for them, in preparation
for deleting the previous ad-hoc names:

+#define MSR_TURBO_RATIO_LIMIT          0x000001ad
+#define MSR_TURBO_RATIO_LIMIT1         0x000001ae
+#define MSR_TURBO_RATIO_LIMIT2         0x000001af

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
---
 arch/x86/include/uapi/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/asm/msr-index.h
index 3ce0791..c4c7527 100644
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -61,6 +61,9 @@
 #define MSR_OFFCORE_RSP_1		0x000001a7
 #define MSR_NHM_TURBO_RATIO_LIMIT	0x000001ad
 #define MSR_IVT_TURBO_RATIO_LIMIT	0x000001ae
+#define MSR_TURBO_RATIO_LIMIT		0x000001ad
+#define MSR_TURBO_RATIO_LIMIT1		0x000001ae
+#define MSR_TURBO_RATIO_LIMIT2		0x000001af
 
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
-- 
2.4.0.rc1


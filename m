From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/4] x86: remove unused definition of MSR_NHM_PLATFORM_INFO
Date: Thu, 12 Nov 2015 02:42:32 -0500
Message-ID: <60a356d64f7439d40ef8fc7e899805c5bfb1ed6a.1447313797.git.len.brown@intel.com>
References: <1447314152-2145-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36299 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbKLHnP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2015 02:43:15 -0500
Received: by ykdr82 with SMTP id r82so86158464ykd.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 23:43:14 -0800 (PST)
In-Reply-To: <1447314152-2145-1-git-send-email-lenb@kernel.org>
In-Reply-To: <22c227bf47c6812dd8ac4e59cae4acd3fec74272.1447313797.git.len.brown@intel.com>
References: <22c227bf47c6812dd8ac4e59cae4acd3fec74272.1447313797.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

MSR_NHM_PLATFORM_INFO has been replaced by...
MSR_PLATFORM_INFO

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b8c14bb..705c408 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -35,7 +35,7 @@
 #define MSR_IA32_PERFCTR0		0x000000c1
 #define MSR_IA32_PERFCTR1		0x000000c2
 #define MSR_FSB_FREQ			0x000000cd
-#define MSR_NHM_PLATFORM_INFO		0x000000ce
+#define MSR_PLATFORM_INFO		0x000000ce
 
 #define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
@@ -44,7 +44,6 @@
 #define SNB_C1_AUTO_UNDEMOTE		(1UL << 27)
 #define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
 
-#define MSR_PLATFORM_INFO		0x000000ce
 #define MSR_MTRRcap			0x000000fe
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
-- 
2.6.2.450.g259b5e6


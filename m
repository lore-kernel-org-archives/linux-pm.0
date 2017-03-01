From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/44] x86: msr-index.h: Remove unused MSR_NHM_SNB_PKG_CST_CFG_CTL
Date: Wed,  1 Mar 2017 00:27:14 -0500
Message-ID: <419c9e986ea453d07140bffb9708d730b6317e8e.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36315 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdCAGbJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 01:31:09 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, x86@kernel.org

From: Len Brown <len.brown@intel.com>

The two users, intel_idle driver and turbostat utility
are using the new name, MSR_PKG_CST_CONFIG_CONTROL

Cc: x86@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 975f23eefe14..12ecc6c1e7f8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -46,7 +46,6 @@
 #define MSR_FSB_FREQ			0x000000cd
 #define MSR_PLATFORM_INFO		0x000000ce
 
-#define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
-- 
2.11.0.161.g6610af872

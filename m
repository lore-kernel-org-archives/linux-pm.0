From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/44] x86: intel-family.h: Add GEMINI_LAKE SOC
Date: Wed,  1 Mar 2017 00:27:28 -0500
Message-ID: <311f77708f362c1af0a999ba5ebbbc062fdc5601.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33246 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbdCAFjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:39:32 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, x86@kernel.org

From: Len Brown <len.brown@intel.com>

Cc: x86@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 8167fdb67ae8..9814db42b790 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -59,6 +59,7 @@
 #define INTEL_FAM6_ATOM_MERRIFIELD	0x4A /* Tangier */
 #define INTEL_FAM6_ATOM_MOOREFIELD	0x5A /* Anniedale */
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C
+#define INTEL_FAM6_ATOM_GEMINI_LAKE	0x7A
 #define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
 
 /* Xeon Phi */
-- 
2.11.0.161.g6610af872

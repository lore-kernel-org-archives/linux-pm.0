From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/3] mfd: intel_soc_pmic_bxtwc: Move inclusion to c-file
Date: Fri, 17 Mar 2017 17:37:14 +0200
Message-ID: <20170317153715.48555-2-andriy.shevchenko@linux.intel.com>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:48743 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbdCQPiU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Mar 2017 11:38:20 -0400
In-Reply-To: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to include intel_soc_pmic.h into header which doesn't
require it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 1 +
 include/linux/mfd/intel_bxtwc.h    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 699c8c7c9052..c71db687b7ca 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel_bxtwc.h>
+#include <linux/mfd/intel_soc_pmic.h>
 #include <asm/intel_pmc_ipc.h>
 
 /* PMIC device registers */
diff --git a/include/linux/mfd/intel_bxtwc.h b/include/linux/mfd/intel_bxtwc.h
index 1a0ee9d6efe9..240d6752ec64 100644
--- a/include/linux/mfd/intel_bxtwc.h
+++ b/include/linux/mfd/intel_bxtwc.h
@@ -13,8 +13,6 @@
  * more details.
  */
 
-#include <linux/mfd/intel_soc_pmic.h>
-
 #ifndef __INTEL_BXTWC_H__
 #define __INTEL_BXTWC_H__
 
-- 
2.11.0

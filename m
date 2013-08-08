From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC v02 3/5] PowerCap: Added to drivers build
Date: Thu,  8 Aug 2013 08:23:48 -0700
Message-ID: <1375975430-9202-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1375975430-9202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12282 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965920Ab3HHPZP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Aug 2013 11:25:15 -0400
In-Reply-To: <1375975430-9202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added changes to Makefile and Kconfig to include in driver build.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/Kconfig  | 2 ++
 drivers/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 9953a42..89ff2f8 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -166,4 +166,6 @@ source "drivers/ipack/Kconfig"
 
 source "drivers/reset/Kconfig"
 
+source "drivers/powercap/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 130abc1..e207b2d 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -152,3 +152,4 @@ obj-$(CONFIG_IIO)		+= iio/
 obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_IPACK_BUS)		+= ipack/
 obj-$(CONFIG_NTB)		+= ntb/
+obj-$(CONFIG_POWERCAP_SUPPORT)	+= powercap/
-- 
1.8.3.1


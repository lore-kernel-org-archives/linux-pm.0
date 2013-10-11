From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 3/6] PowerCap: Added to drivers build
Date: Fri, 11 Oct 2013 16:54:57 -0700
Message-ID: <1381535700-2408-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1381535700-2408-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381535700-2408-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Added changes to Makefile and Kconfig to include in driver build.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/Kconfig  | 2 ++
 drivers/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index aa43b91..969e987 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -166,4 +166,6 @@ source "drivers/reset/Kconfig"
 
 source "drivers/fmc/Kconfig"
 
+source "drivers/powercap/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index ab93de8..34c1d55 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -152,3 +152,4 @@ obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_IPACK_BUS)		+= ipack/
 obj-$(CONFIG_NTB)		+= ntb/
 obj-$(CONFIG_FMC)		+= fmc/
+obj-$(CONFIG_POWERCAP)		+= powercap/
-- 
1.8.3.1

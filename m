From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/15] drivers: acpi: Fix dependency for ACPI_HOTPLUG_CPU
Date: Mon,  4 Jun 2012 01:40:05 -0400
Message-ID: <2f07a6134f670755e6ce657d019c26305bfcef89.1338786832.git.len.brown@intel.com>
References: <1338788406-29981-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1338788406-29981-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
References: <c5971456964290da7e98222892797b71ef793e62.1338786831.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Fix the following build warning:

warning: (ACPI_HOTPLUG_CPU) selects ACPI_CONTAINER which has unmet direct dependencies (ACPI && EXPERIMENTAL)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 47768ff..8099895 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -208,7 +208,7 @@ config ACPI_IPMI
 
 config ACPI_HOTPLUG_CPU
 	bool
-	depends on ACPI_PROCESSOR && HOTPLUG_CPU
+	depends on EXPERIMENTAL && ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
 	default y
 
-- 
1.7.11.rc0.100.g5498c5f


From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 19/19] Thermal: int340x thermal: select ACPI fan driver
Date: Thu, 18 Sep 2014 09:53:50 +0800
Message-ID: <1411005230-2227-20-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

we share the same driver for both ACPI predefined Fan device
and INT3404 Fan device, thus we should select the ACPI Fan
driver when int340x thermal drivers are enabeld.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig    | 2 +-
 drivers/thermal/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d0f3265..b23fe37 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -144,7 +144,7 @@ config ACPI_VIDEO
 
 config ACPI_FAN
 	tristate "Fan"
-	select THERMAL
+	depends on THERMAL
 	default y
 	help
 	  This driver supports ACPI fan devices, allowing user-mode
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3a89292..e65ca2f 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -224,6 +224,7 @@ config INT340X_THERMAL
 	depends on X86 && ACPI
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
+	select ACPI_FAN
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
 	  other devices with thermal control capabilities outside the core
-- 
1.8.3.2


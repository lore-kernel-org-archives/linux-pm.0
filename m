From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v3 07/11] drivers: thermal: int3406_thermal: Make PCI dependency explicit
Date: Sun, 23 Dec 2018 23:25:16 +0000
Message-ID: <20181223232521.11320-8-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Need CONFIG_PCI to be set in order to be able to use this driver.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 0582bd12a239..fba1976d5f8d 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -31,7 +31,7 @@ if INT340X_THERMAL
 
 config INT3406_THERMAL
 	tristate "ACPI INT3406 display thermal driver"
-	depends on ACPI_VIDEO
+	depends on ACPI_VIDEO && PCI
 	help
 	  The display thermal device represents the LED/LCD display panel
 	  that may or may not include touch support. The main function of
-- 
2.19.0

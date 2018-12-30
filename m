From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v4 11/11] drivers: thermal: int340x_thermal: Make PCI dependency explicit
Date: Sun, 30 Dec 2018 19:56:12 +0000
Message-ID: <20181230195612.6657-12-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

IOSF_CORE depends on PCI. This was never mentioned.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index fba1976d5f8d..2acddf8fb314 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -4,7 +4,7 @@
 
 config INT340X_THERMAL
 	tristate "ACPI INT340X thermal drivers"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && PCI
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
-- 
2.19.0

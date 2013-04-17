From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 17/30] thermal: cpu_cooling: update Kconfig entry
Date: Wed, 17 Apr 2013 13:12:10 -0400
Message-ID: <1366218743-20841-18-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53571 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965456Ab3DQRSu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Apr 2013 13:18:50 -0400
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

There is no support for hotplug or any other means of reducing
temperature. So, this patch removes these references from Kconfig.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d1c2160..5e3c025 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -72,10 +72,11 @@ config CPU_THERMAL
 	select CPU_FREQ_TABLE
 	help
 	  This implements the generic cpu cooling mechanism through frequency
-	  reduction, cpu hotplug and any other ways of reducing temperature. An
-	  ACPI version of this already exists(drivers/acpi/processor_thermal.c).
+	  reduction. An ACPI version of this already exists
+	  (drivers/acpi/processor_thermal.c).
 	  This will be useful for platforms using the generic thermal interface
 	  and not the ACPI interface.
+
 	  If you want this support, you should say Y here.
 
 config THERMAL_EMULATION
-- 
1.8.2.1.342.gfa7285d


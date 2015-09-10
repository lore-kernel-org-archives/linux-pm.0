From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 06/17] thermal: u8500: allow compile test
Date: Wed,  9 Sep 2015 21:11:02 -0700
Message-ID: <1441858273-4017-7-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to u8500 driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b38ce41..f810bad 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -224,7 +224,7 @@ config DOVE_THERMAL
 
 config DB8500_THERMAL
 	bool "DB8500 thermal management"
-	depends on ARCH_U8500
+	depends on ARCH_U8500 || COMPILE_TEST
 	default y
 	help
 	  Adds DB8500 thermal management implementation according to the thermal
@@ -252,7 +252,7 @@ config TEGRA_SOCTHERM
 
 config DB8500_CPUFREQ_COOLING
 	tristate "DB8500 cpufreq cooling"
-	depends on ARCH_U8500
+	depends on ARCH_U8500 || COMPILE_TEST
 	depends on CPU_THERMAL
 	default y
 	help
-- 
2.5.0

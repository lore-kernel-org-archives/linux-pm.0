From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 08/17] thermal: tegra: allow compile test
Date: Wed,  9 Sep 2015 21:11:04 -0700
Message-ID: <1441858273-4017-9-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to tegra driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e0d0de..c94efd3 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -242,7 +242,7 @@ config ARMADA_THERMAL
 
 config TEGRA_SOCTHERM
 	tristate "Tegra SOCTHERM thermal management"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  Enable this option for integrated thermal management support on NVIDIA
 	  Tegra124 systems-on-chip. The driver supports four thermal zones
-- 
2.5.0

From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] thermal: st: fix Makefile typo
Date: Mon, 10 Dec 2018 22:57:27 +0100
Message-ID: <20181210215738.2189126-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Arnd Bergmann <arnd@arndb.de>, David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When STM32_THERMAL is enabled, this overrides all previously
enabled files in the same directory, as seen from this link failure:

ERROR: "st_thermal_pm_ops" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!
ERROR: "st_thermal_register" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!
ERROR: "st_thermal_unregister" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!

The correct syntax in Makefile requires using += instead of :=.

Fixes: 1d6931556073 ("thermal: add stm32 thermal driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/st/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/st/Makefile b/drivers/thermal/st/Makefile
index b2b9e9b96296..243ca7881b12 100644
--- a/drivers/thermal/st/Makefile
+++ b/drivers/thermal/st/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_ST_THERMAL)		:= st_thermal.o
 obj-$(CONFIG_ST_THERMAL_SYSCFG)		+= st_thermal_syscfg.o
 obj-$(CONFIG_ST_THERMAL_MEMMAP)		+= st_thermal_memmap.o
-obj-$(CONFIG_STM32_THERMAL)		:= stm_thermal.o
\ No newline at end of file
+obj-$(CONFIG_STM32_THERMAL)		+= stm_thermal.o
-- 
2.20.0

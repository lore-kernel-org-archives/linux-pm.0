From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] power: reset: reboot mode: fix build error of missing ioremap/iounmap on UM
Date: Sun,  7 Aug 2016 21:14:21 +0800
Message-ID: <1470575661-22325-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: richard@nod.at, matthias.bgg@gmail.com, moritz.fischer@ettus.com, fengguang.wu@intel.com, alexandre.belloni@free-electrons.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, k.kozlowski@samsung.com, dwmw2@infradead.org, nicolas.ferre@atmel.com, Andy Yan <andy.yan@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Add missing HAS_IOMEM dependency for MFD_SYSCON to fix the um-allyesconfig
build error:

drivers/mfd/syscon.c: In function 'of_syscon_register':
drivers/mfd/syscon.c:67:9: error: implicit declaration of function 'ioremap' [-Werror=implicit-function-declaration]
  base = ioremap(res.start, resource_size(&res));
         ^
drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  base = ioremap(res.start, resource_size(&res));
       ^
drivers/mfd/syscon.c:109:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
  iounmap(base);
  ^

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/power/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 7053abc..1388be3 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -190,6 +190,7 @@ config REBOOT_MODE
 config SYSCON_REBOOT_MODE
 	tristate "Generic SYSCON regmap reboot mode driver"
 	depends on OF
+	depends on HAS_IOMEM
 	select REBOOT_MODE
 	select MFD_SYSCON
 	help
-- 
2.7.4

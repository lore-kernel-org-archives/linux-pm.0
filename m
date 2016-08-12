From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v1] power: reset: reboot mode: fix build error of missing ioremap/iounmap on UM
Date: Fri, 12 Aug 2016 18:01:50 +0800
Message-ID: <1470996110-8550-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: k.kozlowski@samsung.com, matthias.bgg@gmail.com, dbaryshkov@gmail.com, richard@nod.at, alexandre.belloni@free-electrons.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, nicolas.ferre@atmel.com, Andy Yan <andy.yan@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

commit 4fcd504edbf7 ("power: reset: add reboot mode driver") uses api from
syscon, and syscon uses ioremap/iounmap which depends on HAS_IOMEM, so
let's depend on MFD_SYSCON instead of selecting it directly to avoid the
um-allyesconfig like build error on archs that without iomem:

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

Reported-by: Kbuild test robot <fengguang.wu@intel.com>
Fixes: 4fcd504edbf7("power: reset: add reboot mode driver")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v1:
- let this driver depend on MFD_SYSCON
- add Reported-by tag, which suggested by Krzysztof Kozlowski
- add Fixes tag, which suggested by Matthias Brugger

 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 7053abc..10f8ddb 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -190,8 +190,8 @@ config REBOOT_MODE
 config SYSCON_REBOOT_MODE
 	tristate "Generic SYSCON regmap reboot mode driver"
 	depends on OF
+	depends on MFD_SYSCON
 	select REBOOT_MODE
-	select MFD_SYSCON
 	help
 	  Say y here will enable reboot mode driver. This will
 	  get reboot mode arguments and store it in SYSCON mapped
-- 
2.7.4

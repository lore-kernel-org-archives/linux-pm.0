From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 14/17] thermal: exynos: allow compile test
Date: Wed,  9 Sep 2015 21:11:10 -0700
Message-ID: <1441858273-4017-15-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to exynos driver to facilitate
maintenance.

Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0fa5d20..9069cc7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -345,7 +345,7 @@ source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
 
 menu "Samsung thermal drivers"
-depends on ARCH_EXYNOS
+depends on ARCH_EXYNOS || COMPILE_TEST
 source "drivers/thermal/samsung/Kconfig"
 endmenu
 
-- 
2.5.0

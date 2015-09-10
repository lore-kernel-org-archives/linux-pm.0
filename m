From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 15/17] thermal: st: allow compile test
Date: Wed,  9 Sep 2015 21:11:11 -0700
Message-ID: <1441858273-4017-16-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>, Fabian Frederick <fabf@skynet.be>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to st driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Fabian Frederick <fabf@skynet.be>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9069cc7..d94b4e9 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -350,7 +350,7 @@ source "drivers/thermal/samsung/Kconfig"
 endmenu
 
 menu "STMicroelectronics thermal drivers"
-depends on ARCH_STI && OF
+depends on (ARCH_STI || COMPILE_TEST) && OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
-- 
2.5.0

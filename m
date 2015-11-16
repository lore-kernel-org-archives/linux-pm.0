From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Revert "thermal: qcom_spmi: allow compile test"
Date: Mon, 16 Nov 2015 22:43:50 +0100
Message-ID: <9183915.mBPRJBbpGR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Ivan T. Ivanov" <iivanov@mm-sol.com>, David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This just caused build errors:

warning: (QCOM_SPMI_TEMP_ALARM) selects REGMAP_SPMI which has unmet direct dependencies (SPMI)
drivers/built-in.o: In function `regmap_spmi_ext_gather_write':
:(.text+0x609b0): undefined reference to `spmi_ext_register_write'
:(.text+0x609f0): undefined reference to `spmi_ext_register_writel'

While it's generally a good idea to allow compile testing, in this
case, it just doesn't work, so reverting the patch that
introduced the compile-test variant seems the most appropriate
solution.

Note that SPIMI also has a 'depends on ARCH_QCOM || COMPILE_TEST'
statement, so we should be able to enable SPMI on all architectures
for compile testing already.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cb7fb4d34202 ("thermal: qcom_spmi: allow compile test")

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2e7524f0f3f7..6045b17d0e00 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -381,7 +381,7 @@ endmenu
 
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
-	depends on OF && (SPMI || COMPILE_TEST) && IIO
+	depends on OF && SPMI && IIO
 	select REGMAP_SPMI
 	help
 	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)

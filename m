From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] cpufreq: imx6q-cpufreq driver is reused on i.MX6 series SoCs
Date: Fri, 20 Dec 2013 10:12:16 +0800
Message-ID: <1387505536-22720-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, John Tobias <john.tobias.ph@gmail.com>, Anson Huang <b20788@freescale.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

The imx6q-cpufreq driver nowadays is not only running on imx6q but also
other i.MX6 series SoCs like imx6dl and imx6sl.  Update Kconfig prompt
and help text to make it clear to users.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/cpufreq/Kconfig.arm |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index ce52ed9..3ba5dcc 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -79,11 +79,11 @@ config ARM_HIGHBANK_CPUFREQ
 	  If in doubt, say N.
 
 config ARM_IMX6Q_CPUFREQ
-	tristate "Freescale i.MX6Q cpufreq support"
-	depends on SOC_IMX6Q
+	tristate "Freescale i.MX6 cpufreq support"
+	depends on ARCH_MXC
 	depends on REGULATOR_ANATOP
 	help
-	  This adds cpufreq driver support for Freescale i.MX6Q SOC.
+	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
 
 	  If in doubt, say N.
 
-- 
1.7.9.5



From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 05/12] ARM: ux500: Create APE generic power domain
Date: Thu, 28 Mar 2013 17:11:31 +0100
Message-ID: <1364487098-10319-6-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hongbo.zhang@linaro.org, ulf.hansson@linaro.org, khilman@linaro.org, linus.walleij@stericsson.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com
List-Id: linux-pm@vger.kernel.org

The APE generic power domain is created and
initiated. This power domain is turned off in
the sleep states ApSleep and ApDeepSleep

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig        |  1 +
 arch/arm/mach-ux500/board-mop500.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5dea906..b2e5c8b 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -12,6 +12,7 @@ config UX500_SOC_COMMON
 	select PINCTRL
 	select PINCTRL_NOMADIK
 	select PL310_ERRATA_753970 if CACHE_PL310
+	select PM_GENERIC_DOMAINS if PM
 
 config UX500_SOC_DB8500
 	bool
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index d453522..77d3d1a 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -37,7 +37,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/platform_data/dma-ste-dma40.h>
-
+#include <linux/pm_domain.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
@@ -645,6 +645,15 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 	&u8500_cpufreq_cooling_device,
 };
 
+struct generic_pm_domain ape_domain = {
+	.name = "APE",
+};
+
+static void __init init_pm_domains(void)
+{
+	pm_genpd_init(&ape_domain, NULL, false);
+}
+
 static void __init mop500_init_machine(void)
 {
 	struct device *parent = NULL;
@@ -668,6 +677,8 @@ static void __init mop500_init_machine(void)
 	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
+	init_pm_domains();
+
 	u8500_cryp1_hash1_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
@@ -700,6 +711,8 @@ static void __init snowball_init_machine(void)
 	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
+	init_pm_domains();
+
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
 }
@@ -732,6 +745,8 @@ static void __init hrefv60_init_machine(void)
 	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
+	init_pm_domains();
+
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 
 	i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
-- 
1.8.2

From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 10/12] ARM: ux500: Create ICN device
Date: Thu, 28 Mar 2013 17:11:36 +0100
Message-ID: <1364487098-10319-11-git-send-email-rickard.andersson@stericsson.com>
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

Add platform device for dbx500-icn. Also add
the device to the generic power domain APE.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 arch/arm/boot/dts/dbx5x0.dtsi        |  5 +++++
 arch/arm/mach-ux500/board-mop500.c   |  1 +
 arch/arm/mach-ux500/cpu-db8500.c     |  1 +
 arch/arm/mach-ux500/devices-common.c | 16 ++++++++++++++++
 arch/arm/mach-ux500/devices-common.h |  1 +
 drivers/bus/Makefile                 |  1 +
 6 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index b1438d2..ef98422 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -666,6 +666,11 @@
 			  <0xa03cf000 0x1000>;
 		};
 
+		icn {
+		    compatible = "stericsson,db8500-icn";
+		    reg = <0x81000000 0x2000>;
+		};
+
 		external-bus@50000000 {
 			compatible = "simple-bus";
 			reg = <0x50000000 0x4000000>;
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b351f25..76bace3 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -660,6 +660,7 @@ static void __init init_pm_domains(void)
 	pm_genpd_init(&ape_domain, NULL, false);
 
 	add_platform_device_to_genpd(&db8500_clk_device, &ape_domain);
+	add_platform_device_to_genpd(&dbx500_icn_device, &ape_domain);
 }
 
 static void __init mop500_init_machine(void)
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 6ead606..d849986 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -143,6 +143,7 @@ static struct platform_device db8500_prcmu_device = {
 
 static struct platform_device *platform_devs[] __initdata = {
 	&db8500_clk_device,
+	&dbx500_icn_device,
 	&u8500_dma40_device,
 	&db8500_pmu_device,
 	&db8500_prcmu_device,
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 16b5f71..74c7a76 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -18,6 +18,22 @@
 
 #include "devices-common.h"
 
+static struct resource icn_resources[] = {
+	[0] = {
+		.start = U8500_ICN_BASE,
+		.end   = U8500_ICN_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "base",
+	},
+};
+
+struct platform_device dbx500_icn_device = {
+	.name = "dbx500-icn",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(icn_resources),
+	.resource = icn_resources
+};
+
 static struct platform_device *
 dbx500_add_gpio(struct device *parent, int id, resource_size_t addr, int irq,
 		struct nmk_gpio_platform_data *pdata)
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index 96fa4ac..adbf524 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -16,6 +16,7 @@
 #include <linux/platform_data/crypto-ux500.h>
 
 struct spi_master_cntlr;
+extern struct platform_device dbx500_icn_device;
 
 static inline struct amba_device *
 dbx500_add_msp_spi(struct device *parent, const char *name,
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 45d997c..78851c0 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the bus drivers.
 #
 
+obj-$(CONFIG_UX500_SOC_DB8500)	+= dbx500-icn.o
 obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 
 # Interconnect bus driver for OMAP SoCs.
-- 
1.8.2

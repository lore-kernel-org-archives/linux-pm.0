From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 12/12] ARM: ux500: Create TPIU device
Date: Thu, 28 Mar 2013 17:11:38 +0100
Message-ID: <1364487098-10319-13-git-send-email-rickard.andersson@stericsson.com>
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

Add platform device for the ux500 TPIU driver. TPIU
is Trace Port Interface Unit. Also add the device
to the generic power domain APE.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 arch/arm/boot/dts/dbx5x0.dtsi        |  5 +++++
 arch/arm/mach-ux500/board-mop500.c   |  1 +
 arch/arm/mach-ux500/cpu-db8500.c     |  1 +
 arch/arm/mach-ux500/devices-common.c | 16 ++++++++++++++++
 arch/arm/mach-ux500/devices-common.h |  1 +
 5 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index ef98422..9e5fce5 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -671,6 +671,11 @@
 		    reg = <0x81000000 0x2000>;
 		};
 
+		tpiu {
+		    compatible = "stericsson,dbx500-tpiu";
+		    reg = <0x80190000 0x1000>;
+		};
+
 		external-bus@50000000 {
 			compatible = "simple-bus";
 			reg = <0x50000000 0x4000000>;
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 76bace3..f1c08a9 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -661,6 +661,7 @@ static void __init init_pm_domains(void)
 
 	add_platform_device_to_genpd(&db8500_clk_device, &ape_domain);
 	add_platform_device_to_genpd(&dbx500_icn_device, &ape_domain);
+	add_platform_device_to_genpd(&dbx500_tpiu_device, &ape_domain);
 }
 
 static void __init mop500_init_machine(void)
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index d849986..7096462 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -144,6 +144,7 @@ static struct platform_device db8500_prcmu_device = {
 static struct platform_device *platform_devs[] __initdata = {
 	&db8500_clk_device,
 	&dbx500_icn_device,
+	&dbx500_tpiu_device,
 	&u8500_dma40_device,
 	&db8500_pmu_device,
 	&db8500_prcmu_device,
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 74c7a76..a0f87ae 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -34,6 +34,22 @@ struct platform_device dbx500_icn_device = {
 	.resource = icn_resources
 };
 
+static struct resource tpiu_resources[] = {
+	[0] = {
+		.start = U8500_TPIU_BASE,
+		.end   = U8500_TPIU_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+		.name  = "base",
+	},
+};
+
+struct platform_device dbx500_tpiu_device = {
+	.name = "dbx500-tpiu",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(tpiu_resources),
+	.resource = tpiu_resources
+};
+
 static struct platform_device *
 dbx500_add_gpio(struct device *parent, int id, resource_size_t addr, int irq,
 		struct nmk_gpio_platform_data *pdata)
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index adbf524..3106b13 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -17,6 +17,7 @@
 
 struct spi_master_cntlr;
 extern struct platform_device dbx500_icn_device;
+extern struct platform_device dbx500_tpiu_device;
 
 static inline struct amba_device *
 dbx500_add_msp_spi(struct device *parent, const char *name,
-- 
1.8.2

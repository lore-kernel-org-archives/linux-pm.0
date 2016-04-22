From: Penny Chiu <pchiu@nvidia.com>
Subject: [PATCH 04/11] clk: tegra: Add Tegra210 support in DFLL driver
Date: Fri, 22 Apr 2016 18:31:04 +0800
Message-ID: <1461321071-6431-5-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, Penny Chiu <pchiu@nvidia.com>, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add Tegra210 support and related CVB table in tegra124 DFLL driver,
and also update the binding document.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 .../bindings/clock/nvidia,tegra124-dfll.txt        |  4 +-
 drivers/clk/tegra/Makefile                         |  4 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         | 55 ++++++++++++++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
index 84080a8..42a1fe6 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -11,7 +11,9 @@ communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
 Currently only the I2C mode is supported by these bindings.
 
 Required properties:
-- compatible : should be "nvidia,tegra124-dfll"
+- compatible : should be one of following:
+  - "nvidia,tegra124-dfll" for the Tegra124 SoC
+  - "nvidia,tegra210-dfll" for the Tegra210 SoC
 - reg : Defines the following set of registers, in the order listed:
         - registers for the DFLL control logic.
         - registers for the I2C output logic.
diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index 97984c5..9b8e9de 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -17,7 +17,9 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-dfll-fcpu.o
+ifneq ($(filter y, $(CONFIG_ARCH_TEGRA_124_SOC) $(CONFIG_ARCH_TEGRA_210_SOC)),)
+obj-y					+= clk-tegra124-dfll-fcpu.o
+endif
 obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
 obj-y					+= cvb.o
 obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index b577bc6..6b3316c 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -44,6 +44,11 @@ static const unsigned long tegra124_cpu_max_freq_table[] = {
 	[3] = 2524500000UL,
 };
 
+static const unsigned long tegra210_cpu_max_freq_table[] = {
+	[0] = 1912500000UL,
+	[1] = 1912500000UL,
+};
+
 static const struct cvb_table tegra124_cpu_cvb_tables[] = {
 	{
 		.speedo_id = -1,
@@ -87,6 +92,45 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
 	},
 };
 
+static const struct cvb_table tegra210_cpu_cvb_tables[] = {
+	{
+		.speedo_id = -1,
+		.process_id = -1,
+		.min_millivolts = 850,
+		.max_millivolts = 1170,
+		.speedo_scale = 100,
+		.voltage_scale = 1000,
+		.cvb_table = {
+			{51000000UL,    {1007452, -23865, 370} },
+			{102000000UL,   {1007452, -23865, 370} },
+			{204000000UL,   {1007452, -23865, 370} },
+			{306000000UL,   {1052709, -24875, 370} },
+			{408000000UL,   {1099069, -25895, 370} },
+			{510000000UL,   {1146534, -26905, 370} },
+			{612000000UL,   {1195102, -27915, 370} },
+			{714000000UL,   {1244773, -28925, 370} },
+			{816000000UL,   {1295549, -29935, 370} },
+			{918000000UL,   {1347428, -30955, 370} },
+			{1020000000UL,  {1400411, -31965, 370} },
+			{1122000000UL,  {1454497, -32975, 370} },
+			{1224000000UL,  {1509687, -33985, 370} },
+			{1326000000UL,  {1565981, -35005, 370} },
+			{1428000000UL,  {1623379, -36015, 370} },
+			{1530000000UL,  {1681880, -37025, 370} },
+			{1632000000UL,  {1741485, -38035, 370} },
+			{1734000000UL,  {1802194, -39055, 370} },
+			{1836000000UL,  {1864006, -40065, 370} },
+			{1912500000UL,  {1910780, -40815, 370} },
+			{0,             {      0,      0,   0} },
+		},
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+		}
+	},
+};
+
 static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
 	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
 	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
@@ -94,11 +138,22 @@ static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
 	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
 };
 
+static const struct dfll_fcpu_data tegra210_dfll_fcpu_data = {
+	.cpu_max_freq_table = tegra210_cpu_max_freq_table,
+	.cpu_max_freq_table_size = ARRAY_SIZE(tegra210_cpu_max_freq_table),
+	.cpu_cvb_tables = tegra210_cpu_cvb_tables,
+	.cpu_cvb_tables_size = ARRAY_SIZE(tegra210_cpu_cvb_tables)
+};
+
 static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
 	{
 		.compatible = "nvidia,tegra124-dfll",
 		.data = &tegra124_dfll_fcpu_data
 	},
+	{
+		.compatible = "nvidia,tegra210-dfll",
+		.data = &tegra210_dfll_fcpu_data
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra124_dfll_fcpu_of_match);
-- 
2.8.1

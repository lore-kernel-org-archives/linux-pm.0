From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V7 06/12] thermal: tegra: add a debugfs to show registers
Date: Fri, 11 Mar 2016 11:10:35 +0800
Message-ID: <1457665835-29880-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add a debugfs interface to show register contents for debug.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 143 ++++++++++++++++++++++++++++++++++++++-
 drivers/thermal/tegra/soctherm.h |   2 +
 2 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 52a33760e8e8..02ac6d2e5a20 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -15,6 +15,7 @@
  *
  */
 
+#include <linux/debugfs.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -33,14 +34,18 @@
 
 #define SENSOR_CONFIG0				0
 #define SENSOR_CONFIG0_STOP			BIT(0)
-#define SENSOR_CONFIG0_TALL_SHIFT		8
-#define SENSOR_CONFIG0_TCALC_OVER		BIT(4)
-#define SENSOR_CONFIG0_OVER			BIT(3)
 #define SENSOR_CONFIG0_CPTR_OVER		BIT(2)
+#define SENSOR_CONFIG0_OVER			BIT(3)
+#define SENSOR_CONFIG0_TCALC_OVER		BIT(4)
+#define SENSOR_CONFIG0_TALL_MASK		(0xfffff << 8)
+#define SENSOR_CONFIG0_TALL_SHIFT		8
 
 #define SENSOR_CONFIG1				4
+#define SENSOR_CONFIG1_TSAMPLE_MASK		0x3ff
 #define SENSOR_CONFIG1_TSAMPLE_SHIFT		0
+#define SENSOR_CONFIG1_TIDDQ_EN_MASK		(0x3f << 15)
 #define SENSOR_CONFIG1_TIDDQ_EN_SHIFT		15
+#define SENSOR_CONFIG1_TEN_COUNT_MASK		(0x3f << 24)
 #define SENSOR_CONFIG1_TEN_COUNT_SHIFT		24
 #define SENSOR_CONFIG1_TEMP_ENABLE		BIT(31)
 
@@ -49,6 +54,14 @@
  * because, it will be used by tegra_soctherm_fuse.c
  */
 
+#define SENSOR_STATUS0				0xc
+#define SENSOR_STATUS0_VALID_MASK		BIT(31)
+#define SENSOR_STATUS0_CAPTURE_MASK		0xffff
+
+#define SENSOR_STATUS1				0x10
+#define SENSOR_STATUS1_TEMP_VALID_MASK		BIT(31)
+#define SENSOR_STATUS1_TEMP_MASK		0xffff
+
 #define READBACK_VALUE_MASK			0xff00
 #define READBACK_VALUE_SHIFT			8
 #define READBACK_ADD_HALF			BIT(7)
@@ -73,6 +86,8 @@ struct tegra_soctherm {
 
 	u32 *calib;
 	struct tegra_soctherm_soc *soc;
+
+	struct dentry *debugfs_dir;
 };
 
 static int enable_tsensor(struct tegra_soctherm *tegra,
@@ -140,6 +155,124 @@ static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 };
 
+#ifdef CONFIG_DEBUG_FS
+static int regs_show(struct seq_file *s, void *data)
+{
+	struct platform_device *pdev = s->private;
+	struct tegra_soctherm *ts = platform_get_drvdata(pdev);
+	const struct tegra_tsensor *tsensors = ts->soc->tsensors;
+	u32 r, state;
+	int i;
+
+	seq_puts(s, "-----TSENSE (convert HW)-----\n");
+
+	for (i = 0; i < ts->soc->num_tsensors; i++) {
+		r = readl(ts->regs + tsensors[i].base + SENSOR_CONFIG1);
+		state = REG_GET_MASK(r, SENSOR_CONFIG1_TEMP_ENABLE);
+		if (!state)
+			continue;
+
+		seq_printf(s, "%s: ", tsensors[i].name);
+
+		seq_printf(s, "En(%d) ", state);
+		state = REG_GET_MASK(r, SENSOR_CONFIG1_TIDDQ_EN_MASK);
+		seq_printf(s, "tiddq(%d) ", state);
+		state = REG_GET_MASK(r, SENSOR_CONFIG1_TEN_COUNT_MASK);
+		seq_printf(s, "ten_count(%d) ", state);
+		state = REG_GET_MASK(r, SENSOR_CONFIG1_TSAMPLE_MASK);
+		seq_printf(s, "tsample(%d) ", state + 1);
+
+		r = readl(ts->regs + tsensors[i].base + SENSOR_STATUS1);
+		state = REG_GET_MASK(r, SENSOR_STATUS1_TEMP_VALID_MASK);
+		seq_printf(s, "Temp(%d/", state);
+		state = REG_GET_MASK(r, SENSOR_STATUS1_TEMP_MASK);
+		seq_printf(s, "%d) ", translate_temp(state));
+
+		r = readl(ts->regs + tsensors[i].base + SENSOR_STATUS0);
+		state = REG_GET_MASK(r, SENSOR_STATUS0_VALID_MASK);
+		seq_printf(s, "Capture(%d/", state);
+		state = REG_GET_MASK(r, SENSOR_STATUS0_CAPTURE_MASK);
+		seq_printf(s, "%d) ", state);
+
+		r = readl(ts->regs + tsensors[i].base + SENSOR_CONFIG0);
+		state = REG_GET_MASK(r, SENSOR_CONFIG0_STOP);
+		seq_printf(s, "Stop(%d) ", state);
+		state = REG_GET_MASK(r, SENSOR_CONFIG0_TALL_MASK);
+		seq_printf(s, "Tall(%d) ", state);
+		state = REG_GET_MASK(r, SENSOR_CONFIG0_TCALC_OVER);
+		seq_printf(s, "Over(%d/", state);
+		state = REG_GET_MASK(r, SENSOR_CONFIG0_OVER);
+		seq_printf(s, "%d/", state);
+		state = REG_GET_MASK(r, SENSOR_CONFIG0_CPTR_OVER);
+		seq_printf(s, "%d) ", state);
+
+		r = readl(ts->regs + tsensors[i].base + SENSOR_CONFIG2);
+		state = REG_GET_MASK(r, SENSOR_CONFIG2_THERMA_MASK);
+		seq_printf(s, "Therm_A/B(%d/", state);
+		state = REG_GET_MASK(r, SENSOR_CONFIG2_THERMB_MASK);
+		seq_printf(s, "%d)\n", (s16)state);
+	}
+
+	r = readl(ts->regs + SENSOR_PDIV);
+	seq_printf(s, "PDIV: 0x%x\n", r);
+
+	r = readl(ts->regs + SENSOR_HOTSPOT_OFF);
+	seq_printf(s, "HOTSPOT: 0x%x\n", r);
+
+	seq_puts(s, "\n");
+	seq_puts(s, "-----SOC_THERM-----\n");
+
+	r = readl(ts->regs + SENSOR_TEMP1);
+	state = REG_GET_MASK(r, SENSOR_TEMP1_CPU_TEMP_MASK);
+	seq_printf(s, "Temperatures: CPU(%d) ", translate_temp(state));
+	state = REG_GET_MASK(r, SENSOR_TEMP1_GPU_TEMP_MASK);
+	seq_printf(s, " GPU(%d) ", translate_temp(state));
+	r = readl(ts->regs + SENSOR_TEMP2);
+	state = REG_GET_MASK(r, SENSOR_TEMP2_PLLX_TEMP_MASK);
+	seq_printf(s, " PLLX(%d) ", translate_temp(state));
+	state = REG_GET_MASK(r, SENSOR_TEMP2_MEM_TEMP_MASK);
+	seq_printf(s, " MEM(%d)\n", translate_temp(state));
+
+	return 0;
+}
+
+static int regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, regs_show, inode->i_private);
+}
+
+static const struct file_operations regs_fops = {
+	.open		= regs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void soctherm_debug_init(struct platform_device *pdev)
+{
+	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
+	struct dentry *root, *file;
+
+	root = debugfs_create_dir("soctherm", NULL);
+	if (!root) {
+		dev_err(&pdev->dev, "failed to create debugfs directory\n");
+		return;
+	}
+
+	tegra->debugfs_dir = root;
+
+	file = debugfs_create_file("reg_contents", 0644, root,
+				   pdev, &regs_fops);
+	if (!file)
+		dev_err(&pdev->dev, "failed to create debugfs file\n");
+}
+#else
+static inline void soctherm_debug_init(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static const struct of_device_id tegra_soctherm_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 	{
@@ -279,6 +412,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		}
 	}
 
+	soctherm_debug_init(pdev);
+
 	return 0;
 
 disable_clocks:
@@ -292,6 +427,8 @@ static int tegra_soctherm_remove(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(tegra->debugfs_dir);
+
 	clk_disable_unprepare(tegra->clock_tsensor);
 	clk_disable_unprepare(tegra->clock_soctherm);
 
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index 69d317269af1..ec4b87616d01 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -16,7 +16,9 @@
 #define __DRIVERS_THERMAL_TEGRA_SOCTHERM_H
 
 #define SENSOR_CONFIG2                          8
+#define SENSOR_CONFIG2_THERMA_MASK		(0xffff << 16)
 #define SENSOR_CONFIG2_THERMA_SHIFT		16
+#define SENSOR_CONFIG2_THERMB_MASK		0xffff
 #define SENSOR_CONFIG2_THERMB_SHIFT		0
 
 #define SENSOR_PDIV				0x1c0
-- 
1.9.1

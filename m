From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 11/12] misc: ux500: Add TPIU driver
Date: Thu, 28 Mar 2013 17:11:37 +0100
Message-ID: <1364487098-10319-12-git-send-email-rickard.andersson@stericsson.com>
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

TPIU is Trace Port Interface Unit. Ux500 needs a TPIU
driver because in Ux500 the TPIU hardware block loses
its settings when the APE power domain is turned off.
Settings needs to be saved before the sleep state ApSleep
or ApDeepSleep is reached and the block needs to be
unlocked and restored when leaving those sleep states.
If this is not done PTM tracing with debugger stops
working after the first sleep where the power domain is
off.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/misc/Makefile      |   1 +
 drivers/misc/dbx500-tpiu.c | 182 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 drivers/misc/dbx500-tpiu.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 2129377..9a774ab 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,3 +49,4 @@ obj-y				+= carma/
 obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
 obj-$(CONFIG_INTEL_MEI)		+= mei/
+obj-$(CONFIG_UX500_SOC_DB8500)	+= dbx500-tpiu.o
\ No newline at end of file
diff --git a/drivers/misc/dbx500-tpiu.c b/drivers/misc/dbx500-tpiu.c
new file mode 100644
index 0000000..fd07c6f
--- /dev/null
+++ b/drivers/misc/dbx500-tpiu.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010-2013
+ * Author: Rickard Andersson <rickard.andersson@stericsson.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <mach/hardware.h>
+
+#define TPIU_PORT_SIZE 0x4
+#define TPIU_TRIGGER_COUNTER 0x104
+#define TPIU_TRIGGER_MULTIPLIER 0x108
+#define TPIU_CURRENT_TEST_PATTERN 0x204
+#define TPIU_TEST_PATTERN_REPEAT 0x208
+#define TPIU_FORMATTER 0x304
+#define TPIU_FORMATTER_SYNC 0x308
+#define TPIU_LOCK_ACCESS_REGISTER 0xFB0
+
+#define TPIU_UNLOCK_CODE 0xc5acce55
+
+/* The context of the Trace Port Interface Unit (TPIU) */
+static struct {
+	void __iomem *base;
+	u32 port_size;
+	u32 trigger_counter;
+	u32 trigger_multiplier;
+	u32 current_test_pattern;
+	u32 test_pattern_repeat;
+	u32 formatter;
+	u32 formatter_sync;
+} context_tpiu;
+
+/*
+ * Save the context of the DB8500 Trace Port Interface Unit (TPIU).
+ * Saving/restoring is needed for the PTM tracing to work together
+ * with sleep states where the APE power domain is turned off.
+ */
+static void tpiu_save_context(void)
+{
+	context_tpiu.port_size		  = readl(context_tpiu.base +
+						  TPIU_PORT_SIZE);
+	context_tpiu.trigger_counter	  = readl(context_tpiu.base +
+						  TPIU_TRIGGER_COUNTER);
+	context_tpiu.trigger_multiplier   = readl(context_tpiu.base +
+						TPIU_TRIGGER_MULTIPLIER);
+	context_tpiu.current_test_pattern = readl(context_tpiu.base +
+						  TPIU_CURRENT_TEST_PATTERN);
+	context_tpiu.test_pattern_repeat  = readl(context_tpiu.base +
+						 TPIU_TEST_PATTERN_REPEAT);
+	context_tpiu.formatter		  = readl(context_tpiu.base +
+						  TPIU_FORMATTER);
+	context_tpiu.formatter_sync	  = readl(context_tpiu.base +
+						  TPIU_FORMATTER_SYNC);
+}
+
+/*
+ * Restore the context of the DB8500 Trace Port Interface Unit (TPIU).
+ * Saving/restoring is needed for the PTM tracing to work together
+ * with the sleep states where the APE power domain is turned off.
+ */
+static void tpiu_restore_context(void)
+{
+	writel(TPIU_UNLOCK_CODE,
+	       context_tpiu.base + TPIU_LOCK_ACCESS_REGISTER);
+
+	writel(context_tpiu.port_size,
+	       context_tpiu.base + TPIU_PORT_SIZE);
+	writel(context_tpiu.trigger_counter,
+	       context_tpiu.base + TPIU_TRIGGER_COUNTER);
+	writel(context_tpiu.trigger_multiplier,
+	       context_tpiu.base + TPIU_TRIGGER_MULTIPLIER);
+	writel(context_tpiu.current_test_pattern,
+	       context_tpiu.base + TPIU_CURRENT_TEST_PATTERN);
+	writel(context_tpiu.test_pattern_repeat,
+	       context_tpiu.base + TPIU_TEST_PATTERN_REPEAT);
+	writel(context_tpiu.formatter,
+	       context_tpiu.base + TPIU_FORMATTER);
+	writel(context_tpiu.formatter_sync,
+	       context_tpiu.base + TPIU_FORMATTER_SYNC);
+}
+
+static int tpiu_context_call(struct notifier_block *this,
+			     unsigned long event, void *data)
+{
+	bool power_on = (bool)event;
+
+	if (power_on)
+		tpiu_restore_context();
+	else
+		tpiu_save_context();
+
+	return 0;
+}
+
+static struct notifier_block tpiu_context_notifier = {
+	.notifier_call = tpiu_context_call,
+};
+
+static const struct of_device_id dbx500_tpiu_match[] = {
+	{ .compatible = "stericsson,dbx500-tpiu", },
+	{},
+};
+
+static struct platform_driver dbx500_tpiu_plat_driver = {
+	.driver = {
+		.name = "dbx500-tpiu",
+		.of_match_table = dbx500_tpiu_match,
+	},
+	.remove = __exit_p(dbx500_tpiu_remove),
+};
+
+static int __init dbx500_tpiu_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing platform resources\n");
+		return -EINVAL;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		return -EBUSY;
+	}
+
+	context_tpiu.base = ioremap(res->start, resource_size(res));
+	if (!context_tpiu.base) {
+		ret = -ENOMEM;
+		goto err_free_mem_region;
+	}
+
+	ret = pm_genpd_register_on_off_notifier(&pdev->dev,
+						&tpiu_context_notifier);
+	if (ret)
+		goto err_iounmap;
+
+	return ret;
+
+ err_iounmap:
+	iounmap(context_tpiu.base);
+ err_free_mem_region:
+	release_mem_region(res->start, resource_size(res));
+	return ret;
+}
+
+static int __exit dbx500_tpiu_remove(struct platform_device *pdev)
+{
+	int ret;
+
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	ret = pm_genpd_unregister_on_off_notifier(&pdev->dev,
+						  &tpiu_context_notifier);
+	iounmap(context_tpiu.base);
+	release_mem_region(res->start, resource_size(res));
+
+	return ret;
+}
+
+static int __init dbx500_tpiu_init(void)
+{
+	return platform_driver_probe(&dbx500_tpiu_plat_driver,
+				     dbx500_tpiu_probe);
+}
+
+static void __exit dbx500_tpiu_exit(void)
+{
+	return platform_driver_unregister(&dbx500_tpiu_plat_driver);
+}
+
+arch_initcall(dbx500_tpiu_init);
+module_exit(dbx500_tpiu_exit);
+
+MODULE_DESCRIPTION("TPIU driver for dbx500");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Rickard Andersson <rickard.andersson@stericsson.com>");
-- 
1.8.2

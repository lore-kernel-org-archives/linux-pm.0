From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [RFC] i2c: qup: Use the interconnect API
Date: Thu, 20 Sep 2018 11:29:03 -0700
Message-ID: <20180920182903.19991-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

The interconnect API provides an interface for consumer drivers to express
their bandwidth needs in the SoC. This data is aggregated and the on-chip
interconnect hardware is configured to the appropriate power/performance
profile.

Use the interconnect API to get() the path between the endpoints used for
data transfers by the I2C QUP and report the needed bandwidth based on the
i2c mode.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

This patch depends on the interconnect API: https://lkml.org/lkml/2018/8/31/444

TODO: Use a macro for converting and rounding to icc units instead of
converting between kilobits, kilobytes etc. in the consumer drivers.

 drivers/i2c/busses/i2c-qup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index c86c3ae1318f..436747a74dc6 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -14,6 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -280,6 +281,11 @@ struct qup_i2c_dev {
 	void (*read_rx_fifo)(struct qup_i2c_dev *qup);
 	/* function to write tags in tx fifo for i2c read transfer */
 	void (*write_rx_tags)(struct qup_i2c_dev *qup);
+
+	/* frequency mode standard */
+	u32			clk_freq;
+	/* interconnect path to scale according to bandwidth needs */
+	struct icc_path		*path;
 };
 
 static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
@@ -1657,6 +1663,16 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 	clk_disable_unprepare(qup->pclk);
 }
 
+static void qup_i2c_enable_icc(struct qup_i2c_dev *qup)
+{
+	icc_set(qup->path, 0, qup->clk_freq / 8000);
+}
+
+static void qup_i2c_disable_icc(struct qup_i2c_dev *qup)
+{
+	icc_set(qup->path, 0, 0);
+}
+
 static const struct acpi_device_id qup_i2c_acpi_match[] = {
 	{ "QCOM8010"},
 	{ },
@@ -1784,6 +1800,10 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		}
 		ACPI_COMPANION_SET(&qup->adap.dev, ACPI_COMPANION(qup->dev));
 	} else {
+		qup->path = of_icc_get(qup->dev, "i2c-mem");
+		if (IS_ERR(qup->path))
+			return PTR_ERR(qup->path);
+
 		qup->clk = devm_clk_get(qup->dev, "core");
 		if (IS_ERR(qup->clk)) {
 			dev_err(qup->dev, "Could not get core clock\n");
@@ -1795,6 +1815,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
 			dev_err(qup->dev, "Could not get iface clock\n");
 			return PTR_ERR(qup->pclk);
 		}
+		qup->clk_freq = clk_freq;
+		qup_i2c_enable_icc(qup);
 		qup_i2c_enable_clocks(qup);
 		src_clk_freq = clk_get_rate(qup->clk);
 	}
@@ -1927,6 +1949,7 @@ static int qup_i2c_remove(struct platform_device *pdev)
 
 	disable_irq(qup->irq);
 	qup_i2c_disable_clocks(qup);
+	icc_put(qup->path);
 	i2c_del_adapter(&qup->adap);
 	pm_runtime_disable(qup->dev);
 	pm_runtime_set_suspended(qup->dev);
@@ -1939,6 +1962,7 @@ static int qup_i2c_pm_suspend_runtime(struct device *device)
 	struct qup_i2c_dev *qup = dev_get_drvdata(device);
 
 	dev_dbg(device, "pm_runtime: suspending...\n");
+	qup_i2c_disable_icc(qup);
 	qup_i2c_disable_clocks(qup);
 	return 0;
 }
@@ -1948,6 +1972,7 @@ static int qup_i2c_pm_resume_runtime(struct device *device)
 	struct qup_i2c_dev *qup = dev_get_drvdata(device);
 
 	dev_dbg(device, "pm_runtime: resuming...\n");
+	qup_i2c_enable_icc(qup);
 	qup_i2c_enable_clocks(qup);
 	return 0;
 }

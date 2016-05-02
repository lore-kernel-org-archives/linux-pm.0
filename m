From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH 1/2] spi: qup: Handle clocks in pm_runtime suspend and resume
Date: Mon,  2 May 2016 17:44:03 +0530
Message-ID: <1462191244-30758-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, andy.gross@linaro.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-pm@vger.kernel.org

Clocks must ne disabled in pm_runtime to achieve some power saving.
Enable the clocks when the device is runtime resumed during a transfer.

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
---
 drivers/spi/spi-qup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 810a7fa..e42ff61 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -937,6 +937,10 @@ static int spi_qup_pm_suspend_runtime(struct device *device)
 	config = readl(controller->base + QUP_CONFIG);
 	config |= QUP_CONFIG_CLOCK_AUTO_GATE;
 	writel_relaxed(config, controller->base + QUP_CONFIG);
+
+	clk_disable_unprepare(controller->cclk);
+	clk_disable_unprepare(controller->iclk);
+
 	return 0;
 }
 
@@ -945,6 +949,15 @@ static int spi_qup_pm_resume_runtime(struct device *device)
 	struct spi_master *master = dev_get_drvdata(device);
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	u32 config;
+	int ret;
+
+	ret = clk_prepare_enable(controller->iclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(controller->cclk);
+	if (ret)
+		return ret;
 
 	/* Disable clocks auto gaiting */
 	config = readl_relaxed(controller->base + QUP_CONFIG);
-- 
1.8.2.1

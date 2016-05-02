From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Handle clocks in pm_runtime suspend and resume" to the spi tree
Date: Mon, 02 May 2016 16:47:24 +0100
Message-ID: <E1axG4C-0005RE-2M@debutante>
References: <1462191244-30758-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462191244-30758-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, andy.gross@linaro.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The patch

   spi: qup: Handle clocks in pm_runtime suspend and resume

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From dae1a7700b34eceae049cf8f1567a640528ca4c1 Mon Sep 17 00:00:00 2001
From: Pramod Gurav <pramod.gurav@linaro.org>
Date: Mon, 2 May 2016 17:44:03 +0530
Subject: [PATCH] spi: qup: Handle clocks in pm_runtime suspend and resume

Clocks must ne disabled in pm_runtime to achieve some power saving.
Enable the clocks when the device is runtime resumed during a transfer.

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 810a7fae3479..e42ff613c0e0 100644
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
2.8.1

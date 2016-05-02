From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Add spi_master_put in remove function" to the spi tree
Date: Mon, 02 May 2016 16:47:21 +0100
Message-ID: <E1axG49-0005QK-50@debutante>
References: <1462191244-30758-2-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41912 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbcEBPr3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 11:47:29 -0400
In-Reply-To: <1462191244-30758-2-git-send-email-pramod.gurav@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, andy.gross@linaro.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The patch

   spi: qup: Add spi_master_put in remove function

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

>From d2442287e77926ee3552acf3bf31a6047ecb0ac1 Mon Sep 17 00:00:00 2001
From: Pramod Gurav <pramod.gurav@linaro.org>
Date: Mon, 2 May 2016 17:44:04 +0530
Subject: [PATCH] spi: qup: Add spi_master_put in remove function

Release memory allocated for spi master by calling spi_master_put in
.remove function.

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index e42ff613c0e0..c338ef1136f6 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1030,6 +1030,8 @@ static int spi_qup_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.8.1


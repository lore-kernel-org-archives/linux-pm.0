From: Shuah Khan <shuah.kh@samsung.com>
Subject: [RFT][PATCH 03/12] arm: change scoop platform power management to use dev_pm_ops
Date: Mon, 10 Feb 2014 09:12:26 -0700
Message-ID: <8b18981d7719af5ecf2ab093f5f41d2b79c33197.1392040067.git.shuah.kh@samsung.com>
References: <cover.1392040064.git.shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1392040064.git.shuah.kh@samsung.com>
In-Reply-To: <cover.1392040064.git.shuah.kh@samsung.com>
References: <cover.1392040064.git.shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux@arm.linux.org.uk
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

Change scoop platform driver to register pm ops using dev_pm_ops instead of
legacy pm_ops. .pm hooks call existing legacy suspend and resume interfaces
by passing in the right pm state.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 arch/arm/common/scoop.c |   44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index a5c3dc3..260a60b 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -151,7 +151,7 @@ static void check_scoop_reg(struct scoop_dev *sdev)
 		iowrite16(0x0101, sdev->base + SCOOP_MCR);
 }
 
-static int scoop_suspend(struct platform_device *dev, pm_message_t state)
+static int __scoop_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct scoop_dev *sdev = platform_get_drvdata(dev);
 
@@ -162,7 +162,22 @@ static int scoop_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int scoop_resume(struct platform_device *dev)
+static int scoop_suspend(struct device *dev)
+{
+	return __scoop_suspend(to_platform_device(dev), PMSG_SUSPEND);
+}
+
+static int scoop_freeze(struct device *dev)
+{
+	return __scoop_suspend(to_platform_device(dev), PMSG_FREEZE);
+}
+
+static int scoop_poweroff(struct device *dev)
+{
+	return __scoop_suspend(to_platform_device(dev), PMSG_HIBERNATE);
+}
+
+static int __scoop_resume(struct platform_device *dev)
 {
 	struct scoop_dev *sdev = platform_get_drvdata(dev);
 
@@ -171,9 +186,11 @@ static int scoop_resume(struct platform_device *dev)
 
 	return 0;
 }
-#else
-#define scoop_suspend	NULL
-#define scoop_resume	NULL
+
+static int scoop_resume(struct device *dev)
+{
+	return __scoop_resume(to_platform_device(dev));
+}
 #endif
 
 static int scoop_probe(struct platform_device *pdev)
@@ -266,13 +283,26 @@ static int scoop_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static const struct dev_pm_ops scoop_dev_pm_ops = {
+	.suspend = scoop_suspend,
+	.resume = scoop_resume,
+	/* Hibernate hooks */
+	.freeze = scoop_freeze,
+	.thaw = scoop_resume,
+	.poweroff = scoop_poweroff,
+	.restore = scoop_resume,
+};
+#endif
+
 static struct platform_driver scoop_driver = {
 	.probe		= scoop_probe,
 	.remove		= scoop_remove,
-	.suspend	= scoop_suspend,
-	.resume		= scoop_resume,
 	.driver		= {
 		.name	= "sharp-scoop",
+#ifdef CONFIG_PM
+		.pm	= &scoop_dev_pm_ops,
+#endif
 	},
 };
 
-- 
1.7.10.4

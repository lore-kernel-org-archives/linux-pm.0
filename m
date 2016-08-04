From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 2/2] power: reset: syscon-reboot-mode: Use managed resource API
Date: Wed,  3 Aug 2016 22:04:06 -0700
Message-ID: <1470287046-17437-2-git-send-email-bjorn.andersson@linaro.org>
References: <1470287046-17437-1-git-send-email-bjorn.andersson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32927 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbcHDFLT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2016 01:11:19 -0400
Received: by mail-pa0-f47.google.com with SMTP id ti13so1760775pac.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2016 22:11:02 -0700 (PDT)
In-Reply-To: <1470287046-17437-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, John Stultz <john.stultz@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Use the managed resource version of reboot_mode_register().

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

John, here's a "pointer" to what I meant with my comment on your
sram-reboot-mode patch. Only compile tested though.

 drivers/power/reset/syscon-reboot-mode.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index 9e1cba5dd58e..1ecb51d67149 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -53,8 +53,6 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 	syscon_rbm->reboot.write = syscon_reboot_mode_write;
 	syscon_rbm->mask = 0xffffffff;
 
-	dev_set_drvdata(&pdev->dev, syscon_rbm);
-
 	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
 	if (IS_ERR(syscon_rbm->map))
 		return PTR_ERR(syscon_rbm->map);
@@ -65,20 +63,13 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 
 	of_property_read_u32(pdev->dev.of_node, "mask", &syscon_rbm->mask);
 
-	ret = reboot_mode_register(&syscon_rbm->reboot);
+	ret = devm_reboot_mode_register(&pdev->dev, &syscon_rbm->reboot);
 	if (ret)
 		dev_err(&pdev->dev, "can't register reboot mode\n");
 
 	return ret;
 }
 
-static int syscon_reboot_mode_remove(struct platform_device *pdev)
-{
-	struct syscon_reboot_mode *syscon_rbm = dev_get_drvdata(&pdev->dev);
-
-	return reboot_mode_unregister(&syscon_rbm->reboot);
-}
-
 static const struct of_device_id syscon_reboot_mode_of_match[] = {
 	{ .compatible = "syscon-reboot-mode" },
 	{}
@@ -86,7 +77,6 @@ static const struct of_device_id syscon_reboot_mode_of_match[] = {
 
 static struct platform_driver syscon_reboot_mode_driver = {
 	.probe = syscon_reboot_mode_probe,
-	.remove = syscon_reboot_mode_remove,
 	.driver = {
 		.name = "syscon-reboot-mode",
 		.of_match_table = syscon_reboot_mode_of_match,
-- 
2.5.0


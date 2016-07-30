From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] thermal: qcom: tsens: Fix return value check in init_common()
Date: Sat, 30 Jul 2016 06:32:37 +0000
Message-ID: <1469860357-2773-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33167 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcG3Gcn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jul 2016 02:32:43 -0400
Received: by mail-pa0-f67.google.com with SMTP id q2so6320911pap.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Jul 2016 23:32:43 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-pm@vger.kernel.org

In case of error, the function of_iomap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.
And the function devm_regmap_init_mmio() returns ERR_PTR()
and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/thermal/qcom/tsens-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 4a1af15..b1449ad 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -128,13 +128,13 @@ int __init init_common(struct tsens_device *tmdev)
 	void __iomem *base;
 
 	base = of_iomap(tmdev->dev->of_node, 0);
-	if (IS_ERR(base))
+	if (!base)
 		return -EINVAL;
 
 	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
-	if (!tmdev->map) {
+	if (IS_ERR(tmdev->map)) {
 		iounmap(base);
-		return -ENODEV;
+		return PTR_ERR(tmdev->map);
 	}
 
 	return 0;


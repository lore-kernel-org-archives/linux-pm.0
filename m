From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH] cpufreq: dt: Add support for hi3660
Date: Tue, 23 May 2017 14:34:23 +0800
Message-ID: <1495521263-84196-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:6372 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757852AbdEWGhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 02:37:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com

Add the compatible string for supporting the generic device tree cpufreq-dt
driver on Hisilicon's 3660 SoC.

Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 921b4a6..b54e610 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -32,6 +32,7 @@
 	{ .compatible = "arm,integrator-cp", },
 
 	{ .compatible = "hisilicon,hi6220", },
+	{ .compatible = "hisilicon,hi3660", },
 
 	{ .compatible = "fsl,imx27", },
 	{ .compatible = "fsl,imx51", },
-- 
1.7.9.5

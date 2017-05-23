From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [Patch v2] cpufreq: dt: Add support for hi3660
Date: Tue, 23 May 2017 16:13:18 +0800
Message-ID: <1495527198-125891-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <20170523070517.GL6510@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:6440 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965136AbdEWIQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 04:16:35 -0400
In-Reply-To: <20170523070517.GL6510@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com

Add the compatible string for supporting the generic device tree cpufreq-dt
driver on Hisilicon's 3660 SoC.

Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
---
Changes in v2:
- changed order according to Viresh's suggestion

 drivers/cpufreq/cpufreq-dt-platdev.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 921b4a6..1c26292 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -31,6 +31,7 @@
 	{ .compatible = "arm,integrator-ap", },
 	{ .compatible = "arm,integrator-cp", },
 
+	{ .compatible = "hisilicon,hi3660", },
 	{ .compatible = "hisilicon,hi6220", },
 
 	{ .compatible = "fsl,imx27", },
-- 
1.7.9.5

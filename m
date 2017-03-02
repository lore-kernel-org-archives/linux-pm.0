From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 1/2] cpufreq: mt8173: Mark mt8173_cpufreq_driver_init as __init
Date: Thu,  2 Mar 2017 19:03:44 +0800
Message-ID: <20170302110345.184924-1-djkurtz@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35241 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdCBLdk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2017 06:33:40 -0500
Received: by mail-pg0-f47.google.com with SMTP id b129so31562850pgc.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Mar 2017 03:33:30 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Yidi Lin <yidi.lin@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

This function is only called once at boot by device_initcall(), so mark
it as __init.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/cpufreq/mt8173-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index ab25b1235a5e..72bc1192bd30 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -573,7 +573,7 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
 	.probe		= mt8173_cpufreq_probe,
 };
 
-static int mt8173_cpufreq_driver_init(void)
+static int __init mt8173_cpufreq_driver_init(void)
 {
 	struct platform_device *pdev;
 	int err;
-- 
2.12.0.rc1.440.g5b76565f74-goog

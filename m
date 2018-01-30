From: Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH] arm: imx: Add MODULE_ALIAS for cpufreq
Date: Tue, 30 Jan 2018 10:55:26 +0100
Message-ID: <20180130095526.9478-1-kwizart@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45313 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeA3Jzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jan 2018 04:55:31 -0500
Received: by mail-wr0-f196.google.com with SMTP id 16so10383303wry.12
        for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2018 01:55:31 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Nicolas Chauvet <kwizart@gmail.com>

Without this, the imx6q-cpufreq driver isn't loaded
automatically when built as a module

Tested on wandboard quad with a fedora 27 kernel rpm

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index d9b2c2de49c4..cef3d46fd642 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -473,6 +473,7 @@ static struct platform_driver imx6q_cpufreq_platdrv = {
 };
 module_platform_driver(imx6q_cpufreq_platdrv);
 
+MODULE_ALIAS("platform:imx6q-cpufreq");
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
 MODULE_DESCRIPTION("Freescale i.MX6Q cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.13.6

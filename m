From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH] cpufreq: dt: Add support for zx296718
Date: Wed, 30 Nov 2016 15:35:29 +0800
Message-ID: <1480491329-5242-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35240 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755210AbcK3HgB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 02:36:01 -0500
Received: by mail-pg0-f47.google.com with SMTP id p66so79262412pga.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Nov 2016 23:36:00 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Add the compatible string for supporting the generic cpufreq driver on
the ZTE's zx296718 SoC.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 7126762..c0a28e23b 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -81,6 +81,8 @@ static const struct of_device_id machines[] __initconst = {
 
 	{ .compatible = "xlnx,zynq-7000", },
 
+	{ .compatible = "zte,zx296718", },
+
 	{ }
 };
 
-- 
2.7.4


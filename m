From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] cpufreq: dt: Add terminate entry for of_device_id tables
Date: Sun, 21 Aug 2016 15:41:44 +0000
Message-ID: <1471794104-31436-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34669 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932853AbcHUPmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Aug 2016 11:42:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id g202so4730730pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 21 Aug 2016 08:42:08 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Make sure of_device_id tables are NULL terminated.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 470db30..285ed3e 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -75,6 +75,8 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "ti,omap5", },
 
 	{ .compatible = "xlnx,zynq-7000", },
+
+	{ }
 };
 
 static int __init cpufreq_dt_platdev_init(void)




From: "Pankaj Gupta (Pankaj Gupta)" <Pankaj.Gupta@spreadtrum.com>
Subject: [PATCH] driver: cpufreq: simplified goto out in
 cpufreq_register_driver
Date: Mon, 16 May 2016 11:07:19 +0000
Message-ID: <20160516110718.GA5005@pankajguptaubtnb.spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sci-ig4.spreadtrum.com ([114.30.40.213]:34224 "EHLO
	TPSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751895AbcEPL2J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 May 2016 07:28:09 -0400
Content-Language: en-US
Content-ID: <18087D16B0B5D04CB9ED09BFCBC51869@spreadtrum.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Yinghai Lu <yinghai@kernel.org>

simplified goto out in cpufreq_register_driver for increasing
code readability

Signed-off-by: Pankaj Gupta <pankaj.gupta@spreadtrum.com>
Signed-off-by: Sanjeev Yadav <sanjeev.yadav@spreadtrum.com>
---
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b87596b..0bc23f6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2370,10 +2370,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 
 	register_hotcpu_notifier(&cpufreq_cpu_notifier);
 	pr_debug("driver %s up and running\n", driver_data->name);
-
-out:
-	put_online_cpus();
-	return ret;
+	goto out;
 
 err_if_unreg:
 	subsys_interface_unregister(&cpufreq_interface);
@@ -2383,7 +2380,9 @@ err_null_driver:
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-	goto out;
+out:
+	put_online_cpus();
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_register_driver);
 

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] s5pv210-cpufreq: fix wrong do_div() usage
Date: Tue, 3 Nov 2015 17:13:57 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511031706460.630@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33523 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbbKCWOA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 17:14:00 -0500
Received: by qgeo38 with SMTP id o38so26408612qge.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2015 14:13:59 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org

It is wrong to use do_div() with 32-bit dividends (unsigned long is
32 bits on 32-bit architectures).

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 9e231f5215..051a8a8224 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -212,11 +212,11 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port ch, unsigned long freq)
 	/* Find current DRAM frequency */
 	tmp = s5pv210_dram_conf[ch].freq;
 
-	do_div(tmp, freq);
+	tmp /= freq;
 
 	tmp1 = s5pv210_dram_conf[ch].refresh;
 
-	do_div(tmp1, tmp);
+	tmp1 /= tmp;
 
 	__raw_writel(tmp1, reg);
 }

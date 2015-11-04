From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] base/power/domain: fix wrong do_div() usage
Date: Wed, 4 Nov 2015 13:29:54 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511041325170.630@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36469 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031863AbbKDS35 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 13:29:57 -0500
Received: by qgad10 with SMTP id d10so47487759qga.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2015 10:29:56 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org

do_div() is meant to be used with an unsigned dividend.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 16550c63d6..5722ad73ad 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -142,7 +142,7 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 
 static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 {
-	s64 usecs64;
+	u64 usecs64;
 
 	if (!genpd->cpuidle_data)
 		return;

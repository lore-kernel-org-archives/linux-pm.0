From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 RESEND 3/3] cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model
Date: Mon, 30 Sep 2013 23:44:33 +0300
Message-ID: <1380573873-14448-4-git-send-email-aaro.koskinen@iki.fi>
References: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:40318 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab3I3UpT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 16:45:19 -0400
In-Reply-To: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Enable cpufreq on iMac G5 (iSight) model. Tested with the 2.1 GHz version.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pmac64-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 0196d60..6084f9b 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -397,7 +397,8 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 	/* Check supported platforms */
 	if (of_machine_is_compatible("PowerMac8,1") ||
 	    of_machine_is_compatible("PowerMac8,2") ||
-	    of_machine_is_compatible("PowerMac9,1"))
+	    of_machine_is_compatible("PowerMac9,1") ||
+	    of_machine_is_compatible("PowerMac12,1"))
 		use_volts_smu = 1;
 	else if (of_machine_is_compatible("PowerMac11,2"))
 		use_volts_vdnap = 1;
-- 
1.8.4.rc3


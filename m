From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/3] PM / OPP: Export more symbols for module usage
Date: Tue, 8 Jan 2013 14:54:01 +0800
Message-ID: <1357628043-19256-2-git-send-email-shawn.guo@linaro.org>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:46503
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038Ab3AHGyj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jan 2013 01:54:39 -0500
In-Reply-To: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

Export opp_init_cpufreq_table and opp_free_cpufreq_table for module
usage.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/opp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 50b2831..d16db9a 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -661,6 +661,7 @@ int opp_init_cpufreq_table(struct device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL(opp_init_cpufreq_table);
 
 /**
  * opp_free_cpufreq_table() - free the cpufreq table
@@ -678,6 +679,7 @@ void opp_free_cpufreq_table(struct device *dev,
 	kfree(*table);
 	*table = NULL;
 }
+EXPORT_SYMBOL(opp_free_cpufreq_table);
 #endif		/* CONFIG_CPU_FREQ */
 
 /**
-- 
1.7.9.5



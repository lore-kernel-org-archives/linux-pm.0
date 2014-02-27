From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] PM / Domains: Turn latency warning into debug message
Date: Thu, 27 Feb 2014 19:26:44 +0100
Message-ID: <1393525604-21471-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53461 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbaB0S0v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 13:26:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

If devices don't provide latency data, this warning can be quite noisy until
the pm domain was enabled and disabled a few times. Turn this warning into
a debug message.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6d47498..93ca31f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -46,7 +46,7 @@
 	struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;			\
 	if (!__retval && __elapsed > __td->field) {				\
 		__td->field = __elapsed;					\
-		dev_warn(dev, name " latency exceeded, new value %lld ns\n",	\
+		dev_dbg(dev, name " latency exceeded, new value %lld ns\n",	\
 			__elapsed);						\
 		genpd->max_off_time_changed = true;				\
 		__td->constraint_changed = true;				\
-- 
1.8.5.3


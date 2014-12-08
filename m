From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] opp: remove double calls to find_device_opp()
Date: Mon,  8 Dec 2014 13:46:18 +0530
Message-ID: <ad3feb97e2a3c80e8b3897a9ca17d682034e6de6.1418026567.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:62395 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbaLHIQo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Dec 2014 03:16:44 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so4790483pab.32
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2014 00:16:44 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

By mistake we called find_device_opp() twice in of_free_opp_table(), fix it.

Generated diff doesn't show the problem well and so here is the code snippet:

void of_free_opp_table(struct device *dev)
{
	struct device_opp *dev_opp = find_device_opp(dev);
	struct dev_pm_opp *opp, *tmp;

	/* Check for existing list for 'dev' */
	dev_opp = find_device_opp(dev);

	...
}

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 2d195f3..16c59f4 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -768,7 +768,7 @@ EXPORT_SYMBOL_GPL(of_init_opp_table);
  */
 void of_free_opp_table(struct device *dev)
 {
-	struct device_opp *dev_opp = find_device_opp(dev);
+	struct device_opp *dev_opp;
 	struct dev_pm_opp *opp, *tmp;
 
 	/* Check for existing list for 'dev' */
-- 
2.2.0


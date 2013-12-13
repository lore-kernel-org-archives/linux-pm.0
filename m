From: Andre Przywara <andre.przywara@linaro.org>
Subject: [PATCH] ARM/cpuidle: remove __init tag from Calxeda cpuidle probe function
Date: Fri, 13 Dec 2013 21:49:19 +0100
Message-ID: <1386967759-12952-1-git-send-email-andre.przywara@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:48617 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab3LMUty (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2013 15:49:54 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so1570200bkz.14
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2013 12:49:53 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rob.herring@calxeda.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andre Przywara <andre.przywara@linaro.org>

Commit 60a66e370007e8535b7a561353b07b37deaf35ba changed the Calxeda
cpuidle driver to a platform driver, copying the __init tag from the
_init() to the newly used _probe() function. However, "probe should
not be __init." (Rob said ;-)
Remove the __init tag to fix a section mismatch in the Calxeda
cpuidle driver.

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
---
 drivers/cpuidle/cpuidle-calxeda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index 3679563..6e51114 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -65,7 +65,7 @@ static struct cpuidle_driver calxeda_idle_driver = {
 	.state_count = 2,
 };
 
-static int __init calxeda_cpuidle_probe(struct platform_device *pdev)
+static int calxeda_cpuidle_probe(struct platform_device *pdev)
 {
 	return cpuidle_register(&calxeda_idle_driver, NULL);
 }
-- 
1.7.12.1


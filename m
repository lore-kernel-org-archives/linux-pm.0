From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] cpufreq:cpufreq-nforce2 - Fix typo in comment to function nforce2_init().
Date: Sat, 23 May 2015 10:36:18 +0530
Message-ID: <1432357578-4069-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35540 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbbEWFGe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 May 2015 01:06:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/cpufreq/cpufreq-nforce2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index a225809..db69eeb 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -414,7 +414,7 @@ static int nforce2_detect_chipset(void)
  * nforce2_init - initializes the nForce2 CPUFreq driver
  *
  * Initializes the nForce2 FSB support. Returns -ENODEV on unsupported
- * devices, -EINVAL on problems during initiatization, and zero on
+ * devices, -EINVAL on problems during initialization, and zero on
  * success.
  */
 static int __init nforce2_init(void)
-- 
1.7.9.5


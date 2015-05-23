From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] cpufreq:gx-suspmod - Fix two typos in two comments.
Date: Sat, 23 May 2015 10:36:49 +0530
Message-ID: <1432357609-4102-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35886 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbbEWFHP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 May 2015 01:07:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/cpufreq/gx-suspmod.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index 1d723dc..3488c9c 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -144,7 +144,7 @@ module_param(max_duration, int, 0444);
 
 
 /**
- * we can detect a core multipiler from dir0_lsb
+ * we can detect a core multiplier from dir0_lsb
  * from GX1 datasheet p.56,
  *	MULT[3:0]:
  *	0000 = SYSCLK multiplied by 4 (test only)
@@ -346,7 +346,7 @@ static int cpufreq_gx_verify(struct cpufreq_policy *policy)
 
 	/* it needs to be assured that at least one supported frequency is
 	 * within policy->min and policy->max. If it is not, policy->max
-	 * needs to be increased until one freuqency is supported.
+	 * needs to be increased until one frequency is supported.
 	 * policy->min may not be decreased, though. This way we guarantee a
 	 * specific processing capacity.
 	 */
-- 
1.7.9.5


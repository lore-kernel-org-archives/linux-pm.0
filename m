From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/15] cpufreq: integrator: initialize .owner field with THIS_MODULE
Date: Wed, 31 Jul 2013 19:49:16 +0530
Message-ID: <8a9af45028b36379c29e10da6f7ea4be503df129.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:45054 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760328Ab3GaOUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2013 10:20:30 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so809109pdc.19
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2013 07:20:30 -0700 (PDT)
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

CPUFreq core does following at multiple places:
module_{get|put}(cpufreq_driver->owner)).

This is done to make sure module doesn't get unloaded if it is currently in use.
This will work only if the .owner field of cpufreq driver is initialized with a
valid pointer.

This field wasn't initialized for this driver, lets initialize it with
THIS_MODULE.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/integrator-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
index f7c99df..7205ea3 100644
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -199,6 +199,7 @@ static struct cpufreq_driver integrator_driver = {
 	.target		= integrator_set_target,
 	.get		= integrator_get,
 	.init		= integrator_cpufreq_init,
+	.owner		= THIS_MODULE,
 	.name		= "integrator",
 };
 
-- 
1.7.12.rc2.18.g61b472e


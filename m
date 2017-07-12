From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: OF: Use pr_debug() instead of pr_err() while adding OPP table
Date: Wed, 12 Jul 2017 09:21:49 +0530
Message-ID: <3b5b0e789b7296f7b38f4ab9503a53031280a672.1499831484.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36736 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755749AbdGLDwQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 23:52:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id q86so6067007pfl.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2017 20:52:16 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Mason <slash.tmp@free.fr>, linux-kernel@vger.kernel.org

Some platforms add the OPPs dynamically from platform specific drivers
instead of getting them statically from DT. The cpufreq-dt driver
already ignores the return value of dev_pm_opp_of_cpumask_add_table() to
not error out for such cases, but we still end up printing error message
from that routine. That's not nice.

Convert the print message to use pr_debug() instead.

Reported-by: Mason <slash.tmp@free.fr>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/of.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 779428676f63..f1d8b01db546 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -533,8 +533,12 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 
 		ret = dev_pm_opp_of_add_table(cpu_dev);
 		if (ret) {
-			pr_err("%s: couldn't find opp table for cpu:%d, %d\n",
-			       __func__, cpu, ret);
+			/*
+			 * OPP may get registered dynamically, don't print error
+			 * message here.
+			 */
+			pr_debug("%s: couldn't find opp table for cpu:%d, %d\n",
+				 __func__, cpu, ret);
 
 			/* Free all other OPPs */
 			dev_pm_opp_of_cpumask_remove_table(cpumask);
-- 
2.13.0.71.gd7076ec9c9cb

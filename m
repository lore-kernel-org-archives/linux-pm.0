From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/17] cpufreq: dt: Unsupported OPPs are already disabled
Date: Tue, 22 Dec 2015 15:46:14 +0530
Message-ID: <c1abc34d5aaf0eb584c4cbeb6771d393c850ba85.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33075 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKRI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:17:08 -0500
Received: by mail-pa0-f41.google.com with SMTP id cy9so33025963pac.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:17:08 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

The core already have a valid regulator set for the device opp and the
unsupported OPPs are already disabled by the core. There is no need to
repeat that in the user drivers, get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 39df4f1a06d2..8b6e55f62852 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -346,8 +346,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 					min_uV = opp_uV;
 				if (opp_uV > max_uV)
 					max_uV = opp_uV;
-			} else {
-				dev_pm_opp_disable(cpu_dev, opp_freq);
 			}
 
 			opp_freq++;
-- 
2.7.0.rc1.186.g94414c4


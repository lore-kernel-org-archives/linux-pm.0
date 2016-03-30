From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/4] cpufreq: dt: Include types.h from cpufreq-dt.h
Date: Wed, 30 Mar 2016 13:45:25 +0530
Message-ID: <761afb1626b6e044bbddca711ba74900991b725f.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33215 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbcC3IPj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 04:15:39 -0400
Received: by mail-pf0-f177.google.com with SMTP id 4so36227408pfd.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 01:15:39 -0700 (PDT)
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, k.kozlowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org

cpufreq-dt.h uses 'bool' data type but doesn't include types.h. It works
fine for now as the files that include cpufreq-dt.h, also include
types.h directly or indirectly.

But, when a file includes cpufreq-dt.h without including types.h, we get
a build error. Avoid such errors by including types.h in cpufreq-dt
itself.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq-dt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
index 0414009e2c30..a87335a1660c 100644
--- a/include/linux/cpufreq-dt.h
+++ b/include/linux/cpufreq-dt.h
@@ -10,6 +10,8 @@
 #ifndef __CPUFREQ_DT_H__
 #define __CPUFREQ_DT_H__
 
+#include <linux/types.h>
+
 struct cpufreq_dt_platform_data {
 	/*
 	 * True when each CPU has its own clock to control its
-- 
2.7.1.410.g6faf27b


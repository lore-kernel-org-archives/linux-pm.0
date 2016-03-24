From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: dt: Include types.h from cpufreq-dt.h
Date: Thu, 24 Mar 2016 12:10:28 +0530
Message-ID: <b234b9fde941f82acd62f3d0b5ed19c580f8c680.1458801338.git.viresh.kumar@linaro.org>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34298 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcCXGlN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 02:41:13 -0400
Received: by mail-pa0-f50.google.com with SMTP id fe3so14690072pab.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2016 23:41:12 -0700 (PDT)
In-Reply-To: <cover.1458801338.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1458801338.git.viresh.kumar@linaro.org>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org

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


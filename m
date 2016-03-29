From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 1/3] cpufreq: dt: Include types.h from cpufreq-dt.h
Date: Tue, 29 Mar 2016 12:09:47 +0530
Message-ID: <754ba649ec35503ed958132884c4991de6e6861b.1459233524.git.viresh.kumar@linaro.org>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459233524.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1459233524.git.viresh.kumar@linaro.org>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, k.kozlowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

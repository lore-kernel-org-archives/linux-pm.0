From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 22/34] Thermal: add indent for code alignment.
Date: Sun,  2 Dec 2012 22:44:56 +0800
Message-ID: <1354459508-3707-22-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab2LBOpn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:43 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "hongbo.zhang" <hongbo.zhang@linaro.com>, Zhang Rui <rui.zhang@intel.com>

From: "hongbo.zhang" <hongbo.zhang@linaro.com>

The curly bracket should be aligned with corresponding if else statements.

Signed-off-by: hongbo.zhang <hongbo.zhang@linaro.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index cc1c930..b6b4c2a 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -369,7 +369,7 @@ struct thermal_cooling_device *cpufreq_cooling_register(
 			if (min != policy.cpuinfo.min_freq ||
 				max != policy.cpuinfo.max_freq)
 				return ERR_PTR(-EINVAL);
-}
+		}
 	}
 	cpufreq_dev = kzalloc(sizeof(struct cpufreq_cooling_device),
 			GFP_KERNEL);
-- 
1.7.7.6


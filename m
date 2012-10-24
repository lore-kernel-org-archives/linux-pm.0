From: "hongbo.zhang" <hongbo.zhang@linaro.org>
Subject: [PATCH V2 1/6] Thermal: add indent for code alignment.
Date: Wed, 24 Oct 2012 19:58:15 +0800
Message-ID: <1351079900-32236-2-git-send-email-hongbo.zhang@linaro.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
 <1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:58687 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111Ab2JXL7B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Oct 2012 07:59:01 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so220401dak.19
        for <linux-pm@vger.kernel.org>; Wed, 24 Oct 2012 04:59:01 -0700 (PDT)
In-Reply-To: <1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>

From: "hongbo.zhang" <hongbo.zhang@linaro.com>

The curly bracket should be aligned with corresponding if else statements.

Signed-off-by: hongbo.zhang <hongbo.zhang@linaro.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
1.7.11.3


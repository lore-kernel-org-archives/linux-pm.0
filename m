From: "hongbo.zhang" <hongbo.zhang@linaro.org>
Subject: [PATCH V3 1/5] Thermal: add indent for code alignment.
Date: Tue, 30 Oct 2012 17:48:57 +0100
Message-ID: <1351615741-24134-2-git-send-email-hongbo.zhang@linaro.com>
References: <1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
 <1351615741-24134-1-git-send-email-hongbo.zhang@linaro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351615741-24134-1-git-send-email-hongbo.zhang@linaro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, amit.kachhap@linaro.org
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, "hongbo.zhang" <hongbo.zhang@linaro.com>
List-Id: linux-pm@vger.kernel.org

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

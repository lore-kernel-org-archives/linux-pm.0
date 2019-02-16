From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] cpufreq: longhaul: remove unneeded semicolon
Date: Sat, 16 Feb 2019 10:55:27 -0500
Message-ID: <20190216155527.11839-3-tiny.windzz@gmail.com>
References: <20190216155527.11839-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190216155527.11839-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The semicolon is unneeded, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/longhaul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 279bd9e9fa95..fb546e0d0356 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -851,7 +851,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 	case TYPE_POWERSAVER:
 		pr_cont("Powersaver supported\n");
 		break;
-	};
+	}
 
 	/* Doesn't hurt */
 	longhaul_setup_southbridge();
-- 
2.17.0

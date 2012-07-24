From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [RESEND PATCH] conservative: Initialise the cpu field during governor start
Date: Tue, 24 Jul 2012 14:56:12 +0530
Message-ID: <1343121972-9130-1-git-send-email-amit.daniel@samsung.com>
References: <201207232055.26506.rjw@sisk.pl>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <201207232055.26506.rjw@sisk.pl>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: amit.kachhap@linaro.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This change initialises the cpu id field of cs_cpu_dbs_info structure in
conservative governor and keep this consistent with other governors.
Similar initialisation is present in ondemand governor.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/cpufreq/cpufreq_conservative.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 235a340..a1563d7 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -504,6 +504,7 @@ static int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 				j_dbs_info->prev_cpu_nice =
 						kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 		}
+		this_dbs_info->cpu = cpu;
 		this_dbs_info->down_skip = 0;
 		this_dbs_info->requested_freq = policy->cur;
 
-- 
1.7.1


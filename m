From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 2/2] Cpufreq/gov: use tick_nohz_check() to check idle micro accouting support
Date: Tue, 29 Oct 2013 16:48:57 +0800
Message-ID: <1383036537-30362-2-git-send-email-tianyu.lan@intel.com>
References: <1383036537-30362-1-git-send-email-tianyu.lan@intel.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1383036537-30362-1-git-send-email-tianyu.lan@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Current, od_init() uses get_cpu_idle_time_us() to check whether
idle micro accouting is supported. The get_cpu_idle_time_us()
returns -1 only when tick nohz is disabled. This patch is to use
tick_nohz_check() directly to check nohz enable status instead of
get_cpu_idle_time_us(). This can avoid unnecessary getting and
putting cpu.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/cpufreq/cpufreq_ondemand.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 32f26f6..79986a9 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -485,10 +485,7 @@ static int od_init(struct dbs_data *dbs_data)
 		return -ENOMEM;
 	}
 
-	cpu = get_cpu();
-	idle_time = get_cpu_idle_time_us(cpu, NULL);
-	put_cpu();
-	if (idle_time != -1ULL) {
+	if (tick_nohz_check()) {
 		/* Idle micro accounting is supported. Use finer thresholds */
 		tuners->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
 		/*
-- 
1.8.4.rc0.1.g8f6a3e5.dirty


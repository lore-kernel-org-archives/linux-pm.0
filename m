From: Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 4/4] cpufreq: ondemand: use all CPUs in update_sampling_rate
Date: Wed, 30 Jan 2013 14:00:03 +0100
Message-ID: <1359550803-18577-5-git-send-email-fabio.baltieri@linaro.org>
References: <1359550803-18577-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1359550803-18577-1-git-send-email-fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Modify update_sampling_rate() to check, and eventually immediately
schedule, all CPU's do_dbs_timer delayed work.

This is required in case of software coordinated CPUs, as we now have a
separate delayed work for each CPU.

Signed-off-by: Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 13ceb3c..1017b90 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -326,7 +326,7 @@ static void update_sampling_rate(unsigned int new_rate)
 			cpufreq_cpu_put(policy);
 			continue;
 		}
-		dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
+		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cpufreq_cpu_put(policy);
 
 		mutex_lock(&dbs_info->cdbs.timer_mutex);
@@ -345,8 +345,7 @@ static void update_sampling_rate(unsigned int new_rate)
 			cancel_delayed_work_sync(&dbs_info->cdbs.work);
 			mutex_lock(&dbs_info->cdbs.timer_mutex);
 
-			schedule_delayed_work_on(dbs_info->cdbs.cpu,
-					&dbs_info->cdbs.work,
+			schedule_delayed_work_on(cpu, &dbs_info->cdbs.work,
 					usecs_to_jiffies(new_rate));
 
 		}
-- 
1.7.12.1

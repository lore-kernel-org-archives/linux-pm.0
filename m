From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V4 1/6] cpufreq: suspend governors from dpm_{suspend|resume}()
Date: Mon,  2 Dec 2013 11:22:31 +0530
Message-ID: <6b3eed450097f1c3309b26a3b9c319385559314b.1385962528.git.viresh.kumar@linaro.org>
References: <cover.1385962528.git.viresh.kumar@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1385962528.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1385962528.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1385962528.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jhbird.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Recently support for suspending governors has been added in cpufreq and
callbacks are called from dpm_{suspend|resume}_noirq(). The problem here is that
most of the devices (i.e. devices with ->suspend() callbacks) have already been
suspended by now and so if drivers want to change frequency before suspending,
then it might not be possible for many platforms (which depend on other
peripherals like i2c, regulators, etc).

So, we actually need to do this from dpm_{suspend|resume}() instead. This patch
does it.

Tested-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Tested-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/base/power/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e3219df..c9fbb9d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -541,7 +541,6 @@ static void dpm_resume_noirq(pm_message_t state)
 	dpm_show_time(starttime, state, "noirq");
 	resume_device_irqs();
 	cpuidle_resume();
-	cpufreq_resume();
 }
 
 /**
@@ -791,6 +790,8 @@ void dpm_resume(pm_message_t state)
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, NULL);
+
+	cpufreq_resume();
 }
 
 /**
@@ -957,7 +958,6 @@ static int dpm_suspend_noirq(pm_message_t state)
 	ktime_t starttime = ktime_get();
 	int error = 0;
 
-	cpufreq_suspend();
 	cpuidle_pause();
 	suspend_device_irqs();
 	mutex_lock(&dpm_list_mtx);
@@ -1262,6 +1262,8 @@ int dpm_suspend(pm_message_t state)
 
 	might_sleep();
 
+	cpufreq_suspend();
+
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
-- 
1.7.12.rc2.18.g61b472e

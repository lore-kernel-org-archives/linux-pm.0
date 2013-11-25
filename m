From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] Cpufreq: Change sysfs interface cpuinfo_cur_freq access privilege
Date: Mon, 25 Nov 2013 10:53:38 +0800
Message-ID: <1385348018-30525-1-git-send-email-tianyu.lan@intel.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, hg197@gmx.de
Cc: Lan Tianyu <tianyu.lan@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently, cpuinfo_cur_freq is only accessible for root user while
other cpufreq sysfs interfaces(E,G scaling_cur_freq) are available
to ordinary user. This seems make no sense. This patch is to change
it.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 include/linux/cpufreq.h   | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02d534d..1926465 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -605,7 +605,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
 }
 
-cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
+cpufreq_freq_attr_ro(cpuinfo_cur_freq);
 cpufreq_freq_attr_ro(cpuinfo_min_freq);
 cpufreq_freq_attr_ro(cpuinfo_max_freq);
 cpufreq_freq_attr_ro(cpuinfo_transition_latency);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 5bd6ab9..b4bb677 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -166,10 +166,6 @@ struct freq_attr {
 static struct freq_attr _name =			\
 __ATTR(_name, 0444, show_##_name, NULL)
 
-#define cpufreq_freq_attr_ro_perm(_name, _perm)	\
-static struct freq_attr _name =			\
-__ATTR(_name, _perm, show_##_name, NULL)
-
 #define cpufreq_freq_attr_rw(_name)		\
 static struct freq_attr _name =			\
 __ATTR(_name, 0644, show_##_name, store_##_name)
-- 
1.8.4.rc0.1.g8f6a3e5.dirty


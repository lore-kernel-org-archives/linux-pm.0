From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] cpufreq: stats: Get rid of CPUFREQ_STATDEVICE_ATTR
Date: Mon,  4 Feb 2013 17:08:52 +0530
Message-ID: <0f3f2223e79388db616fc5925ef8fc6b223f1d81.1359976493.git.viresh.kumar@linaro.org>
References: <cover.1359976493.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1359976493.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1359976493.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1359976493.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Macro "CPUFREQ_STATDEVICE_ATTR" is defined local to cpufreq_stats.c file and is
almost a copy of the generic version present in cpufreq.h file. Lets use the
generic version instead.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq_stats.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 572124c..a2dee4c 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -24,12 +24,6 @@
 
 static spinlock_t cpufreq_stats_lock;
 
-#define CPUFREQ_STATDEVICE_ATTR(_name, _mode, _show) \
-static struct freq_attr _attr_##_name = {\
-	.attr = {.name = __stringify(_name), .mode = _mode, }, \
-	.show = _show,\
-};
-
 struct cpufreq_stats {
 	unsigned int cpu;
 	unsigned int total_trans;
@@ -136,17 +130,17 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 		return PAGE_SIZE;
 	return len;
 }
-CPUFREQ_STATDEVICE_ATTR(trans_table, 0444, show_trans_table);
+cpufreq_freq_attr_ro(trans_table);
 #endif
 
-CPUFREQ_STATDEVICE_ATTR(total_trans, 0444, show_total_trans);
-CPUFREQ_STATDEVICE_ATTR(time_in_state, 0444, show_time_in_state);
+cpufreq_freq_attr_ro(total_trans);
+cpufreq_freq_attr_ro(time_in_state);
 
 static struct attribute *default_attrs[] = {
-	&_attr_total_trans.attr,
-	&_attr_time_in_state.attr,
+	&total_trans.attr,
+	&time_in_state.attr,
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
-	&_attr_trans_table.attr,
+	&trans_table.attr,
 #endif
 	NULL
 };
-- 
1.7.12.rc2.18.g61b472e

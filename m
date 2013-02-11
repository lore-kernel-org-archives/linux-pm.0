From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V2 3/4] cpufreq: Add Kconfig option to enable/disable
	have_multiple_policies
Date: Mon, 11 Feb 2013 13:20:02 +0530
Message-ID: <0289db340545c87d8e4aac7184dd91177eeb9a43.1360568193.git.viresh.kumar@linaro.org>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1360568193.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1360568193.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1360568193.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, toddpoynor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, charles.garcia-tobin-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

have_multiple_policies is required by platforms having multiple clock-domains
for cpus, i.e. supporting multiple policies for cpus. This patch adds in a
Kconfig option for enabling execution of this code.

Reported-by: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/Kconfig | 3 +++
 include/linux/cpufreq.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index cbcb21e..e6e6939 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -23,6 +23,9 @@ config CPU_FREQ_TABLE
 config CPU_FREQ_GOV_COMMON
 	bool
 
+config CPU_FREQ_HAVE_MULTIPLE_POLICIES
+	bool
+
 config CPU_FREQ_STAT
 	tristate "CPU frequency translation statistics"
 	select CPU_FREQ_TABLE
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c5ac9a5..0d84bfa 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -107,11 +107,13 @@ struct cpufreq_policy {
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
+#ifdef CONFIG_CPU_FREQ_HAVE_MULTIPLE_POLICIES
 	/* This should be set by init() of platforms having multiple
 	 * clock-domains, i.e.  supporting multiple policies. With this sysfs
 	 * directories of governor would be created in cpu/cpu<num>/cpufreq/
 	 * directory */
 	bool			have_multiple_policies;
+#endif
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
@@ -142,9 +144,11 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
 static inline struct kobject *
 get_governor_parent_kobj(struct cpufreq_policy *policy)
 {
+#ifdef CONFIG_CPU_FREQ_HAVE_MULTIPLE_POLICIES
 	if (policy->have_multiple_policies)
 		return &policy->kobj;
 	else
+#endif
 		return cpufreq_global_kobject;
 }
 
-- 
1.7.12.rc2.18.g61b472e

From: viresh kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/6] cpufreq: suspend governors on system suspend/hibernate
Date: Tue, 26 Nov 2013 09:42:43 +0530
Message-ID: <52941FBB.7070603@linaro.org>
References: <cover.1385374819.git.viresh.kumar@linaro.org> <55cc3fbf9c553d669629e8ba98eef2b0ef33aaad.1385374822.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55cc3fbf9c553d669629e8ba98eef2b0ef33aaad.1385374822.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jinchoi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jhbird.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Monday 25 November 2013 07:41 PM, Viresh Kumar wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index dc196bb..6d93f91 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -255,6 +255,9 @@ struct cpufreq_driver {
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  
> +void cpufreq_suspend(void);
> +void cpufreq_resume(void);
> +
>  const char *cpufreq_get_current_driver(void);
>  
>  static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,

A minor fix here to get kernel compiled without cpufreq support enabled:

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 8d8b2f4..d40809d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -259,9 +259,6 @@ struct cpufreq_driver {
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);

-void cpufreq_suspend(void);
-void cpufreq_resume(void);
-
 const char *cpufreq_get_current_driver(void);

 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
@@ -287,6 +284,14 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
                        policy->cpuinfo.max_freq);
 }

+#ifdef CONFIG_CPU_FREQ
+void cpufreq_suspend(void);
+void cpufreq_resume(void);
+#elif
+static inline void cpufreq_suspend(void) {}
+static inline void cpufreq_resume(void) {}
+#endif
+
 /*********************************************************************
  *                     CPUFREQ NOTIFIER INTERFACE                    *
  *********************************************************************/

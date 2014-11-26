From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/7] cpufreq: Fix formatting issues in 'struct cpufreq_driver'
Date: Wed, 26 Nov 2014 11:22:56 +0530
Message-ID: <3d727922615731d6e839f1ce5cb977bd3fc6ed24.1416980447.git.viresh.kumar@linaro.org>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36686 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaKZFxV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 00:53:21 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so2161450pab.21
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 21:53:21 -0800 (PST)
In-Reply-To: <cover.1416980447.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1416980447.git.viresh.kumar@linaro.org>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

Adding any new callback to 'struct cpufreq_driver' gives following checkpatch
warning:

WARNING: Unnecessary space before function pointer arguments
+	void	(*usable)	(struct cpufreq_policy *policy);

This is because we have been using a tab spacing between function pointer name
and its arguments and the new one tried to follow that.

Though we normally don't try to fix every checkpatch warning, specially around
formatting issues as that creates unnecessary noise over lists. But I thought we
better fix this so that new additions don't generate these warnings plus it
looks far better/symmetric now.

So, remove these tab spacing issues in 'struct cpufreq_driver' only + fix
alignment of all members.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 503b085..db3c130 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -217,26 +217,26 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
 
 
 struct cpufreq_driver {
-	char			name[CPUFREQ_NAME_LEN];
-	u8			flags;
-	void			*driver_data;
+	char		name[CPUFREQ_NAME_LEN];
+	u8		flags;
+	void		*driver_data;
 
 	/* needed by all drivers */
-	int	(*init)		(struct cpufreq_policy *policy);
-	int	(*verify)	(struct cpufreq_policy *policy);
+	int		(*init)(struct cpufreq_policy *policy);
+	int		(*verify)(struct cpufreq_policy *policy);
 
 	/* define one out of two */
-	int	(*setpolicy)	(struct cpufreq_policy *policy);
+	int		(*setpolicy)(struct cpufreq_policy *policy);
 
 	/*
 	 * On failure, should always restore frequency to policy->restore_freq
 	 * (i.e. old freq).
 	 */
-	int	(*target)	(struct cpufreq_policy *policy,	/* Deprecated */
-				 unsigned int target_freq,
-				 unsigned int relation);
-	int	(*target_index)	(struct cpufreq_policy *policy,
-				 unsigned int index);
+	int		(*target)(struct cpufreq_policy *policy,
+				  unsigned int target_freq,
+				  unsigned int relation);	/* Deprecated */
+	int		(*target_index)(struct cpufreq_policy *policy,
+					unsigned int index);
 	/*
 	 * Only for drivers with target_index() and CPUFREQ_ASYNC_NOTIFICATION
 	 * unset.
@@ -252,27 +252,27 @@ struct cpufreq_driver {
 	 * wish to switch to intermediate frequency for some target frequency.
 	 * In that case core will directly call ->target_index().
 	 */
-	unsigned int (*get_intermediate)(struct cpufreq_policy *policy,
-					 unsigned int index);
-	int	(*target_intermediate)(struct cpufreq_policy *policy,
-				       unsigned int index);
+	unsigned int	(*get_intermediate)(struct cpufreq_policy *policy,
+					    unsigned int index);
+	int		(*target_intermediate)(struct cpufreq_policy *policy,
+					       unsigned int index);
 
 	/* should be defined, if possible */
-	unsigned int	(*get)	(unsigned int cpu);
+	unsigned int	(*get)(unsigned int cpu);
 
 	/* optional */
-	int	(*bios_limit)	(int cpu, unsigned int *limit);
+	int		(*bios_limit)(int cpu, unsigned int *limit);
 
-	int	(*exit)		(struct cpufreq_policy *policy);
-	void	(*stop_cpu)	(struct cpufreq_policy *policy);
-	int	(*suspend)	(struct cpufreq_policy *policy);
-	int	(*resume)	(struct cpufreq_policy *policy);
-	struct freq_attr	**attr;
+	int		(*exit)(struct cpufreq_policy *policy);
+	void		(*stop_cpu)(struct cpufreq_policy *policy);
+	int		(*suspend)(struct cpufreq_policy *policy);
+	int		(*resume)(struct cpufreq_policy *policy);
+	struct freq_attr **attr;
 
 	/* platform specific boost support code */
-	bool                    boost_supported;
-	bool                    boost_enabled;
-	int     (*set_boost)    (int state);
+	bool		boost_supported;
+	bool		boost_enabled;
+	int		(*set_boost)(int state);
 };
 
 /* flags */
-- 
2.0.3.693.g996b0fd


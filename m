From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] cpufreq: Add dummy cpufreq_cpu_get/put for CONFIG_CPU_FREQ=n
Date: Tue,  8 Oct 2013 10:56:11 +0200
Message-ID: <1381222571-20317-1-git-send-email-daniel.vetter@ffwll.ch>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, kbuild test robot <fengguang.wu@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The drm/i915 driver wants to adjust it's own power policies using the
cpu policies as a guideline (we can implicitly boost the cpus through
the gpus on some platforms). To avoid a dreaded select (since a
depends will leave users wondering where where their driver has gone
too) add dummy functions.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild test robot <fengguang.wu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
A quick ack for merging this this through the drm-intel tree is
probably the simplest way forward.
-Daniel
---
 include/linux/cpufreq.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index fcabc42..5ad9a4e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -93,8 +93,16 @@ struct cpufreq_policy {
 #define CPUFREQ_SHARED_TYPE_ALL	 (2) /* All dependent CPUs should set freq */
 #define CPUFREQ_SHARED_TYPE_ANY	 (3) /* Freq can be set from any dependent CPU*/
 
+#ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
 void cpufreq_cpu_put(struct cpufreq_policy *policy);
+#else
+static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
+{
+	return NULL;
+}
+static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
+#endif
 
 static inline bool policy_is_shared(struct cpufreq_policy *policy)
 {
-- 
1.8.4.rc3


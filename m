From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 3/3] drm/i915: Move to new PM core fields
Date: Fri, 14 Dec 2018 15:22:27 +0100
Message-ID: <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, thara.gopinath@linaro.org, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: ulf.hansson@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

With jiffies been replaced by raw ns in PM core accounting, 915 driver is
updated to use this new time infrastructure.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
 drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index d6c8f8f..cf6437d 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
 		 */
 		if (kdev->power.runtime_status == RPM_SUSPENDED) {
 			if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
-				i915->pmu.suspended_jiffies_last =
-						  kdev->power.suspended_jiffies;
+				i915->pmu.suspended_time_last =
+					kdev->power.suspended_time;
 
-			val = kdev->power.suspended_jiffies -
-			      i915->pmu.suspended_jiffies_last;
-			val += jiffies - kdev->power.accounting_timestamp;
+			val = kdev->power.suspended_time -
+				i915->pmu.suspended_time_last;
+			val += ktime_to_ns(ktime_get()) -
+				kdev->power.accounting_timestamp;
 
-			val = jiffies_to_nsecs(val);
 			val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
 
 			i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
index 7f164ca..3dc2a30 100644
--- a/drivers/gpu/drm/i915/i915_pmu.h
+++ b/drivers/gpu/drm/i915/i915_pmu.h
@@ -95,9 +95,9 @@ struct i915_pmu {
 	 */
 	struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
 	/**
-	 * @suspended_jiffies_last: Cached suspend time from PM core.
+	 * @suspended_time_last: Cached suspend time from PM core.
 	 */
-	unsigned long suspended_jiffies_last;
+	u64 suspended_time_last;
 	/**
 	 * @i915_attr: Memory block holding device attributes.
 	 */
-- 
2.7.4

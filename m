From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] PM / devfreq: Remove redundant frequency adjustment from governors
Date: Wed, 16 May 2018 14:10:51 -0700
Message-ID: <20180516211051.78875-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

The performance, powersave, simpleondemand and userspace governors
determine a target frequency and then adjust it according to the
df->min/max_freq limits that might have been set by user space. This
adjustment is redundant, it is done in update_devfreq() for any
governor, right after governor->get_target_freq().

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/governor_performance.c    | 10 ++--------
 drivers/devfreq/governor_powersave.c      |  5 -----
 drivers/devfreq/governor_simpleondemand.c |  7 +------
 drivers/devfreq/governor_userspace.c      | 16 ++++------------
 4 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index 4d23ecfbd948..31ee30622c00 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -16,14 +16,8 @@
 static int devfreq_performance_func(struct devfreq *df,
 				    unsigned long *freq)
 {
-	/*
-	 * target callback should be able to get floor value as
-	 * said in devfreq.h
-	 */
-	if (!df->max_freq)
-		*freq = UINT_MAX;
-	else
-		*freq = df->max_freq;
+	*freq = UINT_MAX;
+
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 0c42f23249ef..50a891f7c92d 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -16,11 +16,6 @@
 static int devfreq_powersave_func(struct devfreq *df,
 				  unsigned long *freq)
 {
-	/*
-	 * target callback should be able to get ceiling value as
-	 * said in devfreq.h
-	 */
-	*freq = df->min_freq;
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 28e0f2de7100..7ed733c528f4 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -27,7 +27,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
 	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
 	struct devfreq_simple_ondemand_data *data = df->data;
-	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
+	unsigned long max = UINT_MAX;
 
 	err = devfreq_update_stats(df);
 	if (err)
@@ -85,11 +85,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
 	*freq = (unsigned long) b;
 
-	if (df->min_freq && *freq < df->min_freq)
-		*freq = df->min_freq;
-	if (df->max_freq && *freq > df->max_freq)
-		*freq = df->max_freq;
-
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 080607c3f34d..378d84c011df 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -26,19 +26,11 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
 {
 	struct userspace_data *data = df->data;
 
-	if (data->valid) {
-		unsigned long adjusted_freq = data->user_frequency;
-
-		if (df->max_freq && adjusted_freq > df->max_freq)
-			adjusted_freq = df->max_freq;
-
-		if (df->min_freq && adjusted_freq < df->min_freq)
-			adjusted_freq = df->min_freq;
-
-		*freq = adjusted_freq;
-	} else {
+	if (data->valid)
+		*freq = data->user_frequency;
+	else
 		*freq = df->previous_freq; /* No user freq specified yet */
-	}
+
 	return 0;
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

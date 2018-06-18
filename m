From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: supply: ab8500: stop using getnstimeofday64()
Date: Mon, 18 Jun 2018 16:23:29 +0200
Message-ID: <20180618142352.3556062-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

getnstimeofday64() is deprecated in favor of the ktime_get() family.

The direct replacement would be ktime_get_real_ts64(), but we only need
the seconds value, and it seems better to use boottime than real time
to avoid unexpected behavior with a concurrent settimeofday().

ktime_get_seconds() might also work, but it seems better to use
boottime than monotonic time since I assume that the charging
process continues during suspend.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/ab8500_fg.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index d9c6c7bedd85..02356f9b5f22 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -379,15 +379,13 @@ static int ab8500_fg_is_low_curr(struct ab8500_fg *di, int curr)
  */
 static int ab8500_fg_add_cap_sample(struct ab8500_fg *di, int sample)
 {
-	struct timespec64 ts64;
+	time64_t now = ktime_get_boottime_seconds();
 	struct ab8500_fg_avg_cap *avg = &di->avg_cap;
 
-	getnstimeofday64(&ts64);
-
 	do {
 		avg->sum += sample - avg->samples[avg->pos];
 		avg->samples[avg->pos] = sample;
-		avg->time_stamps[avg->pos] = ts64.tv_sec;
+		avg->time_stamps[avg->pos] = now;
 		avg->pos++;
 
 		if (avg->pos == NBR_AVG_SAMPLES)
@@ -400,7 +398,7 @@ static int ab8500_fg_add_cap_sample(struct ab8500_fg *di, int sample)
 		 * Check the time stamp for each sample. If too old,
 		 * replace with latest sample
 		 */
-	} while (ts64.tv_sec - VALID_CAPACITY_SEC > avg->time_stamps[avg->pos]);
+	} while (now - VALID_CAPACITY_SEC > avg->time_stamps[avg->pos]);
 
 	avg->avg = avg->sum / avg->nbr_samples;
 
@@ -439,14 +437,14 @@ static void ab8500_fg_clear_cap_samples(struct ab8500_fg *di)
 static void ab8500_fg_fill_cap_sample(struct ab8500_fg *di, int sample)
 {
 	int i;
-	struct timespec64 ts64;
+	time64_t now;
 	struct ab8500_fg_avg_cap *avg = &di->avg_cap;
 
-	getnstimeofday64(&ts64);
+	now = ktime_get_boottime_seconds();
 
 	for (i = 0; i < NBR_AVG_SAMPLES; i++) {
 		avg->samples[i] = sample;
-		avg->time_stamps[i] = ts64.tv_sec;
+		avg->time_stamps[i] = now;
 	}
 
 	avg->pos = 0;
-- 
2.9.0

From: tuukka.tikkanen@linaro.org
Subject: [PATCH 1/8] Cpuidle: Ignore interval prediction result when timer is shorter
Date: Wed, 14 Aug 2013 19:02:34 +0300
Message-ID: <e0958b6ce8d2e115444dd95e6d047e6f217ae252.1376493949.git.tuukka.tikkanen@linaro.org>
References: <cover.1376487596.git.tuukka.tikkanen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.mmd.net ([80.83.0.3]:57311 "EHLO mx.mmd.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759962Ab3HNQRm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Aug 2013 12:17:42 -0400
In-Reply-To: <cover.1376487596.git.tuukka.tikkanen@linaro.org>
In-Reply-To: <cover.1376493949.git.tuukka.tikkanen@linaro.org>
References: <cover.1376493949.git.tuukka.tikkanen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: private-pmwg@linaro.org, linux-kernel@vger.kernel.org, Tuukka Tikkanen <tuukka.tikkanen@linaro.org>

From: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>

This patch prevents cpuidle menu governor from using repeating interval
prediction result if the idle period predicted is longer than the one
allowed by shortest running timer.

Signed-off-by: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
---
 drivers/cpuidle/governors/menu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index bc580b6..c8ab1c5 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -238,10 +238,13 @@ again:
 	 *
 	 * The typical interval is obtained when standard deviation is small
 	 * or standard deviation is small compared to the average interval.
+	 *
+	 * Use this result only if there is no timer to wake us up sooner.
 	 */
 	if (((avg > stddev * 6) && (divisor * 4 >= INTERVALS * 3))
 							|| stddev <= 20) {
-		data->predicted_us = avg;
+		if (data->expected_us > avg)
+			data->predicted_us = avg;
 		return;
 
 	} else if ((divisor * 4) > INTERVALS * 3) {
-- 
1.7.9.5


From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [PATCH] PM / devfreq: Skip status update on uninitialized previous_freq
Date: Thu, 29 Sep 2016 14:36:36 +0200
Message-ID: <1475152596-7892-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:44100 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750877AbcI2Mgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 08:36:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

In case devfreq->previous_freq is still uninitialized in
devfreq_update_status(), i.e. it has value '0', the lookups in
that function fail, eventually leading to some error message:
[    3.041292] devfreq bus_dmc: Couldn't update frequency transition information.

Just skip the statup update in this situation.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/devfreq/devfreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 478006b..1bb300f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -137,6 +137,10 @@ static int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 
 	cur_time = jiffies;
 
+	/* Immediately exit if previous_freq is not initialized yet. */
+	if (!devfreq->previous_freq)
+		goto out;
+
 	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
 	if (prev_lev < 0) {
 		ret = prev_lev;
-- 
2.7.3


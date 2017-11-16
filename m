From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/4] rk3399_dmc: Fix line continuation format
Date: Thu, 16 Nov 2017 07:27:26 -0800
Message-ID: <7d659960e45f66894126fba9e2d54cf25ae1185b.1510845910.git.joe@perches.com>
References: <cover.1510845910.git.joe@perches.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:45423 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1759902AbdKPP1k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 10:27:40 -0500
In-Reply-To: <cover.1510845910.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Line continuations with excess spacing causes unexpected output.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/devfreq/rk3399_dmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 5dfbfa3cc878..0938c97d46f0 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -146,8 +146,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	/* If get the incorrect rate, set voltage to old value. */
 	if (dmcfreq->rate != target_rate) {
-		dev_err(dev, "Get wrong ddr frequency, Request frequency %lu,\
-			Current frequency %lu\n", target_rate, dmcfreq->rate);
+		dev_err(dev, "Get wrong ddr frequency, Request frequency %lu, Current frequency %lu\n",
+			target_rate, dmcfreq->rate);
 		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
 				      dmcfreq->volt);
 		goto out;
-- 
2.15.0

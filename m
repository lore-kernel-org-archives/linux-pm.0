From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] PM / devfreq: Send the DEVFREQ_POSTCHANGE notification when
 target() is failed
Date: Thu, 23 Jun 2016 11:18:43 +0900
Message-ID: <1466648323-776-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53262 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbcFWCSr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 22:18:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: kyungmin.park@samsung.com, hl@rock-chips.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch sends the DEVFREQ_POSTCHANGE notification when
devfreq->profile->targer() is failed. The PRECHANGE/POSTCHANGE
should be paired.

Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
Reported-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1d6c803804d5..387799fec4c3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -268,8 +268,11 @@ int update_devfreq(struct devfreq *devfreq)
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
 
 	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
-	if (err)
+	if (err) {
+		freqs.new = cur_freq;
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 		return err;
+	}
 
 	freqs.new = freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-- 
1.9.1


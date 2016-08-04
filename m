From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] PM / devfreq: event: remove duplicate
 devfreq_event_get_drvdata()
Date: Thu, 04 Aug 2016 19:28:45 +0900
Message-ID: <1470306525-5515-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43244 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbcHDKlR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2016 06:41:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>

From: Lin Huang <hl@rock-chips.com>

there define two devfreq_event_get_drvdata() function in devfreq-event.h
when disable CONFIG_PM_DEVFREQ_EVENT, it will lead to build fail. So
remove devfreq_event_get_drvdata() function.

Fixes: f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/linux/devfreq-event.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 0a83a1e648b0..4db00b02ca3f 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -148,11 +148,6 @@ static inline int devfreq_event_reset_event(struct devfreq_event_dev *edev)
 	return -EINVAL;
 }
 
-static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
-{
-	return ERR_PTR(-EINVAL);
-}
-
 static inline struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
 					struct device *dev, int index)
 {
-- 
1.9.1


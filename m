From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2] PM / devfreq: event: remove duplicate
 devfreq_event_get_drvdata()
Date: Thu, 04 Aug 2016 19:32:33 +0900
Message-ID: <1470306753-5721-1-git-send-email-cw00.choi@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>, stable@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

there define two devfreq_event_get_drvdata() function in devfreq-event.h
when disable CONFIG_PM_DEVFREQ_EVENT, it will lead to build fail. So
remove devfreq_event_get_drvdata() function.

Fixes: f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")
Cc: stable@vger.kernel.org
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1:
- Add <stable@vger.kernel.org>

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

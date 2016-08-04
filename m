From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH] PM / devfreq: event: remove duplicate devfreq_event_get_drvdata()
Date: Thu,  4 Aug 2016 14:01:48 +0800
Message-ID: <1470290508-19178-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33533 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcHDGB6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2016 02:01:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>

there define two devfreq_event_get_drvdata() function in devfreq-event.h
when disable CONFIG_PM_DEVFREQ_EVENT, it will lead to build fail. So
remove devfreq_event_get_drvdata() function.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 include/linux/devfreq-event.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 0a83a1e..4db00b0 100644
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


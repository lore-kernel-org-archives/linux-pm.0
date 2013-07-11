From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] power: Fix comment typo in pm_wakeup.h
Date: Thu, 11 Jul 2013 13:55:58 +0900
Message-ID: <1373518558-670-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:65181 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab3GKE4H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2013 00:56:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch fix typo (sorce -> source)

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/linux/pm_wakeup.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 569781f..a0f7080 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -36,8 +36,8 @@
  * @last_time: Monotonic clock when the wakeup source's was touched last time.
  * @prevent_sleep_time: Total time this source has been preventing autosleep.
  * @event_count: Number of signaled wakeup events.
- * @active_count: Number of times the wakeup sorce was activated.
- * @relax_count: Number of times the wakeup sorce was deactivated.
+ * @active_count: Number of times the wakeup source was activated.
+ * @relax_count: Number of times the wakeup source was deactivated.
  * @expire_count: Number of times the wakeup source's timeout has expired.
  * @wakeup_count: Number of times the wakeup source might abort suspend.
  * @active: Status of the wakeup source.
-- 
1.8.0


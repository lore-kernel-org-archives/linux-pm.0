From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 1/2] timer: add setup_deferrable_timer macro
Date: Tue, 12 Jan 2016 18:17:19 +0100
Message-ID: <1452619040-27137-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46061 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933756AbcALRRZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 12:17:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de

Add the trivial missing macro to setup a deferrable timer.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 include/linux/timer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 61aa61dc410c..20ac746f3eb3 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -145,6 +145,8 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 
 #define setup_timer(timer, fn, data)					\
 	__setup_timer((timer), (fn), (data), 0)
+#define setup_deferrable_timer(timer, fn, data)				\
+	__setup_timer((timer), (fn), (data), TIMER_DEFERRABLE)
 #define setup_timer_on_stack(timer, fn, data)				\
 	__setup_timer_on_stack((timer), (fn), (data), 0)
 #define setup_deferrable_timer_on_stack(timer, fn, data)		\
-- 
2.6.4


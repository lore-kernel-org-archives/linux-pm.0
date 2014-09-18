From: Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH v2] PM: Print pending wakeup IRQ preventing suspend
Date: Fri, 19 Sep 2014 04:52:35 +0530
Message-ID: <1411082555-4425-1-git-send-email-amit.pundir@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54309 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaIRXXJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Sep 2014 19:23:09 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so2510530pab.32
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2014 16:23:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Todd Poynor <toddpoynor@google.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>, Amit Pundir <amit.pundir@linaro.org>

From: Todd Poynor <toddpoynor@google.com>

Currently when a pending wakeup irq stops suspend, it can be difficult
to determine why suspend was prevented and which IRQ was actually
responsible. In order to help debug such situation, this patch prints the
IRQ number and action name of that pending wakeup irq.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Android Kernel Team <kernel-team@android.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
[Amit Pundir: Reworded the commit message]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Resending this patch assuming that it might have got lost in between merge
window rush last time and now people might have some time to look at it.
 
 kernel/irq/pm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index abcd6ca..c2bc8d9 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -109,8 +109,13 @@ int check_wakeup_irqs(void)
 		 * can abort suspend.
 		 */
 		if (irqd_is_wakeup_set(&desc->irq_data)) {
-			if (desc->depth == 1 && desc->istate & IRQS_PENDING)
+			if (desc->depth == 1 && desc->istate & IRQS_PENDING) {
+				pr_info("Wakeup IRQ %d %s pending, suspend aborted\n",
+					irq,
+					desc->action && desc->action->name ?
+					desc->action->name : "");
 				return -EBUSY;
+			}
 			continue;
 		}
 		/*
-- 
1.9.1


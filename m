From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 01/15] timer: move enum definition out of ifdef section
Date: Mon, 25 Mar 2013 18:55:26 +0100
Message-ID: <1364234140-514-2-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37349 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758819Ab3CYRzn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 13:55:43 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so10508514wib.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 10:55:42 -0700 (PDT)
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, tglx@linutronix.de
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

The next patch will setup automatically the broadcast timer for
the different cpuidle driver when one idle state stops its timer.
This will be part of the generic code.

But some ARM boards, like s3c64xx, uses cpuidle but without the
CONFIG_GENERIC_CLOCKEVENTS_BUILD set. Hence the cpuidle framework
will be compiled with the code supposed to be generic, that is
with clockevents_notify and the different enum, but will fail to
compile because the enum is not defined.

Also the function clockevents_notify is a noop macro, this is fine
except the usual code is:

	int cpu = smp_processor_id();
	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);

and that raises a warning telling the variable 'cpu' is not used.

Move the clock_event_nofitiers enum definition out of the
CONFIG_GENERIC_CLOCKEVENTS_BUILD section to prevent a compilation
error when these are used in the code.

Change the clockevents_notify macro to a static inline noop function
to prevent a compilation warning.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/clockchips.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 6634652..ba661e9 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -8,15 +8,6 @@
 #ifndef _LINUX_CLOCKCHIPS_H
 #define _LINUX_CLOCKCHIPS_H
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BUILD
-
-#include <linux/clocksource.h>
-#include <linux/cpumask.h>
-#include <linux/ktime.h>
-#include <linux/notifier.h>
-
-struct clock_event_device;
-
 /* Clock event mode commands */
 enum clock_event_mode {
 	CLOCK_EVT_MODE_UNUSED = 0,
@@ -40,6 +31,15 @@ enum clock_event_nofitiers {
 	CLOCK_EVT_NOTIFY_CPU_DEAD,
 };
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BUILD
+
+#include <linux/clocksource.h>
+#include <linux/cpumask.h>
+#include <linux/ktime.h>
+#include <linux/notifier.h>
+
+struct clock_event_device;
+
 /*
  * Clock event features
  */
@@ -173,7 +173,7 @@ extern int tick_receive_broadcast(void);
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void clockevents_notify(unsigned long reason, void *arg);
 #else
-# define clockevents_notify(reason, arg) do { } while (0)
+static inline void clockevents_notify(unsigned long reason, void *arg) {}
 #endif
 
 #else /* CONFIG_GENERIC_CLOCKEVENTS_BUILD */
@@ -181,7 +181,7 @@ extern void clockevents_notify(unsigned long reason, void *arg);
 static inline void clockevents_suspend(void) {}
 static inline void clockevents_resume(void) {}
 
-#define clockevents_notify(reason, arg) do { } while (0)
+static inline void clockevents_notify(unsigned long reason, void *arg) {}
 
 #endif
 
-- 
1.7.9.5


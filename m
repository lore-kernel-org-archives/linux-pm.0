From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/6] alarmtimer: Postpone wake-up source registration until really available
Date: Mon, 20 Feb 2017 21:33:24 +0100
Message-ID: <1487622809-25127-2-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Currently the alarmtimer registers a wake-up source unconditionally,
regardless of the system having a (wake-up capable) RTC or not.
To fix this, postpone registration until a wake-up capable RTC device is
added.

After this, the alarmtimer no longer shows up in
/sys/kernel/debug/wakeup_sources, unless it is available for real.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/time/alarmtimer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index e6dc9a538efa2116..5e0ce78607da5b5d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -82,6 +82,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 {
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
+	struct wakeup_source *__ws;
 
 	if (rtcdev)
 		return -EBUSY;
@@ -91,13 +92,20 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;
 
+	__ws = wakeup_source_register("alarmtimer");
+
 	spin_lock_irqsave(&rtcdev_lock, flags);
 	if (!rtcdev) {
 		rtcdev = rtc;
 		/* hold a reference so it doesn't go away */
 		get_device(dev);
+		ws = __ws;
+		__ws = NULL;
 	}
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
+
+	wakeup_source_unregister(__ws);
+
 	return 0;
 }
 
@@ -908,7 +916,6 @@ static int __init alarmtimer_init(void)
 		error = PTR_ERR(pdev);
 		goto out_drv;
 	}
-	ws = wakeup_source_register("alarmtimer");
 	return 0;
 
 out_drv:
-- 
2.7.4

From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 09/13] power: reset: ltc2952: fix C++ style function pointers
Date: Wed, 22 Oct 2014 16:31:06 +0200
Message-ID: <1413988270-28092-10-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The function pointers for the timers and pm_power_off are assigned with
C++ style
	foo = &func;

Let's change it instead to the more C style
	foo = func;

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 70d8e3a..8ab1da6 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -182,10 +182,10 @@ static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 	data->trigger_delay = ktime_set(2, 500L*1E6L);
 
 	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->timer_trigger.function = &ltc2952_poweroff_timer_trigger;
+	data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
 
 	hrtimer_init(&data->timer_wde, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->timer_wde.function = &ltc2952_poweroff_timer_wde;
+	data->timer_wde.function = ltc2952_poweroff_timer_wde;
 }
 
 static int ltc2952_poweroff_init(struct platform_device *pdev)
@@ -270,7 +270,7 @@ static int ltc2952_poweroff_probe(struct platform_device *pdev)
 
 	/* TODO: remove ltc2952_data */
 	ltc2952_data = data;
-	pm_power_off = &ltc2952_poweroff_kill;
+	pm_power_off = ltc2952_poweroff_kill;
 
 	data->panic_notifier.notifier_call = ltc2952_poweroff_notify_panic;
 	atomic_notifier_chain_register(&panic_notifier_list,
-- 
2.1.0

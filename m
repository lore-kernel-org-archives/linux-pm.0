From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 10/13] power: reset: ltc2952: disable timers in _remove
Date: Wed, 22 Oct 2014 16:31:07 +0200
Message-ID: <1413988270-28092-11-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Disable the timers when ltc2952_poweroff is removed. We don't want to
risk calling functions on data that no longer exist.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 8ab1da6..2f3fd5b 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -285,6 +285,8 @@ static int ltc2952_poweroff_remove(struct platform_device *pdev)
 	struct ltc2952_poweroff *data = platform_get_drvdata(pdev);
 
 	pm_power_off = NULL;
+	hrtimer_cancel(&data->timer_trigger);
+	hrtimer_cancel(&data->timer_wde);
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &data->panic_notifier);
 	return 0;
-- 
2.1.0

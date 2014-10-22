From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 07/13] power: reset: ltc2952: drop empty suspend/resume functions
Date: Wed, 22 Oct 2014 16:31:04 +0200
Message-ID: <1413988270-28092-8-git-send-email-frans.klaver@xsens.com>
References: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413988270-28092-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Documentation/SubmittingDrivers suggests these be implemented even when
they do nothing. On the other hand, the platform code calls these
functions 'legacy'. Suspend and resume operations should go into a
pm_ops structure, pointed at by the driver's pm field. This approach
would lead to a lot of boiler plate, while achieving nothing. Drop the
functions instead.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index bc8d228..af3cb6e 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -184,17 +184,6 @@ static void ltc2952_poweroff_kill(void)
 	gpiod_set_value(ltc2952_data->gpio_kill, 1);
 }
 
-static int ltc2952_poweroff_suspend(struct platform_device *pdev,
-	pm_message_t state)
-{
-	return -ENOSYS;
-}
-
-static int ltc2952_poweroff_resume(struct platform_device *pdev)
-{
-	return -ENOSYS;
-}
-
 static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 {
 	data->wde_interval = ktime_set(0, 300L*1E6L);
@@ -323,8 +312,6 @@ static struct platform_driver ltc2952_poweroff_driver = {
 		.owner = THIS_MODULE,
 		.of_match_table = of_ltc2952_poweroff_match,
 	},
-	.suspend = ltc2952_poweroff_suspend,
-	.resume = ltc2952_poweroff_resume,
 };
 
 module_platform_driver(ltc2952_poweroff_driver);
-- 
2.1.0

From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] power: reset: gpio-restart: increase priority slightly
Date: Tue, 02 Jun 2015 16:48:50 +0200
Message-ID: <4893951.aWdOo6F7tl@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:40714 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932394AbbFBOs7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jun 2015 10:48:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

gpio-restart uses a priority of 128 and currently most soc-level restart
mechanisms use the same - with some exceptions even using 192.
But while the soc-level restarts are provided by the soc itself,
gpio-restarts will most of the time be board-specfic and be used
when some special board condition makes the soc-level restart
only a second choice.

The problem at hand manifested itself on the rk3288-veyron devices.
While the soc-level restart can sucessfully restart all other rockchip
boards I have, the veyron devices use an external restart mechanism that
seems to not only reset the soc but also some external needed components.

With both restart handlers having priority 128 in my tests the soc-specific
variant took precedent in all cases. While it could restart the soc
sucessfully in all cases, firmware then got an issue when talking to an
external component, resulting in the device being put into recovery mode.

So, give the board-specific restart handler a slight push and move it
to priority 129 to make it more important than the generic soc-specific
restart-handler.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/power/reset/gpio-restart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpio-restart.c
index edb327e..829b45f 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -78,7 +78,7 @@ static int gpio_restart_probe(struct platform_device *pdev)
 	}
 
 	gpio_restart->restart_handler.notifier_call = gpio_restart_notify;
-	gpio_restart->restart_handler.priority = 128;
+	gpio_restart->restart_handler.priority = 129;
 	gpio_restart->active_delay_ms = 100;
 	gpio_restart->inactive_delay_ms = 100;
 	gpio_restart->wait_delay_ms = 3000;
-- 
2.1.4



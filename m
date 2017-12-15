From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Fri, 15 Dec 2017 16:56:29 +0100
Message-ID: <1513353391-30806-2-git-send-email-ulf.hansson@linaro.org>
References: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45071 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932437AbdLOP4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 10:56:46 -0500
Received: by mail-lf0-f66.google.com with SMTP id f13so10943674lff.12
        for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2017 07:56:45 -0800 (PST)
In-Reply-To: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

The PM core in the device_prepare() phase, resets the wakeup_path status
flag to the value of device_may_wakeup(). This means if a ->prepare() or a
->suspend() callback for the device would update the device's wakeup
setting, this doesn't become reflected in the wakeup_path status flag.

In general this isn't a problem, because wakeup settings isn't supposed to
be changed during those system suspend phases. Nevertheless, there are a
cases not conforming to that behaviour, as device_set_wakeup_enable() is
indeed called from ->suspend() callbacks.

To address this, let's move the assignment of the wakeup_path status flag
to the __device_suspend() phase and more precisely, after the ->suspend()
callback has been invoked.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 6e8cc5d..810e5fb 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1620,6 +1620,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
  End:
 	if (!error) {
 		dev->power.is_suspended = true;
+		if (device_may_wakeup(dev))
+			dev->power.wakeup_path = true;
 		dpm_propagate_to_parent(dev);
 		dpm_clear_suppliers_direct_complete(dev);
 	}
@@ -1744,7 +1746,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	device_lock(dev);
 
-	dev->power.wakeup_path = device_may_wakeup(dev);
+	dev->power.wakeup_path = false;
 
 	if (dev->power.no_pm_callbacks) {
 		ret = 1;	/* Let device go direct_complete */
-- 
2.7.4

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] PM / Domains: Sync runtime PM status with genpd after probe
Date: Fri, 20 Mar 2015 15:55:12 +0100
Message-ID: <1426863312-31132-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:36296 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbbCTOzw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 10:55:52 -0400
Received: by labe2 with SMTP id e2so13660187lab.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2015 07:55:51 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

From: Russell King <rmk+kernel@arm.linux.org.uk>

Buses which currently supports attaching devices to their PM domains,
will invoke the dev_pm_domain_attach() API from their ->probe()
callbacks. During the attach procedure, genpd power up the PM domain.

In those scenarios where the bus/driver don't need to access its device
during probe, it may leave it in runtime PM suspended state since
that's also the default state. In that way, no notifications through
the runtime PM callbacks will reach the PM domain during probe.

For genpd, the consequence from the above scenario means the PM domain
will remain powered. Therefore, implement the struct dev_pm_domain's
->sync() callback, which is invoked from driver core after the
bus/driver has probed the device. It allows genpd to power off the PM
domain if it's unused.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
[Ulf: Updated patch according to updates in driver core]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- I picked up Russell's earlier patch [1] and updated it to fit the
	changes [2] proposed to be done to the driver core.

	[1]: [PATCH 3/9] pm: domains: sync runtime PM status with PM domains
	after probe

	[2]: [PATCH v3] driver core / PM: Add PM domain callbacks for device
	setup/cleanup
	http://www.spinics.net/lists/arm-kernel/msg407394.html

---
 drivers/base/power/domain.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 45937f8..295ff71 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2130,6 +2130,17 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 }
 
+static void genpd_dev_pm_sync(struct device *dev)
+{
+	struct generic_pm_domain *pd;
+
+	pd = dev_to_genpd(dev);
+	if (IS_ERR(pd))
+		return;
+
+	genpd_queue_power_off_work(pd);
+}
+
 /**
  * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
  * @dev: Device to attach.
@@ -2196,6 +2207,7 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
+	dev->pm_domain->sync = genpd_dev_pm_sync;
 	pm_genpd_poweron(pd);
 
 	return 0;
-- 
1.9.1


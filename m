From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/4] PM / Domains: Don't allow an existing generic PM domain data
Date: Tue, 28 Oct 2014 15:38:08 +0100
Message-ID: <1414507090-516-3-git-send-email-ulf.hansson@linaro.org>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:63508 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbaJ1OiY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 10:38:24 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so719549lab.41
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2014 07:38:22 -0700 (PDT)
In-Reply-To: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

While adding devices to the generic PM domain we allocate data for the
struct generic_pm_domain_data.

Don't allow existing generic_pm_domain_data in this case, since that
indicates the device is already being added from another context. Let's
instead return an error.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7546242..9d511c7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1423,9 +1423,9 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	spin_lock_irq(&dev->power.lock);
 
-	dev->pm_domain = &genpd->domain;
 	if (dev->power.subsys_data->domain_data) {
-		gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+		ret = -EINVAL;
+		goto out;
 	} else {
 		gpd_data = gpd_data_new;
 		dev->power.subsys_data->domain_data = &gpd_data->base;
@@ -1433,6 +1433,8 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (td)
 		gpd_data->td = *td;
 
+	dev->pm_domain = &genpd->domain;
+
 	spin_unlock_irq(&dev->power.lock);
 
 	if (genpd->attach_dev)
-- 
1.9.1


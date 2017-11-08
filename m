From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Fix genpd to deal with drivers returning 1 from ->prepare()
Date: Wed,  8 Nov 2017 10:11:02 +0100
Message-ID: <1510132262-21928-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:55546 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdKHJLL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 04:11:11 -0500
Received: by mail-lf0-f66.google.com with SMTP id e143so2238179lfg.12
        for <linux-pm@vger.kernel.org>; Wed, 08 Nov 2017 01:11:10 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>

During system-wide PM, genpd relies on its PM callbacks to be invoked for
all its attached devices, as to deal with powering off/on the PM domain. In
other words, genpd is not compatible with the direct_complete path, if
executed by the PM core for any of its attached devices.

However, when genpd's ->prepare() callback invokes pm_generic_prepare(), it
does not take into account that it may return 1. Instead it treats that as
an error internally and expects the PM core to abort the prepare phase and
roll back. This leads to genpd not properly powering on/off the PM domain,
because its internal counters gets wrongly balanced.

To fix the behaviour, allow drivers to return 1 from their ->prepare()
callbacks, but let's return 0 from genpd's ->prepare() callback in such
case, as that prevents the PM core from running the direct_complete path
for the device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 24e39ce..0c80bea 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1008,7 +1008,7 @@ static int genpd_prepare(struct device *dev)
 	genpd_unlock(genpd);
 
 	ret = pm_generic_prepare(dev);
-	if (ret) {
+	if (ret < 0) {
 		genpd_lock(genpd);
 
 		genpd->prepared_count--;
@@ -1016,7 +1016,8 @@ static int genpd_prepare(struct device *dev)
 		genpd_unlock(genpd);
 	}
 
-	return ret;
+	/* Never return 1, as genpd don't cope with the direct_complete path. */
+	return ret >= 0 ? 0 : ret;
 }
 
 /**
-- 
2.7.4

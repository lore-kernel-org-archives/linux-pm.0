From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [RESEND][PATCH] PM / Domains: Fix typo in comment
Date: Wed, 27 Jan 2016 08:29:27 +0100
Message-ID: <1453879767-2447-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:32995 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbcA0HaP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2016 02:30:15 -0500
Received: by mail-wm0-f54.google.com with SMTP id 123so138350874wmz.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2016 23:30:14 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@baylibre.com
Cc: ulf.hansson@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 167418e..f23c036 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -160,7 +160,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 
 /**
  * genpd_queue_power_off_work - Queue up the execution of genpd_poweroff().
- * @genpd: PM domait to power off.
+ * @genpd: PM domain to power off.
  *
  * Queue up the execution of genpd_poweroff() unless it's already been done
  * before.
-- 
2.7.0


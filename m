From: Sriram Dash <dash.sriram@gmail.com>
Subject: [PATCH] base: power: domain.c: fixed a typo error
Date: Tue, 26 May 2015 08:06:51 +0530
Message-ID: <1432607811-22826-1-git-send-email-dash.sriram@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32821 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbEZChC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 22:37:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dashsriram <dash.sriram@gmail.com>

From: dashsriram <dash.sriram@gmail.com>

Fixed a typo error in the file

Signed-off-by: Sriram Dash <dash.sriram@gmail.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2327613..10aa00c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -491,7 +491,7 @@ static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
 
 /**
  * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
- * @genpd: PM domait to power off.
+ * @genpd: PM domain to power off.
  *
  * Queue up the execution of pm_genpd_poweroff() unless it's already been done
  * before.
-- 
2.4.1


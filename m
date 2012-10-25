From: Nishanth Menon <nm@ti.com>
Subject: [for-next PATCH 2/2] PM / devfreq: more documentation warning fixes next set
Date: Thu, 25 Oct 2012 18:10:14 -0500
Message-ID: <1351206614-23993-3-git-send-email-nm@ti.com>
References: <1351206614-23993-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55448 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab2JYXKg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Oct 2012 19:10:36 -0400
In-Reply-To: <1351206614-23993-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Rajagopal Venkat <rajagopal.venkat@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>

commit cfd5194aecd08cd8fbfbf1534a0209b95bc6fcdf
(PM / devfreq: Core updates to support devices which can idle)
in Rafael's pm-devfreq-next branch on
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

Patchworks: https://patchwork.kernel.org/patch/1545751/

introduced a kernel documentation warning:
Warning(drivers/devfreq/devfreq.c:289): bad line: 		release its resources.

This is due to lack of '*' at documentation start messing
up poor scripts/kernel-doc 's mind. I suggest squashing
this to original commit given not-yet-upstream status :).

Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cdc3e2d..2f6ad6b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -286,7 +286,7 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 
 /**
  * _remove_devfreq() - Remove devfreq from the devfreq list and
-		release its resources.
+ *			release its resources.
  * @devfreq:	the devfreq struct
  * @skip:	skip calling device_unregister().
  */
-- 
1.7.9.5


From: Nishanth Menon <nm@ti.com>
Subject: [for-next PATCH 1/2] PM / devfreq: more documentation warning fixes
Date: Thu, 25 Oct 2012 18:10:13 -0500
Message-ID: <1351206614-23993-2-git-send-email-nm@ti.com>
References: <1351206614-23993-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43059 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894Ab2JYXKg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Oct 2012 19:10:36 -0400
In-Reply-To: <1351206614-23993-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Rajagopal Venkat <rajagopal.venkat@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>

Commit 34b53237e9ceb141e13e846baed2a282461f4a01
(PM / devfreq: Add suspend and resume apis)
in Rafael's pm-devfreq-next branch on
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

Patchworks: https://patchwork.kernel.org/patch/1545791/

Warning(drivers/devfreq/devfreq.c:436): No description found for parameter 'devfreq'
Warning(drivers/devfreq/devfreq.c:450): No description found for parameter 'devfreq'

Yet again, a missing ':' causes the kernel-doc to cry

Since it is not merged to upstream, I suggest squashing it

Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/devfreq/devfreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 32e9b48..cdc3e2d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -430,7 +430,7 @@ EXPORT_SYMBOL(devfreq_remove_device);
 
 /**
  * devfreq_suspend_device() - Suspend devfreq of a device.
- * @devfreq	the devfreq instance to be suspended
+ * @devfreq:	the devfreq instance to be suspended
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
@@ -444,7 +444,7 @@ EXPORT_SYMBOL(devfreq_suspend_device);
 
 /**
  * devfreq_resume_device() - Resume devfreq of a device.
- * @devfreq	the devfreq instance to be resumed
+ * @devfreq:	the devfreq instance to be resumed
  */
 int devfreq_resume_device(struct devfreq *devfreq)
 {
-- 
1.7.9.5


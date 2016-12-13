From: Chris Diamand <chris.diamand@arm.com>
Subject: [PATCH] PM / devfreq: Don't delete sysfs group twice
Date: Tue, 13 Dec 2016 17:09:36 +0000
Message-ID: <20161213170935.GA4661@e107465-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934947AbcLMRJk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Dec 2016 12:09:40 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Nishanth Menon <nm@ti.com>, Cai Zhiyong <caizhiyong@huawei.com>

The 'userspace' governor adds a sysfs entry, which is removed when
the governor is changed, or the devfreq device is released. However,
when the latter occurs via device_unregister(), device_del() is
called first, which removes the sysfs entries recursively and deletes
the kobject.

This means we get an Oops when the governor calls
sysfs_remove_group() on the deleted kobject. Fix this by explicitly
stopping the governor in devfreq_remove_device(), *before* the
devfreq entry is removed.

Note that we can't just remove the call to sysfs_remove_group() in
the userspace governor, as it's needed for when the governor is
changed to one without a sysfs entry.

Signed-off-by: Chris Diamand <chris.diamand@arm.com>
---
 drivers/devfreq/devfreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 478006b..d8a817c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -622,6 +622,12 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
+	if (devfreq->governor) {
+		devfreq->governor->event_handler(devfreq,
+						 DEVFREQ_GOV_STOP, NULL);
+		devfreq->governor = NULL;
+	}
+
 	device_unregister(&devfreq->dev);
 
 	return 0;
-- 
1.9.1


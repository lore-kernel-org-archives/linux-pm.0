From: chris.diamand@arm.com
Subject: [PATCH v2] PM / devfreq: Don't delete sysfs group twice
Date: Thu, 12 Jan 2017 14:57:41 +0000
Message-ID: <1484233061-22516-1-git-send-email-chris.diamand@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdALO6K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Jan 2017 09:58:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Nishanth Menon <nm@ti.com>, Cai Zhiyong <caizhiyong@huawei.com>, "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>, Chris Diamand <chris.diamand@arm.com>

From: Chris Diamand <chris.diamand@arm.com>

The 'userspace' governor adds a sysfs entry, which is removed when
the governor is changed, or the devfreq device is released. However,
when the latter occurs via device_unregister(), device_del() is
called first, which removes the sysfs entries recursively and deletes
the kobject.

This means we get an Oops when the governor calls
sysfs_remove_group() on the deleted kobject. Fix this by only doing
the call when kobj *hasn't* been kobject_del()'d.

Note that we can't just remove the call to sysfs_remove_group()
entirely - it's needed for when the governor is changed to one which
doesn't need a sysfs entry.

Signed-off-by: Chris Diamand <chris.diamand@arm.com>
---
Hi all - this is a resend of my updated devfreq removal fix.

This takes a different approach to v1, and fixes the issue in the governor
instead. This means reference counting should still work as usual, so anything
which doesn't call devfreq_remove_device() should still work.

Cheers!
Chris

 drivers/devfreq/governor_userspace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 35de6e8..9db4d6f 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -112,7 +112,13 @@ static int userspace_init(struct devfreq *devfreq)
 
 static void userspace_exit(struct devfreq *devfreq)
 {
-	sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
+	/*
+	 * Remove the sysfs entry, unless this is being called after
+	 * device_del(), which should have done this already via kobject_del().
+	 */
+	if (devfreq->dev.kobj.sd)
+		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
+
 	kfree(devfreq->data);
 	devfreq->data = NULL;
 }
-- 
1.9.1


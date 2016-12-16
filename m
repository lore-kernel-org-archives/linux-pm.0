From: Chris Diamand <chris.diamand@arm.com>
Subject: [PATCH v2] PM / devfreq: Don't delete sysfs group twice
Date: Fri, 16 Dec 2016 19:09:47 +0000
Message-ID: <20161216190947.GA5454@e107465-lin.cambridge.arm.com>
References: <CGME20161213171211epcas3p3ed8807883967daca28b7abe211446739@epcas3p3.samsung.com>
 <20161213170935.GA4661@e107465-lin.cambridge.arm.com>
 <5850A286.9080302@samsung.com>
 <5850B30A.20701@samsung.com>
 <420ba56f-70be-0735-ad99-d90dd04113c5@arm.com>
 <172e4f85358b4f4e9206c4a54b5db056@AM4PR0802MB2210.eurprd08.prod.outlook.com>
 <20161214113239.GA10108@e107465-lin.cambridge.arm.com>
 <7a342ead78be4f32a4a37b541fde412b@AM4PR0802MB2210.eurprd08.prod.outlook.com>
 <20161215104147.GA6504@e107465-lin.cambridge.arm.com>
 <f4620f8efbf247119640470ec12810fe@AM4PR0802MB2210.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbcLPTJx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Dec 2016 14:09:53 -0500
Content-Disposition: inline
In-Reply-To: <f4620f8efbf247119640470ec12810fe@AM4PR0802MB2210.eurprd08.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Nishanth Menon <nm@ti.com>, Cai Zhiyong <caizhiyong@huawei.com>, "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>

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
This takes a different approach to v1, and fixes the issue in the governor
instead. This means reference counting should still work as usual, so anything
which doesn't call devfreq_remove_device() should still work.

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


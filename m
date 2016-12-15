From: Chris Diamand <chris.diamand@arm.com>
Subject: Re: [PATCH] PM / devfreq: Don't delete sysfs group twice
Date: Thu, 15 Dec 2016 10:41:47 +0000
Message-ID: <20161215104147.GA6504@e107465-lin.cambridge.arm.com>
References: <CGME20161213171211epcas3p3ed8807883967daca28b7abe211446739@epcas3p3.samsung.com>
 <20161213170935.GA4661@e107465-lin.cambridge.arm.com>
 <5850A286.9080302@samsung.com>
 <5850B30A.20701@samsung.com>
 <420ba56f-70be-0735-ad99-d90dd04113c5@arm.com>
 <172e4f85358b4f4e9206c4a54b5db056@AM4PR0802MB2210.eurprd08.prod.outlook.com>
 <20161214113239.GA10108@e107465-lin.cambridge.arm.com>
 <7a342ead78be4f32a4a37b541fde412b@AM4PR0802MB2210.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755291AbcLOKtQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Dec 2016 05:49:16 -0500
Content-Disposition: inline
In-Reply-To: <7a342ead78be4f32a4a37b541fde412b@AM4PR0802MB2210.eurprd08.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Nishanth Menon <nm@ti.com>, Cai Zhiyong <caizhiyong@huawei.com>, "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>

Hi!

> As you mentioned, it is right to remain this code in _remove_devfreq()
> for other case to unregister devfreq device except for devfreq_remove_device().

Sure, I'll send out another patch with a comment.

Although, if anyone does unregister devfreq without devfreq_remove_device(),
the userspace governor will still be broken.

I wonder if it would be better to fix this in the governor instead, because
this problem only affects things using sysfs entries. Something like this:

--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -112,7 +112,13 @@ out:
 
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

It's a bit uglier, but would fix it in all cases - what do you think?

Cheers,
Chris

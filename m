Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91951C433F5
	for <linux-pm@archiver.kernel.org>; Tue, 29 Mar 2022 09:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiC2JQq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiC2JQp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2022 05:16:45 -0400
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168379BAE9;
        Tue, 29 Mar 2022 02:15:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07702377|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00585561-0.00836691-0.985777;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=kant@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.NFILkml_1648545298;
Received: from sunxibot.allwinnertech.com(mailfrom:kant@allwinnertech.com fp:SMTPD_---.NFILkml_1648545298)
          by smtp.aliyun-inc.com(33.37.68.114);
          Tue, 29 Mar 2022 17:14:59 +0800
From:   Kant Fan <kant@allwinnertech.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: [RESEND] devfreq: governor: Save void *data in the governor userspace
Date:   Tue, 29 Mar 2022 17:14:49 +0800
Message-Id: <20220329091449.105308-1-kant@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The member void *data in the structure devfreq can be overwrite
by governor_userspace. For example:
1. The device driver assigned the devfreq governor to simple_ondemand
by the function devfreq_add_device() and init the devfreq member
void *data to a pointer of a static structure devfreq_simple_ondemand_data
by the function devfreq_add_device().
2. The user changed the devfreq governor to userspace by the command
"echo userspace > /sys/class/devfreq/.../governor".
3. The governor userspace alloced a dynamic memory for the struct
userspace_data and assigend the member void *data of devfreq to
this memory by the function userspace_init().
4. The user changed the devfreq governor back to simple_ondemand
by the command "echo simple_ondemand > /sys/class/devfreq/.../governor".
5. The governor userspace exited and assigned the member void *data
in the structure devfreq to NULL by the function userspace_exit().
6. The governor simple_ondemand fetched the static information of
devfreq_simple_ondemand_data in the function
devfreq_simple_ondemand_func() but the member void *data of devfreq was
assigned to NULL by the function userspace_exit().
7. The information of upthreshold and downdifferential is lost
and the governor simple_ondemand can't work correctly.

The member void *data in the structure devfreq is designed for
a static pointer used in a governor and inited by the function
devfreq_add_device(). So if a governor want to use void *data
to do some other things, it must save void *data in the init()
function and restore void *data in the exit() function.

Signed-off-by: Kant Fan <kant@allwinnertech.com>
---
 drivers/devfreq/governor_userspace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index ab9db7adb3ad..dbbb448dcbcf 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -17,6 +17,7 @@
 struct userspace_data {
 	unsigned long user_frequency;
 	bool valid;
+	void *saved_data;
 };
 
 static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
@@ -91,6 +92,7 @@ static int userspace_init(struct devfreq *devfreq)
 		goto out;
 	}
 	data->valid = false;
+	data->saved_data = devfreq->data;
 	devfreq->data = data;
 
 	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
@@ -100,6 +102,8 @@ static int userspace_init(struct devfreq *devfreq)
 
 static void userspace_exit(struct devfreq *devfreq)
 {
+	struct userspace_data *data = devfreq->data;
+	void *saved_data = data->saved_data;
 	/*
 	 * Remove the sysfs entry, unless this is being called after
 	 * device_del(), which should have done this already via kobject_del().
@@ -108,7 +112,7 @@ static void userspace_exit(struct devfreq *devfreq)
 		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
 
 	kfree(devfreq->data);
-	devfreq->data = NULL;
+	devfreq->data = saved_data;
 }
 
 static int devfreq_userspace_handler(struct devfreq *devfreq,
-- 
2.29.0


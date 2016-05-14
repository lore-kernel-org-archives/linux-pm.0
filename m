From: Caizhiyong <caizhiyong@hisilicon.com>
Subject: [PATCH] devfreq: fix double call put_device
Date: Sat, 14 May 2016 05:45:45 +0000
Message-ID: <C3050A4DBA34F345975765E43127F10F6381E56F@SZXEMA512-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:17571 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcENFtN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 May 2016 01:49:13 -0400
Content-Language: zh-CN
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, lkml <linux-kernel@vger.kernel.org>
Cc: "Wanli (welly)" <welly.wan@hisilicon.com>, Quyaxin <quyaxin@hisilicon.com>, "Wangming (Wonder)" <mingwonder.wang@hisilicon.com>

From: Cai Zhiyong <caizhiyong@huawei.com>
Date: Sat, 14 May 2016 14:13:30 +0800
Subject: [PATCH] devfreq: fix double call put_device

1295  */
1296 void device_unregister(struct device *dev)
1297 {
1298         pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
1299         device_del(dev);
1300         put_device(dev);
1301 }
1302 EXPORT_SYMBOL_GPL(device_unregister);
1303

device_unregister is called put_device, there is no need to call
put_device(&devfreq->dev) again.

Signed-off-by: Cai Zhiyong <caizhiyong@huawei.com>
---
 drivers/devfreq/devfreq.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1d6c803..8de22c0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -621,7 +621,6 @@ int devfreq_remove_device(struct devfreq *devfreq)
 		return -EINVAL;
 
 	device_unregister(&devfreq->dev);
-	put_device(&devfreq->dev);
 
 	return 0;
 }
-- 
1.7.9.5

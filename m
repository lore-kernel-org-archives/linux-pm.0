From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: remove compiler error with module governors (2)
Date: Wed, 28 Nov 2012 10:57:21 +0900
Message-ID: <1354067841-4936-1-git-send-email-myungjoo.ham@samsung.com>
References: <2278739.ton8Zzmpxv@vostro.rjw.lan>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60278 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2K1B5Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Nov 2012 20:57:25 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0ME600AFCDFG8VA0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 28 Nov 2012 10:57:23 +0900 (KST)
Received: from localhost.localdomain ([10.90.51.65])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0ME6009I4DFLZG50@mmp1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 28 Nov 2012 10:57:23 +0900 (KST)
In-reply-to: <2278739.ton8Zzmpxv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: myungjoo.ham@gmail.com, linux-pm@vger.kernel.org, nm@ti.com

Governors compiled as modules may use these functions.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
This patch is also locataed at
git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq for-rafael tags/pull_req_20121128

 drivers/devfreq/devfreq.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 34c00c5..a8f0173 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -235,6 +235,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 }
+EXPORT_SYMBOL(devfreq_monitor_start);
 
 /**
  * devfreq_monitor_stop() - Stop load monitoring of a devfreq instance
@@ -248,6 +249,7 @@ void devfreq_monitor_stop(struct devfreq *devfreq)
 {
 	cancel_delayed_work_sync(&devfreq->work);
 }
+EXPORT_SYMBOL(devfreq_monitor_stop);
 
 /**
  * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq instance
@@ -273,6 +275,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
+EXPORT_SYMBOL(devfreq_monitor_suspend);
 
 /**
  * devfreq_monitor_resume() - Resume load monitoring of a devfreq instance
@@ -297,6 +300,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 out:
 	mutex_unlock(&devfreq->lock);
 }
+EXPORT_SYMBOL(devfreq_monitor_resume);
 
 /**
  * devfreq_interval_update() - Update device devfreq monitoring interval
@@ -343,6 +347,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 out:
 	mutex_unlock(&devfreq->lock);
 }
+EXPORT_SYMBOL(devfreq_interval_update);
 
 /**
  * devfreq_notifier_call() - Notify that the device frequency requirements
-- 
1.7.5.4


From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: remove compiler error when a governor is module
Date: Wed, 21 Nov 2012 17:25:51 +0900
Message-ID: <1353486351-7216-1-git-send-email-myungjoo.ham@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44525 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab2KUIZz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Nov 2012 03:25:55 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDT008VFWQW5ZW0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 21 Nov 2012 17:25:53 +0900 (KST)
Received: from localhost.localdomain ([10.90.51.65])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDT009QNWR3LE40@mmp2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 21 Nov 2012 17:25:53 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, nm@ti.com, myungjoo.ham@gmail.com

With the intruction of patch, eff607fdb1f787da1fedf46ab6e64adc2afd1c5a,
it became possible to include a governor as a module.
Thus the #ifdef statement for a governor should become #if IS_ENABLED.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 include/linux/devfreq.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 235248c..e83ef39 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -192,7 +192,7 @@ extern int devfreq_register_opp_notifier(struct device *dev,
 extern int devfreq_unregister_opp_notifier(struct device *dev,
 					   struct devfreq *devfreq);
 
-#ifdef CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND
+#if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
  * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
  *	and devfreq_add_device
-- 
1.7.5.4


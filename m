Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E43E6DCB
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665413; cv=none; b=oy57D4sRqQ4V2+tXOnguBfbecsGwvzxoBoI8tqW2s9awZQvyw1c4TVnNS1BD217Vca2+2cMWGX2W57hqc+XpLwWu3osye9v9j0NNzRUm7IEum1JoaXmV1cCPaKV0vZRBL8+m0o6He+zOz01aYAzAppbaj5FWN+6zZTT7UZO77gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665413; c=relaxed/simple;
	bh=Hl4W/eJbRh1Kfit5HrCYID2NYVWyabLoGKNHob3NJiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rf7/Luwt7ehxUMOGxCwCCQOUCP7kmT3gVuA+4S0VlTUcnRazjemIZapO2i16uGaNuYRWipceF4ajlbEZ6KzfakPAW99bLvrZ+TD0bu40PO4a5aQzdDoax/D47wBGJGpUGP3VhSizT3b3sUru/XyNEc7Rkb7ijaSFlOEgSYzD7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gFpH43NHDz1K96k;
	Wed, 13 May 2026 17:35:44 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 33E2A40563;
	Wed, 13 May 2026 17:43:20 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 17:43:19 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cwchoi00@gmail.com>, <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v2 5/6] devfreq: Get and put module refcount when switching governor
Date: Wed, 13 May 2026 17:38:31 +0800
Message-ID: <20260513093832.1645890-6-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
References: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)

A governor module can be dynamically inserted or removed if compiled as a
kernel module.  'devfreq->governor' would become NULL if the governor
module is removed when it's in use.

To prevent the governor module from being removed (except for force
unload) when it's in use, get and put a refcount of the governor module
when starting and stopping the governor.

As a result, unloading a governor module in use returns an error, e.g.:
  $ cat governor
  performance
  $ rmmod governor_performance
  rmmod: ERROR: Module governor_performance is in use

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e1363ab69173..2ea42325d030 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -345,24 +345,37 @@ static int devfreq_set_governor(struct devfreq *df,
 				 __func__, df->governor->name, ret);
 			return ret;
 		}
+		module_put(old_gov->owner);
 	}
 
 	/* Start the new governor */
+	if (!try_module_get(new_gov->owner)) {
+		df->governor = NULL;
+		return -EINVAL;
+	}
+
 	df->governor = new_gov;
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
+		module_put(new_gov->owner);
 
 		/* Restore previous governor */
 		df->governor = old_gov;
 		if (!df->governor)
 			return ret;
 
+		if (!try_module_get(old_gov->owner)) {
+			df->governor = NULL;
+			return -EINVAL;
+		}
+
 		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 		if (ret) {
 			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
 				__func__, df->governor->name, ret);
+			module_put(old_gov->owner);
 			df->governor = NULL;
 			return ret;
 		}
@@ -1040,9 +1053,11 @@ int devfreq_remove_device(struct devfreq *devfreq)
 
 	devfreq_cooling_unregister(devfreq->cdev);
 
-	if (devfreq->governor)
+	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
+		module_put(devfreq->governor->owner);
+	}
 	device_unregister(&devfreq->dev);
 
 	return 0;
-- 
2.43.0


Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F03B8D40
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528783; cv=none; b=Hd6S9nLLPlNvki5QPQ7vzmpRR5/r3uqY2OLoGuQ69gRuwq5U7UtokS3m9QqsIsEHQgYRjwv5cSfRCJdk/b2hsuhmGceh5AJ/WCNLD/bG68mHPG9ty+MT6AoRyNemBybqonUyyNCiOkqCCHlD11J1aL+N0xjTGDNS9jEgmULvAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528783; c=relaxed/simple;
	bh=l6sttMBYQs3t9cbWL5myUOmgFLFHda5k/B0WdD3I/Ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFuzGUGh8PkNR4kdekXZ52pgDR4l555FGkbxb1Wm4EmxligrTAidYBxSqDduhcTiBwnPUOjrgfV43yNMPYUtzk5LIaTBVVo87ksqzvHEV5tOfzoV4n+k3KHZ2l6NeBe7qxdi36w+p6T2OIYJi1b1GF1PfA9MyjbZ7srS/3kN3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fhNVx38F8z1T4gq;
	Thu, 26 Mar 2026 20:34:01 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F3E840569;
	Thu, 26 Mar 2026 20:39:34 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:39:33 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH v1 07/10] devfreq: Get and put module refcount when switching governor
Date: Thu, 26 Mar 2026 20:34:25 +0800
Message-ID: <20260326123428.800407-8-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326123428.800407-1-zhanjie9@hisilicon.com>
References: <20260326123428.800407-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)

When compiled as a kernel module, the governor module can be dynamically
inserted or removed.  'devfreq->governor' would become NULL if the
governor module is removed when it's in use.

To prevent the governor module from being removed (except for force
unload) when it's in use, get and put a refcount of the governor module
when starting and stopping the governor.

Now, unloading a governor module that is set for a devfreq device
returns an error, for example:
  # cat governor
  performance
  # rmmod governor_performance
  rmmod: ERROR: Module governor_performance is in use

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 9b078458d129..ba09948915ba 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -338,22 +338,31 @@ static int devfreq_set_governor_locked(struct devfreq *df,
 				 __func__, df->governor->name, ret);
 			return ret;
 		}
+		module_put(old_gov->owner);
 	}
 
 	/* Start the new governor */
+	if (!try_module_get(new_gov->owner))
+		return -EINVAL;
+
 	df->governor = new_gov;
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
 
+		module_put(new_gov->owner);
 		if (!old_gov)
 			return ret;
 
 		/* Restore previous governor */
+		if (!try_module_get(old_gov->owner))
+			return -EINVAL;
+
 		df->governor = old_gov;
 		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 		if (ret) {
+			module_put(old_gov->owner);
 			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
 				__func__, old_gov->name, ret);
 			df->governor = NULL;
-- 
2.43.0


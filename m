Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A193F788E
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528777; cv=none; b=I/lisSs8cDcuSYydGyOYHgv9pH1l4BWoVOe/2J1YxG8YKIXIhMyOH9L/88c/M+RvB6AEkgac4J4xcLSefds7nycd8h3OaEXph7OhajpUzPgttkLKi1rh8wQz5EHT+zKYYd1/eB1pczTwbEkdITxVb5JW2R9PvLJHDIv+slMVJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528777; c=relaxed/simple;
	bh=X69WGbiNAsxMMDNTkzEcrQn5MZ+1hLdH9tWLO9/Wq+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYl6FwlCognx9DhNdWnEwlJHGgUfv3Fl+TUi7vQiG0sfQZKxd6+EJwy3M68a1K3PL5Auo7OSjEodOWGB93931eEFmQthOSKbooTxs7PoEfmOT4mAUGUmaEG3YxiCCR7T3fOl9rgV5c23rdxjP2u/MkWu8ViiWlD6xP3DTIthA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fhNVH0K1TzRhQP;
	Thu, 26 Mar 2026 20:33:27 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D6CC40537;
	Thu, 26 Mar 2026 20:39:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:39:32 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH v1 05/10] devfreq: Remove dead code in devfreq_add_governor()
Date: Thu, 26 Mar 2026 20:34:23 +0800
Message-ID: <20260326123428.800407-6-zhanjie9@hisilicon.com>
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

In devfreq_add_governor(), we've already checked the governor list to
see if there's a governor already registered with the same name.

It's impossible that a devfreq device is using such a governor, so the
check can never be true and the error handling is unreachable.

Remove the redundant error handling to simplify the logic.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 378a01f71165..7e71e8c76303 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1300,7 +1300,6 @@ void devfreq_resume(void)
 int devfreq_add_governor(struct devfreq_governor *governor)
 {
 	struct devfreq_governor *g;
-	struct devfreq *devfreq;
 
 	if (!governor) {
 		pr_err("%s: Invalid parameters.\n", __func__);
@@ -1317,39 +1316,6 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 	scoped_guard(mutex, &devfreq_gov_lock)
 		list_add(&governor->node, &devfreq_governor_list);
 
-	guard(mutex)(&devfreq_list_lock);
-	list_for_each_entry(devfreq, &devfreq_list, node) {
-		int ret = 0;
-		struct device *dev = devfreq->dev.parent;
-
-		if (!strncmp(devfreq->governor->name, governor->name,
-			     DEVFREQ_NAME_LEN)) {
-			/* The following should never occur */
-			if (devfreq->governor) {
-				dev_warn(dev,
-					 "%s: Governor %s already present\n",
-					 __func__, devfreq->governor->name);
-				ret = devfreq->governor->event_handler(devfreq,
-							DEVFREQ_GOV_STOP, NULL);
-				if (ret) {
-					dev_warn(dev,
-						 "%s: Governor %s stop = %d\n",
-						 __func__,
-						 devfreq->governor->name, ret);
-				}
-				/* Fall through */
-			}
-			devfreq->governor = governor;
-			ret = devfreq->governor->event_handler(devfreq,
-						DEVFREQ_GOV_START, NULL);
-			if (ret) {
-				dev_warn(dev, "%s: Governor %s start=%d\n",
-					 __func__, devfreq->governor->name,
-					 ret);
-			}
-		}
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL(devfreq_add_governor);
-- 
2.43.0


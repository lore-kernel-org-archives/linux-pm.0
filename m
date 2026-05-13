Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D13EE1E6
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665426; cv=none; b=oD9s7ghzjmq7b1MnIo+0ed4O7EZtxKZkhpfThGAE7+++XQwlWW9Bd2G+lsySYOD1KJ6qv9ckeSSMB47eWF46lR9QAO8w+gKOYTlhlDU9g4IngVc+04L7y2Ht2qcAbOZjo1GQSkDDSox4DXwQg6aMATWal4UWTRTrpXGk4SHPpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665426; c=relaxed/simple;
	bh=Jndg6kP4pQ99+4jnPAC/srFvulY4X0TO/16yMpYCpKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STd2kygI7wzVzmB771igJGZL6csMn0Xb568Y34ATSjI0txuLGnWlYgNEOEgiuPCDtFKfJmWsRcb8uhM44rWP7uH9jXtvbqABDm1zjubonmsND6TAvZSWPqEkNmXRWnnMvuNRqjx8FHl7le6cZnZknto3zNY4Vnh01RhrPIOFYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gFpRQ343Mz1BFMY
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:42:58 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gFpGx3TYQz1T4Fh;
	Wed, 13 May 2026 17:35:37 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id D2A43202E6;
	Wed, 13 May 2026 17:43:18 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 17:43:18 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cwchoi00@gmail.com>, <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v2 2/6] devfreq: Use mutex guard in devfreq_add/remove_governor()
Date: Wed, 13 May 2026 17:38:28 +0800
Message-ID: <20260513093832.1645890-3-zhanjie9@hisilicon.com>
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

Use mutex guard in devfreq_add/remove_governor() so as to simplify the
locking logic.

No functional impact intended.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7a70dd051644..53c40d795a13 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1261,28 +1261,23 @@ void devfreq_resume(void)
 int devfreq_add_governor(struct devfreq_governor *governor)
 {
 	struct devfreq_governor *g;
-	int err = 0;
 
 	if (!governor) {
 		pr_err("%s: Invalid parameters.\n", __func__);
 		return -EINVAL;
 	}
 
-	mutex_lock(&devfreq_list_lock);
+	guard(mutex)(&devfreq_list_lock);
 	g = find_devfreq_governor(governor->name);
 	if (!IS_ERR(g)) {
 		pr_err("%s: governor %s already registered\n", __func__,
 		       g->name);
-		err = -EINVAL;
-		goto err_out;
+		return -EINVAL;
 	}
 
 	list_add(&governor->node, &devfreq_governor_list);
 
-err_out:
-	mutex_unlock(&devfreq_list_lock);
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_add_governor);
 
@@ -1320,21 +1315,20 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 {
 	struct devfreq_governor *g;
 	struct devfreq *devfreq;
-	int err = 0;
 
 	if (!governor) {
 		pr_err("%s: Invalid parameters.\n", __func__);
 		return -EINVAL;
 	}
 
-	mutex_lock(&devfreq_list_lock);
+	guard(mutex)(&devfreq_list_lock);
 	g = find_devfreq_governor(governor->name);
 	if (IS_ERR(g)) {
 		pr_err("%s: governor %s not registered\n", __func__,
 		       governor->name);
-		err = PTR_ERR(g);
-		goto err_out;
+		return PTR_ERR(g);
 	}
+
 	list_for_each_entry(devfreq, &devfreq_list, node) {
 		int ret;
 		struct device *dev = devfreq->dev.parent;
@@ -1356,10 +1350,8 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 	}
 
 	list_del(&governor->node);
-err_out:
-	mutex_unlock(&devfreq_list_lock);
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_remove_governor);
 
-- 
2.43.0


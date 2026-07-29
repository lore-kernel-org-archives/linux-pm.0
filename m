Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1774446E6
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321061; cv=none; b=fCS/ZVUQdkQ3iVbZuTEv9n4Jj5V1l3rm8hD7glmY58cEnA81URRTOPSaxlsERdRd2Wm8eHWo1oSgLAIqNn30M4LRxFd+mtxlIUwskQxC9ucmowdqsFtE2sZg8SY1ajcJrtDx3hKrIXlCRkjZj+pFk4WPbJFBa6g3E/ISzY9Hj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321061; c=relaxed/simple;
	bh=QEcwuF+2Mf9bs4d/80X+a02PgKRKo3cQONv0ynLyX/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYkDp9KizjfJGc3G/vH3titFsVUoHGCikXMmo3D1BPuyRWQABPjKPPSAiYbLx4uBu1syz3MMnkQijvtuhtsPrLRlGWtKrKYbRb1Xpm/rTMKBnqnxSVtV1JRzoDUXSkStJhzTYMEzwg3NNGp8MZdW+Zb745jiRrgud2NF5m5eyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h97fC5fn2z1T4JN;
	Wed, 29 Jul 2026 18:21:23 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C694203C1;
	Wed, 29 Jul 2026 18:30:54 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Jul 2026 18:30:53 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cwchoi00@gmail.com>, <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v4 1/4] devfreq: Use mutex guard in governor_store()
Date: Wed, 29 Jul 2026 18:23:45 +0800
Message-ID: <20260729102348.3857779-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729102348.3857779-1-zhanjie9@hisilicon.com>
References: <20260729102348.3857779-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Use mutex guard in governor_store() so as to simplify the locking logic.

No functional impact intended.

Reviewed-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f08fc6966eae..7a70dd051644 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1394,23 +1394,20 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&devfreq_list_lock);
+	guard(mutex)(&devfreq_list_lock);
 	governor = try_then_request_governor(str_governor);
-	if (IS_ERR(governor)) {
-		ret = PTR_ERR(governor);
-		goto out;
-	}
+	if (IS_ERR(governor))
+		return PTR_ERR(governor);
+
 	if (!df->governor)
 		goto start_new_governor;
 
-	if (df->governor == governor) {
-		ret = 0;
-		goto out;
-	} else if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)
-		|| IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (df->governor == governor)
+		return count;
+
+	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE) ||
+	    IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE))
+		return -EINVAL;
 
 	/*
 	 * Stop the current governor and remove the specific sysfs files
@@ -1420,7 +1417,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
 			 __func__, df->governor->name, ret);
-		goto out;
+		return ret;
 	}
 
 start_new_governor:
@@ -1438,7 +1435,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		/* Restore previous governor */
 		df->governor = prev_governor;
 		if (!df->governor)
-			goto out;
+			return ret;
 
 		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 		if (ret) {
@@ -1446,7 +1443,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 				"%s: reverting to Governor %s failed (%d)\n",
 				__func__, prev_governor->name, ret);
 			df->governor = NULL;
-			goto out;
+			return ret;
 		}
 	}
 
@@ -1455,13 +1452,10 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	 * the new governor, restore the sysfs files of previous governor.
 	 */
 	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
+	if (ret)
+		return ret;
 
-out:
-	mutex_unlock(&devfreq_list_lock);
-
-	if (!ret)
-		ret = count;
-	return ret;
+	return count;
 }
 static DEVICE_ATTR_RW(governor);
 
-- 
2.43.0


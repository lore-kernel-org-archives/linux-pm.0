Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5C396B78
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528792; cv=none; b=JhKYLkm4ELGuLQVHtTkJ78az0ppnjaZSK9FbQ2Vgv1/lfn/Eurw3TPD+yz0VpdoePjW4xKP026xb16n9/opL9XmT57PfxrK4KwXSmQRkiV9rs+tJ27QlH9nBScGQpolU7AbCcPRaxmgmKpQAfYVpYpQKZXHRHkEF0iVT7ycrz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528792; c=relaxed/simple;
	bh=a0ZiqY95fjkC3CVtLoc4L3/vJi95DVBc2DcNNiOh5UA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLApAcYmMEDtNFTyPp55D+Vs6D70XsBCOfHBb2b3hkY8wNSUPf8T+bAGveL1sqbaILJJ8U9RS06d8u+Wi4FQl5FTvhjRvHJrfNvdiYJZQCi//5IpzwuGzH4jKWK/GfAV/pcv1xN19f3TZRfuBjE7FYzaC4QK0PjZGG0nFyAduro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fhNVC5nLPz1prKM;
	Thu, 26 Mar 2026 20:33:23 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id DA90640569;
	Thu, 26 Mar 2026 20:39:32 +0800 (CST)
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
Subject: [PATCH v1 04/10] devfreq: Factor out devfreq_set_governor[_locked]()
Date: Thu, 26 Mar 2026 20:34:22 +0800
Message-ID: <20260326123428.800407-5-zhanjie9@hisilicon.com>
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

Factor out common governor setting logic into devfreq_set_governor() to
reduce code duplication in governor_store() and devfreq_add_device().

Additionally, devfreq_set_governor_locked() is used when
'devfreq_list_lock' is already held by the caller, e.g. in
devfreq_set_governor(), to avoid an immediate relock after unlock.

Note that the new functions support setting a governor even if
devfreq->governor is NULL.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 129 +++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 66 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e54e3092e0e0..378a01f71165 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -313,6 +313,64 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 	return governor;
 }
 
+static int devfreq_set_governor_locked(struct devfreq *df,
+				       const struct devfreq_governor *new_gov)
+{
+	const struct devfreq_governor *old_gov;
+	struct device *dev;
+	int ret;
+
+	old_gov = df->governor;
+	dev = &df->dev;
+
+	if (old_gov) {
+		if (old_gov == new_gov)
+			return 0;
+
+		if (IS_SUPPORTED_FLAG(old_gov->flags, IMMUTABLE) ||
+		    IS_SUPPORTED_FLAG(new_gov->flags, IMMUTABLE))
+			return -EINVAL;
+
+		/* Stop the current governor */
+		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
+		if (ret) {
+			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
+				 __func__, df->governor->name, ret);
+			return ret;
+		}
+	}
+
+	/* Start the new governor */
+	df->governor = new_gov;
+	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+	if (ret) {
+		dev_warn(dev, "%s: Governor %s not started(%d)\n",
+			 __func__, df->governor->name, ret);
+
+		if (!old_gov)
+			return ret;
+
+		/* Restore previous governor */
+		df->governor = old_gov;
+		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+		if (ret) {
+			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
+				__func__, old_gov->name, ret);
+			df->governor = NULL;
+			return ret;
+		}
+	}
+
+	return sysfs_update_group(&df->dev.kobj, &gov_attr_group);
+}
+
+static int devfreq_set_governor(struct devfreq *df,
+				const struct devfreq_governor *new_gov)
+{
+	guard(mutex)(&devfreq_list_lock);
+	return devfreq_set_governor_locked(df, new_gov);
+}
+
 static int devfreq_notify_transition(struct devfreq *devfreq,
 		struct devfreq_freqs *freqs, unsigned int state)
 {
@@ -936,22 +994,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	mutex_lock(&devfreq_list_lock);
-	devfreq->governor = governor;
-	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
-						NULL);
-	if (err) {
-		dev_err_probe(dev, err,
-			"%s: Unable to start governor for the device\n",
-			 __func__);
-		goto err_init;
-	}
-
-	err = sysfs_update_group(&devfreq->dev.kobj, &gov_attr_group);
+	err = devfreq_set_governor_locked(devfreq, governor);
 	if (err)
-		goto err_init;
+		goto err_devfreq;
 
 	list_add(&devfreq->node, &devfreq_list);
-
 	mutex_unlock(&devfreq_list_lock);
 
 	if (devfreq->profile->is_cooling_device) {
@@ -962,8 +1009,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	return devfreq;
 
-err_init:
-	mutex_unlock(&devfreq_list_lock);
 err_devfreq:
 	devfreq_remove_device(devfreq);
 	devfreq = NULL;
@@ -1409,7 +1454,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
-	const struct devfreq_governor *governor, *prev_governor;
+	const struct devfreq_governor *governor;
 
 	if (!df->governor)
 		return -EINVAL;
@@ -1422,57 +1467,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (IS_ERR(governor))
 		return PTR_ERR(governor);
 
-	guard(mutex)(&devfreq_list_lock);
-	if (df->governor == governor)
-		return count;
-
-	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE) ||
-	    IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE))
-		return -EINVAL;
-
-	/*
-	 * Stop the current governor and remove the specific sysfs files
-	 * which depend on current governor.
-	 */
-	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
-	if (ret) {
-		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
-			 __func__, df->governor->name, ret);
-		return ret;
-	}
-
-	/*
-	 * Start the new governor and create the specific sysfs files
-	 * which depend on the new governor.
-	 */
-	prev_governor = df->governor;
-	df->governor = governor;
-	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
-	if (ret) {
-		dev_warn(dev, "%s: Governor %s not started(%d)\n",
-			 __func__, df->governor->name, ret);
-
-		/* Restore previous governor */
-		df->governor = prev_governor;
-		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
-		if (ret) {
-			dev_err(dev,
-				"%s: reverting to Governor %s failed (%d)\n",
-				__func__, prev_governor->name, ret);
-			df->governor = NULL;
-			return ret;
-		}
-	}
-
-	/*
-	 * Create the sysfs files for the new governor. But if failed to start
-	 * the new governor, restore the sysfs files of previous governor.
-	 */
-	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
-	if (ret)
-		return ret;
+	ret = devfreq_set_governor(df, governor);
 
-	return count;
+	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(governor);
 
-- 
2.43.0


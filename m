Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CCC3E6DF4
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665412; cv=none; b=STvInr4QCMboCTEMKAJYY7HFOTVjzQru3slibuy9NB25FLEiQg9sHgZ2RfPHcUNGPpWoCsYMyJb5j7F66iT9x7c0vLjS9q56Q7ZCqrrNS3E+Iey0W573MrbUkSSbI9PiBfyYQO+U1+JghVfy9Y4O1N52roA6X6IZaOyYhH6Bskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665412; c=relaxed/simple;
	bh=T1mmkGYzSNpQbW4UWjAqNIBuMcqPk/84MPbsIgKZXsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Evd4tgjRBAfbEwe/g1VMyBKjIadilr5ery9c781cTRjFzPYSNDd+LHli/cLgTN10UyrEGiICeBURpT18Mcolusce66uotUj0/RIPb28aXDie+m75st2+0ccscnnsOgJzPsRpTWNXzs6l3j6RK3ncAA0KgKW5Grg8dmhAwOexGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gFpH23v1fzRhSP;
	Wed, 13 May 2026 17:35:42 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C07A40577;
	Wed, 13 May 2026 17:43:19 +0800 (CST)
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
Subject: [PATCH v2 3/6] devfreq: Factor out devfreq_set_governor()
Date: Wed, 13 May 2026 17:38:29 +0800
Message-ID: <20260513093832.1645890-4-zhanjie9@hisilicon.com>
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

Factor out common governor setting logic into devfreq_set_governor() so as
to consolidate the code in governor_store() and devfreq_add_device().

The caller is expected to hold 'devfreq_list_lock', enforced via
lockdep_assert_held().  This is required because devfreq_add_device() must
hold the lock from setting governor until the device is added to
'devfreq_list', so that a concurrent devfreq_remove_governor() cannot free
the governor in between.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 117 ++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 61 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 53c40d795a13..9e3e6a7348f8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -318,6 +318,59 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 	return governor;
 }
 
+static int devfreq_set_governor(struct devfreq *df,
+				const struct devfreq_governor *new_gov)
+{
+	const struct devfreq_governor *old_gov;
+	struct device *dev;
+	int ret;
+
+	lockdep_assert_held(&devfreq_list_lock);
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
+		/* Restore previous governor */
+		df->governor = old_gov;
+		if (!df->governor)
+			return ret;
+
+		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+		if (ret) {
+			dev_err(dev, "%s: restore Governor %s failed (%d)\n",
+				__func__, df->governor->name, ret);
+			df->governor = NULL;
+			return ret;
+		}
+	}
+
+	return sysfs_update_group(&df->dev.kobj, &gov_attr_group);
+}
+
 static int devfreq_notify_transition(struct devfreq *devfreq,
 		struct devfreq_freqs *freqs, unsigned int state)
 {
@@ -942,9 +995,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
-	devfreq->governor = governor;
-	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
-						NULL);
+	err = devfreq_set_governor(devfreq, governor);
 	if (err) {
 		dev_err_probe(dev, err,
 			"%s: Unable to start governor for the device\n",
@@ -952,10 +1003,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
-	err = sysfs_update_group(&devfreq->dev.kobj, &gov_attr_group);
-	if (err)
-		goto err_init;
-
 	list_add(&devfreq->node, &devfreq_list);
 
 	mutex_unlock(&devfreq_list_lock);
@@ -1380,7 +1427,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
-	const struct devfreq_governor *governor, *prev_governor;
+	const struct devfreq_governor *governor;
 
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
@@ -1391,59 +1438,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (IS_ERR(governor))
 		return PTR_ERR(governor);
 
-	if (!df->governor)
-		goto start_new_governor;
-
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
-start_new_governor:
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
-		if (!df->governor)
-			return ret;
-
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
+	ret = devfreq_set_governor(df, governor);
 	if (ret)
 		return ret;
 
-- 
2.43.0


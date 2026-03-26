Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB931714B
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528783; cv=none; b=NKcYx/mVlM6TtwHKuTkN1oLU5jBd/dQ+bkJ6coIePSnwITUnINRzBaj4LBpPSC1EA/VHiTTttuFZsSIcufSlRz/thsiImpG6NPJlXZXkKBk7XCjjWFCHjUMRROYmaJGNNam8vuEHW2CD5R3BHDkzuCqJYUvj5bATKIB9Zsnqd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528783; c=relaxed/simple;
	bh=YqMF2fZCTmjS2j04Q+l69hR2e0bF9VmX0CzVTS1eNaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcBKHfvRTudNmEN9yONIdzgztEPeX2BmhP10ghZLOUw5epgChXr0U/G2cXgAs7mjVuTbWpnAyVSMhvZaF3xmAr5IQ2JkvcqPyzTPvLQgQVx30yYtT0jLUSKNOC0kr60j29e7w4wXSgW7IukuClZ+4QgvA5hPqky9iX6YFGgSpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fhNVX4fHGzcb1r;
	Thu, 26 Mar 2026 20:33:40 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 88EB840567;
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
Subject: [PATCH v1 08/10] devfreq: Allow find_devfreq_governor() to get module refcount
Date: Thu, 26 Mar 2026 20:34:26 +0800
Message-ID: <20260326123428.800407-9-zhanjie9@hisilicon.com>
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

Add a 'get' parameter for find_devfreq_governor() to optionally get a
refcount of the governor module.

Getting refcount in try_then_request_governor() prevents the governor
module from being removed during the governor setting phase.

However, in devfreq_add/remove_governor(), it doesn't need to get a
refcount of the governor module because it just checks whether a
governor registered with the same name exists or not.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ba09948915ba..c6b670b8fd22 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -254,11 +254,13 @@ EXPORT_SYMBOL(devfreq_update_status);
 /**
  * find_devfreq_governor() - find devfreq governor from name
  * @name:	name of the governor
+ * @get:	whether to get a refcount of the governor module
  *
  * Search the list of devfreq governors and return the matched
  * governor's pointer.
  */
-static struct devfreq_governor *find_devfreq_governor(const char *name)
+static struct devfreq_governor *find_devfreq_governor(const char *name,
+						      bool get)
 {
 	struct devfreq_governor *tmp_governor;
 
@@ -269,8 +271,13 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
 
 	guard(mutex)(&devfreq_gov_lock);
 	list_for_each_entry(tmp_governor, &devfreq_governor_list, node) {
-		if (!strncmp(tmp_governor->name, name, DEVFREQ_NAME_LEN))
-			return tmp_governor;
+		if (strncmp(tmp_governor->name, name, DEVFREQ_NAME_LEN))
+			continue;
+
+		if (get && !try_module_get(tmp_governor->owner))
+			return ERR_PTR(-EBUSY);
+
+		return tmp_governor;
 	}
 
 	return ERR_PTR(-ENODEV);
@@ -285,6 +292,9 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
  * if is not found. This can happen when both drivers (the governor driver
  * and the driver that call devfreq_add_device) are built as modules.
  * Returns the matched governor's pointer or an error pointer.
+ * On success, this holds a refcount of the governor module to prevent the
+ * module from being unloaded during usage, so the caller should put a module
+ * refcount after using it.
  */
 static struct devfreq_governor *try_then_request_governor(const char *name)
 {
@@ -296,7 +306,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		return ERR_PTR(-EINVAL);
 	}
 
-	governor = find_devfreq_governor(name);
+	governor = find_devfreq_governor(name, true);
 	if (IS_ERR(governor)) {
 		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
 			     DEVFREQ_NAME_LEN))
@@ -307,7 +317,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		if (err)
 			return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL);
 
-		governor = find_devfreq_governor(name);
+		governor = find_devfreq_governor(name, true);
 	}
 
 	return governor;
@@ -1007,6 +1017,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (err)
 		goto err_devfreq;
 
+	module_put(governor->owner);
+
 	list_add(&devfreq->node, &devfreq_list);
 	mutex_unlock(&devfreq_list_lock);
 
@@ -1312,7 +1324,7 @@ int __devfreq_add_governor(struct devfreq_governor *governor,
 		return -EINVAL;
 	}
 
-	g = find_devfreq_governor(governor->name);
+	g = find_devfreq_governor(governor->name, false);
 	if (!IS_ERR(g)) {
 		pr_err("%s: governor %s already registered\n", __func__,
 		       g->name);
@@ -1361,7 +1373,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		return -EINVAL;
 	}
 
-	g = find_devfreq_governor(governor->name);
+	g = find_devfreq_governor(governor->name, false);
 	if (IS_ERR(g)) {
 		pr_err("%s: governor %s not registered\n", __func__,
 		       governor->name);
@@ -1436,6 +1448,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 
 	ret = devfreq_set_governor(df, governor);
 
+	module_put(governor->owner);
+
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(governor);
-- 
2.43.0


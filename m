Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052D2D1303
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528777; cv=none; b=EA+tO+96H6kmyNYXb0oUSwqyIvtGtZR/VXwEwYV6m7s0hblfnCBCIZySWLJEfZWPNiTZ3v3XT3yfiiqUmmDQy4OFR4nAwdMHh3rrMeCBDKJ9ZGR1XfVw9R9Kv79hHdGheo1pTycoXXBop3qYBRqB3oN3IW+xEZY0AT8eHJ0XApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528777; c=relaxed/simple;
	bh=+u5GML3jep5PZqA2ab7p9OEdE+59Adw0fK9Tr+9IPEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TESYOwW9yK/uUsrmNal7n3a8ZyqcG2YdhUq8u0LE9BSrOx06EW+HNZJpWDcQRc17zgp3NZ+nT1rdq8WQdGWChnfwPBd4iMuGIAJhbO4gsYUsZraFJGE8HJIhuq3YTdlIAnyu8ykaXfhJaqTCK6LmhGWohcNEyG7fXmSVNqgKkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fhNVH0SyszLlt4;
	Thu, 26 Mar 2026 20:33:27 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 823D74056C;
	Thu, 26 Mar 2026 20:39:32 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:39:31 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH v1 03/10] devfreq: Add a dedicated mutex for the governor list
Date: Thu, 26 Mar 2026 20:34:21 +0800
Message-ID: <20260326123428.800407-4-zhanjie9@hisilicon.com>
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

Accessing the list of available governors ('devfreq_governor_list') is
currently guarded by 'devfreq_list_lock', but 'devfreq_list_lock' is
supposed to protect the list of devfreq devices ('devfreq_list').

The scope of 'devfreq_list_lock' is too broad to maintain.
'devfreq_governor_list' should have its own mutex lock rather than share
with 'devfreq_list'.

Add a governor mutex lock and lock it when accessing the governor list.
Remove locking of 'devfreq_list_lock' around 'devfreq_governor_list'.

This is also a preparation for further refactoring around
try_then_request_governor().

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 83f75dc21c99..e54e3092e0e0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -49,6 +49,7 @@ static struct workqueue_struct *devfreq_wq;
 
 /* The list of all device-devfreq governors */
 static LIST_HEAD(devfreq_governor_list);
+static DEFINE_MUTEX(devfreq_gov_lock);
 /* The list of all device-devfreq */
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
@@ -255,19 +256,18 @@ EXPORT_SYMBOL(devfreq_update_status);
  * @name:	name of the governor
  *
  * Search the list of devfreq governors and return the matched
- * governor's pointer. devfreq_list_lock should be held by the caller.
+ * governor's pointer.
  */
 static struct devfreq_governor *find_devfreq_governor(const char *name)
 {
 	struct devfreq_governor *tmp_governor;
 
-	lockdep_assert_held(&devfreq_list_lock);
-
 	if (IS_ERR_OR_NULL(name)) {
 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
+	guard(mutex)(&devfreq_gov_lock);
 	list_for_each_entry(tmp_governor, &devfreq_governor_list, node) {
 		if (!strncmp(tmp_governor->name, name, DEVFREQ_NAME_LEN))
 			return tmp_governor;
@@ -284,16 +284,13 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
  * Search the list of devfreq governors and request the module and try again
  * if is not found. This can happen when both drivers (the governor driver
  * and the driver that call devfreq_add_device) are built as modules.
- * devfreq_list_lock should be held by the caller. Returns the matched
- * governor's pointer or an error pointer.
+ * Returns the matched governor's pointer or an error pointer.
  */
 static struct devfreq_governor *try_then_request_governor(const char *name)
 {
 	struct devfreq_governor *governor;
 	int err = 0;
 
-	lockdep_assert_held(&devfreq_list_lock);
-
 	if (IS_ERR_OR_NULL(name)) {
 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
@@ -301,15 +298,12 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 
 	governor = find_devfreq_governor(name);
 	if (IS_ERR(governor)) {
-		mutex_unlock(&devfreq_list_lock);
-
 		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
 			     DEVFREQ_NAME_LEN))
 			err = request_module("governor_%s", "simpleondemand");
 		else
 			err = request_module("governor_%s", name);
 		/* Restore previous state before return */
-		mutex_lock(&devfreq_list_lock);
 		if (err)
 			return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL);
 
@@ -933,16 +927,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (err)
 		goto err_devfreq;
 
-	mutex_lock(&devfreq_list_lock);
-
 	governor = try_then_request_governor(governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
 			__func__);
 		err = PTR_ERR(governor);
-		goto err_init;
+		goto err_devfreq;
 	}
 
+	mutex_lock(&devfreq_list_lock);
 	devfreq->governor = governor;
 	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
 						NULL);
@@ -1269,7 +1262,6 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 		return -EINVAL;
 	}
 
-	guard(mutex)(&devfreq_list_lock);
 	g = find_devfreq_governor(governor->name);
 	if (!IS_ERR(g)) {
 		pr_err("%s: governor %s already registered\n", __func__,
@@ -1277,8 +1269,10 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 		return -EINVAL;
 	}
 
-	list_add(&governor->node, &devfreq_governor_list);
+	scoped_guard(mutex, &devfreq_gov_lock)
+		list_add(&governor->node, &devfreq_governor_list);
 
+	guard(mutex)(&devfreq_list_lock);
 	list_for_each_entry(devfreq, &devfreq_list, node) {
 		int ret = 0;
 		struct device *dev = devfreq->dev.parent;
@@ -1355,7 +1349,6 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		return -EINVAL;
 	}
 
-	guard(mutex)(&devfreq_list_lock);
 	g = find_devfreq_governor(governor->name);
 	if (IS_ERR(g)) {
 		pr_err("%s: governor %s not registered\n", __func__,
@@ -1363,6 +1356,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		return PTR_ERR(g);
 	}
 
+	guard(mutex)(&devfreq_list_lock);
 	list_for_each_entry(devfreq, &devfreq_list, node) {
 		int ret;
 		struct device *dev = devfreq->dev.parent;
@@ -1383,7 +1377,8 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		}
 	}
 
-	list_del(&governor->node);
+	scoped_guard(mutex, &devfreq_gov_lock)
+		list_del(&governor->node);
 
 	return 0;
 }
@@ -1423,11 +1418,11 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret != 1)
 		return -EINVAL;
 
-	guard(mutex)(&devfreq_list_lock);
 	governor = try_then_request_governor(str_governor);
 	if (IS_ERR(governor))
 		return PTR_ERR(governor);
 
+	guard(mutex)(&devfreq_list_lock);
 	if (df->governor == governor)
 		return count;
 
-- 
2.43.0


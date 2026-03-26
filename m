Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003553CEB95
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528778; cv=none; b=Zhc/iyzksnFvBzyHwpT1wEnUTCdWa5AAvPDbyIzKmdhWNYNNA3jgMxhXUi9VIE7Uyh2cj0c6RrPqFE8xHpFhd3wKWFvcVGBXMyRwAShsnvQ5T9fGv/PunLCeXNmDnwkU5JUu6tq09WRU2VLTKcmBXa20s1DXoE+aW9GxiFH3+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528778; c=relaxed/simple;
	bh=sL/swqhLtdhes32IjZRH4Y93hd6v7rdiNaYIl5rQkAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExjhOUDhfXdEskfqgZmYpvg+uqqDYn3/4DxLSyqAD8jRok3tXYaMGBXZKP1XX65VK/m1MiSBjgyKokENKbBDP4x2S4G/B2+617/yEnWdJ6SSCcTHemDMIFglNhYibcr3YJC4kxP7l2e/mzBBEy4ngflVWPFranJx4IGmyE6WfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fhNVG0Z0JzmV8X;
	Thu, 26 Mar 2026 20:33:26 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id BDB5540565;
	Thu, 26 Mar 2026 20:39:33 +0800 (CST)
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
Subject: [PATCH v1 06/10] devfreq: Add module owner to devfreq governor
Date: Thu, 26 Mar 2026 20:34:24 +0800
Message-ID: <20260326123428.800407-7-zhanjie9@hisilicon.com>
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

Add an 'owner' member to struct devfreq_governor, such that we can find
the module that holds the governor code when it's compiled as a kernel
module.  This allows the devfreq core to properly manage the lifecycle
of governors.

Update devfreq_add_governor() and devm_devfreq_add_governor() to
automatically set 'owner' to THIS_MODULE via helper macros.

This is a prerequisite for implementing governor reference counting
to prevent module unloading while a governor is in use.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c        | 26 +++++++++-----------------
 include/linux/devfreq-governor.h | 26 +++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7e71e8c76303..9b078458d129 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1293,11 +1293,8 @@ void devfreq_resume(void)
 	mutex_unlock(&devfreq_list_lock);
 }
 
-/**
- * devfreq_add_governor() - Add devfreq governor
- * @governor:	the devfreq governor to be added
- */
-int devfreq_add_governor(struct devfreq_governor *governor)
+int __devfreq_add_governor(struct devfreq_governor *governor,
+			   struct module *mod)
 {
 	struct devfreq_governor *g;
 
@@ -1313,38 +1310,33 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 		return -EINVAL;
 	}
 
+	governor->owner = mod;
 	scoped_guard(mutex, &devfreq_gov_lock)
 		list_add(&governor->node, &devfreq_governor_list);
 
 	return 0;
 }
-EXPORT_SYMBOL(devfreq_add_governor);
+EXPORT_SYMBOL(__devfreq_add_governor);
 
 static void devm_devfreq_remove_governor(void *governor)
 {
 	WARN_ON(devfreq_remove_governor(governor));
 }
 
-/**
- * devm_devfreq_add_governor() - Add devfreq governor
- * @dev:	device which adds devfreq governor
- * @governor:	the devfreq governor to be added
- *
- * This is a resource-managed variant of devfreq_add_governor().
- */
-int devm_devfreq_add_governor(struct device *dev,
-			      struct devfreq_governor *governor)
+int __devm_devfreq_add_governor(struct device *dev,
+				struct devfreq_governor *governor,
+				struct module *mod)
 {
 	int err;
 
-	err = devfreq_add_governor(governor);
+	err = __devfreq_add_governor(governor, mod);
 	if (err)
 		return err;
 
 	return devm_add_action_or_reset(dev, devm_devfreq_remove_governor,
 					governor);
 }
-EXPORT_SYMBOL(devm_devfreq_add_governor);
+EXPORT_SYMBOL(__devm_devfreq_add_governor);
 
 /**
  * devfreq_remove_governor() - Remove devfreq feature from a device.
diff --git a/include/linux/devfreq-governor.h b/include/linux/devfreq-governor.h
index dfdd0160a29f..1c4ff57e24de 100644
--- a/include/linux/devfreq-governor.h
+++ b/include/linux/devfreq-governor.h
@@ -12,6 +12,7 @@
 #define __LINUX_DEVFREQ_DEVFREQ_H__
 
 #include <linux/devfreq.h>
+struct module;
 
 #define DEVFREQ_NAME_LEN			16
 
@@ -50,6 +51,7 @@
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
+ * @owner:		Module that this governor belongs to
  * @name:		Governor's name
  * @attrs:		Governor's sysfs attribute flags
  * @flags:		Governor's feature flags
@@ -67,6 +69,7 @@
 struct devfreq_governor {
 	struct list_head node;
 
+	struct module *owner;
 	const char name[DEVFREQ_NAME_LEN];
 	const u64 attrs;
 	const u64 flags;
@@ -81,11 +84,28 @@ void devfreq_monitor_suspend(struct devfreq *devfreq);
 void devfreq_monitor_resume(struct devfreq *devfreq);
 void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay);
 
-int devfreq_add_governor(struct devfreq_governor *governor);
+/**
+ * devfreq_add_governor() - Add devfreq governor
+ * @governor:	The devfreq governor to be added
+ */
+#define devfreq_add_governor(governor) \
+	__devfreq_add_governor((governor), THIS_MODULE)
+int __devfreq_add_governor(struct devfreq_governor *governor,
+			   struct module *mod);
 int devfreq_remove_governor(struct devfreq_governor *governor);
 
-int devm_devfreq_add_governor(struct device *dev,
-			      struct devfreq_governor *governor);
+/**
+ * devm_devfreq_add_governor() - Add devfreq governor
+ * @dev:	device which adds devfreq governor
+ * @governor:	the devfreq governor to be added
+ *
+ * This is a resource-managed variant of devfreq_add_governor().
+ */
+#define devm_devfreq_add_governor(dev, governor) \
+	__devm_devfreq_add_governor((dev), (governor), THIS_MODULE)
+int __devm_devfreq_add_governor(struct device *dev,
+				struct devfreq_governor *governor,
+				struct module *mod);
 
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
 int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
-- 
2.43.0


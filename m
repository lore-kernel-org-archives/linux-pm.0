Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE653F8EB7
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190666; cv=none; b=VSnS/NVlqHCeSeLbHDilaUR+oE8tA+GNH8JglFaa11o4J6vwB/J0tkOHU0L1ihU6pzqimfbVkXJ2rqnMIJbdivU//7agzA6jZfyWKhVrOOjPjj7lKEJo1HKIWZP6YHCcZ/aLKfCSONnMu6JyUlxqvFLKzQ5BHHaj5jqs4dVMrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190666; c=relaxed/simple;
	bh=g5OYUU3WsFdGyw70fm8EL0I84pjxWFsul7bUbC5P1FQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsaIla2Pk8JmDJ/HFzf2fsL7l6xxgPhLnmTuzM9Zd2J2vuaC99+xr7hygel0OmpANiuhDhtiUrvtdDeAr8CF3HPD2yyo0bSvo102JduQVTBRIuevF7fEYu4Ag5mnXx54h24hntMewXWOZIVHRf6Pl/HFDPmsaJTrzXLjZtmaFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gKXX12xbSz1prLM;
	Tue, 19 May 2026 19:29:53 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id B6EFF2025F;
	Tue, 19 May 2026 19:37:36 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 19:37:35 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cwchoi00@gmail.com>, <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v3 4/4] devfreq: Refcount governor modules while in use
Date: Tue, 19 May 2026 19:32:50 +0800
Message-ID: <20260519113251.3745140-5-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519113251.3745140-1-zhanjie9@hisilicon.com>
References: <20260519113251.3745140-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)

A governor module can be inserted or removed dynamically when built as a
kernel module.  'devfreq->governor' would become NULL if the governor
module is removed when it's in use.

Add a refcount mechanism for governor modules to prevent the governor
module from being removed (except for force unload):
1. Add an optional 'owner' member to struct devfreq_governor so the devfreq
   core can identify the module that holds the governor code.
2. Get and put a refcount of the governor module when starting and stopping
   the governor.

The new 'owner' field is optional:
- Common governor modules (performance, powersave, simple_ondemand,
  userspace, passive) set 'owner' to THIS_MODULE.
- Governors that are bundled into a device driver module must leave 'owner'
  NULL.  The device's lifetime already pins that module, and setting
  'owner' would create a self-reference that blocks the driver from being
  unloaded.

As a result, a non-forced rmmod of an in-use stand-alone governor now
fails with -EBUSY, e.g.:

  $ cat governor
  performance
  $ rmmod governor_performance
  rmmod: ERROR: Module governor_performance is in use

Force unloads (rmmod -f, if configured) can't be blocked.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c                 | 17 ++++++++++++++++-
 drivers/devfreq/governor_passive.c        |  1 +
 drivers/devfreq/governor_performance.c    |  1 +
 drivers/devfreq/governor_powersave.c      |  1 +
 drivers/devfreq/governor_simpleondemand.c |  1 +
 drivers/devfreq/governor_userspace.c      |  1 +
 include/linux/devfreq-governor.h          | 11 +++++++++++
 7 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 9e3e6a7348f8..1cee43636ded 100644
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
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index d7feecd900f1..3e63dd200a04 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -449,6 +449,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 static struct devfreq_governor devfreq_passive = {
 	.name = DEVFREQ_GOV_PASSIVE,
 	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE,
+	.owner = THIS_MODULE,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
 };
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index fdb22bf512cf..0a08b067ea6b 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -37,6 +37,7 @@ static int devfreq_performance_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_performance = {
 	.name = DEVFREQ_GOV_PERFORMANCE,
+	.owner = THIS_MODULE,
 	.get_target_freq = devfreq_performance_func,
 	.event_handler = devfreq_performance_handler,
 };
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index ee2d6ec8a512..3ae296d55e3e 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -37,6 +37,7 @@ static int devfreq_powersave_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_powersave = {
 	.name = DEVFREQ_GOV_POWERSAVE,
+	.owner = THIS_MODULE,
 	.get_target_freq = devfreq_powersave_func,
 	.event_handler = devfreq_powersave_handler,
 };
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ac9c5e9e51a4..46287b279ded 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -119,6 +119,7 @@ static struct devfreq_governor devfreq_simple_ondemand = {
 	.name = DEVFREQ_GOV_SIMPLE_ONDEMAND,
 	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
 		| DEVFREQ_GOV_ATTR_TIMER,
+	.owner = THIS_MODULE,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
 };
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 3906ebedbae8..b1acccc79f7f 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -135,6 +135,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_userspace = {
 	.name = DEVFREQ_GOV_USERSPACE,
+	.owner = THIS_MODULE,
 	.get_target_freq = devfreq_userspace_func,
 	.event_handler = devfreq_userspace_handler,
 };
diff --git a/include/linux/devfreq-governor.h b/include/linux/devfreq-governor.h
index dfdd0160a29f..ae1721e58401 100644
--- a/include/linux/devfreq-governor.h
+++ b/include/linux/devfreq-governor.h
@@ -12,6 +12,7 @@
 #define __LINUX_DEVFREQ_DEVFREQ_H__
 
 #include <linux/devfreq.h>
+struct module;
 
 #define DEVFREQ_NAME_LEN			16
 
@@ -53,6 +54,15 @@
  * @name:		Governor's name
  * @attrs:		Governor's sysfs attribute flags
  * @flags:		Governor's feature flags
+ * @owner:		Optional, module that owns this governor.
+ *			When set (typically to THIS_MODULE), the devfreq core
+ *			takes a reference on @owner while this governor is in
+ *			use so that the governor module cannot be removed,
+ *			except by a forced unload. Governors that are bundled
+ *			into a device driver module must leave @owner NULL: the
+ *			device's lifetime already pins that module, and setting
+ *			@owner would create a self-reference that prevents the
+ *			driver from being unloaded.
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -70,6 +80,7 @@ struct devfreq_governor {
 	const char name[DEVFREQ_NAME_LEN];
 	const u64 attrs;
 	const u64 flags;
+	struct module *owner;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
-- 
2.43.0


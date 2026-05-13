Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979833C4152
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665415; cv=none; b=EJuGWBExPK5s2WEmppBQ33a+inB9JS7uyX0qNbxWM+R7dtC8eUjDNZBSlOXm8U5ZO9bUmmR1n4MQAoUqxUlwC+rVXIvFwejLHPNFS5cloLbocB73mX2qx0vjuJACNBDDyA1Nn50oGtYJaGC4MwwxYQMeuQt9GuiODeN+EWZemx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665415; c=relaxed/simple;
	bh=XUaL+LXCzsptXp3YSV5xxE8dxTl3uHCQraCJbdB2wxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Agax/PkCFOpQ3KTOe33RQjquje2N2+OxiSxXPNfR4YpkT3QtoIVHZCajgg0Qs2FKT+Qwu425o/0NDwD40K6Yf3TCOAilkQDZbB5GseuHBB2F4VBJDIka4wmyaUxQBzqMa02utsIOOVnaOCtw2YhxumdNs9dHcQBmTAA6u4glh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gFpH22ychzmV7R;
	Wed, 13 May 2026 17:35:42 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id A62EC40562;
	Wed, 13 May 2026 17:43:20 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 17:43:20 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cwchoi00@gmail.com>, <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v2 6/6] devfreq: Get module refcount in try_then_request_governor()
Date: Wed, 13 May 2026 17:38:32 +0800
Message-ID: <20260513093832.1645890-7-zhanjie9@hisilicon.com>
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

Get a refcount of the governor module in try_then_request_governor() so
that the governor module cannot be unloaded between finding the governor
and the caller using it.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2ea42325d030..fb1a7aa168aa 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -285,6 +285,9 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
  * and the driver that call devfreq_add_device) are built as modules.
  * devfreq_list_lock should be held by the caller. Returns the matched
  * governor's pointer or an error pointer.
+ * On success, this holds a refcount of the governor module to prevent the
+ * module from being unloaded during usage, so the caller should put a module
+ * refcount after using it.
  */
 static struct devfreq_governor *try_then_request_governor(const char *name)
 {
@@ -313,8 +316,13 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 			return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL);
 
 		governor = find_devfreq_governor(name);
+		if (IS_ERR(governor))
+			return governor;
 	}
 
+	if (!try_module_get(governor->owner))
+		return ERR_PTR(-EBUSY);
+
 	return governor;
 }
 
@@ -1009,6 +1017,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	err = devfreq_set_governor(devfreq, governor);
+	module_put(governor->owner);
 	if (err) {
 		dev_err_probe(dev, err,
 			"%s: Unable to start governor for the device\n",
@@ -1446,6 +1455,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		return PTR_ERR(governor);
 
 	ret = devfreq_set_governor(df, governor);
+	module_put(governor->owner);
 	if (ret)
 		return ret;
 
-- 
2.43.0


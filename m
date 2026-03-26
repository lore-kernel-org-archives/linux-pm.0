Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865303F8DF1
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528779; cv=none; b=EUvHuDoSZDweeUvaw8NHKQDAR0uTfbxQFQPwL2VHjYN4Uscr3vbZzrRtWPxiXAXMiME+Qu5Jss3uZAujc4si2A6SDL8p9hKU4ZCS3CviFd+f7mKIOtHqXwW1YguLAwXER6nx8GOKIl2lsNUFrNnGJyAmbsTI5ISDdUb6pefE9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528779; c=relaxed/simple;
	bh=CN/r9rj/rKUJwEJFynmUvrH/lc9oQ/S1D8CVLSLtjPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNiFgRSdOPAKheHLaykjVRdkAPHwaNDFoYl7AHdqPIxB2jdbq3mAzr/jNhxjq4q252Ez5ZrGWYY10fKZ7y+Ni8c9wTP/eKqCTeVbLIZ5Ju87clbhoMMG1U9xLorbINqNXTuuwq8hhsOYp8UKPIZ34RRD/R6DNaVPTeYyVjfbxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fhNW453vLz12LDk;
	Thu, 26 Mar 2026 20:34:08 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 637144056A;
	Thu, 26 Mar 2026 20:39:35 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:39:34 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH v1 10/10] devfreq: Allow setting governor when device governor is NULL
Date: Thu, 26 Mar 2026 20:34:28 +0800
Message-ID: <20260326123428.800407-11-zhanjie9@hisilicon.com>
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

From: Zhi Wang <wangzhi12@huawei.com>

When a device's governor is set to NULL, the system should allow
reconfiguring the governor to restore normal operation of devfreq

Before:
$: echo simple_ondemand > governor
$: rmmod -f governor_simpleondemand
$: echo performance > governor
-bash: echo: write error: Invalid argument

After:
$: echo simple_ondemand > governor
$: rmmod -f governor_simpleondemand
$: echo performance > governor
$: cat governor
performance

Signed-off-by: Zhi Wang <wangzhi12@huawei.com>
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 5aebb32e89b0..a61880ff2792 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1435,9 +1435,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	char str_governor[DEVFREQ_NAME_LEN + 1];
 	const struct devfreq_governor *governor;
 
-	if (!df->governor)
-		return -EINVAL;
-
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
 		return -EINVAL;
-- 
2.43.0


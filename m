Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9331714B
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528778; cv=none; b=MZxgJct69gs3nVvt83uevNPgCJ6ltNDHt0xm6uhEB4+HiM8vdkV/qdHk3Oz/NMRaya1N91UWP5R7Ot64ekk5sCuO+iVgQdWW+iT0wfCEzxfTEJcbQRM91+E/ApA+m6/iqcpR49w50NIICvUfL39XDlyOlJ7/I4LZgbMG0ZKevzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528778; c=relaxed/simple;
	bh=Ezuwea1JoIadOyaU5kEJTQPeRiIwexWclA2coM7PU8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYEJjik4/cBytvjAKh+GHjOm4ju5I8qwFNHSDX/BbZgHtkrCRiEALy0fTCyaKlNCJR3oS55iVD/KopIcmTjivHlURRY+RJjem1GF+f9G7u5hXuOI80V/Qbva+BfsVxX/DAONyoQzup5f/8dMrldR77oK2IiOpfQekQXC6WFWKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fhNVK3x3QzLlTn;
	Thu, 26 Mar 2026 20:33:29 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 04C8E4056C;
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
Subject: [PATCH v1 09/10] devfreq: Allow showing available_governors when device governor is NULL
Date: Thu, 26 Mar 2026 20:34:27 +0800
Message-ID: <20260326123428.800407-10-zhanjie9@hisilicon.com>
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

Allow showing available_governors via sysfs when a device's governor is
NULL, enabling reconfiguration of the device's governor.

Before:
$: echo simple_ondemand > governor
$: rmmod -f governor_simpleondemand
$: cat available_governors
cat: available_governors: Invalid argument

After:
$: echo simple_ondemand > governor
$: rmmod -f governor_simpleondemand
$: cat available_governors
hisi_platform userspace powersave performance

Signed-off-by: Zhi Wang <wangzhi12@huawei.com>
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/devfreq/devfreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c6b670b8fd22..5aebb32e89b0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1461,16 +1461,13 @@ static ssize_t available_governors_show(struct device *d,
 	struct devfreq *df = to_devfreq(d);
 	ssize_t count = 0;
 
-	if (!df->governor)
-		return -EINVAL;
-
 	mutex_lock(&devfreq_list_lock);
 
 	/*
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
+	if (df->governor && IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				  "%s ", df->governor->name);
 	/*
-- 
2.43.0


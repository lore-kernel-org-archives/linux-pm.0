Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804323EDACB
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665415; cv=none; b=Qoy8yFbn1TJk6gleFxE9g7QPES0yI4nKhk+s1lkVLlkNhd6AKFOj+arcnUllaFSW8TZ/Qd8B+mX+o5IAllPw/N9gKZu08UBBQi7VXARUwP9F++G/CipeHsxEuGPNmVwIAuJzr1L973k8yeZzAI63qZ1bb6tg6jCdMsFLL7VNF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665415; c=relaxed/simple;
	bh=YRU5YJddRRF44yBgzTuEwlUh8SmVS2Z4JSE4krQOqqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+OQAJThmS/20dqO4ns6YtsafTvaf0zWg7wjW6aZwPDxHF7leoGb6u8FyvQfL95+i7AXaOXnCqjiiz7eILfcfm9Mj1Ir3XegKjhZqb7rc9Zso6nmoe7Oy4CaXnCYbYRDoCEgipKdGIeJKfyoEduq4ZCK78prHgvzenpdbLZXbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gFpRJ1K02z1BG6W
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:42:52 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gFpHh3494zpSwH;
	Wed, 13 May 2026 17:36:16 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E14A14048F;
	Wed, 13 May 2026 17:43:17 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 17:43:17 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cwchoi00@gmail.com>, <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <tianyaxiong@kylinos.cn>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <zhangpengjie2@huawei.com>,
	<lihuisong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v2 0/6] devfreq: Add refcounts for governor modules
Date: Wed, 13 May 2026 17:38:26 +0800
Message-ID: <20260513093832.1645890-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.43.0
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

A governor module can be dynamically inserted or removed if compiled as a
kernel module.  'devfreq->governor' would become NULL if the governor
module is removed when it's in use.

For user-friendliness, get and put the module refcount of a governor module
when it's in use.  As a result, unloading a governor module in use returns
an error, e.g.:

$ cat governor
performance
$ rmmod governor_performance
rmmod: ERROR: Module governor_performance is in use

Note that this can't stop force unload, so it's more of a
user-friendliness improvement rather than strict protection.  The
existing code that keeps devfreq working when 'devfreq->governor' is
NULL should still be there.

Patch 1-3 clean up mutex with guards and factor out a common governor
setting function, so as to prepare for implementing governor reference
counting.  They can be applied separately.

Patch 4-6 add the reference counting mechanism for devfreq governor modules.

Changelog:
v2:
- Rebase on devfreq-next of 7.1-rc1.
- Drop the patches related to the NULL pointer deference issue of
  'devfreq->governor', which has been solved and merged recently.
- Remove the dedicated mutex for 'devfreq_governor_list' because the
  refcount changes don't depend on that.
- Some minor cleanups and fixes.

v1:
https://lore.kernel.org/all/20260326123428.800407-1-zhanjie9@hisilicon.com/

Jie Zhan (6):
  devfreq: Use mutex guard in governor_store()
  devfreq: Use mutex guard in devfreq_add/remove_governor()
  devfreq: Factor out devfreq_set_governor()
  devfreq: Add module owner to devfreq governor
  devfreq: Get and put module refcount when switching governor
  devfreq: Get module refcount in try_then_request_governor()

 drivers/devfreq/devfreq.c        | 210 +++++++++++++++----------------
 include/linux/devfreq-governor.h |  26 +++-
 2 files changed, 127 insertions(+), 109 deletions(-)

-- 
2.43.0


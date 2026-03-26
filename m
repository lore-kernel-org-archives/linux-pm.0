Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04563B8D40
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528781; cv=none; b=b3CkPAg/QXzU/5X7HgkjhWs0vxw9ktaj5oMw3rIKsWipOnSSMFS0MrFOGtcfkD92E8h6b1gxv6LAyspiWZtTHMNNh5VDQSDx8QVZBq/pR3dqEj/RxoJ34bYrayeA8QJALI5+dB3sidbyqCZQVNYc/BfFVqDDYj0wLc9LBHKZzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528781; c=relaxed/simple;
	bh=Eq+XKKLdDKe+d+4bP5AzGmn3pJTUlbXuicSHmu2GvRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SEIbGtwD9xJX1OhHcprNgVjP2PX81wO25qlwMyQjkNGTxontJYFKWe+GUJbnctpgmQg+4PNUbJJLTe7SHAmJAKoT/JAW48LaLNY524PaWCf8Hfpz0OG+ifm47n1MuFpjD8S+XGZQKHBZX3baeoWotLvI6caz3Ff/A9ckp1e+u2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fhNVn3jzQzpSvx;
	Thu, 26 Mar 2026 20:33:53 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 53B0740567;
	Thu, 26 Mar 2026 20:39:31 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 20:39:30 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <tianyaxiong@kylinos.cn>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <zhenglifeng1@huawei.com>,
	<zhangpengjie2@huawei.com>, <lihuisong@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: [PATCH v1 00/10] devfreq: Fix NULL pointer dereference when a governor module is unloaded
Date: Thu, 26 Mar 2026 20:34:18 +0800
Message-ID: <20260326123428.800407-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.43.0
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

When compiled as a kernel module, the governor module can be dynamically
inserted or removed.  'devfreq->governor' would become NULL if the governor
module is removed when it's in use, and NULL pointer dereference would be
triggered.  A similar issue was also reported in [1].

To address this issue:

Patch 1-5 rework mutex, factor out a common governor setting function, and
clean up some unreachable code.

Patch 6-8 prevent a governor module in use from being removed (except for
force unload) by getting/putting a refcount of the governor's module when
switching governors.

Patch 9-10 allow 'governor' and 'available_governors' to work normally even
when a governor module in use is force unloaded.

Note that this series is based on [1] or devfreq-next, otherwise code
would conflict.

[1] https://lore.kernel.org/all/20260319091409.998397-1-tianyaxiong@kylinos.cn/
[2] https://lore.kernel.org/all/20251216031153.2242306-1-zhangpengjie2@huawei.com/

Jie Zhan (8):
  devfreq: Use mutex guard in governor_store()
  devfreq: Use mutex guard in devfreq_add/remove_governor()
  devfreq: Add a dedicated mutex for the governor list
  devfreq: Factor out devfreq_set_governor[_locked]()
  devfreq: Remove dead code in devfreq_add_governor()
  devfreq: Add module owner to devfreq governor
  devfreq: Get and put module refcount when switching governor
  devfreq: Allow find_devfreq_governor() to get module refcount

Zhi Wang (2):
  devfreq: Allow showing available_governors when device governor is
    NULL
  devfreq: Allow setting governor when device governor is NULL

 drivers/devfreq/devfreq.c        | 287 +++++++++++++------------------
 include/linux/devfreq-governor.h |  26 ++-
 2 files changed, 143 insertions(+), 170 deletions(-)

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965766;
	b=SJ+ApHNrjfdvvfVov7mKc1mLtUjfFZ/sXo08TxD038CJsBYz3ZPABa1Pj4iiSTFUvE94
	 OhfWroTVLTNDiWkqE8xzJwilm5B5hgsmVpttYrs2GpwImuX1a+R6jgvUQhAxBM/wxHOXX
	 czReY385h/Kcdmb+oxSfxgzF4kNoFf6YtUP3i+dwMPiWluJFfrd2zcJNnyLFmz27/tmuI
	 LWTNWXcP6B1LtIQY4YoDKq896E0yYgjGYja96Ezj5g/lpozYU/0RPT8xdTrcbp8PWatfR
	 FqCy6i4cbNUjfPE5slEIHTjGf96uXfKZdV/WXh7hq/UpH6hChZD64fKouKuZ6KPcE4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965766;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=tqwg86cWIOWTdLp/+zgu2PQN+ZFQzUG8gHBzc4KE4M0=;
	b=xI5g9juCqGp74BHxZmtXFhkmfhVpL50MUuNNkWy0Jm6sG5bhwpYHv2uUSbfD1yTfDwXg
	 z1aqvgmnJdPGAzKddU0Sh2KYB0xkIWN7Nh+RE6qBtEf31g7OufdPGoNG1pNZAVsKmTfLi
	 0M8ynhkxvHirupitMNrPZ3f+005MFkfGqoquwRNIewcKGquOaHq4+/XlMC11hGHQcfFu8
	 +EZOq/xBFQ5reqHofXUYER/YEPeNtIGXbu/2Uebc8sXHt7VAc60+kUV9zOS4IE57CKR3o
	 inGcZAzerCQZw8TQ4SDJ0Cvcll94cmLUiJBvu38UtJ2zp1Dw64zm1ddzYzsyPYRYAmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Y3ac5Jzu;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2195606A31C;
	Wed, 18 Nov 2026 01:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2195606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Y3ac5Jzu
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tqwg86cWIOWTdLp/+zgu2PQN+ZFQzUG8gHBzc4KE4M0=;
	b=Y3ac5Jzu6yLgCPjrYvSSfvTBZMclbKslhpdkAeKnkb46hAfozJ5JM3APP9Q4wTtlsPyLv4/nd
	5/XBTe3Fn4XZS/XDEhjDvNJOAHtcaeAw1ErihSARznWIIDy5NjYj18WWj6vgTEr0G2zcKiAVkjU
	uf6Af4jCw9cVrkoJ67DTgPY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jTkgx4c74zmV6w;
	Wed, 18 Nov 2026 09:35:41 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id DC16840565;
	Wed, 18 Nov 2026 09:36:00 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 18 Nov
 2026 09:36:00 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<zhenglifeng1@huawei.com>, <christian.loehle@arm.com>, <yubowen8@huawei.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhangpengjie2@huawei.com>,
	<mojunjun4@huawei.com>
Subject: [PATCH v4] cpufreq: CPPC: Enable boost by default
Date: Wed, 18 Nov 2026 09:35:58 +0800
Message-ID: <20261118013558.3075038-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)

The CPPC driver leaves boost disabled by default when Highest Performance
exceeds Nominal Performance. Userspace must explicitly enable boost
before governors can use the full advertised performance range.

For user convenience, set .boost_enabled = true in cppc_cpufreq_driver.
Since cppc_cpufreq_cpu_init() sets policy->boost_supported when
highest_perf > nominal_perf, the cpufreq core will enable boost by
default only for policies that support it.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>

---
Changes in v4:
- Rebase onto linux-pm/bleeding-edge.
- Link to v3: https://lore.kernel.org/all/20261117105240.1113405-1-zhangpengjie2@huawei.com/

Changes in v3:
- Drop cppc_cpufreq_default_boost_init() and set .boost_enabled = true
  statically in cppc_cpufreq_driver (Christian).
- Link to v2: https://lore.kernel.org/all/20261022075901.3436021-1-zhangpengjie2@huawei.com/

Changes in v2:
- Drop "even" from the commit message (Christian).
- Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
---
 drivers/cpufreq/cppc_cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 29b93780219a..2c67c55a3ab7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1774,6 +1774,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.offline = cppc_cpufreq_cpu_offline,
 	.suspend = cppc_cpufreq_cpu_suspend,
 	.resume = cppc_cpufreq_cpu_resume,
+	.boost_enabled = true,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.33.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912767;
	b=3oJdnV/yrQWVXrcejcO0pvk78gwgby7hQVaS8nrxcTZ2sYfOVJbYm73QKMM0QbDYtaxr
	 DNe6WUsVa1epkIMR2rcY9FBsDzFqwZOTDMWmmBOJHO2xbJtn+lBiz2tDkQKjaCsppbycf
	 AhHxFSgTBpwaHKlt485KR1T68lYh6W2Wa1heL0+TJfEcjeKG1+xkinGu3FyWGYyNPZ/rr
	 rMcqwgPZeWkDIUrM6p2dLX7LT6wJfZQcr9tex41apRnzi6HDg5Kz1dycWaKQEDbO8awpx
	 1ysqPg21kWn4/HJYMIWarEzJQGq16I3FVRSacJG1LzEt7fwhQq+jS7QZu6YcBJGeOiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912767;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=gIDyOlmda9Z172HEhXPnShF0sdY8RfmEkzJnJkYDlTI=;
	b=fZquUZa6DIK3vSSl3nRy/ddnzXmmSInvQEIQfQqpwGV3RmDKCdSZ2ap/lt0+4fFCSbdL
	 3vYNIdT+mIWx0JA8pAIF4FLEKUWWXsbfCJwfuUN/fdnXeqGx7FpMD5Q7zsk2Nw9W2r414
	 B4SFk7C0f3K61nWJTZOkK8oUNCDRVOhlEICKS7KvA0tVw24GfhvgjX1iJsabg6kVNBLBn
	 MvCh+PPObRuz32oH+W8nWWQD14sxZxAK5066WbodzDVq1iIikr7zrwAtbn92sT6X9JFUV
	 s8l59BzhV8fPtmSPEWHcXezGCy1TbJZZf1SaMIbqUvk3/ydFcHcRv48rvmUMwk36rzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aPDnMgab;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D907606A33A;
	Tue, 17 Nov 2026 10:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D907606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aPDnMgab
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gIDyOlmda9Z172HEhXPnShF0sdY8RfmEkzJnJkYDlTI=;
	b=aPDnMgabkVBwnbZqz3ckgrFm5tY2iFKJmN/QOtJ41/1jaWQe3MTzW4Cr2Z0mi6dHO/GTiOd5V
	/XopetpJeY6PPkUEnqdRw/BC3h3I73h7rfjTUk6jGvHfcICVNOa9xg/BascYAUGZYgycOLw4VWO
	aipkS99/7W+Msiabp4eJrZ8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jTM4s2TwQz1prKZ;
	Tue, 17 Nov 2026 18:52:29 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id AEF7740686;
	Tue, 17 Nov 2026 18:52:41 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 18:52:40 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<zhenglifeng1@huawei.com>, <christian.loehle@arm.com>, <yubowen8@huawei.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhangpengjie2@huawei.com>,
	<mojunjun4@huawei.com>
Subject: [PATCH v3] cpufreq: CPPC: Enable boost by default
Date: Tue, 17 Nov 2026 18:52:40 +0800
Message-ID: <20261117105240.1113405-1-zhangpengjie2@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)

The CPPC driver leaves boost disabled by default when Highest Performance
exceeds Nominal Performance. Userspace must explicitly enable boost
before governors can use the full advertised performance range.

For user convenience, set .boost_enabled = true in cppc_cpufreq_driver.
Since cppc_cpufreq_cpu_init() sets policy->boost_supported when
highest_perf > nominal_perf, the cpufreq core will enable boost by
default only for policies that support it.

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
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
index 957fa7775260..1ea16e95c0e9 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1059,6 +1059,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
+	.boost_enabled = true,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.33.0


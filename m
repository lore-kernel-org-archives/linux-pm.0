Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A94339853;
	Thu, 15 Oct 2026 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029499; cv=none; b=e2tja4OA6qaco9NClZwqfqwDEKMKktNKoCWzekhqyEWloYgfIZgv/G4gUFTpXok6GxznweUpY1nm8mEkO92F+/qvyebG+0Th+Ob9fTJlghCr0zYi5XYDgNfxrPrkRFDQVM3UDacKXRgpdZNyl0OaDc+EqzzgtSlQePrb5uhsFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029499; c=relaxed/simple;
	bh=dSypW2ssAHoPEtRXeNz0eQUuqjMANWxJ0LhPm6pCOu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MSQgpYLKtJg3tao+pFMUmjfEhN6llNU5UIOuHinNsd+W+Si7JvS50SdOF4g4EAeCo/Ifu8E3ohLRAMHoj4Qg8R7YyCjdA91IF+JzF/SKwirXxebDRaqPACtF4FcHk/3w64PATDLA+iYEyrSVtrApmGVSGc47jncHsU0I1QM90i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=snNGwZbs; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="snNGwZbs"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mE2sCQjYiBW5anq7kkPita/5yu9Nfvs1H+JAKiyTHPU=;
	b=snNGwZbsHoNHZ3zRSg/6JKJpDzoa0yw3sUZYwdBRRGRwHefr+B0Q918crfpbueRS4XYZeY1Ts
	kyOSfNKOOeiQZ/mklpSPoOn4LKZBCpPALCPpqfmHuPuuJ+O82uM3ssFaxXWHLHdzqHbbjecV8he
	L9R+GlAjXGQPHy27Q9F+r9Q=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j4rWP4zBdz1prN6;
	Thu, 15 Oct 2026 09:45:53 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id C9A8E4057F;
	Thu, 15 Oct 2026 09:58:13 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 15 Oct
 2026 09:58:13 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhangpengjie2@huawei.com>,
	<mojunjun4@huawei.com>
Subject: [PATCH] cpufreq: cppc: Enable boost by default when supported
Date: Thu, 15 Oct 2026 09:58:12 +0800
Message-ID: <20261015015812.867988-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)

The CPPC driver leaves boost disabled by default, even when Highest
Performance exceeds Nominal Performance. Userspace must explicitly
enable boost before governors can use the full advertised performance
range.

For user convenience, enable boost by default when at least one possible
CPU reports support. Check the performance capabilities before registering
the driver so that the cpufreq core enables boost for each policy that
supports it.

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 80893844353c..0a4255a36f60 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.name = "cppc_cpufreq",
 };
 
+static void __init cppc_cpufreq_default_boost_init(void)
+{
+	struct cppc_perf_caps caps;
+	bool enable = false;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (cppc_get_perf_caps(cpu, &caps))
+			continue;
+
+		if (caps.highest_perf > caps.nominal_perf) {
+			enable = true;
+			break;
+		}
+	}
+
+	cppc_cpufreq_driver.boost_enabled = enable;
+}
+
 static int __init cppc_cpufreq_init(void)
 {
 	int ret;
@@ -1061,6 +1080,7 @@ static int __init cppc_cpufreq_init(void)
 
 	cppc_freq_invariance_init();
 	populate_efficiency_class();
+	cppc_cpufreq_default_boost_init();
 
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
 	if (ret)
-- 
2.33.0


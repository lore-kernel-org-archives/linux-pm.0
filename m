Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655954;
	b=UvoDtnBlv+bosQ9EPTr1Sl7qv3m7fRiBkWvZ52gPHoisBZmhbGPwAD7cl0y4H7M0gJrl
	 HzZLxm8IOoAs9AMdEfQos5/vUF0jziEonwO77LWzruWKvzPgouW6MKVQm9mF99ykHQ5lr
	 Qq0rr4FgvWyDzpCX2kduQnTLezZbXE1N1rEEoV2kSUhmt3KOixG3imndWGILbsbiqY4uq
	 RmUBAu7udbNLALN8LwEuKsohRMgvrzM0gstcrbd9cWne2q0mjwOur5drdAdF7MSsudwXi
	 2LF+Y8i4gjEEse/sxeZmAO2mxCuIsG1tOmsvEnZXuVoMoABmG6Fc+rQ53ZGSLuqYZMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655954;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=6CAHN9UM/PpVKXHkJKYb+AS7KhiPVoOFxspm9Pqdqn8=;
	b=MltL6inIirK9IltRjZL8qgbncR4baM2AoodXZZcLSfU5vtOJnD/P59jWXmjGMhLYhMT9
	 cpbFHdnTHZEfrHPnCwufWdseDUQpKC2maihEpL1a0ocGlok9o3kz8mIoKkoNtZ+SB0GJm
	 ysFAJTWC54o2bWVGIiX8hejWvMD776NZj4FqfGouP5QXoy5D8pfRwq8eADIFLZTm/LK/8
	 JmHj4uc+fQNi+DkeYBydHdvirQBr43rrS5AooG6+WIVtsMfNO9sh7VkSUvCE273dZ5iTk
	 9ybuHV2f+JTqqscei+sqm5o2b0ozQBwwd5gbPcwT1aL3Og3vUfbsAohAWeDbDGKE17Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TdkNFPl2;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B6606A31A;
	Thu, 22 Oct 2026 07:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 463B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TdkNFPl2
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6CAHN9UM/PpVKXHkJKYb+AS7KhiPVoOFxspm9Pqdqn8=;
	b=TdkNFPl2S/FZG3QZnHPvQFrGyyI1l5qD+IW2E2x4vhpWlpd4DpjmGFmWfakndycmq0XHCxgVo
	8NoexMYB0KojcW+Mp0zCeHBbuCnuSRMnCynfdoDIp+zL4L/RHyC814GxMltWWX+jIcVgSXntYWz
	/FMKP/WrxEVRO12/A5wOic0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4j9JSg5DBtzcb3l;
	Thu, 22 Oct 2026 15:58:59 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A1364057D;
	Thu, 22 Oct 2026 15:59:02 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 15:59:01 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhangpengjie2@huawei.com>,
	<mojunjun4@huawei.com>
Subject: [PATCH v2] cpufreq: CPPC: Enable boost by default when supported
Date: Thu, 22 Oct 2026 15:59:01 +0800
Message-ID: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr200004.china.huawei.com (7.202.195.241)

The CPPC driver leaves boost disabled by default when Highest Performance
exceeds Nominal Performance. Userspace must explicitly enable boost
before governors can use the full advertised performance range.

Enable boost by default when at least one possible CPU reports support,
while users who prefer to stay within the sustained nominal limit can
still disable it via the boost knob without determining scaling_max_freq
for each policy.

Check the performance capabilities before registering the driver so that
the cpufreq core enables boost for each policy that supports it.

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
Changes in v2:
- Drop "even" and clarify the commit message (Christian).
- Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/

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


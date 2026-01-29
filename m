Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793523D2A3;
	Thu, 29 Jan 2026 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689098; cv=none; b=sc9ZfilHMhpAapvAS/adx+ek56AQ0SkRCnh7uf5qOEnfAvZAo8EYCeHWrhNoIA1jgunHAy2aa/EE9KC3LNz8OmRIhwpob+dnJ+KDCdGiM+nWmb3wTZ37DjjHZelmT/s5q5yZcMGKixtKdLowrl+ETrymIKqf/aUpSmfuWC0CdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689098; c=relaxed/simple;
	bh=F3JRTED3JbKrmV91pCbRZ4+G3lnexefBPkRP1wpF0hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mFRdWX92fu3uUkbjBKS5YAikn+Zo0ovftWi7G0ahr84mLyuUnLjLHTuDpKwbI3N/te5dNP1lg+NmwfSnoSaiorVqEmqOz4U0+R9P/vDyTVM3L9oDcGc0Keam5TaKIhxMLYX/GomptgoTHs/QVsott2ZGXkNTDaRe4A9Fr68Qg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CJSwOTi6; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CJSwOTi6"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xOaH0TRs7D7j4qS1HC/y4wPrJPLdFsRGD+heOvgXv3Q=;
	b=CJSwOTi6te/Q4iIBO0SzuAr1174cKtFfoFlvufseD4I86jU9jQH31xfLH7aTW9WIatM6NHg4v
	RejbXzfAELiij7XwEtjmndrvqy0GKJLYwueMFIxMaAqBr7Nxcl4X/KEq/5JMKIKRSDQAD6M07hn
	ftljMJNxmZXkKA3h05PRC/Y=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4f1ykY1s0WzmVC7;
	Thu, 29 Jan 2026 20:14:45 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 887E940565;
	Thu, 29 Jan 2026 20:18:14 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Jan
 2026 20:18:13 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH] cpufreq: Add debug print for current frequency in __cpufreq_driver_target()
Date: Thu, 29 Jan 2026 20:18:13 +0800
Message-ID: <20260129121813.3874516-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Include policy->cur in the debug message to explicitly show the frequency
transition (from current to target).

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4472bb1ec83c..b3d2d2e0c864 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2361,8 +2361,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	target_freq = __resolve_freq(policy, target_freq, policy->min,
 				     policy->max, relation);
 
-	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
-		 policy->cpu, target_freq, relation, old_target_freq);
+	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
+		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
 
 	/*
 	 * This might look like a redundant call as we are checking it again
-- 
2.33.0


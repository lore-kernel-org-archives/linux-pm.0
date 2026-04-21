Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80034B19A;
	Tue, 21 Apr 2026 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775026; cv=none; b=qth63kaohN7q16Jk1nsCFVhbHMjxnO3LD9WGccHR4vnB66HHVME/pkNKZ9uvs5Wfh9XaOdKAdphEGi0BN75Rlss1Y0R7tnIlKRFl/LpCmuz/6GPS89rNeSJi1cYOpmtri9TibI47c7H+oupXugZfm6IsKSzzLhzjCRSRKWAgaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775026; c=relaxed/simple;
	bh=nOlruvSNVaVVrsQCtI5cjfSJuDEcWFJeY+Dp619l6Yk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dhOHKY2z+sTmc7EOsAyz5YRzN0qJEWItDmUvkzBE5qfJIL3K3xJJhLlPPD8yu3vRSUkLCus3aqHVVWEmU8sZYGoNTixYKkukHtw8GG+lFsi4rJqtX//5/dXMbNY51THRYDsmzAFPeciQfQAWIiwoCcXljmTwoe7Jwr5GjRB6z+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hPGsWbPu; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hPGsWbPu"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LH/vc/DrVSp39qqIAdMHuuklJKSMYzEeuulyWSJplqM=;
	b=hPGsWbPuAwuXfFYCHW1gDSMhKXyYg99wsOltZhUSuxG2eM60r+XWHA5OY0uLvtsa71qXQcc/z
	yacl+dYXqBo7jcTR6iigRvgmqGsSTSmo0U7KLjyDOqPPiBe+L0adYCf6EyAQQOfZzG976++svGT
	hzQ8r1Vvd/kyvV1W/yoQnCc=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g0MBy55y1zKm4w;
	Tue, 21 Apr 2026 20:30:34 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id AA5F240562;
	Tue, 21 Apr 2026 20:36:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 21 Apr 2026 20:36:58 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <stratosk@semaphore.gr>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease due to stale target
Date: Tue, 21 Apr 2026 20:35:45 +0800
Message-ID: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100001.china.huawei.com (7.202.181.215)

In cs_dbs_update(), the requested frequency is decremented by one freq_step
for each idle period. However, this can cause divergence between
'requested_freq' (target for current update) and 'dbs_info->requested_freq'
(target from previous update).

When the load crosses up_threshold or down_threshold, the decision on
whether to increase or decrease frequency should be based on the *previous*
target (dbs_info->requested_freq), not the current one. Otherwise, the
update step may be skipped entirely if the current target has already hit a
boundary due to prior adjustments.

Ensure that frequency scaling decisions are made using the correct
historical target, fixing cases where frequency fails to decrease despite
sustained idle periods.

Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index df01d33993d8..f3c3b54e4bf8 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -104,7 +104,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		dbs_info->down_skip = 0;
 
 		/* if we are already at full speed then break out early */
-		if (requested_freq == policy->max)
+		if (dbs_info->requested_freq == policy->max)
 			goto out;
 
 		requested_freq += freq_step;
@@ -127,7 +127,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		/*
 		 * if we cannot reduce the frequency anymore, break out early
 		 */
-		if (requested_freq == policy->min)
+		if (dbs_info->requested_freq == policy->min)
 			goto out;
 
 		if (requested_freq > freq_step)
-- 
2.33.0


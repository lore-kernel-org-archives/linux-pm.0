Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4B314B8F;
	Wed,  3 Jun 2026 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466203; cv=none; b=s2eN0UxDqiY72hvLE5g6ZmeEecVra9xEcjfoB4fJ6Xk9KuYAe/WZh/FELyFP8riWAExXww/zKoPN5Zuf6ojUPtnqWrS38XCXBXsp3+VPxrdFAE6m2YYBcpL6bIjNvQ9qfwJrDJDt6KGiUpfpKcgiio5efAlbmLkMPeRlZ8u0WQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466203; c=relaxed/simple;
	bh=ihnBRnuiawMRpx4Ju3/9ELmf1p9Q5arnv8psZ5IrH+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ByG1SskoCEYjqAqhl4yOXV2opi69FWJWISdjjYttbLD1qjib/u9h3deeR8uUqgzOEj+vwPQ3n3gpU9sNO22tZ+H1Y401DYxQsUaqBXrC+BypVV5VjcFDWz96HndQXEMSqL6/2Lhx31lb2igk3hSao8fDj1FCe8Fw6Va5uSCa+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xZwdt+FK; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xZwdt+FK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Nig0WWbDCgpsFzsv9VKbhr+B9TjEQEZKyFyAJDj3xOI=;
	b=xZwdt+FKvDQ0pMrZpqJ/rJyyhQcRxtnm+Y7/a+bsJgm00xS2kI5pp0bU4lMg5+p3IK/8qj5pX
	7kW9sWIUwa5MTDCHnG6iEiNfnPWm7uT4zGcFoEXyzh7stHTw6UvQy16c3/WVkwcukkT6L4+32AQ
	r3Qno9lBTAiiDgVPPvQJqVw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gVcFS1YzYzKmV1;
	Wed,  3 Jun 2026 13:48:44 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 857DB40571;
	Wed,  3 Jun 2026 13:56:36 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Jun
 2026 13:56:35 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>
CC: <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <lihuisong@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <zhongqiu.han@oss.qualcomm.com>
Subject: [PATCH v2] cpufreq: Documentation: fix freq_step description
Date: Wed, 3 Jun 2026 13:56:35 +0800
Message-ID: <20260603055635.1549943-1-zhangpengjie2@huawei.com>
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

The conservative governor documentation incorrectly states that setting
freq_step to 0 will use the default 5% frequency step. In reality, since
at least commit 8e677ce83bf4 ("[CPUFREQ] conservative: fixup governor to
function more like ondemand logic"), freq_step=0 has always caused the
governor to skip frequency updates entirely.

Correct the documentation to reflect the actual behavior: freq_step=0
disables frequency changes by the governor entirely.

Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and consolidation")
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
Changes in v2:
- Update commit message to reference the correct historical commit
  8e677ce83bf4 instead of b9170836d1aa, as the original implementation
  had asymmetric behavior for freq_step=0 (suggested by Zhongqiu Han).
- Link to v1:https://lore.kernel.org/all/20260529111122.3321645-1-zhangpengjie2@huawei.com/
---
 Documentation/admin-guide/pm/cpufreq.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index dbe6d23a5d67..98c724d49047 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -586,8 +586,8 @@ This governor exposes the following tunables:
 	100 (5 by default).
 
 	This is how much the frequency is allowed to change in one go.  Setting
-	it to 0 will cause the default frequency step (5 percent) to be used
-	and setting it to 100 effectively causes the governor to periodically
+	it to 0 disables frequency changes by the governor entirely and setting
+	it to 100 effectively causes the governor to periodically
 	switch the frequency between the ``scaling_min_freq`` and
 	``scaling_max_freq`` policy limits.
 
-- 
2.33.0


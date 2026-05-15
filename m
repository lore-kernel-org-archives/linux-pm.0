Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7F43D4EC;
	Fri, 15 May 2026 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838576; cv=none; b=d7l+dMPESmS1Jnn5FvGc40+Mie/O0fiATTL8hOvKmPeAYBWTKhZFuAJg78o3RBPReocfO3siw6SYF38gFj7s7dWrkP75jnYK/+SmqWVcIFElNNEmfbj6zY1avzG5xc+1tlUNsGRkOShFRBnL6SUR/NZsDKLbIC31it+dbGJBCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838576; c=relaxed/simple;
	bh=rWTAaOAOYDmQ6UBxvzKThMN94E4arVA1Gebhj55YfcE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X12EJvK/8ZrrrZH9jCBymLkXoDQG49gLdKnDRr8IddEVU+AHYppmKMpL9gKN3qMhdUBu8nwatHdC0SUEhUPMG+9qQyOJ4mAfVf3aDpOOfZZ2JqbsIrp49hT+wj+g0fPgaWreS0QD6Ct29YPAhNYYh9jdVfWFIrwG6W/GCT/oErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HTNL3PEs; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HTNL3PEs"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ddf5rnkcewWB3VTTcGX1fHHmNywN/T2k0aDW7rLyNVA=;
	b=HTNL3PEsw+EhyCcCe/PTiMxfjc/ZA4bYXbJXjsaPSiV7KqUFp0s6fqAOKsidZOcJ8RQYizoXx
	ias266hbyn1eM215+JSc5LTrr6TMbPvkZi9wg6ZjlDMCnBXPiJlPL5riYDI7pnFzI3rZnGvJBCu
	oRWVVL1EW0V9nxXJEF8LWtk=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gH2KG3QJkz1cyPB;
	Fri, 15 May 2026 17:41:54 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 861F940539;
	Fri, 15 May 2026 17:49:31 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 May
 2026 17:49:30 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <corbet@lwn.net>
CC: <skhan@linuxfoundation.org>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH] cpufreq: Documentation: fix sampling_down_factor documentation range
Date: Fri, 15 May 2026 17:49:30 +0800
Message-ID: <20260515094930.273599-1-zhangpengjie2@huawei.com>
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

The ondemand governor implementation accepts sampling_down_factor values
from 1 to 100000 via MAX_SAMPLING_DOWN_FACTOR, but the documentation in
admin-guide/pm/cpufreq.rst still says the valid range is 1 to 100.

Update the documentation to match the actual code.

Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and consolidation")
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index dbe6d23a5d67..fdca59c955dc 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -516,7 +516,7 @@ This governor exposes the following tunables:
 	of those tasks above 0 and set this attribute to 1.
 
 ``sampling_down_factor``
-	Temporary multiplier, between 1 (default) and 100 inclusive, to apply to
+	Temporary multiplier, between 1 (default) and 100000 inclusive, to apply to
 	the ``sampling_rate`` value if the CPU load goes above ``up_threshold``.
 
 	This causes the next execution of the governor's worker routine (after
-- 
2.33.0


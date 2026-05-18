Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6E3783C3;
	Mon, 18 May 2026 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111306; cv=none; b=GY+wDWZpydJ30fDd9tWLkM8nuYo4qxl1xVjgUfd7IFZpNqyD/RNeoS+Ox1nYybGl0ZopEs4bDgVvMoZ78QX1BdbbhlyHzUuOHXvyVUCfMg/MyBzwL7JuOyBGZUHE5Zds+pFAMUzPjOYdQ/SbgPXP6BnJ0Vvx9MuFztrEIWBtwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111306; c=relaxed/simple;
	bh=ew2Tqhep/T7jvCIXj7uaGBDg+dnwzEJZ2P2BH/P98qw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzBjW1JilVTfY70Nudks6b1fAVEQ+tLAc57uiEkvhQZrpEFohKUCiDbllxVzwrCXQxgtWD4YNLxLFG+rRp4BCYfJMGZm+MW8biznScaxb8O0J5ST71ZMy8gNh76U1fTL/a0WSnjAsK8/wTJQrMzddy5AQwZzSKRdjleCuDFkWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FvH3zPJv; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FvH3zPJv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fJmk12HcaeWEqgC6VcThQhjwf0CbSUyWqdGBfCJ4mVM=;
	b=FvH3zPJvrUB8qUCYAFM+IxnQNYAzXYvr1ycaskuIP5Cq4rshaLrr20vv4zWGSFhTwHjy0qN6c
	xfq4CURl4VZASk+r3N0ZcR56sOgSkn8Df8j2h+fqbWFKzW8CUF6fOqYh9ivy3xQRXcw6hV1O2Nn
	mDGR46Tp/HPVaXwZbaHmSi4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gJzBX4Ml5zpStK;
	Mon, 18 May 2026 21:27:48 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 3050540569;
	Mon, 18 May 2026 21:34:59 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 May
 2026 21:34:58 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <corbet@lwn.net>
CC: <skhan@linuxfoundation.org>, <zhongqiu.han@oss.qualcomm.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v2] cpufreq: Documentation: fix sampling_down_factor range
Date: Mon, 18 May 2026 21:34:57 +0800
Message-ID: <20260518133457.2408463-1-zhangpengjie2@huawei.com>
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
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
Changes in v2:
- Modify the title.
- Add Reviewed-by tag.
Link to v1:https://lore.kernel.org/all/20260515094930.273599-1-zhangpengjie2@huawei.com/
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


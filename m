Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9843D646B
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928126; cv=none; b=pFamvEJDJqJIEYEZ0gwqt2e85JE0N2Ah7M5rfGmEcs2G0SuqfY2haCYzEpghojV0wFJlXWlf2/wNAJAEJu7SO50W7wv+JJ3dysO+0dyLRt5aZWGiLVGrSCwKT1M2F/nElXVMtMdlV8Y0nAsUJRKFd1pZuz2SICP7c7dpJramxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928126; c=relaxed/simple;
	bh=mTGHYlCcgme6N6XMZATgEDhtxoCwK4bPv8lXD183SpU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBqbhHr4jucitXribRuu3bMqZ1i1Uui3aWIyp10iiESVXJ51X3sRWRCdG8mb6Bbbq4qw9TR3QGcdBGRBeL7uwsqhigWrM2C593ch38NBn7CTL3ZZfV64wcE7ci4Sgs2HEpbgxKaPdIQ7psFHswkOrJw3DpcbpSr2E5m0Pqo5QPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.78.36.208) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 20 Sep
 2026 21:00:07 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	<linux-pm@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Caesar Wang
	<wxt@rock-chips.com>, Kevin Hilman <khilman@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] pmdomain: rockchip: fix domain check in rockchip_pm_add_one_domain()
Date: Sun, 20 Sep 2026 20:59:27 +0300
Message-ID: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

In rockchip_pm_add_one_domain(), there's the check (most probably for
the case where the "reg" prop has an unexpected value?) which doesn't
make much sense as the variable pd_info will be NULL iff pmu->info->
domain_info is NULL and the variable id is 0.  What does make sense
there is checking pd_info->pwr_mask and pd_info->req_mask which (as
seems to follow from the code) can't both be 0 for a valid domain...

Found by Linux Verification Center (linuxtesting.org) with the Svace
static analysis tool.

Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
This patch is against the fixes branch of Ulf Hansson's linux-pm.git repo.

 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index ba66ae719428..69792e2b215b 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -809,7 +809,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		return 0;
 
 	pd_info = &pmu->info->domain_info[id];
-	if (!pd_info) {
+	if (!pd_info->pwr_mask && !pd_info->req_mask) {
 		dev_err(pmu->dev, "%pOFn: undefined domain id %d\n",
 			node, id);
 		return -EINVAL;
-- 
2.55.0

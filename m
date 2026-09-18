Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com [101.71.155.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23793C3F51
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733617; cv=none; b=b0jweZK3dg+dX2/vsJVSNCD/fdLxK7pExah2FrUOQk3o4cKE2TN1AfZeap2EiheQAPfVSjnZXcrB22R7KGoSgVxcsHRqrwEpv2i0cuO6+jEwFPmhMLHIVE7wNU686wJj40KI1zV02/1oHhKVhOhmu/tLRLWoH85gNuGyXt1OpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733617; c=relaxed/simple;
	bh=k2u3cMQLTU6nmqDLe5HFbf6P4agmjGVuzdNLI8s9K2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=N7PG2ohfqsEydWDsDl3j0arBUrgB1NZEZixnZ2TV3ImN/WClAlgzpXrbmUfn4XloKylCc8vSqlm+/uZrcoBsdG10a5vgYAuwI0x/0yliiajM3UzhUqrc600Gvwzk+iV02XO4u7h0BLrMANOw1AYcfQIc5BKF2E5X3nA7pua5t/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OTpK4IKy; arc=none smtp.client-ip=101.71.155.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OTpK4IKy"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e4c12fe9;
	Fri, 18 Sep 2026 20:08:16 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/4] pmdomain: rockchip: drop duplicated errno from supply failure message
Date: Fri, 18 Sep 2026 20:07:38 +0800
Message-Id: <1789733258-10133-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0b46ad84003a4kunm5c34220f164168
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQkgaH1ZCGE5JTxhJHR
	keTB5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OTpK4IKyGqiwpCE3IOQKe94v5wqANKpgNm+WYU/U4OdTfXiPAdfFBCqyvVXmU4TAYnRwHiGF+9U5TsRYvKG5PkVBw093DJDetbPZqZRk6quhLFd10CzIlYy7x5FvJ8k1Hy0X6mK0X2vTCZtzDoWstXEXwTRhi6cEyWpxwhai6RE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=L38ywsGFkP5JtQHfFIAHW4aI+xM0RO7u0rEagaMw/Hg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

dev_err_probe() already appends the error code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index e193f97..dd5e2987 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -721,7 +721,7 @@ static int rockchip_pd_power_on(struct generic_pm_domain *domain)
 	ret = rockchip_pd_regulator_enable(pd);
 	if (ret)
 		return dev_err_probe(pd->pmu->dev, ret,
-				     "Failed to enable supply: %d\n", ret);
+				     "Failed to enable supply\n");
 
 	ret = rockchip_pd_power(pd, true);
 	if (ret)
-- 
2.7.4


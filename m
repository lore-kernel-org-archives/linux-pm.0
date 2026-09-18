Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com [220.197.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D73563E1
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735418; cv=none; b=j+75C+8zq++7mTtbPHZrI8dKPypXWY+UnTtiw/YN9aZYvZkGQsMFGHVLwOdh+mF9E31HvtWHpN4cv7dNqyQRiAr7s8AFVQyjn/TFA+rZFWj1jI5cGnOoYAcVeGhiKHzSNCpIw0qx2nUoTWbJ7J39lNoIgoamB3f0Nf5orWAHzus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735418; c=relaxed/simple;
	bh=FQQomiHrOADtf6rpCoNNq+sosE2LZpopxa3GIRLKlO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mpkfbDPJ4NVFIRFIcOwd2ldC8PBoD7ee8Y4APNRUfvlMfWj60mBX/SrigWEnky+XgEn+ConpDL5+WyffzNL6rvKCyFxT4CVOC9KOiHfRE0ohXq5u6SK207dJ21pSjI4VClusnghHdDL8bjRHsM/EA89RfR+CarvsyHevCs6y2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AlS/by0n; arc=none smtp.client-ip=220.197.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AlS/by0n"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e4c12fbe;
	Fri, 18 Sep 2026 20:07:54 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/4] pmdomain: rockchip: propagate subdomain add errors
Date: Fri, 18 Sep 2026 20:07:35 +0800
Message-Id: <1789733258-10133-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789733258-10133-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0b46a82e203a4kunm5c34220f1640d1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQhgeQ1YdSR5CThpCGE
	5MHRlWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=AlS/by0nylogZoeV0XjpX1P4PnYDBWH18sFZJWj9U0h8WOQlZ54IxIQ+BXA6/IKDq8FqHAW/zhET68hqVEeOkzWgBnjJQSbiuaa7bZ/ZKzyslSi4WFRBT3OyOq1Jj7D1BwWXngq+stgGV6ehcgJjP27VIQcwN/cY+Plo8dBNnEQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=GhhwQoELOawdooWCrE2EbpE6ODju7TA9wquESlNU2sA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

rockchip_pm_add_subdomain() ignored the return value of its recursive
call, so a failure deeper in the hierarchy was silently dropped and
probe still succeeded with an incomplete domain tree.

Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pmdomain/rockchip/pm-domains.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index ba66ae7..068dd4b3 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -1018,7 +1018,9 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 				parent_domain->name, child_domain->name);
 		}
 
-		rockchip_pm_add_subdomain(pmu, np);
+		error = rockchip_pm_add_subdomain(pmu, np);
+		if (error)
+			return error;
 	}
 
 	return 0;
-- 
2.7.4


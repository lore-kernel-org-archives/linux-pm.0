Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com [101.71.155.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B322749DC
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782683; cv=none; b=HYEvPOafn2dWsOXMJNerN/21KLSngJDbL64x3oC2yXtJ20oCLUOK8MQZnnWM2gY2DPaisW+DzBAIECScoGq7lfJwx1C+9ji/5CUKzuxmnpOQdF1SvGAr43N1GFUfSrC8LuNCg8u0GfyKwzLtX9z1PQR58cTYZUxCrGUrDqcthJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782683; c=relaxed/simple;
	bh=gNz7x7l3v1ySk2P61KZB7UTotqCZDgvosd9aeN6NctM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vq5Qrimiwz4cDNaeGu0VVJIQ5t5g23544bpLKGobMAvUPeAi464CqQYnfJu2f8tKNRJs/eNqGnLFPhLCwavyHeSLpgaGzeFvgzcWje1ENVRKWIrsRegG3MTPL0omz7WY7KIhWyZM7TTC7jG7yl5lXxinZPl+20S2DB7pZ3EK3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KBNlEdH1; arc=none smtp.client-ip=101.71.155.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KBNlEdH1"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e57cbc51;
	Sat, 19 Sep 2026 08:35:41 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 4/4] pmdomain: rockchip: drop duplicated errno from supply failure message
Date: Sat, 19 Sep 2026 08:35:11 +0800
Message-Id: <1789778111-173149-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789778111-173149-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789778111-173149-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0b717217a03a4kunm44a9997f1a8f94
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQk9JS1YfHx9PGE9MGk
	tNGEtWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KBNlEdH1vNSQoJ+lkfUxO1BYXqPYsaMwgkFA+DndFhc9+dK56NIi7J6CcGl76sKmW8MC7jkGWHNpLdkMePb5qpXmVYHLF0CqSIPXvgc5pyoC0pTvcXxsbDcmLX3uzC8REojqorxfvzD3BD4YBs3on/lmXO07K3D8uGZOIo6v1Hk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=PmtTMG7rosUEwaAKUVvSUzCJQZVC7qYUH0ykAT8dIp8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

dev_err_probe() already appends the error code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

Changes in v2: None

 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 9917ebf..1f236e1 100644
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


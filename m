Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1D3E0C4C;
	Fri, 17 Jul 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278451; cv=none; b=jJdM/mM+IX0mu5/ZJEfkAj4AlKgAoy26Jj4887sNeqa+8UPBogJL0Cc0C6RYvWGOIl7Dn1dE5YoPVvOoCMIC85FsAfvEOTFvEwxqUca1xIou+Cn0FO/GljmvS/SRE+vJ3QqrIfJ1meGWkPkLG8XdNtKG+WjC+widxbsEtdV80LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278451; c=relaxed/simple;
	bh=yLeEgXdUBNIR4HbnwnydG2IqAiO6ulWCbhx/Rrf2MNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDe2QznEvS9jEa8cx1yRjbLkTvNHdoFka+2+sGFTX1dE2uEvAZIw9vsriMFnBQI8hyITRKp73wDljH1YoYrumr/XkbTNJG/FW2gGxcvuNYegu3m2dP9dt6RD1q2Bet3hJjHKDb4/o6J59/mDRZeBr/AGVgcSdVOOvhmxJ9B+t4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=JPzIasAd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H7W/vmW6; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="JPzIasAd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H7W/vmW6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id B9F2713002D1;
	Fri, 17 Jul 2026 04:54:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Jul 2026 04:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784278447; x=
	1784282047; bh=jciNOVcjwfiY3K3wYHnk65hT9aC3kb+UF6ZOUQUxjM8=; b=J
	PzIasAd6Mb6g7wy0iH/sn+0Kb3n2neTY7MweFeYOMeRpSKHilodGjTevSk2jz5uq
	B0eaCEC7IAQfosLdHvgSEMbWinrs3YRoTjYRtOVHm8QOslnV8BBoYodbsfeTjDAx
	Kgv16jaiL8+Z7PTHM/K+1kCGazQmCzLz6v4PJxxskqHMB+r1N1NsmAl/pv+cK/Vo
	FZsvDmFXR0ycmax9X/mpjdPIy7T5MPgx68VHcKkAMUWV4qXRpzrJcWKJl+xZ6YwR
	rLxu111lysgwyo9evNk6O7sB3porLBVyfTNJ7HxDjQUBNJN9RldVqi5qouaVLf+O
	TMzuAnwQwYmg/wtm5T2ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784278447; x=1784282047; bh=j
	ciNOVcjwfiY3K3wYHnk65hT9aC3kb+UF6ZOUQUxjM8=; b=H7W/vmW6cHn0f589T
	sSBacdcq7Qsa2d7y8rFh7a8EHSfPVSKHFuYp9nWa7Be7BKEnyWNJvsftoD9D0iHH
	FLkgMTp/1Kh1DbUUuHhT3Tzro1DBFvM6PM77PIcOeXUF3V6qoev9bBSCVipi3FtJ
	nNxfb7dfnJCHQzHHOJFvNGcIlL1zcnJU8GC5LXwBJiGEKBnQuLbyCG74fa/+77/3
	pduidBSi64I4BSTb8mIUEoQsyOYku2RDaqQklvPf5MwgXgLi/zPcUhU1LTYsvQUp
	fram4giHOUdTgu2HUBWN51sk8xgG2Qd3qLoct4/xrxBi3Tt62dgr+bRvlUVTeci7
	MA1Og==
X-ME-Sender: <xms:r-1ZarvQMRK7VPD5GHElMXAdNtPez0ItPlDD6Jf6_cTnsKZJUK-W9w>
    <xme:r-1ZaqLINSBpDOmfQnJzF6evIO4MimTq7ZOIBa8Arqc9fSIen7VwNJzuJm7vAg9io
    Z65D7AcEFNpTDXU-qjI_zK1mrGKspUtzLBOo322eSKffKoE13cxj7bs>
X-ME-Received: <xmr:r-1Zagjj8s1XA7TzJ_qhpcfTjV6Wiauzd95Y-XFZoW4-V0aZw0nU8Oqaaquh3QsK-8_q1STIrmVihG_ajaU>
X-ME-Proxy-Cause: dmFkZTFS7GW/vS+PGg3aNaRtXNWwH13wr4t6a3PsYvzLEfoa0d1tCLQMk4kuPOyqJxWYg8
    zWRgYifu3Q3qEvL/I6D+A7sONbehMF6Fzv0Jx15W8Bp0zPI2L6EoHnTvsn7KCzlmdcjq5Z
    AMiUX8pm/4UU/5q2rly/ctUYuGrpfv6aggolOMe4+7cw+YQgQv04wJ8otXu77hR4cT4fFc
    rauulgYGXJAH/ttinZ2FdpHwYOQghdgc8wZDZhtrydZHcBfVIkqxRabCZivPsjLLb49//R
    HUixI1q1RTZqMytwufV0grN2inkZxcvjyE8RnYSpDV3z9U1hNPWgMeNXqfzcYN3TNROTmR
    RgdzuH7DU+5N1oY8M3ODw+67ns+HFGVOSMGhx5XQjWxx/E68KouXSoOpv/PUcY/YDeVRSP
    WK+GWEwQ7/prMm45XSJrsMeNKFxlTq1W4xqfm1rBdumM4pobMDS8xA4z5/fcup0LpFYmpx
    K/Yc3mOP4uOBFn+05OiOMmoDIXkNoQocZjQ3SG5OHVADrnlhqCsft8JbTumD+zChibYASt
    cM9nB9U5jUKCu6Z5+WfbcR6r7qq/eXvtnwaVVTqMW6bLVF5AS2NjuMsNlbltTaDEzr/tVg
    Z0HabB9G2gzJuq7f61cGRWOsPSvYZHlsefSmgZ0whRvkfasj+XJljWCYJ4rw
X-ME-Proxy: <xmx:r-1ZamuTL59blPvmv74ZiIvEo5A-LT34JoIV1CK0A_PKr17t6E0XsQ>
    <xmx:r-1Zaih9s_aEUraz5ZKwHABcymZXG9YqD8f42hXzqwXNBfXZnwNsJQ>
    <xmx:r-1ZapdbiGf4nvsVQpnvGXbTihYD0GC4Ei3ImCyzdxQsNWEk0CAr-Q>
    <xmx:r-1Zanldm8Jv3_veMoAAkJ4kOHmdMY0J6AOh0q2P-t-SRBDTTZfdUw>
    <xmx:r-1ZarISlvY7p8Rl8QhZZAflQSdhsrsVOHbZYMusJtoVGobKYDDvE7ux>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:54:01 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH 5/9] iommu/rockchip: skip orphaned-fault banks in CMD_ENABLE_STALL dispatch
Date: Fri, 17 Jul 2026 20:50:43 +1200
Message-ID: <20260717085220.3212274-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717085220.3212274-1-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sending CMD_ENABLE_STALL to a bank that carries an orphaned firmware
fault (PAGE_FAULT_ACTIVE & !STALL_ACTIVE & IDLE) causes the command to
be silently dropped by that bank.  The dropped command also interferes
with the other banks' stall transition, delaying them past the poll
timeout even though they would otherwise stall within a few
microseconds.

Skip such banks when issuing CMD_ENABLE_STALL, matching the skip
condition already used in rk_iommu_is_stall_active().

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/iommu/rockchip-iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f42ffcafb..ce586919b 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -434,7 +434,21 @@ static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 	if (!rk_iommu_is_paging_enabled(iommu))
 		return 0;
 
-	rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_STALL);
+	/*
+	 * Do not send CMD_ENABLE_STALL to orphaned-fault banks
+	 * (PAGE_FAULT_ACTIVE & !STALL_ACTIVE & IDLE): the command is ignored
+	 * by such a bank but its presence on the shared bus delays the other
+	 * banks from reaching STALL_ACTIVE within the poll timeout.
+	 */
+	for (i = 0; i < iommu->num_mmu; i++) {
+		u32 status = rk_iommu_read(iommu->bases[i], RK_MMU_STATUS);
+
+		if ((status & RK_MMU_STATUS_PAGE_FAULT_ACTIVE) &&
+		    !(status & RK_MMU_STATUS_STALL_ACTIVE) &&
+		    (status & RK_MMU_STATUS_IDLE))
+			continue;
+		writel(RK_MMU_CMD_ENABLE_STALL, iommu->bases[i] + RK_MMU_COMMAND);
+	}
 
 	ret = readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
 				 val, RK_MMU_POLL_PERIOD_US,
-- 
2.43.0


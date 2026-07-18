Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEC29E110;
	Sat, 18 Jul 2026 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344345; cv=none; b=TGhMOjDXwLJIgh0TRRzgoeqe2JffySAhptWv5tnUtA8SHlpJ+zulpU/RIyAEE82rZMb9x1oE5JCluEFEXny2xl6SEk/QeyTdoApP6rTz9w38sZy+nd94V8Ws6ykjPjXg31nB5r4eUk13I9/2UZu9xsvNj/FAbFNcIsOrqY+rO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344345; c=relaxed/simple;
	bh=taecRovNMmTTM6gLwgWpEaHTa4pE0pHZP0lhZbmrF+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nih1on6MtfxkITu9voYgqcAZByFPyHVTSIZUPNHDyrCls/L3PMAimWlbA0lOs2WOi+lkRjZC0Z0Gf5I6bADDL+s47lx33xRNYWlSnpG7+Nj8sbARHldqmXfSDVPWngoyNzvemynbQ9hm3QGzfUnBw2GjgGk7L3coZiSTsfifuW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=KisL0cry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pAtRK2eA; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="KisL0cry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pAtRK2eA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id DB5F91380324;
	Fri, 17 Jul 2026 23:12:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 23:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784344342; x=
	1784347942; bh=wXvq1c4qizRzzY1hTlhX58r8EY1LF4K2+vKFMFHqhy0=; b=K
	isL0cryIGZUG2o0BJQoSP+6F1qram42RST1EX9LCVWUr+6WyltiiVAx2sA8yxkXr
	efqu9kwy8rJ7DT09AIXRxtCUIG3Jnh38byCO/kgmn9iZ39GPRECkWtoaJ/F3OExq
	9g0mfQde7bE15b+BHIH4DPag0L/s25Hl/uLYP2EZpwcWNjfA3qwSXE8BYCw7kC/k
	BV2B+nH6fVx0EgJBb7I5HNa7QoJUqLt2SCqnHk3TVu72R9gAqaS2dM+XE0QXvNz5
	0jT9PD4pk5KYKZOs1zLJzYHle6gqI2Ex6g9gfnLid5TB3Z9D4Wao62HPdZ4cGErN
	leEYBcrYeh3audaBNpJ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784344342; x=1784347942; bh=w
	Xvq1c4qizRzzY1hTlhX58r8EY1LF4K2+vKFMFHqhy0=; b=pAtRK2eAtWYWGxKOO
	MzfGIZ+5bb6mFU7sYm7oNM5nb8IIxT9SCRFCA7f9liAOmjYqkZksQEPQeOF5SBqT
	6YOJcQiNSo1LEKMEsoJbgIBcW5cowJUcAOR6PLb/knegcnE6fYsNM+B4vGdIed2S
	sjgEw7B8UIxKt3ME/Smc12YXz3WLvg9q8en+2E8YirF9M4fGwmjDivh869gAjHYW
	2H8aD3jm7Wb37rkTtTBQZ6YFt4jq/vuJ76zLNl0/0Zes3h0du24wh2Mekl8N7F8n
	xegkIy9C3LfOhvxflk3KBkFK99y8QIMBQFlHLZ52vgj2WrvWc6hzfs8WBGI6enhQ
	TCKWQ==
X-ME-Sender: <xms:Fu9aamPUhUWUVaX06r_A_pnGm7xiB9dIn0u6B3UKimNabNhzX2jGug>
    <xme:Fu9aalUUH0aEX3pM9pG1u3MzUk_hrksPMYQwnnIOitPPJv1UXsot8Rk56UnHJA9ws
    TcTPybgQdx_8ra5TZ5EM_zsaxjyXrW8IsChVZeoid-qc48qMhHfBQs>
X-ME-Received: <xmr:Fu9aauYTlrrbM3lnSxywYftCxWDFolcFpGpzCbNl_PHD1N2CNi-KgZfHCZW6Z_KpkNob8DBPdHzMx-vkhIo>
X-ME-Proxy-Cause: dmFkZTGdKxYqml70filiwpZAyk9xzZJVUlqXITOq/+pve3XDBYV5qFz8ckWzdQnjGAsfQy
    L94g1S87pSC5A9PqOBmMyyQxvTemSxjsbxCMpV/UkyIw4k85IPMDo4giJDv9meY8W+3ZGJ
    7rs8txKC3pJCgGY8R/cZ16F7AaqWitLXNMydDLsiRhcPuepjcDlKsNyGTcEuNL/NTe46O5
    sbfF0mBd8sxOQr9Axpf/T6uMsL4/0TWxsZd5HtKP2wSMtsouDi5D48PHZsJKTSrN97AFgX
    YyfukrwTjiOyNncXeK6X1bkSY9feAEdBHftqOdE8w0ekw432MGokFfhFE0xgjYmONoZjin
    a+kHlDTSFT5aoAlKXEFvaoTApnxll2T/cMjWi6lx5mplMsZG8x2yGbJucTRJHNJKoXdm6/
    8PbCal1stX7stfKqYDVhOL1EK2VUDTi/E/D/QVuSqFE5NE60qw4Q/YDP54EZ93q/Iyh2lG
    ibrFwrTKGZveR3sDzFOG4A3najJGt7j6Qk+ToxGmqOz4leQisD33E+CX4zlNlGpONqnXWZ
    +GfzHRhV/a8IcbmZ5PtS2a9tKpdYzmqrWByu/PzzJpJegpO9HtdP+VU3jO41VvYHNhRVMj
    /hYbxrA4yuT4EmbE65+3d7MPD8WP3E7fdkX56KdTlDTjURcSA44lqcsWclpw
X-ME-Proxy: <xmx:Fu9aaivOoLEQVr9XTSuJzmpQVZeVotb1ZGYAH-0IsIrTyi5j8K9nDg>
    <xmx:Fu9aatluhQ9mm0O3JR8T31B-SqX18T9kwhOsl4DKu9UMjc840SCVTg>
    <xmx:Fu9aajXQLoYeV28E6-mLRvSg7stB7pjKLwqX8sibFv1t59vABBKULw>
    <xmx:Fu9aagni_11MlSGeEAx96onP3KyQBldg_yIMr0dFyay6MOLmCuBUtA>
    <xmx:Fu9aasDUC-3WKaoPvFOutZH8cptEd0MAPaQGMP3bsDz3b6zJvtZF0W8u>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 23:12:15 -0400 (EDT)
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
Cc: chaoyi.chen@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v2 2/8] pmdomain/rockchip: add optional per-domain power-on settle delay
Date: Sat, 18 Jul 2026 15:11:40 +1200
Message-ID: <20260718031146.3368811-3-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718031146.3368811-1-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU domains need a short settle time after the idle
request is released before the QoS registers behind the domain are
written: restoring QoS immediately after de-idle can raise an SError
on the register access while the NoC is still settling (observed on
ROCK 4D as a panic inside rockchip_pd_power() during NPU runtime-PM
cycling).

The vendor kernel handles this with a per-domain delay_us field
applied between the de-idle request and the QoS restore, carrying
15us for the RK3576 NPUTOP domain.  Mirror that: add delay_us to
rockchip_domain_info, honor it in rockchip_pd_power() right before
rockchip_pmu_restore_qos(), and set 15us for NPUTOP, NPU0 and NPU1
(the two core domains power-cycle constantly under runtime PM and
showed the same symptom during bring-up).  All other domains keep 0,
so nothing changes for them.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 51 ++++++++++++++------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 490bbb1d1..1787f62ba 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -59,6 +59,7 @@ struct rockchip_domain_info {
 	u32 pwr_offset;
 	u32 mem_offset;
 	u32 req_offset;
+	u32 delay_us;
 };
 
 struct rockchip_pmu_info {
@@ -185,7 +186,7 @@ struct rockchip_pmu {
 	.need_regulator = regulator,			\
 }
 
-#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
+#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, delay, wakeup)	\
 {							\
 	.name = _name,					\
 	.pwr_offset = p_offset,				\
@@ -200,6 +201,7 @@ struct rockchip_pmu {
 	.req_mask = (req),				\
 	.idle_mask = (idle),				\
 	.clk_ungate_mask = (g_mask),			\
+	.delay_us = (delay),				\
 	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
 }
@@ -244,8 +246,8 @@ struct rockchip_pmu {
 #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
 	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
 
-#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
-	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
+#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
+	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup)
 
 /*
  * Dynamic Memory Controller may need to coordinate with us -- see
@@ -612,7 +614,6 @@ static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 			return ret;
 	}
 
-
 	ret = readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_on,
 					is_on == on, 0, 10000);
 	if (ret) {
@@ -667,6 +668,9 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (ret < 0)
 			goto out;
 
+		if (pd->info->delay_us)
+			udelay(pd->info->delay_us);
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -1286,25 +1290,26 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
 };
 
 static const struct rockchip_domain_info rk3576_pm_domains[] = {
-	[RK3576_PD_NPU]		= DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       false),
-	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false),
-	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false),
-	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false),
-	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false),
-	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       false),
-	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
-	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
-	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
-	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
-	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
-	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
-	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
-	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
-	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
-	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
-	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
-	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
-	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
+	/*                                               name    p_offset pwr      status  r_status r_offset req      idle     g_mask   delay wakeup */
+	[RK3576_PD_NPU]		= DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       0,    false),
+	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  0,    false),
+	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     0,    false),
+	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  0,    false),
+	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), 0,    false),
+	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       0,    false),
+	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  0,    false),
+	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  0,    false),
+	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  0,    false),
+	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  0,    true),
+	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  0,    false),
+	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   0,    false),
+	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  0,    false),
+	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  0,    false),
+	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  0,    false),
+	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    15,   false),
+	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    15,   false),
+	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    15,   false),
+	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  0,    false),
 };
 
 static const struct rockchip_domain_info rk3588_pm_domains[] = {
-- 
2.43.0


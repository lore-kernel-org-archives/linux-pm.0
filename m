Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A874376BEF;
	Fri, 17 Jul 2026 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278399; cv=none; b=XzsARZxnSHlU0ekQqu0EswU22GjYpq9fjDeS242bbMMLHZgc6l84XIAqhw8AW/atB3vhZET1LKeNKVtjz+oJ94oCpl6WMIIgIbVgkIWa+d8IM5RnlbRJWZ/K62H//Mv6+pYW2TGApBcAqvgL+CsmOoqR8Rp/XZqVjZ4QmyCCJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278399; c=relaxed/simple;
	bh=taecRovNMmTTM6gLwgWpEaHTa4pE0pHZP0lhZbmrF+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bA6ahRltXe+pQC3B2D/hSqTyn73Hs8Xb0/Wzm/GYXJEkfK/OpRBn2O5ki+tTP/KTsSzV2Tajs6cGSUg7NwIdaICHwXf2Mxyvm80ZjpOAo//khkmeG6DVXrxr7bSeRPmn8t8K3RxH/u/PUntyyVB4iZF5nxhXCD9BdRt8p4Vve2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=TRagtDUS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdCMXrAB; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="TRagtDUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdCMXrAB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 3162C13002B6;
	Fri, 17 Jul 2026 04:53:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 04:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784278397; x=
	1784281997; bh=wXvq1c4qizRzzY1hTlhX58r8EY1LF4K2+vKFMFHqhy0=; b=T
	RagtDUSUeUPQre/8I1sDc8VWHkrxSvEFA4F/ZI/QbgY2D3gl7QU19W/Ji/+poel0
	37jFDCYrmgkHriwMl9nxI0UhFnysRL+O+baSLvKctz86N/ya2QJeF06/RUxS6sy2
	5LHoL+idL1cvl/aDLLKcsgZ65y5zEZnXnm5ppRykrHQYZdlev6zqId8EwicGCOwG
	ADM+sEkGCVGkcZk1Ufq57FX1H4xfa4rBCK/eMF5k73u0487718JIhAUqHzct8mQb
	SkdCz5OFiWwN2nOLuVdP0omOsK13xA7/0vf+z4t9rZH/DuXLg0q7G45dk4edR7jF
	0Dn1t+tK9Zm8gAcE5EW7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784278397; x=1784281997; bh=w
	Xvq1c4qizRzzY1hTlhX58r8EY1LF4K2+vKFMFHqhy0=; b=GdCMXrABS7a/9BKEa
	7kWeh8VeAZTV4XoiqnD+186ZbuAVkn8LAv4ykLmPMDa9I54XNUcSYZyv31ogpjb4
	Vk7SPCPoPb75NsP6D3Ai+MsudFkdKWkNyhEYaQ3tF6b6CgIKxKT2T0uwyG9n6Ag0
	JVKdMbBoyiLpCHHNe716h07i3gHZchw28ChszIZJc1OnJswr1nsI9ZgptoTLLPIT
	wrodD6Jc5u6ewl4cCnd+4WrkTUynf4MH50o/8MeUNxPPKAhlAo+qrW0Qs5EN+U26
	nhDtTpWtnHEi+YDXELEhBFzybpSnKJR+MQZJT5ev3mXAWz8vNCAHgSoje3ZyVAkN
	8BwBg==
X-ME-Sender: <xms:fO1ZamdYB5OTfVz5QXJLqIgFtnU6sBCfhSDdBEYKGa4Ce212RdOxIg>
    <xme:fO1ZasF8hOA1t1UjLFEYjDZA7Pq33HDgcAj77F9ADTFhpI8nc9C55yLtReUt6bRYa
    ZUKY-oI9t4B86wqE6WrtvGwnnCEeoUpCkCIFc5S_-MekyzwoiUMtw>
X-ME-Received: <xmr:fO1ZajBrfgnhqquGjJn-zv9GP20dxmGTfQ4SLtmwBea8gWJmA6YYPAlS6ZzHKe_ZDplmfLCp24IyhtYqDFY>
X-ME-Proxy-Cause: dmFkZTG16mKV94tZPvKsg+wPyPbpns4AHanTkNBYO5Ham9g0s2KCPd/AQbQlnJWsv8rFsU
    x0B5kDLRFWMrpIoCTawm5+fWdymCJG66EACayyvKZ8t7ETpdXAjykbi7Ep5TEu4b14/WMe
    BGMFOJX3RtCigXWJ3iA64sUC22dsLNtIqxF3R+iE8n5Usvm0JKu22WmUN+I0FI3QiO03EO
    kA4A29l52nNb+rlPotr+Uofb1AURlU4GE9cJ70aJXqGjwmP+F6dkiqiMbPVNZVe3dblSOV
    jij6t+VXs0YJYSv4g+8uYKwnr7PUgBHjYqyHkeqCYxGc2wks7xm53FWYu50I0/g2y1SxQz
    Ue2OKCz3PQeAISfebD0h21DtDEo2WwbQ3Y9DEVsIQfcAu1f29kVzErW7W3f98VepYNEw/F
    K//IU/yNpvWZ7FNC2m5taTcEQsN4N3gQ2NqItVsNb2MELCDv6yZ3oOASAnMS52J1ZIehgq
    RN1E0SH3my7K6hV1GSPzgbqdEXwSNGv+El8RRrBKvGfF02YkrC7wnGtydb9BINaQUvSgR8
    DytcuOvkmhxSxXrTQbAfMJJKJUMPGY25HzL/kv8UEIi6Uir9QPnDigIz1BS07bjkUVJduf
    9Hyk3PnwbjTmIO/FrimSY4eo06vOq42fIoL2ndVInMdSGJTPfpaAOdm7FIOA
X-ME-Proxy: <xmx:fO1Zan6t02JZ5OpbIQs2a2_wp1zfhstdqpTrmxtozG_xykbR5E02rg>
    <xmx:fO1ZaqnLk_EM13dbv6aD9gBgwwbRIHSYXjLqZrTEQl1bYpuhJAvqbA>
    <xmx:fO1Zao4jD7O25UBsVI_20bhxx2UmTI1PPKla0GAUTmSLjHXzOIia4w>
    <xmx:fO1ZagXZFcwRFU8jUXkxDDSinNm3D9ZFcKypoahsegtjqI7Yi4DgxA>
    <xmx:fO1ZaiPI158L99XMwjmMjPLHuD7FFlNko31pBWvM_iI9g76RL8wZyxfo>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:53:11 -0400 (EDT)
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
Subject: [RFC PATCH 2/9] pmdomain/rockchip: add optional per-domain power-on settle delay
Date: Fri, 17 Jul 2026 20:50:40 +1200
Message-ID: <20260717085220.3212274-3-gahing@gahingwoo.com>
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


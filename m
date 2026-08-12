Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D040F729;
	Wed, 12 Aug 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527736; cv=none; b=CLK61PMTZqvoLZzKue4jEMCtKN8yr2V+j56EmYtoNtoCTi5R4ptRGY9shVOFZFi4YKZUj6P0rmrclBNzzgnJYnXRJSxywsbvOV0ePaP3nirmcWKJUqg/3lmMlFLS9YgPHD2Fr3q1Ik4RIS6l76G3Yy0zH3/AkvX8kSplQ/hmotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527736; c=relaxed/simple;
	bh=Nqr6CHpbpiWW3sfNMJPrm+iAevtY2L63F6/aYqFMSg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prwh76tjTg5Uf8mPdzD/MZZbmwWklj4XDVDwAbaKbuAzDgDo6dzd8rj6QKa+8BOzkgvQVd80EtrRS0kGBCrJyZ6Vbbp1JbZsnwxBAFjaR+wZ8ElNEa9H/GpzN9LhHiUyHofSEVjqBIXpmIFck0NZ0zFB6Br26fy6xrSxvylPtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=GFT5g87V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=krf4k/gk; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="GFT5g87V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krf4k/gk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 47BC913000EE;
	Wed, 12 Aug 2026 05:42:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 05:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527733; x=
	1786531333; bh=VvFxDkgIfF4tDBD9QKpFN4dgXBjYLgU2XHjl6k+8r/M=; b=G
	FT5g87VxVsjwH38z9nFsEnRbXgQ6u2CviLiT1CgIzl0Rv53iu2WxZw17BcvudQw6
	lmc0U60gc1rx15DYVqhuV0+NpUogT2XAk/PU/MMkCRw/9WtB7axl2HLX+XINPW2T
	vtooVgZEjC6WoPOXYN4ncfJbtWtluQlgPvTKW6Mqt+5VtcEfrCa+qOEcn4mo6Sj7
	nZduQzxXHjtSmLixih8cf39MmL/4f23/BOdIWPoXGS2IoGb6lJgT12dnfbFRTw4w
	PdqCYpodq/StxjTMqvvIyWCe3sf1YoFOEVBPMZeZSeBma521n52Lsdoxw2JAx6mt
	9FUnBJxn1nmMpXeY4k21w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527733; x=1786531333; bh=V
	vFxDkgIfF4tDBD9QKpFN4dgXBjYLgU2XHjl6k+8r/M=; b=krf4k/gkGYZTKWHYp
	2c+i65gmuv/Ipvz/ZqfCTMY0CGPkCqWekI9EXaesgU4SsezXuC8LVMBU65CjSBpv
	NTjihxqPHWncl37PDs7hdCGMZi3939y3cn04OiGvK1NbNMBFV47sWj0cf6AXVSfk
	dlp8Wp8QD+rPg+JoP/Zqd6rekGRen7UoFoxz9Sg5s4A6QONr78D5qNjZPvUPLSXF
	SQwY74kRox48f4pyaTa/rf2Sg5ax5+1IBMGGrj/gbBRQslasDhGFX8cqyxJaKXSG
	RO2m+vTOj9ZTg16iiMKSbAo2M58QCGhTYDokdwmiB8wmiE+FPvHJ4Rv1BNYsx4Cd
	oj/kg==
X-ME-Sender: <xms:9D98akqCVJlDIf0dojPlTl29Mf1R9hHf_ZHdJAfYVNYyOaPEgqIziA>
    <xme:9D98amwk5NblGbWImj_swyhBXEAO6oDxIQDcZmJPANCjRsunvyHjhcANkzQA3Zt6x
    xa-fe4rQRt8l4jffWbu0GSAru_5sFWqS3EtYTEIcNobRVhkOocAKh0>
X-ME-Received: <xmr:9D98alDWtttm9kefdXq-Ik9jkDRhMpVxoqqiIFlEA5CVbR5Zc_kn-ugDO_sGaZ9RkRZdZFr7tg>
X-ME-Proxy-Cause: dmFkZTEPBq1l3vFlyW0vKyyzWbsEa8EjIJrLsZFQa+nnMaKW9vbMVF1o3VXk/fr8PXXfwo
    EHGGBPBVgnGNQ4MZA+j3T+aCPWSOGEzAvjDORzQTfgPB/Ainylhn3owwbGK9va5TERblfI
    pZC1Z9NgyoofcMrcorhTINRDtTJvhbtCpv4Cgf4bCaPcZhnbvMaCed02P82qQB69ERAnMu
    jJ3Xu0AR6n3Rt452d42hgFmHGx5kk8HXgHeV5NQkgbxlDfToVJV8iUy3qTKNY0qUCY3BG/
    aaNQSHMLtlJ9/cSg7vuYjBeElNsZYw8heCP9G/4EgRkJkAPO+nbLXZ1pSvU0kIewZmBOQH
    nFWxW9OICU/XsflE5jQqjJwaRWuBaM9Ytq8NrOWlxeYhT7JmkwWNHGcSZKL5RYnyLmLvh3
    QbTYt7p5V1TuWixWW1iahM2UQFaNxFg4YC1I7Fq0yW5USc5uFCu9zsYDmwbWrypUt+/bub
    aOF5X14Y880Fln0dUguOlrtwjK1E9sQbLZEN0u2GL8Va23w9xtaJLpcsU4Lwlbz8azY0b+
    G9Jf4eFEfbYVltErFtvq3F40gaoj5ZR/ZZQACTW7Nbl4uW3JjlVJlJJZ/uF404ZVnMUFQP
    x+2rD8z9B35cfkTeWlP2BoV12Y5Q9JrbakVS9qazhTqU3uxYHSaLw0w26FDA
X-ME-Proxy: <xmx:9D98alO7gVbJSjD8wR-L7wYKyh2Vp83nDiqLJUw0I3xMMAl_hGTxjA>
    <xmx:9D98akAFDAvcQc4RoXsC3JStehXnIvW_EgHrc-Ma4djXGBWhDZaZTw>
    <xmx:9D98avmxRDFH1_Y6hX-GQQ4OhtcsD1Uvk14G9mFnhPayhwq7HWeAvg>
    <xmx:9D98agraHbYKeL8_Y59d3zadDRvDoJXdaqTOCOaV9j63AhsVuITK2A>
    <xmx:9T98aieWOXpICA8KwrmMbxB4UhNkDmoO_5xdt5exZCpn2nSStn2QlivA>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:42:05 -0400 (EDT)
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
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v7 05/10] pmdomain/rockchip: add optional per-domain power-on settle delay
Date: Wed, 12 Aug 2026 21:41:00 +1200
Message-ID: <20260812094106.1391698-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812094106.1391698-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU domains need a short settle time after the idle request
is released before the QoS registers behind the domain answer. Without
it rockchip_pmu_restore_qos() reads back zeroes, and the NPU throws an
async SError on the first cold power-on.

Give rockchip_domain_info an optional delay_us and wait for it between
releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
DOMAIN_M_O_R_G_W, since the suffixes name the fields the macro sets and
this one now also carries a wakeup delay; RK3576 is its only user, so
the old spelling is not kept around.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 52 +++++++++++++++-----------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index ba66ae719..e1857f878 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
@@ -59,6 +60,7 @@ struct rockchip_domain_info {
 	u32 pwr_offset;
 	u32 mem_offset;
 	u32 req_offset;
+	u32 delay_us;
 };
 
 struct rockchip_pmu_info {
@@ -185,7 +187,7 @@ struct rockchip_pmu {
 	.need_regulator = regulator,			\
 }
 
-#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
+#define DOMAIN_M_O_R_G_W(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, delay, wakeup)	\
 {							\
 	.name = _name,					\
 	.pwr_offset = p_offset,				\
@@ -200,6 +202,7 @@ struct rockchip_pmu {
 	.req_mask = (req),				\
 	.idle_mask = (idle),				\
 	.clk_ungate_mask = (g_mask),			\
+	.delay_us = (delay),				\
 	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
 }
@@ -258,8 +261,8 @@ struct rockchip_pmu {
 #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
 	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
 
-#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
-	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
+#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
+	DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup)
 
 /*
  * Dynamic Memory Controller may need to coordinate with us -- see
@@ -681,6 +684,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (ret < 0)
 			goto out;
 
+		/* Some domains need to settle before the QoS registers answer. */
+		if (pd->info->delay_us)
+			udelay(pd->info->delay_us);
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -1300,25 +1307,26 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
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
+	/*                                            name    p_offset pwr      status  r_status r_offset req      idle     g_mask   delay wakeup */
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


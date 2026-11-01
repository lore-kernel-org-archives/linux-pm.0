Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521498;
	b=eeARUAzDxGIYZIojcShaPaA7pkv2UOxuANQzhPhoEF96oCelIy18ZCT8VkLpKgD6aAQ7
	 KItWCK4qxWEX6rywUB9Vy0mNcLW7vdLyr2imdzGmwFwj5bxNrdOqRmgviz5sKb14XBXTh
	 Jq2iM8gh8Dvfc6oCQJB4Rk3arSVMe4tBsMk2Q+Wt0nvk1ORonKPJQLz1aj+Cy2evtJzuE
	 0vi/JuuoUhgpFKoB//WRe5uOUeODlstP33/pFafDtMbTMXKDmg6JPLgCXkSuklgDhJioi
	 3Q2m3BaSjN2z3rLXAT8QxB8HsmWi760Bris2FNzK6YNaLeJrSsLTZu0xzn/hNRHbDjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521498;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=vai96abn6DVbKfDPrFaOsY+Kl2W7PtNxOEzJYmgAL4I=;
	b=tSqqhxS0uM+3oCMkyeiQ7DXeyyH5dr/vJbmtfIizPNxpMFdnzBXSWTotEX7GbpndpKIx
	 imfKvXOHHyTzvXj3hh+OrPAUPHBsSu6uPUj5JNPYYuiYegN1n81pEqVdmSVDekVchSSK7
	 2dyM/dzzJYSbpmtUf9aiKFnhYMjPE9/3tbwbFwHnk+BWMJzNG+aTCWoPcwiy1FG1fWKLR
	 avbBshR1saSdm+pfAKyNt7eT1ODeLaFz6twst32f7Q3RuFKSHelIMJQY6PbtZGdocHe9t
	 Vzl6E0UXeDhJ1MqnKJK5ConMcjIej/vqsOqPismp/hieITV2IvABGEiaABHrhGoD1jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=cqvEt4wR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="L/h072UA";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B02606A327
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B02606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=cqvEt4wR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=L/h072UA
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A9E5140030E
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:24:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 01 Nov 2026 03:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521496; x=
	1793607896; bh=vai96abn6DVbKfDPrFaOsY+Kl2W7PtNxOEzJYmgAL4I=; b=c
	qvEt4wR7KqSeIMetv63gl9dAgjhJ/6CPFRHWo04LZVTMuTClG0gyJALTTyYDuQ6K
	G/4k89PCoWQk3jspSf4I0SNTa71hVGRSkRFDKHmYC5UjIOXSzczbsw7MwGcWeG8B
	75a/MYRi0bKGu8hYxy+rqiuIiWp0GIjxUyZxiZoy20JX5g3NK/ltapSseN7Jr0gc
	Q4jfvGSk2cUHWt43FxbCMOib7It6Nt9yqtPgIkraXv8cr2TqHLl6ITVwhqVZ36Tu
	qvkJach+xPR+HYFt7skunzdoNk7ywd8EQyHjJfyc5oeNgnMG+ch5AX3wZC+VwINb
	Iy4BjkdQtNeVwtDnZkWjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521496; x=1793607896; bh=v
	ai96abn6DVbKfDPrFaOsY+Kl2W7PtNxOEzJYmgAL4I=; b=L/h072UA6KwKZ3obl
	8Sdji1mLou8TY7GcBNkq8d0F4Fk6fQLiGMCZ8ETNXGg5w37KkpsilMkhayHcpkmi
	6xNMm5lIEolHvOv12KkUWgq19dbFVjC3x3V/yhdNvqzPGgPUy4OXJWBTaJjdyVD1
	rtEoZSJALy/03JYleebwfvCfncvB5VYO8Ql3m1eSPEQf9nlYEQ9f59KYOoxcuxG2
	v255cbDu00sCyHCc52LTOQC8yNr1BQxQHlACGHzH4Kbt2yG7n9lSSfcSkjFvk7Yw
	sydWICkw5DQDUVa+hKo7pJMZ9VXft+ifqoRYse43/tIHQsRH4IQ+3d5nk18mVZEl
	SgfDg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521496; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:jktKQdCM+9919pAueO3MqbvQACYL6mPvZ5mmJLSZA1zpI0q
	TCERFn5xCPZMlXWOTztTVzEDg5h6+RYCcF5zPvg/DHdOaroLw9Da9w4Gjbc6gQEl
	F2+DtfiJehSsHG1JheavcAU4ImbPJxcheZc9Jlkx5LNWRb7lk36/xRykCf6bZLkV
	W1q3vgGcRAwMYBXPnbv/f31x7wa15cufXxrEnc0/gMty1CGefBUHiVc3bbnOCiFS
	2bigRtkItD2xDGt/aiA7AtE39Sl6DnP+9644EtOKPpHZ8jFO0hwPEWaq7Oo7jXKE
	3TUZJnb7d8rTcTBdKTmPa/B5yMsrCLd9YSLXqcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GEGsmBv/0DI5bJ6oecu9LQcVo29Gi8Rdlajvw0F3t+c=:tV/Rr+jnUuiby/AI6znuUctx84c6IIh68ZduMZ22sWs=;
X-ME-Sender: <xms:WPfmal4Ht6Bsm7x8lOmsESJdsPuLLxlg1PxQdKExJAWXKbAf7wkvBA>
    <xme:WPfmalM7LsqKa6ZkUyjg_S3Ol3ZBg3KTND2kknEYeQSLAFH7ohZdxAPFYyQZKUEx3
    5nMqC7RbkKnP0TvgXqdhXgJDccfgX5fDsFbrBm6bwB4LKiYZpchIurZ>
X-ME-Received: <xmr:WPfmarIxU2ZCgcFuku-cqlj14sg-7U6KAbhJCL5r1BP_PE9gkvVILlXujJZhBw3qM0Tci0fE>
X-ME-Proxy-Cause: dmFkZTEio0HITRPU8VpT4PebgbYf+HqQTVmTBwoXIcaWhSPJQuOpCGNL4Feyfw1mm6jNto
    aCqGt+GjGmHddQdDYMsFOcBW2fd2wbE1C2hSqpUPgYFBCtzpG0VAhrL+r+dSJb3xHPmeXu
    bbiU80H+3s8diofjGu9JFbSOoisVQrvN3eDU6svi49hrmcI63rUfSkuUe5+aUvGFuszdig
    Qnc72eHSOddgDW0HvcKHXNvldok2Sz2296F+6Jr1XxRzNWV9h54MRHCMGFMHXdGms8Xsm1
    Bk/Rw1sBqh58/z5F2FEqlRBvxPnvur8T5rxLVrR8npGrMSSnol3N1co7aLduCklPXA/vnn
    +EMljHPbN6yc+dh6VU0T1PUpGwkdUd1wlXSEdSO8CXUZ59Npi0Ar8GmjV7Auofe6zcDPDP
    aMtMiti8yi9QbsF4kp+U6NJWifdPA2ZAB0xMvYbHSzxGYMlfs1OI54ou1jVSF0iRzM0BgO
    +90heK0v8kEQny/K6CEk8NWu0oMEmBOFp2mFZ9kDEPxRETyxwWsebZfJBJNpyo18lEYfcG
    kE9jD7mNK3ibCKiGtJpMURZJ/QchV5hHopO1+8oUNnbZsoSvbzVOdgs9lNVJnu/m6Gir97
    yTnlHFJNKIMC0saht+K9T0WZGiqt1NqMdNzH42iYN8Dh78YJMRVGVbPHFgeA
X-ME-Proxy: <xmx:WPfmarEqV_UkbUhsk1U-_aEd6IvRnfRJW8utqwdHol1IDxUv97nTKg>
    <xmx:WPfmamxQNT0SEFooiBoBh5SuhwQ1OICNlOHPDtIlbAJTe1bkd6Aw7g>
    <xmx:WPfmavz1U_F9z1Je1GpQtBCFI8WbidQXBafxNnmoEegrmpe6v1Ye7Q>
    <xmx:WPfmakY6hYYVeu70gnVDQUuF7JUzyEr9tzWhk2HTJXyQ-_twy-CNyg>
    <xmx:WPfmahFuhyfZ97hZ0Pd_QH5KAbeGpsnEIRqeZuOP5CaHAb2iPbef7CmG>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:24:46 -0500 (EST)
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
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v15 09/15] pmdomain: rockchip: add optional per-domain power-on settle delay
Date: Sun,  1 Nov 2026 21:23:01 +1300
Message-ID: <20261101082307.151957-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU domains need a short settle time after the idle request is
released before the registers behind the domain answer. Without it the QoS
writes that rockchip_pmu_restore_qos() issues land while the domain is
still coming up, and the NPU throws an async SError on the first cold
power-on.

Give rockchip_domain_info an optional delay_us and wait for it between
releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
DOMAIN_M_O_R_G_W for the settle delay it now carries; RK3576 is its only
user, so the old spelling is not kept around.

The macro also takes the regulator argument DOMAIN_M_O_R and DOMAIN_M_R
already have, and RK3576_PD_NPU passes true, so
rockchip_pm_add_one_domain() powers that domain off at probe and the delay
runs on the first power-on even when a bootloader left the NPU up.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 56 ++++++++++++++++----------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index db3879846db6..e3cc60fa2277 100644
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
+#define DOMAIN_M_O_R_G_W(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, delay, wakeup, regulator)	\
 {							\
 	.name = _name,					\
 	.pwr_offset = p_offset,				\
@@ -200,8 +202,10 @@ struct rockchip_pmu {
 	.req_mask = (req),				\
 	.idle_mask = (idle),				\
 	.clk_ungate_mask = (g_mask),			\
+	.delay_us = (delay),				\
 	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
+	.need_regulator = regulator,			\
 }
 
 #define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator)	\
@@ -258,8 +262,11 @@ struct rockchip_pmu {
 #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
 	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
 
-#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
-	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
+#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
+	DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup, false)
+
+#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
+	DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup, true)
 
 /*
  * Dynamic Memory Controller may need to coordinate with us -- see
@@ -681,6 +688,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (ret < 0)
 			goto out;
 
+		/* Some domains need to settle before the QoS registers answer. */
+		if (pd->info->delay_us)
+			udelay(pd->info->delay_us);
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -1314,25 +1325,26 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
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
+	[RK3576_PD_NPU]		= DOMAIN_RK3576_R("npu",  0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       0,    false),
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


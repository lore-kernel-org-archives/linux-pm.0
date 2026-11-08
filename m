Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121329;
	b=mcQgqS6oUhPOoaXuk1yfhUVQJJM4I74DC/J6Y904AiNSE2ODhMV4CryqTZqkNMlBdm1g
	 HaHWy89pYuuG5hQGD4VCwykDLXZBJ9In5KRGpkBXSem4L86+2WU5oHoTbmd+SMYrtppNz
	 NxzD6ou9Wtzn5hfOzqZZK/Vce8pdAMY4FNITzk46owqhsRZSRUKYGc8UfCD/qnVO8cR8H
	 NDdJNFRUXvhdknlA63ytA+Nmi3sg7OvApLrWNb408RIINzjpqI6Upjp7sV3MYOJ8aG5Bw
	 yup3QKjNoNZDdxH/MvxOkk3EMcnXRDfeeEpPGJk/LT7RZJB7+qzPiFXgP+wq3xR2wRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121329;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=DD43XPeL9eSxZv6x7yCqcJs+UE3ZFOhhZ/dwMhRj3wU=;
	b=r/3a62SB5qkLWOQCIuxwFpmiY9tn3Wi1AKpB808o4ak5rhTucGpPRcMddOxD1Ni0dVsh
	 28bN9g4WyE2BHxHmsfrdehaQRFm/kk7VzZ9poplGxS2GYVcQiZqcyPSNp1i9b93Qr8nIq
	 YGxGcG3FrnvI4P3g8JSrprAvJzwNVA6k97RfFZ01LhVMiRiDtrzq4v4CYec0HeQWHB3Uj
	 6CKTu14KAsNFfgOD3jnA053RTEbfsCulTdAFNCcb9L4VleneTEvy+j1Psslm/B5j/YN51
	 YBaRvCqbzYTRB9KlgoM67O09z75xjL4VB50QZ53vHM+pI5lDgv8c4eJeuyvKl6y8Ccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=O5GGDqBD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mAqkKdqC;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46982606A31A
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46982606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=O5GGDqBD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mAqkKdqC
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C9B081D0016A
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:02:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 02:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121323; x=
	1794207723; bh=DD43XPeL9eSxZv6x7yCqcJs+UE3ZFOhhZ/dwMhRj3wU=; b=O
	5GGDqBDuh/Ues/vb1LJZgavr5e+bZZXwoNiRZmqKrRLIyCHyrjIs6M1zd/2bY2Sn
	zNItEXgi43xzgRQVL/DJd4C5IShET1zjQz6LlSY4IP5xEEotuUxEx7NZvBwl+k7y
	Wq4bt1ndp/8C3N8SyGnvz/udLcWNjY82ZlvmzPWfvH5Ei/6ezPpszu1lrZREvoOX
	PaxKLd3atm2qZ6UELm8/x/f8tusoABgTpARzqoSZx/2uuBnm5XgE0JqsrWK+zxBw
	iEoy7euX5EJeUJqKQaU2W0FFHmJgyaktSZPa54AbM2UkF/L0UKFTqWU9WCH4zhFy
	AGS9I1zUSNipLYt0cGkvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121323; x=1794207723; bh=D
	D43XPeL9eSxZv6x7yCqcJs+UE3ZFOhhZ/dwMhRj3wU=; b=mAqkKdqCSB8+6247A
	esOcghoZHBO9CEfLN6PeO82cOX/KvUfSfYhioviWK/mOYZESzOButBQD3peVKq/a
	T6xx0duOMa7Uf1lSqpyXbrQKhv9lpl7RNphq2E/fwB/kR803H9GmdOF7w471Oatx
	IOU0AkPlGHk+zuv9lR+9CXEMxNz6TJNr47LCJj1TlaehGylxGg6GSEWJ7pQu8Edq
	Xm5P1E4aMp4lAjrga/WGFoUeKcEtsWeqTJ6NG7pwUvfzvbMrIwDc5y/0KF/H+WDv
	rjHsVqGjmxjt8QjQ3AVE62zczrGSFifmZjbcAfZ1cTUMiLVKvdYY73mGXYFm6z/b
	NSPzw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121323; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:d78xuCA6m+4onQdzf4YHVmTdvQd+uVIC/v7FiXl7z40MnNf
	cUDge2F4qKfQ02OSIOvBFDyT1zNk56FG+j/HPZJhrZRtWlHu9r+KA7cDiOhZUfml
	MBzbdjzUapnFVpwaDW2WLrtxLMQQr4obCdUWVIug3qar15TVlgG/l4EynN64oVZ2
	xOEOel+JcIEicHu6WguDyqrk6hwcpzLly4oDIl3Ftu5P3GNWy6OVAQ22GcJRDwKI
	c/SAaoa40TY+prgwQr2y3D+cA4z37RVeFet6XVCuv8Ksg9kv0sRG2WYq3OUt4o0A
	b/3ZI/pv/p1nX7LrlQlK7yo/3OFBPjXAq0KbnNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ICZdxShwWdMue3MqUGRvgTzjO++CZDxGgXpWEoFSIFQ=:/yBxaiKZ1kTfj9yFiWN9yB78Q/BNFE7xXq3qjs59jpg=;
X-ME-Sender: <xms:ax7wau57Omlp2IppK2OYZjohyoDLuZ-4Xri0NAYojI1ADmVUlDTyFA>
    <xme:ax7wakUZNuASNQ2MN4T7MYc8vj1u5mm-9mGCxmiCBNxWrDfFDeNC1sJNJxXMDVoq9
    M8AcoOqIvScFiAqxDX4stO-pcEwJC2GeGkSq-SGi8hI-HyTVmuCZGNc>
X-ME-Received: <xmr:ax7waksLNz6FrXDWgD57gEIsbX7PqiIUavlqz4528mN0Wzzjq44ASbfOj3veL1i50uHV3k4z>
X-ME-Proxy-Cause: dmFkZTE5NwZyd+ayTW5ihGeNQbl/O97mnCf1OvUw/2ZR6E1IltWJneehUG6lk211J8bNJD
    GXJcI3YZAXRTrSK5sFTlbLrxzALRC4/6lE7XOctvroRrxMX83re1MlqThq6OcFmRxLDIeg
    dPCIoY08hWRgpTEOmeQAgr6Hi8Hlw66W3366qbyMNTuQvlUyucz9MwwrNSeHDrR4V+rZ6p
    c0CmZtStyiRIxl7LZ2wOt1R6dxPekaPzd2JrKFAURgPeOZIDlHjlK5E6ILvTQRx5g4acrU
    benuNqZX04E55T+WlvMPFZHgoTh9KI7gGDaRJvvN55diSFD3RWkTgRJnSKwwWUx3YOF8XQ
    wCeSILsOcdtUc5DxAdSCG+Lv2dq2i34Xd6eGxFM3m7KJv8txXWMV6oErXRs3QHhCcjF5jU
    Qx0sqw3f/d2bDl+xoX38qbpGaUUFiEMl0UJ3RMY4rcpMoGBB04MiQGXg/1leIbxxzjYF+O
    L5CIiaC/YCKixz4Av4qooT5djaMcsAIuacB1AcfFkWmGdV7XUgci2HgdPLeW+RVbm0A7ep
    t3+Rwf7j3fYAuWSnbyLQ9WrLgzm7Dt5838ywkrqfTW3DVSPiwadM+AhxmaGkU1AI1B/qYY
    lqkGYijTVfueKGKzsYNzyzQu5MLe4D+wnMzYnqutRumK1Mvm/yXFzRCZWeNA
X-ME-Proxy: <xmx:ax7wahpNDiJxoSuyaQSJTJfxnUv9clLsKE_VqNrdnDSs__SRH3VkWw>
    <xmx:ax7waiaVN03aIj5VNeOonrRCl4H0EF-nQjL6bsp4SdwSjk6eeu-0kQ>
    <xmx:ax7waiycMpo4x1kH_cGBNtS9_3oI6ANzpzJgeJgopaugYWqMJWkMBQ>
    <xmx:ax7wao_7TRUAEZkQvBQEBSupbxwsiWDAdqXFeAvAtZBQo7GwqkBdmA>
    <xmx:ax7wasQP6LdEg11UnwKbFTq7LUr5Azm8jHWhNEUN9Lrl-POhN8uikUqb>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:01:54 -0500 (EST)
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
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
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
Subject: [PATCH v16 09/16] pmdomain: rockchip: add optional per-domain power-on settle delay
Date: Sun,  8 Nov 2026 19:59:10 +1300
Message-ID: <20261108065917.135194-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
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

The RK3576 NPU power domains need some time to settle after the idle
request is released.

Without that wait, the QoS registers are written while the domain is not
fully up, and the first cold power-on raises an SError.

Add an optional delay_us field and wait that long after releasing the
idle request and before restoring QoS.

Rename the DOMAIN_M_O_R_G macro to DOMAIN_M_O_R_G_W.

The NPU power domain is switched off when the driver probes, so the first
power-on goes through this wait even when the bootloader left the NPU on.

With delay_us set to 0, an SError still happens even with the regulator
kept always on; with 15 us, 536 cold power-ons in a row are all clean.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
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


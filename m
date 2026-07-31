Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C6C33939D;
	Fri, 31 Jul 2026 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472535; cv=none; b=K1FF2l40u4JK/4BxYh0Borh7LNIaoB+JMpP7mOlo6P0copSqYsiuZvtEBgZnYZw7nKoNi1ckm9AXgQ52sOCel59+oBC/9/oHoO+JrdIT70TCCFreGbkDNwmef0IfYuwqurGQ7NzsnTdfcbssxRY64Zw1jEI+NL6btryxCuO2IUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472535; c=relaxed/simple;
	bh=Nqr6CHpbpiWW3sfNMJPrm+iAevtY2L63F6/aYqFMSg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0+VhNfm5lOkHgzAASYf2tBZPs1ciHJaE3BCaUuLTAIOJf5+AgakZUmj9Q72nv1K52N5Mh9fX7oxfyFFfd40IjepW6vm2+4P5CYgbbD4BInR55BqaMGf3LEFdLheL0B/5mHMfHqGsDtKggb5J4RyIBvpYxk+NEMZWRm9lGqKl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=ceMmo2sL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFMN/OYm; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ceMmo2sL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFMN/OYm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 80BF21380308;
	Fri, 31 Jul 2026 00:35:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jul 2026 00:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785472532; x=
	1785476132; bh=VvFxDkgIfF4tDBD9QKpFN4dgXBjYLgU2XHjl6k+8r/M=; b=c
	eMmo2sLsEwi/GhXBRJSGYhUEAzazg/dydcjgnkzahm4pVaQYYHh2b5v4G4vOC56W
	9W5hdnfJaoI+TTN7VMZD15LjX1CkBUPiBj34dvJJsGcLU4CGuXeTAQEtQ89RPg2j
	5oDH/NQvCZHSQtEdGnt82UDQHJTps0bCx1ePQx4tUnALpU/PRDhK2rVHe8mLqVOP
	6n81JU9ka1TJEcHDxU/6OMhBkWejRA74paHMWt7Npgiaa0KRkkztSTUo2/jc5aA6
	22A9nViqHdgmVCniwAsya1LcP592rGPvwDrCbT2teP8IQzVCGYMleCvCtm+o5iXJ
	EDI6CUBq1xr0VvG43Z46A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785472532; x=1785476132; bh=V
	vFxDkgIfF4tDBD9QKpFN4dgXBjYLgU2XHjl6k+8r/M=; b=RFMN/OYmnr/w4gRH4
	unlqSe2v+v8GYNk+ApcFiLZizmIgOjlvcLhK35k9OPKoEfkkkx0w2WliS+pV+Q5Q
	Ai2jIdWW+ig8HuSbKpvoqbI4O8dI0PrXMbxfPsWyGyda1vp+d8d+zb5Qq8VJe15L
	Z6PpmfqlSIYkl2WKhOJRCMoje/fsrnuaeKB5ZGX5gvcJG8TDK7Vv5H2nNQE7MihV
	GlrIZIerI3qivdL3GEu7wXdiKJFfVIDtdBOLMtkWnaeZwVi7wO5h3zVbaj9knhAu
	GxrzuSZJ1/kOvISZ2LPfSATRiG7y4sSqbjwY+I2RlP0YIgwcJb1IoaL9VnvFxjQ1
	GwAHw==
X-ME-Sender: <xms:FCZsamujFgzXAx0kEriuqf-5eeJoM85taVScn65FRDetEXR2x6XouA>
    <xme:FCZsajZtEPHV2T-q1BChkR7clR6jOOHC0TvZCg0YXFf4ckVFsZDEvN7WUUu3ExErs
    B8pCZkF5Y_DCMr0EHv0bkCTl0_XhXSlQJRmZhIbT3BQGE4QSkzWE9s>
X-ME-Received: <xmr:FCZsao8Ni_07fGmc_CMamhMoO19HW_IhfkS2ZV30M9h7erZ79TbHiimnvreS-6Zy7fyhrrwssQ>
X-ME-Proxy-Cause: dmFkZTF8sD394lmCh4bBILhIMKVCxZujkZC4HlhAlb1eGKAAio9lvVIrql9/Thjmj0PtFZ
    PTYJJMYJqSaWRvldah/DDdEuATX0c7SCchrtH+GXsJAjXTDng0ARkyc1L5kt71yJXQS1fz
    SuwQTDjUHkJ8DiAA0q5X+/cr+6kDvceTSWa2s5H+aCXGtfFDLGiRLQ7cL14b7N1WNfozUn
    A6eIjMU6jhefqnlUAWJMOGBErdNiW+Ohg422WiypYdl5HtAT1EhJh/zxcJ33OpVcFw4zgr
    VaE1u+Waf1BXL8a31jll6LvWthjXrzIH2KY2kTM++EM0QFFr+bJhvr6bS/ZD6jNnokQMLj
    QaWt71rTPOD7+6lVwfhlaCPwmf9E1kWv0X3TTgy3OncK7bNJKV4R323yiv+005oNPZd3OR
    NkoOvqkTdsacQrxIHLVeBRTF0faZFo0J+mz/Ua9LhXn9/haVDtyTJoXDZq02eRNtMKLhuf
    JOCPXCTU2nggYAxOucCpmf0MJvcpRUK0XnV8J/wbPlHQrHzwltxxVubziJZLpWAM8JNlrU
    6zuDehiWM4gzIiQ786eVYBhbN64/ff3D4YUqsjGnUF8fjVmjp5BhNRTDGFTw8VrMQEx8WJ
    f5VGr/7Omo7WUAklq0Hw2xapUVl29NvFtu3iclVnEqspgRLBwtMBFF4O3tjA
X-ME-Proxy: <xmx:FCZsanqdGnlSKK8iFg1S8_9mhlv_r_8sucAzXxASeSDZ_GyY2SDALA>
    <xmx:FCZsajH7NySLfB8ZYjvNtvYZfjuxjALul69F8bNpH0wGCuH_wOGxeA>
    <xmx:FCZsavkxZuvm_tQWmDR6sCJ2vkhJ0ljfM-sBBLGXLKW51tZtroY0gg>
    <xmx:FCZsan_xUyV8lBzQMyQaAFsZMe31LgtsiPaZxDvmjAQFo38FAARpKQ>
    <xmx:FCZsagSmB74nUQqAfXvRsfZi-UeOHiVYCuj1FBTKYAC5fOogWJC7tvzi>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 00:35:27 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com,
	alchark@flipper.net,
	royalnet026@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v3 2/6] pmdomain/rockchip: add optional per-domain power-on settle delay
Date: Fri, 31 Jul 2026 16:35:03 +1200
Message-ID: <20260731043507.1832277-3-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731043507.1832277-1-gahing@gahingwoo.com>
References: <20260731043507.1832277-1-gahing@gahingwoo.com>
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


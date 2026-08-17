Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930E40911F;
	Mon, 17 Aug 2026 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966652; cv=none; b=brScyew7BxQsWzyOWUhG1/NHas6Zp75mUttEdKN9UwNEIIT8Aj6Pv38mE7iamy25feY5BTl95sHZSeiM5McYgTyUwx1/XlUkjYJsT67Oqv8yvb8wglPPAzvq0AH6HfLBRWarI/sSNGmuN10Rg+q9EFHYA/97qicevZSu4lkCbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966652; c=relaxed/simple;
	bh=exTIbWSnlDbTPHqbx0TnTOgcJs7P9pBt/ew4TNkw2AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2YBz5LtfjOM/H2NxPeyh4yN1ghG5c+cqIEv78GvzmlDPS/ZKnE6CqPR7fcq83Sqz4VwANMmMAhhGCjstbW/2D5yiUm1YGN3wc/ARIQSyR9qeckEvFYvM9dfFPVuXsFozJJogkPsVWXyzJRAY2fv+MAvfT/ucy3y3kh/Y/qdHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=tdVlPF7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBdSENGD; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="tdVlPF7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBdSENGD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 3C0F51380159;
	Mon, 17 Aug 2026 07:37:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 07:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786966649; x=
	1786970249; bh=qQ/yKUINgwWm4fYdv4J1jyOmp0DO/DEYDuItDSVwisU=; b=t
	dVlPF7cVFDXg9/hLSTWguZ5rq2CfwTwlOJSgRNtXObmI4EyH5jmUNSTH61XBBho4
	yINlLstS18YNos64YJzcM0ejWr1alC+XmbcVMsnNZhqXk8f/9G5Ai4SJ9MLKtKdB
	nSO8zPz+kxsUe0uXEv88MPstegX7rv8SpSqTNKHG4ySF0iXyfPpK+oIhqijW3848
	HW3rSZXxOiwQKI+xe5oxpP/8ncmgxszzXHdaftungqbjCMfEenS6gXdm0G/JuqP1
	NZLeLHLKNH42qQGV1VG5oJi+zQpm9+3r8pG2BTqvWmAgxVmdP0xybbftcHGGHgBo
	pmA8awn1vbXPy73Kofndw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786966649; x=1786970249; bh=q
	Q/yKUINgwWm4fYdv4J1jyOmp0DO/DEYDuItDSVwisU=; b=hBdSENGDtC2+sHX56
	UL/X//Hbs0n1+WnK8Vxjhe6EvS2Rg7G943dOOvVIloHnXhP3RRug6dXSN02WtSrR
	hGXyanVbEmNzCVY862OwyI35bL9np1vzLZ6H+OBCGNXrrvs6ZNJjIgC1fxhx43Jp
	fXwwQJYtgH7Psl451BGyr/WfL7KyYKglDj/YIxMiZvF4Z+Q2E6oVWFkIc0lOmraC
	O33p9RdDrtHvQYXlmob6MYv5GgjIYcfiHJLZrp6Vh4Hh4vqWzC/Wz6pbkyUq74st
	y85mXHQ0eeofUJNfhd4MT9rWLfFKT0YnHYJWNlNHiqaHohfzajxauteIR1JfEaOR
	KJoqg==
X-ME-Sender: <xms:ePKCanNtF3QqFwKKwJf1EtyE__rfDNM6c4PPhwW6JAuciwxaWYGv5g>
    <xme:ePKCauEa9XKHxkcbtJ96RoMjNCbFJGNoHaI-ZtHa7sNS_S4WQijLJyvRCgfVVDKhR
    Hmbyf7BU_Lhnrg8AwdAQmxeAW-fyhw0dSUq7iT1CPQ-Si89SD0QX1lb>
X-ME-Received: <xmr:ePKCaiHkODaf6CpwRZos9QXjd2OVh-UW6WKGpQyQM_qbL590AsiA27i9x6yrlN7c9hF1phhOrQ>
X-ME-Proxy-Cause: dmFkZTGn55Su7Hrpv3xQW8kiCeQLMMXe+EtNw8Ny5aOMmrmA/S52UxT8toGIRHunZ5TeC3
    8CUVPo0T3TI3v5+JSydbOrVRGOweYdzSDjgeJ2HQU+QnteRCG4RIWbk2YstaxI8PwPUpsI
    B5rlrRzzeplZJm8yeVSbv/dntMzH8U1W06Jzf6jYXremoRNGcl11nn7wHzWdkBjGJoGDz5
    K29ctzqiIeZqkCbp46aL398FJPW7bEBGCmrhb0F1vK6pVmU9zPAKi/cGOkmtwexgjxIL+q
    96O5UmLol4m5QizJ2A09pNn8WXCDa3t2pEd6bRFohA1nn7RuA+wCG078NSdyrM65XTwvCl
    8glXO8amaeogp2qLxSdhK02mGhwJRdIODHTt4gOJfII51sKJ/xTdhzKjVH+bDRRWUKNe7U
    qn2sEYFml42DGAvEAMMLmowf2wuAIBcv7OzsGYtVeQEi6yhYCDMJ/4qTgdrXwg0YgwqKxE
    sWtNEgogQQARCUrFf0DLMaLDlDh3fO2K8l6+PGsBWj6LWsKyIPsuVkKfp0fhiYEoVV6N68
    A3n8qaG4FPxugXPBL33x3VtPkCJV+FW0NiWv77EI82Ya0glRBju4iEiThTYr9A2Zr+hfoQ
    NSVNobcuU2MdpVFpuLaHbYJhGeyHBydwdlaivoHbDzsM/A2lhGBbReuYyelQ
X-ME-Proxy: <xmx:ePKCalBj97KPoiuabN--VjQSCgXuI9LAv-Dmi5A0oEeBaVwEeB-mbw>
    <xmx:ePKCavnZTWEi50uBSuOdN76EfNbDAsgvJvlf08iOjpst7W4NgfzZcA>
    <xmx:ePKCar569pjgDeHTPn54C9qRNfyXjKzXmTnw1PCwCGxygsNFkitAvw>
    <xmx:ePKCautTzYKXq6ZsqiorXc9YScQK3XfLdbiubJOykzmeHCOyMcaQhg>
    <xmx:efKCanUIUxQTRhbXyjmnfFbgjcaVp-lRNW1woMwHQ-ZFHaV7_3rm1N08>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:37:21 -0400 (EDT)
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
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v8 07/12] pmdomain/rockchip: add optional per-domain power-on settle delay
Date: Mon, 17 Aug 2026 23:35:58 +1200
Message-ID: <20260817113603.1436067-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU domains need a short settle time after the idle request
is released before the registers behind the domain answer. Without it
the QoS writes that rockchip_pmu_restore_qos() issues land while the
domain is still coming up, and the NPU throws an async SError on the
first cold power-on.

Give rockchip_domain_info an optional delay_us and wait for it between
releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
DOMAIN_M_O_R_G_W, since the suffixes name the fields the macro sets and
this one now also carries a wakeup delay; RK3576 is its only user, so
the old spelling is not kept around.

While the macro is being rewritten, give it the regulator argument that
DOMAIN_M_O_R and DOMAIN_M_R already take. Without .need_regulator set,
rockchip_pd_regulator_enable() returns early for every RK3576 domain, so
a domain-supply in the device tree is never looked up and never enabled.
Add a DOMAIN_RK3576_R spelling that passes true and use it for
RK3576_PD_NPU, which is the one RK3576 domain with a rail of its own;
every other domain passes false and is unchanged.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 56 ++++++++++++++++----------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index ba66ae719..39988efd8 100644
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
 
@@ -1300,25 +1311,26 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
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


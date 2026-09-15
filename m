Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDC757EA;
	Tue, 15 Sep 2026 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469131; cv=none; b=ol+k5iOgqxognQFY7Ey8I0qaI/lmwhHNYo+KPFY9E+7O2LEemfTcbDFq62xn63j/XqKLRo6EXM7H6VGJRwEBtC0Z5J59fv3NbF7Sr+RZZDnfI4fMuM0IZCU0i4glaQzFi19LDaqf5dhWxXXBVMzaIxunb+MHpWrgKCNOp583WzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469131; c=relaxed/simple;
	bh=9JlB1wAfk8eiNm0B+CSchjx4/2s+XxWZWZHlOOyUWuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tukCZI2qrAKbpImygIvv6qlRHbJ5Zx2Scsj5LKKgG/d/WO8piaGoWyM1fal+12hvhTrivadPvgTv25OFzIlgojkGh6/oo8lShPYm2Z/Jcb4aQhpBjGbnPFy6G5PYlEe/Vkax0Pv/s0VYUvL/md4E4pO/CqXbU5yVKDeB3mmb7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=mTn3J3Mk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0X8oEK1; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="mTn3J3Mk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0X8oEK1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 8803B1300517;
	Tue, 15 Sep 2026 06:45:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Sep 2026 06:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469128; x=
	1789476328; bh=AfLTjFKcw6FIMbVcNJi5khAPRHJ+oln3BDqlR9X/rnM=; b=m
	Tn3J3Mkjl49KxlXL2Plxc921MirCSA82PKh4dw6sgnzymKpjLTeJsYvxdjszRISx
	PefIqs8K+nbrO/Vk6eA/Xo+RqHFQsCnGwJt0ym+AtzCDqBiy/aHlAbURhK90+D30
	fU2LvnhXs/YxnInjc8qNRikpqeZJKzh6mETWsEvJgTW0h/Zpv4dEDHA2CeliUTLq
	aKCNwaLq7kk87Xf5zsXNoaoeosEumlM8PZRJBaDOhkCmq0Y5IdZ/bzSoj92xbdrt
	D1wxi0D0gISN36NnsIOyPuFOYLBDoUErz8tH4ql7BFmdyZYJTd/j8g1PiAmgBWI6
	PABiUwXIy7CDJ3zX9RYvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469128; x=1789476328; bh=A
	fLTjFKcw6FIMbVcNJi5khAPRHJ+oln3BDqlR9X/rnM=; b=E0X8oEK1da214JzgY
	Uo/Ee+chaOhL6V5d2AmdE26w2u1QJqmJnQdZmRKhs4GPpQS73ffD78TTqWtFIgrU
	EjJ37ynNjhZbkTXsoDwrdIaCIiePYHpxzgrJ63t8DEDI2hFZeFtuswSvS6YL64vW
	kKkvlq6Rv4iiiBT01/OBawJJU12wK8RhuiN8cjxOJjE2lZPonTOH79U2wGiZpfjk
	auexxFxvLYkaVoHotSFeR7RkDwUikzvOSs76f0vD714Wke19TCgm2lXVtm3Xdew/
	4re68Z9i4Z7iSS+j77bO7uT+aOz3n164x6NZZt5Qkd5Lnd9shjQTxElTNNBYO0Bj
	RwOlw==
X-ME-Sender: <xms:yCGpagG0iB8EIrtl0uhi8w9wtFF_XMAAhqGhXi0kVrqMljed8ypQaQ>
    <xme:yCGpapdq4XtwUIf4kETQMKGfMHihA2j86SW5LqJ1QUMdFcbuTnzIfExY7xUZM4h_e
    0KiJRpd4YnZ5YFrF8Mh25ITj4bgEpYUcUn1e7o5PhVnjop1P0_nQnE>
X-ME-Received: <xmr:yCGpan9qyHQtsSPvEfLPSPyCtgcza3HGbPjr1ljXgaZQUr-O1NipqSZ13Bg--cqVisn-Lxa7wQ>
X-ME-Proxy-Cause: dmFkZTEvgn30TE/Bhy7j+lDgP7gXmnxf1yEA4+9JDGkkLDKOX+PjWS6C4wfYB6bRewT1h4
    g+oMcdzBaiIBs5c+Pz0dQXZKfUwZnHiQVlJVJDqMWGJD2749OJ0l99nR2edJCf/ZcGPYLu
    30RXGTuoiFK6E8ovSjrRraOKQw1/yZ9qQ/P4z8BMLsmS14llkOiSgUnfVjorc51oae8LTo
    anVnmEPQ5HlX5K1+WHVdnXvbEVz7yNCh4wXVnb5mrixp2KjAAisQetPkg2Ry4FRfbKhSiZ
    90+dZVL2qmx3uYvp96MNB3kt9H9Tf++stO3hlho9KW9Zr3E3C1i+M3opDz8IhDGp0X2el+
    CMH4AvZTd9APlTfZ8R6sNS+p7snSOylauz7eHbO1uQoZYnBXzoWJrt50hTUdgNtKkGViSD
    NfOnEFuO38iOR6NzHOpJ7V2iEw3NS5dvUSLr0uhkkU/00i6fLVkhWJTrLqmYWsw2XAVMgy
    aKKkB62T9ZUgTzTukaon1yk272JexLptgIUGL341lBC+o1/nMA6WSpR5Uf+z36Vg113NDM
    kjLaO/pzVRypXy2BLgXE/3ERfOyGpw+sw56rcuHiv/qae4aAzKIWLJArPjdM8sZZfOgKRP
    iznA5uc1t7RuKo9dkSss9xOnjxYmlgBfRYnwczrTL1l5mCNqAS2S1fV92Hyw
X-ME-Proxy: <xmx:yCGpamWxDKxIu4de9CaGsSeS89H63lm-GNxJrMbdOZLQuSdgntuI0Q>
    <xmx:yCGpakj0_SHCWn7_eZuxM6qemp8xOlOjrMZ0P_AQQCGywY98VhgytA>
    <xmx:yCGpakymf_T7ByxBOxyRORb4VwGJ1bJ9EdcNFCa-QxWZB-83jlpePA>
    <xmx:yCGpaqo8ROPQniPq6wmK0s3xb8WnAe0vXbiL5LMlyHkDtt2RkOtUBQ>
    <xmx:yCGparpBD4ylS1I6zHVuIcrrTWtf5bpGZYsvXYjnwSQDexpiP6ILh9Ou>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:45:19 -0400 (EDT)
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v13 09/14] pmdomain: rockchip: add optional per-domain power-on settle delay
Date: Tue, 15 Sep 2026 22:43:23 +1200
Message-ID: <20260915104328.45901-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
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

The suffix scheme does not survive this cleanly and it is worth saying so
rather than leaving it for review. The letters name fields, but R already
means two things in this family: DOMAIN_M_O_R takes r_status and r_offset
AND a regulator under one R, while DOMAIN_M_R has no repair fields and its
R is the regulator. DOMAIN_M_O_R_G's R was the repair pair -- it did not
set need_regulator at all -- so the paragraph below, which gives it one,
adds a field the name does not mention. Naming it _W_R or _RG would be
inventing a convention rather than following one. Say which you would
rather have.

While the macro is being rewritten, give it the regulator argument that
DOMAIN_M_O_R and DOMAIN_M_R already take. Without .need_regulator set,
rockchip_pd_regulator_enable() returns early for every RK3576 domain, so a
domain-supply in the device tree is never looked up and never enabled. Add
a DOMAIN_RK3576_R spelling that passes true and use it for RK3576_PD_NPU,
which is the one RK3576 domain with a rail of its own; every other domain
passes false and is unchanged.

Two things beyond the delay, both worth saying out loud because neither is
what the subject describes.

RK3576_PD_NPU also gets need_regulator here, which makes
rockchip_pm_add_one_domain() call rockchip_pd_power(pd, false) at probe on
all thirteen in-tree rk3576 boards. Only rock-4d enables an NPU core, and
it is the one that declares the supply, so on the other twelve ->power_on
never runs and the regulator is never looked up at all. It is deliberate,
and it is what the delay is for:
without the domain being forced off at probe, a bootloader that leaves the
NPU powered means ->power_on is never called and neither the delay nor
10/14's reset pulse ever runs.

This is not new behaviour in this driver. RK3588_PD_NPU has carried
need_regulator since it was added and its req_mask is 0 exactly as this
one's is, so rockchip_pd_power(pd, false) has been running at probe on every
rk3588 board, with rockchip_pmu_set_idle_request() returning immediately
because there is no request to make. Of the forty-nine in-tree rk3588 board
files, twenty-one enable an NPU core and declare the supply, twenty-six do
not enable one at all so ->power_on never runs for them, and two enable it
with no supply: quartzpro64 and youyeetoo-yy3588 take the dummy regulator
and the one line dev_warn from the regulator core today. The idle
handshake lives in the child domains and on both SoCs they keep it:
NPUTOP, NPU0 and NPU1 carry req and idle masks of their own.

If that is too much for one patch, say so and it splits.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
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


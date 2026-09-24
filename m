Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C00476CCE;
	Thu, 24 Sep 2026 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245424; cv=none; b=hcUU3JdR8Kktq/dwC3Nf+qyyrcQgFdIiRY8ICdTkpocr+c8qut068bUsVkWKlCtkwcWMgCME/+L+bHoNsv3nY29o1pDjWSDbWvltp3/6kBF5kZCrSBlj42bJFEDgoC12XA0bjYl1a23fgnLFxd4IEwuMPgedf4OHVCIWdb9Q3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245424; c=relaxed/simple;
	bh=J/kQISM1ChJkRxHBTKbgvZq9BU4NjbM5iwquFjJ6zWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnk7fDu9kbtWkavBKEXV4JSIXJJjoRGAbNGatf+nWkYhda258waFR0dCSEdH8YrqCa09VfmrTaWiuQB01ZhWiR/rYIFkTooTU2zRfoa1HLP1yiUH31zBlKR9s7Jw6ZNQYiyMMtSlMBFg/2wteIc18H13Z428r1tYtqM4JU/JQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=nj1IQtXx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rN0O+nHL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="nj1IQtXx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rN0O+nHL"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 386697A0097;
	Thu, 24 Sep 2026 06:23:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 24 Sep 2026 06:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245421; x=
	1790331821; bh=LqocEyI670pyCTIGwzT65n5wuBExGewZWGVng4NeEbc=; b=n
	j1IQtXxdEgJTQBTXutFrRb/aRxNZ/9UYQYrqxfWK1MUSBsp6HRTdqi+G6Mm062B4
	qJcajsuSwFGq4vrh8u/2RK7QBDk4cdNc9YHz+6iTc96Xja/OtVK/MzgRlmtqdscS
	NKVOhz6UnE3LyKrfxgkNqd8IO8rlXfNJLuHROJfzSJb6Afi+x9QRcxUiztcI1ej7
	7/5Umofbmg7xB7Exdj4AAqbyjxtH3+xQNBhxKw+3wVjH4ckRGL/XdgxPJfFn9ogl
	igsjiWU8Mdd5h23feRh3a1R66J7BDZCWvlu8d37ZzZqWLznfO6ZdcTSMCVPAzrYv
	qGNBbH3wpLiyI9EYSJviw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245421; x=1790331821; bh=L
	qocEyI670pyCTIGwzT65n5wuBExGewZWGVng4NeEbc=; b=rN0O+nHLwgQZdhtqk
	eEIDY0IJaQ+YCNaqciVeVD7OiVilcWotsQo+F4/cmelvUKP70mQpk2HcQefJCt6g
	Ohh/nTC5+VuAI0HPHDmqc2zwIcXpB8vA/A/jrf1WLwOs+nhCkwiooSvXoynyYrPr
	Va714qE5imIeAIPENNM0wLzWa4ZTIP6I20c8IECZWEJ4p4l8h3j7blGaReqVh79p
	IeTdI5shvQrTVP/MkbgGEKAqc4M7LQVXdqfJsmaGXcqt1aExr1z/19usXZfe7oCK
	A6gWqPTVH2qg5WdY2AFWqB02YUq1hLE3xa92vk+9UhJN06FpTVnzMK5e86kmaVpL
	jXsaA==
X-ME-Sender: <xms:LPq0ao0KJ48D9z79GKiJU0rbiH7fqVsFIL23M50WOOXDWO5nzMuApg>
    <xme:LPq0ajMMHnXXX567xg-2ivIhhZpcvc49VZ7eMfXVDZ7ODIQNYOomqx5fxFqJJQMoj
    -cAJrAjNvBKvO09OtsUURzTDxORG_LF2L-NN2iwGgzF9rE66IglZj-r1A>
X-ME-Received: <xmr:LPq0authm1BZzl4g8_nNJmjL6mjKlLjsTKz-CGWB100sfzUYhTnUq7fcphiPUvg6Wi9abq7x2g>
X-ME-Proxy-Cause: dmFkZTGDX9MhO02E6aN+xiCdNxSLlRQcCcCNuvJqlDq/EeMyqx9sOhFfhs0W3+1YUs0VtZ
    C4nEebFI0osOzqEkQHRvG/7wkcbKglvvfYaeqp3aI8yQkFiebpTmTpj4nhIcZkrHx5wdwr
    kRnVCaW8+aKaXLKS/OflxApldP8QfdDM+5W3jozW36QZJgdRxSemzjs9ko+Wb/wLHMQeLb
    eD+rruhjEh6WPODJKZu+5eS2P9OpWF1fvgBuOreOmXgkjB4+pF8qHyniimi1rz9dR9dFf+
    ZQpqbFvZmfrj6mFfFmlpuarA1kw/E5U/tvFDqLyFRTZ7flH2koDx6Na4EwL+XG2w7O70Uu
    EXx4H5lXMKJJnQJuGrn9kXURTTuLjeoq8IhwOSRiqcA/Hdb0ISV33Ygv/jHQEP3p0G2+RC
    4gYvXb+JDOe3ttbw/H+JCuW2z5nFTv9ojg/b4YlhhWql0WYRUE2v3BQUFRgWw9YgIdELe/
    n+0RhsXk8quLnkNHD1Zekm1qyin4M8jNF29hNViBwciQ6Ocz0BS2QBLCr9aNUrejnWyDL6
    k+AQ78jOLaf6Xp58jVxUz2Rvm2Gb40F2iFLNTSvvj2WO/nDfQ6c5ipNin51njZYEZFDUH0
    IGHwf19catdKlnIQltczrNzeRAqZGrVwYSSqMntrYGRRNlQMu5rCDVJSnuWw
X-ME-Proxy: <xmx:LPq0amESu458MA6QP_y0_qSnLgq_m8V3qMI6CKN3fGmXPLHpF3aJjw>
    <xmx:LPq0apSnr0FH3tn4CCwL9UYEBByrfWIrhxwemgALEhtU_kroSxJsSA>
    <xmx:LPq0aqhFT0xu8WssnVGUVwPn7aQCy_eYa0McgN9RLqn5YXC0r2toKg>
    <xmx:LPq0ata-p4DcCQAhwM2lDTzO1F_5j_s9jrIjsiY93LScRWB8acqztQ>
    <xmx:Lfq0agyPzxJsqOWbTFo_VbyAvxaWVZBhUGDNgqS2S9AG-v_zs-lyvYuS>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:23:32 -0400 (EDT)
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
Subject: [PATCH v14 09/15] pmdomain: rockchip: add optional per-domain power-on settle delay
Date: Thu, 24 Sep 2026 22:21:29 +1200
Message-ID: <20260924102135.92217-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
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


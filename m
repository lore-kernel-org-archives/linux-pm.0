Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62914B921F
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401871; cv=none; b=u8VRXbMcHcriCytPoVuXKnEv5iXTzhvS8RIBI1RcdId9MnAIpKDp2yNoWPjznkmaBQ7ybTkl5lhsolSkqESo2CSsq0RO0SJynA5922uGtJfOJUc3ZHjG7Zlpq5e95/aW4vBchP+uoFLuu6gsZnfbgBt3P5d/C5Rstfc6c0YmhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401871; c=relaxed/simple;
	bh=m9KAehMUB+1DMur2GTxJzIouA4jvxC5wCEbnEBzuj3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocgx0eLlgHWuLP6D1czR0clNYtqTXCv1geOGrMsEh56+n+6YHy6GnUI/W5R/wRaCGlidoaGIB3wArXyfQeZtiBcXW5zxLROoNkYnfmTgG/82aWzR+9FUv7/JylppaREkPJkhBhNhh++l3HGLZQ+Uy9u62lKP+jCGyx0Pe/13plA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl; spf=pass smtp.mailfrom=lausen.nl; dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b=IUqrjGSb; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=lausen.nl header.i=@lausen.nl header.b="IUqrjGSb"
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 4620D61103
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 11:24:28 +0200 (CEST)
Received: (qmail 17448 invoked by uid 990); 19 Oct 2026 09:24:28 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Mon, 19 Oct 2026 11:24:27 +0200
From: Leonard Lausen <leonard@lausen.nl>
To: ulfh@kernel.org,
	heiko@sntech.de
Cc: leonard@lausen.nl,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	detlev.casanova@collabora.com,
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	inindev@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	gahing@gahingwoo.com
Subject: [PATCH 1/2] pmdomain: rockchip: Manage the RK3576 GPU domain supply
Date: Mon, 19 Oct 2026 09:24:15 +0000
Message-ID: <20261019092417.391522-2-leonard@lausen.nl>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019092417.391522-1-leonard@lausen.nl>
References: <20261019092417.391522-1-leonard@lausen.nl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=m9KAehMUB+1DMur2GTxJzIouA4jvxC5wCEbnEBzuj3A=;
	b=IUqrjGSbisjnlkEcgi9exvSIFkA1HdkgWmiIxOcv+Q+6gFQRxt664pxX3hJ+S4BbCoUVAepTtr
	1TWxrDxrw4RElf9LzcxWMe5j5ZSsWg36TeT/bJM7cctDSIvao0BZ1wW3tf1F2Wb+v6ty1MyVQp2T
	jaZf1rCf0Ta9g0Nwa1BnkPpN2PrRHhXMtOIttY1500mgocXyyF+LL/fLU7kphkFq9f9nGQgbaZi/
	sy+IK6WqXY40NjItTS6THQ5HQ164xO+Bw/Hik7nlXzQjvgh1l8QxfHJf8+4TGYo71eIfEEyoUcX5
	66NawJuH33BqBNDrQg2eNsKOUpU1sHQ4F16LyclZfOkbDD1CvAjNJFsoJ4QXVJRAxqdYNvNASfag
	8HWowYNQzIk1Y6gbuyMPabD/Jz0jPqnKDa0e7mNuznZ+c+ayzLZKkbKORLZnhXQ9Z+0FKPDCZZAY
	3JY2UUGWpEF4emClbA2faCQLM8HAPrrY+VhXf7r143LTJpjhM1VQur3BtUCj8bLm+uldV7ZLgBT7
	UDWzKJ/FO/Huq6c4eZN4IAVHjBHUxeJn6Js1QKBw24/vbCOrxnmDnL+UsvHLDUPdY1Vc+6VHrwTd
	wn0mAvcHuLf1J9GdRn+KvWdi74SiCTIxRIXYLDrdcDz4zAPB5MZMJrGPdudg8NG88NpQ765MwCeS
	U=

On the NanoPi M5, boot hangs during Panfrost initialization. Before this
fix, booting required blacklisting Panfrost on the kernel command line.
Loading Panfrost after boot reports a GPU power-domain acknowledgment
timeout:

  failed to get ack on domain 'gpu', val=0x113ff

Add regulator support to the RK3576 domain descriptors and mark the GPU
domain as regulator-dependent. This lets the existing Rockchip
power-domain regulator handling manage the GPU domain supply.

A corresponding domain-supply property is needed in the board DT.

The regulator-capable descriptors are based on the regulator support in
Jiaxing Hu's pending RK3576 NPU enablement series, without its NPU settle
delay changes.

Link: https://lore.kernel.org/all/20260924102135.92217-10-gahing@gahingwoo.com/
Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
Signed-off-by: Leonard Lausen <leonard@lausen.nl>

---
 drivers/pmdomain/rockchip/pm-domains.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index e193f978d5f35..b41f9fcb62bfe 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -176,41 +176,42 @@ struct rockchip_pmu {
 	.mem_offset = m_offset,				\
 	.mem_status_mask = (m_status),			\
 	.repair_status_mask = (r_status),		\
 	.req_offset = r_offset,				\
 	.req_w_mask = (req) << 16,			\
 	.req_mask = (req),				\
 	.idle_mask = (idle),				\
 	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
 	.need_regulator = regulator,			\
 }
 
-#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
+#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup, regulator)	\
 {							\
 	.name = _name,					\
 	.pwr_offset = p_offset,				\
 	.pwr_w_mask = (pwr) << 16,			\
 	.pwr_mask = (pwr),				\
 	.status_mask = (status),			\
 	.mem_offset = m_offset,				\
 	.mem_status_mask = (m_status),			\
 	.repair_status_mask = (r_status),		\
 	.req_offset = r_offset,				\
 	.req_w_mask = (req) << 16,			\
 	.req_mask = (req),				\
 	.idle_mask = (idle),				\
 	.clk_ungate_mask = (g_mask),			\
 	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
+	.need_regulator = regulator,			\
 }
 
 #define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator)	\
 {							\
 	.name = _name,				\
 	.pwr_w_mask = (pwr) << 16,			\
 	.pwr_mask = (pwr),				\
 	.status_mask = (status),			\
 	.req_w_mask = (req) << 16,			\
 	.req_mask = (req),				\
 	.idle_mask = (idle),				\
 	.ack_mask = (ack),				\
@@ -250,25 +251,28 @@ struct rockchip_pmu {
 	DOMAIN(name, pwr, status, req, req, req, wakeup)
 
 #define DOMAIN_RK3528(name, pwr, req)		\
 	DOMAIN_M(name, pwr, pwr, req, req, req, false)
 
 #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
 	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
 
 #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
 	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
 
 #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
-	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
+	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup, false)
+
+#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
+	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup, true)
 
 /*
  * Dynamic Memory Controller may need to coordinate with us -- see
  * rockchip_pmu_block().
  *
  * dmc_pmu_mutex protects registration-time races, so DMC driver doesn't try to
  * block() while we're initializing the PMU.
  */
 static DEFINE_MUTEX(dmc_pmu_mutex);
 static struct rockchip_pmu *dmc_pmu;
 
 /*
@@ -1323,25 +1327,25 @@ static const struct rockchip_domain_info rk3576_pm_domains[] = {
 	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
 	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
 	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
 	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
 	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
 	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
 	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
 	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
 	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
 	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
 	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
 	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
-	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
+	[RK3576_PD_GPU]		= DOMAIN_RK3576_R("gpu",  0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
 };
 
 static const struct rockchip_domain_info rk3588_pm_domains[] = {
 	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
 	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
 	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, true),
 	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
 	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
 	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
 	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
 	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
 	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
-- 
2.47.3


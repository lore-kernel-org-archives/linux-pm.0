Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625530;
	b=oP62F2AWkyW+oiAsKcnoix6TumNClhRBLj9Jk9emrYbyGtrHY/a66JSBEerl4fCFRlKk
	 7fNgBm6TWJIQU65k/XguiFBXUlrwO088/Wg5rlBO0F85ty78YCnbTRRklFvRohI4XVmYZ
	 WXe+Kk1B4x0NT4ViZxqIdYB6hk0B2f7RxPPHLLCJER37ad2YY/HwkNMSNGe57yWKyNtgn
	 JFbo7mzkYI1Lm93Ou4ZXY7q3wXhaP7ij+0jK+/FNdsVf0M+3pcqdhWEOD9xeL30zOKgdN
	 tcKDe/VaQOu+JomMmTEiohcM6b1hKyD63/QFR+sBXRJp8Z8Yta3Xgzg9en+9VQl9+rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625530;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=GYfj/m8dYxotgpzp9S5XfIVQYDxENsgmIvHBpA1eqAE=;
	b=a9GYCHMNKVMWFvCrdIR25sDSSGurgl+hDTDg/+adJPLRyEbg9fi1qvzz61aiEssjmrxn
	 3i3fQFPR1G2mAv/s6ykxY93xrmnd9OMqU6EW1r3JQxvDQSqsUpg84zHgrLCyNoq6pQv/Y
	 +ckzURhSVK+6d9dUCqGpYBQZ+ObMczuKrEbZqUTbd32op51RatGaIwCCrZkcLcO/7gtGO
	 MBPzg5ipWxOMDZE6U2lDuedBaw2g2vE/KOVeFF3QarB12jTNcfl4NDyxs+HVVn/67rsWv
	 bE9W8zBZOrrgehu3aBjTJ3F51ePBMMufyCaCfLH5ijNK1wGfEM3/b8F+Rg3L64k/osw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Aq0X6KC9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2TOQz80G;
	arc=none smtp.remote-ip=103.168.172.139
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453C606A32E
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C453C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Aq0X6KC9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2TOQz80G
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id DD9C01381A17
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 22:05:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 22:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794625528; x=
	1794632728; bh=GYfj/m8dYxotgpzp9S5XfIVQYDxENsgmIvHBpA1eqAE=; b=A
	q0X6KC9x3Sx56jX/FdvmnFvNjyoNWZxbmPuqj8ctAe9vZi+QRoa6j7wFFy/fnmjO
	kGgruy0uylQ8PXPF4EqNPzXBVuQ7L3nK7RGeI3t3UR7xv8rCVHOAAA7vgRQf9E34
	TrsWZwmGPbtfsIQtl1wmijlMGOyZ6icGvKYbybdiN5dHY9YBlwZbNHaTaaZtBm1z
	wX5rFXRcKL/43zFRH7aP8KGdrrk9C3Bd3heREkILzccInp8yCgHH81eqfZloyTnQ
	C92i0bsGv/snwRXDUa2mEYqzeatPDTVAcEHC9m2pmwEL7UYy+COnHieaI+BAOXoW
	xC5+6pVwznNiopFoxP41Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794625528; x=1794632728; bh=G
	Yfj/m8dYxotgpzp9S5XfIVQYDxENsgmIvHBpA1eqAE=; b=2TOQz80GEX9q65Ak/
	AlfWSNVXoSKNaLC7MeYznIgLdhB1zx7YLS48RMeBXe1ZDcDywDrGuKmnE8ya/d9w
	nGeS5XHYn5mw93gsVsp8KsB68F9LRqAm7f25Cf/DDiNBTwQDAAGuMHDmKNQ7hNBS
	Oxe09SoEBnI85wpnCC92H2+/uAG7buPcgZBtqe+yPWNHD7UD6+DdCb27MtktTL7M
	F/XgPo7jnk4BSayKBoC1KAr4mGDlRgFYs6M7bUII02ulTfLVjrmsdBALPs021w/M
	q25LaVKjKTnuiHr8MrAGV/TO4OaSltG3+Gp/D6EmL7ePubVEjj++W/vkcLRtFXuE
	pYc/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625528; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:nufCII5xf69/esc5R/fi8Pr7F9fthUMqduZb9UqHHL0dP1J
	gja0evW+h+2N+6mgX17y0Q9diSrLd5McRUqWU6znsRYXbRfVkutAHOgeqviZIl6W
	XsVm7NGM8CWXYpt+GL+WPnQzPQrdyrhD3aYaqY7tVwOXD1E3zfVBoWCCtcghLgJS
	gzI8UIFncukcQvs/qh//2F3UD0tAVEURH6N0yohzUlPLMnAr9oNpEcP6thwpZgZX
	c63E+7VcjOGDAtMCFA+Kc5jkY92lJCGgywpVE1OGlgE5fZ0tg0R/RXr6Vbxwoc7T
	0FCihf5ZJJbIYFJR7lew9RjEynshHj3QaLphGvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UzExyQiSsLH0HFt/7zRT6i9QR7vYnxrKEitVAoSpfkI=:d/AGwosAeme3DhaGATkM06CIxgQ9a1M1rxFfk1J2ae4=;
X-ME-Sender: <xms:-M_3ahk8bBJHtG9qP4u36hud_JR-MFrawjkhpbrvGQEVL8ZhJhWKPQ>
    <xme:-M_3aiZs094ICKi17Y08eZSA_UPYwAVQwgQvpMXPghXz_k7PG1iFDLrPaxhvCV_V7
    hsDbZxXFcTo45Rumap3TwJfYHLeCEAXBHr70SLeMeboVYBQgw22lo9A>
X-ME-Received: <xmr:-M_3ahO4iI66nvkHvZuS9TfJOio99StjNzU5eOU3kteXCBGsbjE0Ufe5A3rxU2Tfvp4yb36B>
X-ME-Proxy-Cause: dmFkZTEDa4vAfhYPA9bgZOwF1dDpqcMQzx4025wu+NHVj8PMlc2a9e1kEOyuSIFHHqJh34
    PjggP3wG5rwDRElcqVLIcqRIP1XNL7IdAQKvtTtYQnct0hg7OddBDAnS6rC2mHbHcIFRyU
    jUuIYA3gmHVib+USrzt/QXygqw+1HFmYLVmBUq1O0gOyJgfJpLTzBNgLFJA5WUsISohz3v
    PDaLjmjtuSMKpEzxmcnJL700/tN7yJSZHc/3sGwTTi+nDNX/LfoCAFPhN8qbYZZgALW8t2
    +DlJM6cXDMRDsU7dEOyE/hZJBH3Myq1nth7WSJ5aie7aO/4MaT1QfWquu4WWSqbd+QazIJ
    t6lLyX52mBb/jsdpR4xk27wMjoZSkdWqhp8AIKTwHcOju/7Pxy4ngHYCHFmjBVF60jEXUx
    84acDTIr9IVesHFMQ9jkwEsjRCS+YJpTwHe9mzjLLtlrX4EcGzlkWgNEe2vOm+4rC+7uxm
    FhPjF/FtgKs1C6l2WOLApkFd1Q2D/nJT8+qKKYx7oCyzjWWLCqCR8D3Y8mMauekO0ZYpYC
    PYU0UXURbujyynLO1lxrRZLx7ggAzW2WdSOuagEGoF+BsUopF4ueGK1GHcPktnDfQKy883
    mZZlsWOzz1Z8u6SPFysyqw2a8u6DF5icSDcYiCvFRBq3dDpZmjCoABeAv5eA
X-ME-Proxy: <xmx:-M_3aiewoZDOX3raW02XqE3rjDPp9H0Qmn6D8V5vEvp6udgv07YwEw>
    <xmx:-M_3anEmC4XsMXF-eVcfL5metTX9NWuMKWFGT1Kv1A9PvHSqiwfoLg>
    <xmx:-M_3atsv2-mLZtu0YghK39F-fNO9fYz5IuaCWhVO0sn17Pu-izU5fw>
    <xmx:-M_3ahpgNVeoaBdcrnuC56DHk6wjEjSuwqvKKO6hmu343j-jgwgoVA>
    <xmx:-M_3apu_XsiNujnvWgP_fzwI5YnZTowSgrW4yZ855Rw8nqYF27teZJLF>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:05:24 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: ulf.hansson@oss.qualcomm.com,
	ulfh@kernel.org,
	heiko@sntech.de
Cc: finley.xiao@rock-chips.com,
	shawn.lin@rock-chips.com,
	sebastian.reichel@collabora.com,
	vlwwwwww@gmail.com,
	leonard@lausen.nl,
	abel.vesa@oss.qualcomm.com,
	tomeu@tomeuvizoso.net,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v17 3/3] pmdomain: rockchip: settle RK3576 NPUTOP and VOP after power-on
Date: Sat, 14 Nov 2026 16:05:01 +1300
Message-ID: <c9774b4859b7272179d4eb459730d964b4dc1afd.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615323.git.gahing@gahingwoo.com>
References: <cover.1794615323.git.gahing@gahingwoo.com>
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

Some RK3576 power domains need extra time to settle after their idle
request is released.

If the QoS registers are restored before the domain has settled, the
first power-on after a cold boot can raise an SError.

Add an optional delay_us field: the time a domain waits after the idle
request is released and before its QoS is restored.

In his review of v16, Finley Xiao (Rockchip) pointed out that the 15 us
wait is only needed on the top-level domain, NPUTOP. genpd powers on the
parent NPUTOP first, so by the time NPU0 and NPU1 power on, the parent
has already settled and no further wait is needed.

Finley also pointed out that VOP needs the same 15 us wait. This matches
the delay table in the vendor kernel:

  NPUTOP: 15 us
  NPU0:   0 us
  NPU1:   0 us
  VOP:    15 us

Tested on a Radxa ROCK 4D with the 15 us delay on NPUTOP only: 30 NPU
power-ons after a warm reboot and 30 after a cold power-on, with no
problems.

The VOP delay made no visible difference on this board, but it is kept
at 15 us as Rockchip recommends.

Suggested-by: Finley Xiao <finley.xiao@rock-chips.com>
Link: https://lore.kernel.org/all/4043eb42-ce62-41ff-9a7d-d840bb90364d@rock-chips.com/
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 55 +++++++++++++++-----------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index cb5487ed1e55..073d1bba890b 100644
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
@@ -186,7 +188,7 @@ struct rockchip_pmu {
 	.need_regulator = regulator,			\
 }
 
-#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup, regulator)	\
+#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, delay, wakeup, regulator)	\
 {							\
 	.name = _name,					\
 	.pwr_offset = p_offset,				\
@@ -201,6 +203,7 @@ struct rockchip_pmu {
 	.req_mask = (req),				\
 	.idle_mask = (idle),				\
 	.clk_ungate_mask = (g_mask),			\
+	.delay_us = (delay),				\
 	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
 	.need_regulator = regulator,			\
@@ -260,11 +263,11 @@ struct rockchip_pmu {
 #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
 	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
 
-#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
-	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup, false)
+#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
+	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup, false)
 
-#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
-	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup, true)
+#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
+	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup, true)
 
 /*
  * Dynamic Memory Controller may need to coordinate with us -- see
@@ -686,6 +689,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (ret < 0)
 			goto out;
 
+		/* Some domains need to settle before the QoS registers answer. */
+		if (pd->info->delay_us)
+			udelay(pd->info->delay_us);
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -1360,25 +1367,25 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
 };
 
 static const struct rockchip_domain_info rk3576_pm_domains[] = {
-	[RK3576_PD_NPU]		= DOMAIN_RK3576_R("npu",  0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       false),
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
-	[RK3576_PD_GPU]		= DOMAIN_RK3576_R("gpu",  0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
+	[RK3576_PD_NPU]		= DOMAIN_RK3576_R("npu",  0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       0,    false),
+	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  0,    false),
+	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     0,    false),
+	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  0,    false),
+	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), 0,    false),
+	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       0,    false),
+	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  15,   false),
+	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  0,    false),
+	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  0,    false),
+	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  0,    true),
+	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  0,    false),
+	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   0,    false),
+	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  0,    false),
+	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  0,    false),
+	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  0,    false),
+	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    15,   false),
+	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    0,    false),
+	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    0,    false),
+	[RK3576_PD_GPU]		= DOMAIN_RK3576_R("gpu",  0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  0,    false),
 };
 
 static const struct rockchip_domain_info rk3588_pm_domains[] = {
-- 
2.43.0


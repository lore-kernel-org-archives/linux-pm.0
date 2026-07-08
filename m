Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84438757D
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554181; cv=none; b=hqRtItsfT9oBEEs9FJ6tb/gE1xlHfl7Fh6xUZwvnyepJUOi0kbtkOS1ie5R9YWy2F7koU84mnM/wtD5RQaGZeyqpbRtizFHbjZzMIbpleX3wrs4YB9wCsvQgPYdyp3Kydc8S7/oYQ+juZ5MJp8YNy4ViFr9xkkt6V0wha9vKncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554181; c=relaxed/simple;
	bh=h3R93Ok1NVbqWeVssCZgi3GVnxTbqmic2Yc76Z+ZQ2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mdfh4HhWqoi66smwqyMF+siFN1fCxv2MzTTH2wy5Ou8TA+T70mIFEbv1u8fnAB/kM6dsvSH11CfpL48iFWYnMzCgzWik/zsi2Sh7AxYM+KGpSucR5pWTqVWKRampYXtyfiG7w05kLTnk9bDYwluitxZp0Lddv1tz6thGOhj5tdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFH0DiUA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFH0DiUA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c486f012so5296375e9.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 16:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783554178; x=1784158978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8qcNP21CNq1+szX+Pq/DiZmtH+Ke3MLxP+6o3bgK2g=;
        b=CFH0DiUAl+rLnt3ea0ZbZW+ee/sAoDUUT0qAZ0b88UQtrqaaw3HO0YgKGksbnvQraE
         xn8rhH/JvbNrt7WQ74hCgfZjZZgeO1rGzOt+6JcTNBRZ8HskuDz6IsUeY4Z8PFPiyt3y
         H3KpcUkT7KEF6C3BaBuk3VLevUxCP4faZQ+kh47o21fSrXUGSFPre32zG84AH5VWqHnN
         PkMKZ9YD79Xd4gnOKUj4+AZXRrpIV29Ms943Sz/aMaG/lmKToTVQB2JNbhTfdgJbiADt
         YQIaaWJBl6lmDVWJnAXfRZfIxGQJDx/gWKzigM9hfT0PzbbRhn6pe6ikXZBr+h7RMtS3
         cVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554178; x=1784158978;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U8qcNP21CNq1+szX+Pq/DiZmtH+Ke3MLxP+6o3bgK2g=;
        b=fBaF7+OeKi+E31vYY6iC3y1kJeDoqPkcPRhOB5RMWBGTDqs2n0SYVIrr/k+iioWITV
         PXDcfPKY/4qNgrxTbB5jF9oL3rccEixmCYHaUIl8HDmc3bEu9w+5LA9HZ0rNRmzUSar/
         43YriqgmG19g23zoFk4pb53UdIwK6ZS4o/GIWWSkwchbbjgJluI5NdnSV/g0W4Z/aX1v
         undF/0ptISDmhazXoRMEit4uLYnT2F5rqPQNef7x4ILSjYxGTLiZKz18nztL4Kk1TWns
         wdPSScav+3VX9noqg6TVYW7nVciEzUPuKhbwxZch60bDYyg6pJJcxC64Wyn2G+j6svi9
         9FfQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5/1XKgNGMwaquOeYGwtNSjzfPQGhRXS+a1Xpa9P1qysG9EEgAjxRiWYQlpQVF8ofHAgWVPirJkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzE+k9AKveLnUEudBlCOZ5kjdAXmSojyZEtxF7kD/Y+owhWFws
	/lv4J1yIn0FueF8lK5/GZqz2SO9l9uTNMVGuagBhCo6c+7hDI4Llr7LOOGubuHEFlcU=
X-Gm-Gg: AfdE7cndGGDh0Ozn4OgR2lyKB+GCsb/MTsK5B25IRpi+DGv7lP8++Z9n1q/7/UYlzY4
	88ETlwOhkFnkTws1cio1IU8TGjxUYk8WICE/HCgoop8xmdFJdlx5cIoNwArPp0I16UrJtB2xmIj
	xn0VAzEsAC6SSQslHqfuyS5JVznjOYi9844nsFzk0S0YvJJQdvP+7ASGzFYVsFTBmOxkDZTh1/e
	bzbRRXGgVOqWJ5tEZr/R3DZxysByjyHixtIPXaxMCVIah9UjhGprGMElKg5kRP0nnubWT08ThKI
	pNdBudPa2DpAu1PusKRpZAnVBQA3fUgzmP6rcCb0t84P2NVPJXg9Mq2a85JMku+zaQHorPNjqty
	IcBzhex4SPh+4Y7e0QYO/thGXaTAmEC5+pEFTWm6sKVdAAc7gKoWy6i4H2x0lRyIctA7MFrEYTD
	ShMkV9mW5M3uou4e0djO9L73QctopQa/s=
X-Received: by 2002:a05:600c:4fd4:b0:493:e3ea:b23f with SMTP id 5b1f17b1804b1-493e6861ac2mr44972025e9.10.1783554178246;
        Wed, 08 Jul 2026 16:42:58 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f16cfsm15653275e9.12.2026.07.08.16.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:42:57 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	ulf.hansson@oss.qualcomm.com,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Midgy BALON <midgy971@gmail.com>
Subject: [PATCH] pmdomain: rockchip: Add a regulator to the RK3568 NPU power domain
Date: Thu,  9 Jul 2026 01:46:14 +0200
Message-Id: <20260708234614.499613-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

The RK3568 NPU rail (vdd_npu) needs to be enabled before the domain is
powered on and disabled after it is powered off. Give DOMAIN_RK3568 a
regulator parameter (like DOMAIN_RK3588 already has) so the NPU domain
can set need_regulator, letting genpd manage the rail wired up as the
domain's domain-supply instead of marking it always-on in DT.

Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
This patch was part of the RFC NPU series [1]; Ulf Hansson and Heiko
Stübner reviewed it there and confirmed it can be applied independently of
the rest of the (still-RFC) rocket driver and DT patches, so it is reposted
standalone. The NPU domain's domain-supply DT wiring follows in a separate
patch, so this change alone is a no-op at runtime.

Changes since the RFC posting:
- Move DOMAIN_M_R below the other DOMAIN_M_* macros so they stay
  alphabetically sorted (Heiko Stübner).

[1] https://lore.kernel.org/linux-rockchip/20260613070116.438906-1-midgy971@gmail.com/

 drivers/pmdomain/rockchip/pm-domains.c | 36 ++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 490bbb1d1d8e8..ba66ae7194289 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -204,6 +204,20 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
+#define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator)	\
+{							\
+	.name = _name,				\
+	.pwr_w_mask = (pwr) << 16,			\
+	.pwr_mask = (pwr),				\
+	.status_mask = (status),			\
+	.req_w_mask = (req) << 16,			\
+	.req_mask = (req),				\
+	.idle_mask = (idle),				\
+	.ack_mask = (ack),				\
+	.active_wakeup = wakeup,			\
+	.need_regulator = regulator,			\
+}
+
 #define DOMAIN_RK3036(_name, req, ack, idle, wakeup)		\
 {							\
 	.name = _name,				\
@@ -241,8 +255,8 @@ struct rockchip_pmu {
 #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
 	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
 
-#define DOMAIN_RK3568(name, pwr, req, wakeup)		\
-	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
+#define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
+	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
 
 #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
 	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
@@ -1274,15 +1288,15 @@ static const struct rockchip_domain_info rk3562_pm_domains[] = {
 };
 
 static const struct rockchip_domain_info rk3568_pm_domains[] = {
-	[RK3568_PD_NPU]		= DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false),
-	[RK3568_PD_GPU]		= DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false),
-	[RK3568_PD_VI]		= DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false),
-	[RK3568_PD_VO]		= DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false),
-	[RK3568_PD_RGA]		= DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false),
-	[RK3568_PD_VPU]		= DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false),
-	[RK3568_PD_RKVDEC]	= DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false),
-	[RK3568_PD_RKVENC]	= DOMAIN_RK3568("venc", BIT(3), BIT(7),  false),
-	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false),
+	[RK3568_PD_NPU]		= DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false, true),
+	[RK3568_PD_GPU]		= DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false, false),
+	[RK3568_PD_VI]		= DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false, false),
+	[RK3568_PD_VO]		= DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false, false),
+	[RK3568_PD_RGA]		= DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false, false),
+	[RK3568_PD_VPU]		= DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false, false),
+	[RK3568_PD_RKVDEC]	= DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false, false),
+	[RK3568_PD_RKVENC]	= DOMAIN_RK3568("venc", BIT(3), BIT(7),  false, false),
+	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, false),
 };
 
 static const struct rockchip_domain_info rk3576_pm_domains[] = {
-- 
2.39.5


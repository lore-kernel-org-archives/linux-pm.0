Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5539BFE1
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333930; cv=none; b=CU7KsHDyqZLGUYe3+EHacOV2+vf8oAEpYD+z3SVW68897kdAUrp2Fq3gBG4sIIkp4p3Hv6tegrzweeZc7WclFQ85urk0col7CJeMXG89oFbee+/RaTUluM13M3BxxE7Ajmap0lUBi5Z4B80Uf23xJ3L+wtMwA//EVsj6HaIGnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333930; c=relaxed/simple;
	bh=+oC/cphUq61z1tUYe/It2wm8zgDiOcsdp+YquhThWMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/6ld39jIFxazcGDQoMr+Q92pCG6C3ZXRw5nb+VUB1wxNU0J+L6TTtZVl2WB179F1apLkoNgLbtr4jtp/uWSrUacw6EMIrD7RFLFJLQuYgXdmsJ4laHz8i3W+jrOoVhCgCgAT2XnfnNvTVPaI5RaME25UpSkMbtFh2RsyV0Qqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqkxvb1x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqkxvb1x"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so9842265e9.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333924; x=1781938724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qXDWY05NWH/jJuuAS5m9EpuxlsKXS/Zj0XFrGsO4MM=;
        b=Dqkxvb1xPdmE/QivkU0Tep8gUL6/WD4MmKfUCtrgNDooB2RHfshyYYkXYndpy+BVlO
         H5ycKTW3luL+Vm2DsNGh866zz1NAMBj0WQIzrrOMZdOaiML64q3QeAGQQmoWqLjrodxo
         d3vuSFeE/8eRR3NiFWyrYVw7d3jNuQC6+9mUlKfJuhPwkTg/JLGEzqM5BjasBGr/jgbN
         IQhRp4xg/89+FG8GcomlLt7v8fXaD8LLQ0p4Cjl4H3oe1Nwyg05sq8Ud3BmioLiYs+Hx
         YwbjzdpCO4po64DJzKSLidxm0ZBLr872i9boDOEk19PHKeJU/slYDMvpkxHE1QFwYrf3
         dK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333924; x=1781938724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6qXDWY05NWH/jJuuAS5m9EpuxlsKXS/Zj0XFrGsO4MM=;
        b=CmNU25ikMPYGbLO4G+lNC1egkbTIAF26SWIuibfeBx4G2NR9BIG3iaqbVVKLWfObLp
         R9YEVCK3SAKK1SpFFBvWsqIkQSyjhMMnA0FoZHOgWGxHjg8Tpm9ciIWqazsvVYF04+0l
         ERd/G+1tg/VLo8lCpXGNWuIyI6Vp5HNLMFquJS2QiJI6gL/gA3sJBat01rg8oTz4+mUR
         ded0Vfkegc0J22QRX8S38KUm+ng+4hCP+z3y8FXbE1D0ONqA1uk2icaHtw2xFtBSQa6f
         nhydQeBEBz9ReNkjWVCiG4ND/1hx9ai3QU85YcZisvJEqE5AqTjF/oX5bOOx+w9xor/h
         WeUA==
X-Forwarded-Encrypted: i=1; AFNElJ9HRCpeN1suab+KDwakLPSQ+I0WJGmvD2w/xhZZLQDCEsft4GnsYIeX0GsrVHWkyTAtwlmjUFkuzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCY3ZB+foojvqU8c9T2hn1bM0bAULo1Y3yKEoJWoGUgK/YHql
	s2HpLmkQxV3YJE5GizIUAQNCrccXufDWvXgFY382c0yRXn1kcn4DVPr+
X-Gm-Gg: Acq92OHERnDfj0j/1/usm30crRMdRzOkJQ3IYwdcvY0dfP6RbSFzQr8s9NJyq/JDhU5
	Zp8n5u9cWtvr/Dz4Ver7tU/Ya0Aravzt/AqJ8s0wBqAUWQ39GuSy+w9DVvjN3My5tyQ2NYNq+9M
	+AGfJar9J7EbadAx6Sat9p0Mt2SA5OFsreu9lbzqyIAGvckbAfQ8trfqSnh8cJy5U+MnwyBsAPs
	ml6pB/djWdfYwJKxws2y7IjjH2C/nWEAvmJJ+YNxOiQ1qg86A4R2cqduhMGqKWBjBF80mx5avct
	ZjmKNemVkmyql23UAYfm7Xi+M7rWmxKaeRM/4hQriQPJ0lpp9YPhcBdq6n3OuPX2cPe8S6qks0u
	78gOS/70JOFDlsClJ28uimNt62kkcyWwdtOB+n7wqohFOkWZHeW3GmzdM00WfcCN0tlK/oIJ0/y
	lu8OAx4PdmPdeUKGhhBT4y3Q/CREjJGhTzvXFEB6UBAQ==
X-Received: by 2002:a05:600c:46c4:b0:490:b355:9c8c with SMTP id 5b1f17b1804b1-490ec4fbcb7mr81233115e9.23.1781333924116;
        Fri, 12 Jun 2026 23:58:44 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:43 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 9/9] pmdomain: rockchip: Add a regulator to the RK3568 NPU power domain
Date: Sat, 13 Jun 2026 09:01:16 +0200
Message-Id: <20260613070116.438906-10-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 drivers/pmdomain/rockchip/pm-domains.c | 36 ++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 490bbb1d1d8e8..19db307e3811d 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -138,6 +138,20 @@ struct rockchip_pmu {
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
 #define DOMAIN_M_G(_name, pwr, status, req, idle, ack, g_mask, wakeup, keepon)	\
 {							\
 	.name = _name,					\
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


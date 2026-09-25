Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F424501D
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790309891; cv=none; b=iXZRtpoKde0m8uiNALE7dVjEeQSdxCw2CNS7YPDSqS9U7Rr0TxjuCYRIFCVJ8GbKuwYqZei3HuGvxL43WDZdEOmQPcqjV/ZokADhQUfVqINXPLTDzLOTKm8jCv4uSKZQf9P+W2BdW7mu4IOtc8d7nGrvGimQ8uPErd0mGEqL4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790309891; c=relaxed/simple;
	bh=BIhx9ICvbHtpfbqLnPkCJJkaqtIgJ+HeWkbFrbYaDFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWknNTgM5g4oHRv1vYSUHq5+MjB6csORm1j5eO6a9hrreY1Oq2zgBYUaX0hYRq381HZ1k7C//TMxzLg2uwyhOIAiia+XTY7UsyzlYE0YAMu1+UyQFYUzPZkeZLZkIYfe9kruGBl8cadXUW8k2MU4AXklrnUVk2WDU+Xs5lh8UQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbiX+O98; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbiX+O98"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-39e249c766bso169239a91.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790309889; x=1790914689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6smwopks2PJXygtKAHcL+6mCESGQpHs+ktHru5C6inI=;
        b=XbiX+O98UD9OxoB84C9n+eo5VcqHMIFL4+4Blh4QzGAhcunWY53CKglYb+U5y5fysD
         MOLW5VDk6zcrC1mTeD4gUPbf5sn6gKo9hswzy31B+YGvQKEtiLycmCIRdmIztC6VPmsY
         P5BKx9cImtK2R5IPivzU9tYRswM3sS2Gg0rlv4GdAUHmi2Ktdgo0OSUuS17O5JK1unJs
         9cbFmvlPgaJIg9seW0aTj6kPMHSs+AjZtCRJkUwYFLPuR4Q6tnK7+kT5h+ijGl2XPrcD
         6bhtUhZw7Bxqtbvu4cmP3UcLLxUwcDrg4lG3PapFZl/IW4M9rvI0sQP/GrffzhybBJWm
         WH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790309889; x=1790914689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6smwopks2PJXygtKAHcL+6mCESGQpHs+ktHru5C6inI=;
        b=SgRC8ckwqJDKujES0o6qvUaf3qBB7H4uHZqxHEPO5dFsGbOzrpyaNIspA9+097MyFE
         L206mI3rLSLnynPjgj2zPXMkbJzuuF3MyCRHAH4qVMQHunRfnUljvIcMJGPr1XfXTt5a
         RkJ8ZkuOZ0fyuuL7XQj0JhkrI0giw4H3DWxmpjxRylKRrVgScGGL4e7wMkwYe87LV5kg
         V0V8GWr/o1CqQ9QvI9u1v8VN8YwpQzCUbGbAWJLbdD6B7Sc3kHA087MErarjnTQVHBbf
         SlVWSWtco2NEh5RXxVoOqmbIsI2E3U+qV9bGOpWsL8/IzS0C/potvYgteM73+QBqIg5T
         Fs1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzcPz0VJ87rZkl/BOFBQGr3l0df4u6dzYi51LHM1HdhtcOkON5tEn+vhYoO09kme1AbzdmgnTDL1g==@vger.kernel.org
X-Gm-Message-State: AFuF++mmEAqseESrfFP7WQxB1hWiVCwDDJ73zwcBPmcCYKxbNAV3+jjz
	Q9MDZpF+pg7bhwSQiFYPt6YaGgyt4k0MZ0N1Q40IYT+dGSto/MfYkJM2
X-Gm-Gg: AYBFou0IgYJlduqSQlCqOgSIduL9H6xKCSXbc0kHzZBjAeKZcIRS4TkED/XcaOsYXRy
	5PQsD/SGZA7J3u9s9RQRS/zXyDoRVxCwv5UpeTGjdIZ716pnLos5/1CkX0UH2xshkxf8tix2kum
	vu/HnIt8Wu1f3q1hF4mBf2lChEa+SpUFFXVduhg7mJrKCORkcfnB9/hLF2AryCDR84KPPlnXGL5
	owtv9IE+1j8KLIlrvU7qVjzVEgCR5GfEfhpjPt7PmRQwPa7kP0tpdD6+FST5F24QhZm6ZHSLolB
	2tDtnz25eWgyobh0Q0DfaV0t4eKrpAhS1eW0iWz7X8M73GoiKV3ziNOdRPOAMafTdUhAIoaONFV
	pYWD5YY6pWhg2ILnYRaGXsFGJ9obch69q56tjLU/oKRKL29Dj52M4rwoIFzLzIQQ0+LUiO120N8
	r3K9ZZAWaYh+ZYSwSCjMubGda8dGyhgig8gG42EWnljP7dT/vZ33ByH96+jVoGfRMLRTZZ
X-Received: by 2002:a17:90b:4ad0:b0:39d:b1bd:b384 with SMTP id 98e67ed59e1d1-3a0985b949fmr4116287a91.17.1790309889066;
        Thu, 24 Sep 2026 21:18:09 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4983f43sm852262a91.0.2026.09.24.21.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:18:08 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH] pmdomain: rockchip: mark PD_PIPE as active wakeup on RK3568
Date: Fri, 25 Sep 2026 12:17:51 +0800
Message-ID: <20260925041751.495818-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PD_PIPE power domain on RK3568 hosts the XPCS, the PCIe
controllers and the SATA controllers.  All of them can act as
wakeup sources for the system:

  - the XPCS for MAC WoL, through the SGMII link
  - the PCIe controllers for PME#
  - the SATA controllers for hotplug wake

The domain is registered with active_wakeup = false, so genpd powers
it down during system suspend even when a consumer is on the wakeup
path.  That kills the XPCS and the SerDes, which breaks MAC WoL on
RK3568 SGMII boards, and it also powers down the PCIe and SATA
controllers while their drivers still expect the link to be alive.

Mark PD_PIPE as active_wakeup so that genpd honours the wakeup path
of its consumers.  Consumers that call device_set_wakeup_path() keep
the domain powered; consumers that do not mark themselves as wakeup
sources are unaffected and the domain is still powered down when
nothing needs it.

Several other Rockchip SoCs already mark their PCIe and USB power
domains as active wakeup, for example RK3588's pcie and usb domains
and RK3576's usb domain.  PD_PIPE hosts the same kind of
wakeup-capable controllers on RK3568, so this follows the same
pattern.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index ba66ae719428..16ef0a235f0f 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -1296,7 +1296,7 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
 	[RK3568_PD_VPU]		= DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false, false),
 	[RK3568_PD_RKVDEC]	= DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false, false),
 	[RK3568_PD_RKVENC]	= DOMAIN_RK3568("venc", BIT(3), BIT(7),  false, false),
-	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, false),
+	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), true, false),
 };
 
 static const struct rockchip_domain_info rk3576_pm_domains[] = {
-- 
2.47.3


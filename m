Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF12357CF8
	for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2026 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788675508; cv=none; b=HPVyIlxZfvAlPHsRp4WPc9nyVgZhEFbvD0yN90N4Km+kz6C+cor4OWmrdyY+V3R3Njtwkwr+olXEtwFqD5tQFiX+59VgkghI6vDNyCLF5RvAC5ybtfPqnkxdNcUp4fvXAMWDjmZDI+n8a45qyFRzrtVkXGTDcbG2vGK50A4ZFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788675508; c=relaxed/simple;
	bh=wQGtAlE1eynbFj/BV0uC5lWh+rlGyN0+AtVzgyTUZpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDG38OmNx4Vy+hig8NcOZpWYWbXbefEAS+4Z113EaO+HdehKws5a3AiCaUI+KH3m+4emAOPLEPUb8hXO3cke4bAe5OHPNAyzXykp0/2YaRBMErDv5IAn+nzGwIOSr/FYVnP9TGSKMWKh5nwoWrRp/UvUImD1Ge+cSVEWgGt80mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmYj+KXu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmYj+KXu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d9004f39d3so30007735ad.2
        for <linux-pm@vger.kernel.org>; Sat, 05 Sep 2026 23:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788675506; x=1789280306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86ZMXQ7rWbd5+Kz4WmVDnIj3yBwaLGUiWHIv6rRn9PQ=;
        b=BmYj+KXurujfeMDwlPFtGWG8R++55PN0009DYykfTE5fxMVbSRxczg2OHjc2vd9nEs
         1AnBB0nETR2cftdZubSn8lX8b7BU4A8FwruK5JLMC0Z4f4KOHbW8W6HNPMydLHYILQXD
         iY/OQ0mda+5B4mPvH/lS12NCaTNN8phGqT3p43twP9ABWHxQ/NAcaIouVy0e56vq/5PV
         rY5P4XYgHJPnrSqVod3W3Zgoh3W+6+M910lG8avn6X9rCFP3bb77LxEk3/vRUynlUo57
         g+5s63ag8YpJ0ngLzImSdBCA+E4L0rNtU1yKnxSNWieZk1NE0AWRoRgbAee51kmLpojM
         29dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788675506; x=1789280306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=86ZMXQ7rWbd5+Kz4WmVDnIj3yBwaLGUiWHIv6rRn9PQ=;
        b=RzRt/mu+dFY+97baxE5QnywybhQKc04G/8VqxMAWsHkXEC4btkxGKJ3AcWzAkXCq3o
         xY5Lak4CCTiuvtEY/Z7TUvtrb/BS5qzzxKuGCUnHPP1ioFN35mlaiG+YjuNSq0jcXjxv
         On+cDCwIHqprhXisJOZs5xCILaXBUFLe6uAlV/3JUoQQEP+PHdzVi5Var+wrqI28B94Q
         ONw+0hu5SD+Ow0GLiD6gRlyhOID3rfmqr+JGPOGA5rTY2viiaTLzRZProFUH5MP+Dahh
         xrEEh8qqrj9gEUhPAKVNq98z2FNdTdMmxjgwyOnnJN6f7GDY3+/3NAbRMtYA/QQ1gFV4
         B4qA==
X-Forwarded-Encrypted: i=1; AKwUvBy5dWVjL1iXGT1zlvrMqPPry9rg0Swj1KUORnw1SpPpqU5HWoTdTe8yzWwox8Kvnn5UldN97zPSZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++njdTW+ukdaaDcmr+4RqSMSG46QjJOsE+JKjINFQlVvJ3PwLYdu
	5ErAvcWq7K8yAht+6SuR52HN9//0ZM/bDHROP3tnrJt1sXA0r5E7VOYZ
X-Gm-Gg: AYBFou2vdtn6QaQCILVBXDka8p2ZidkX757Ojhgo5O3E2xcPtBqrcZ7y8KNucvjDbfR
	189RkwO8wu9JSoaLcKS3LLjftwMx+H3ilKqIrbABCFGEP2IiANwxjMpzUnBZI4oKzGIT1Oxhu9y
	N5xkyrwrYKoQXwS+efj23C1ORGUeiRXWYqgYwb/d0f+lNkm6JY1Mp4ZAauotHkHPy0px1kazPj+
	nI0QBSObM8OuHUjg8ibeG98/Q8T0AW8URm5FXCuaQjucnrpu2hVgeCq3/s1x1yzaMFiq3DJmkU0
	iBowPl76OSvRb9ba4IOvEtViXDhcVIkndqi3jppsPI8/x9UpfiaPm9ZMVCkMOi45rJnZklI4zQX
	s0eTNoqq3s2hwX31PVshy/Ng2aAUTB9kGYItv3sechhyzpOosC2/5Z7IZlQ9iBuAMhnYJ518IIG
	Ao1dgEtM3DrbdhURLUzPDqAOV9HDXzvvXGkE8X38RXsKdOZ3sF4NV1WFcc1d0=
X-Received: by 2002:a17:90b:4c4a:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39b2624c32amr22181806a91.21.1788675506361;
        Sat, 05 Sep 2026 23:18:26 -0700 (PDT)
Received: from gmail.com ([58.84.62.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm18280405eec.12.2026.09.05.23.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:18:25 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	amit.kachhap@gmail.com,
	daniel.lezcano@kernel.org,
	thara.gopinath@gmail.com,
	talel@amazon.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	mmayer@broadcom.com,
	viresh.kumar@linaro.org,
	sumitg@nvidia.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sven@kernel.org,
	j@jannau.net,
	marcan@marcan.st,
	casey.connolly@linaro.org,
	sre@kernel.org,
	wens@kernel.org,
	t.schramm@manjaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH 1/5] powercap: intel_rapl: Use %pe to print error pointers symbolically
Date: Sun,  6 Sep 2026 11:47:50 +0530
Message-ID: <20260906061755.5103-2-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906061755.5103-1-sumeet4linux@gmail.com>
References: <20260906061755.5103-1-sumeet4linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace PTR_ERR() and %ld with %pe and pass the original pointer directly
to pr_debug() and dev_err(). The %pe format specifier prints a symbolic
error name (e.g. -ENOMEM) when CONFIG_SYMBOLIC_ERRNAME is enabled,
otherwise it falls back gracefully and prints the raw integer value.
This makes messages more readable without any functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/intel_rapl_msr.c  | 4 ++--
 drivers/powercap/intel_rapl_tpmi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index a34543e66446..46972ee1ff84 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -582,8 +582,8 @@ static int intel_rapl_msr_init(void)
 	rapl_msr_platdev = platform_device_register_data(NULL, "intel_rapl_msr", 0, def,
 							 sizeof(*def));
 	if (IS_ERR(rapl_msr_platdev))
-		pr_debug("intel_rapl_msr device register failed, ret:%ld\n",
-			 PTR_ERR(rapl_msr_platdev));
+		pr_debug("intel_rapl_msr device register failed, ret:%pe\n",
+			 rapl_msr_platdev);
 
 	return 0;
 }
diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 73f36d9c09b1..6baaad3c59ef 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -408,8 +408,8 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 
 	trp->rp = rapl_add_package(info->package_id, &trp->priv, false);
 	if (IS_ERR(trp->rp)) {
-		dev_err(&auxdev->dev, "Failed to add RAPL Domain for Package%d, %ld\n",
-			info->package_id, PTR_ERR(trp->rp));
+		dev_err(&auxdev->dev, "Failed to add RAPL Domain for Package%d, %pe\n",
+			info->package_id, trp->rp);
 		ret = PTR_ERR(trp->rp);
 		goto err;
 	}
-- 
2.43.0


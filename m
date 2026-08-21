Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E4432318
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300042; cv=none; b=dXMjT0DRB/Ply1fvbdVKhZLzpLidweenlq++/yjBOvFNijuLwhYO0YjdsFhdQ1AGwj/MhTuBbaoAtxP6xP7DJ1bfMGZ7z+1wvwF1jAtKEaHAm5c2om3OCdTnJoStgtPv5bqx+xsMeyqr10yia0khnaRrs3po8ie1qWBMAvgcSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300042; c=relaxed/simple;
	bh=u2Yu4YBYm2njILlYS8QED4Q5XuAaD+AtoFT/SlvHqq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSlyN8JcCxyAj5W2O6AdSX2BW9oqjBKQk6KDmPU32yZGDFvRokhLjDP89wysnos2VQOt3BPq9zaQG2W/upyr53OSua+FFazbMttS3H+rE9S0Di9cMWpY6mxVjXW2+hz/Le5D4nEKQIWlQ+TWh+TWzxZw7+5HUCWACSabzOnn9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/v15Lxg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/v15Lxg"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e88b60121so544476a91.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787300040; x=1787904840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEFzlhBjAhuEe8xovPGxxPJuQ8Ojqn67sRBJbsAP39c=;
        b=r/v15LxgIt+ClC1W8QMwX4ML+GIEitmBuXJhWqXrszq3yLDhXyxjJTy7SvJaovc/cG
         a/P4bOBWHT0dXeMWFGvsUbt1vVEajyXAc9O+s8xkvlm16quS0Vb5gm0r3KY6rfOyJlxl
         pC411eoo2m9484DOBo62HOW3VkoKp8CuMneNgi/L4dH6Pk43Z/vc4sT4gLtYAvKMOmPw
         lQWyjr1Ch/pTC8hCJenmwZ4Wp5zKMkG8h9HbS4U9q3HYml4syLwCUwuGnLlMoR7bxCbX
         4YizxtZL4WQ8XEeGdHPQWn3qQixsUQPPLQ5Lll/iOIJVSisfEKO41ZTUz0I7ohCg2tLw
         sx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787300040; x=1787904840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEFzlhBjAhuEe8xovPGxxPJuQ8Ojqn67sRBJbsAP39c=;
        b=UWa1OOaWDtYGgyEybO8Qhie8q4N18h4M8UGjGzX/GhRmLvdAucpBr5jaGCsaRf/rwW
         4he2M5i+Go51+GXQiN6FP6aUfi9uy9aGspnTV8aVKOQOCDEBNgtfhKTgBfOrogbrEh2s
         K2G6mrAcb5dEGzHR/xz0a3JkUy+fxFyZJVwmSLdcrxIu2M4/9DiGe/8z1r2HeNa+KbR0
         icMDjqIFWSWIN9Dis+dnt3K8Y1F/5waNiz8xCqW5syEkBi/NWiH01e06ieS33oNo6Zal
         /Y06l2SmLj2olx6lOaN2uv9ebXzfVeBZmuhinwoPISuoLk/NAWMr49o4gKW6o5eewjMg
         k+pg==
X-Forwarded-Encrypted: i=1; AHgh+RooZRIlARLOz1m9klMwpxqxW7qxnUPsFoty/crp1egiGLBMIQ8uO5S5LvCeGI6geASAHFZDzTOBnw==@vger.kernel.org
X-Gm-Message-State: AFuF++lBzzX1CfoKifcDaYYLmd8j2772HM+C7VBgTc9OypaaKQfBpIzZ
	v+jjNdvdOlLHAk+nrsNEebihPcIGjQTO1zTK0j5amVJtjrd8XHWkwCpZ
X-Gm-Gg: AR+sD13xWOXBcsgx2IHOoPAzG1zH07n2mhx60anblGCJTtufzRLGon2kyk+IiKUj9fI
	7lH0OGBWY4AXn8EhDEEeanBBuoxtt8IbF1p7DqiYDzkd3wZ6/EkA88fzkY9ridNkYZIvizpSJt3
	VE2d2R2OP8dJdD2yBCQZOEFCgkqPusT6cHMna8T4lAN2/PYAud7JCRq3E9TTjejnTyCMvF9pVKS
	R2Si6LWthQMcgLQvO7VIhQOPeFOLB4ukWTxXaCoKEXguzTuyWVi6NHNlX0CfAguMrTkaHY0q7GY
	4NvXfwSrg98wEZLZ36iC2zskXvNV3CE/iZ74XPzayyns5iCyWzwIRpEY1yvoc8s5/wwl2q3tPiU
	IdOiStDp1uhay0OfLeLcN9PFVewzm4HYmMGk+DdfCyu3aqzgHk16vnvdp1Ch1VsyKFsWwJ3iysM
	w70v7O3/r7la3Am/+phc3gEad0tFaejrBYytRRJO/XzMU6XmEkKCrpD1h+/LRIAkJATjI2PyGQC
	3vq9ONvgrt67VnpIGawvfU=
X-Received: by 2002:a17:90a:c2cc:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-395c35d91fbmr8956473a91.11.1787300039934;
        Fri, 21 Aug 2026 01:13:59 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm22040786c88.12.2026.08.21.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:13:59 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	quic_tdas@quicinc.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v3 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Fri, 21 Aug 2026 08:11:24 +0000
Message-ID: <20260821081125.4522-13-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081125.4522-1-sreeshankar0910@gmail.com>
References: <20260821081125.4522-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the cpufreq hardware on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..2dc2c265c 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
-- 
2.43.0


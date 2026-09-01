Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC447D92F
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254816; cv=none; b=Qacrz3nNn8nTApagsDHmgiVjPUYD742BTirYfULoJ8ym4n7ldlPL84DoUsS2y1LxcO4L/5Acw0J4aWxyQZwhrOidYg+coJy3VC+NC9lWi+CFgyXsfVi5Swtqq5PhY5aoHrklZsIJUOLO3kf07V/1X3GuZl9xAkvi3lY03Jjbn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254816; c=relaxed/simple;
	bh=6sYp6gwLdM8q2X0kWDCuDxQHrC8+z3UsdjNuoTgAQ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ7prXZ7/vSXY/Hn6v5SmM0ETVgHpgVfLfdHiDLRd4RNamE0xjVndNnIfC98U63eF7ppRORC4/ZVEJ2VGw9gLo4JeJJmCHMfGkeXERe5DakJHY82lA4oF2iJRCiCaSwY6FFqGKw9ybFNXFDes6HmX9JWFgBEqXGFMT/kDaBFmDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpOXtQbm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpOXtQbm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38511175ad3so4643929a91.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254814; x=1788859614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvcz145bWmmDM17NuFw1MIOBpRinQuOt1aSfmpsmn2w=;
        b=WpOXtQbmDLhfCAbzp5cAwqh04HubaJHw9J8d/601aQ0KBji+oM30YEfB8XTUAZPXTg
         Ar1kObH7lg1z/uuOGlgDT9JYRKXJSNeNQnaiwAm9gWa1D0ut2csAGkI4lvJQEgh36qsv
         moAGe0daOgFx/1MT48tzfvEfqq+VJDJFeX+PGhSg339cHSpMrEv/QT9tRsTAkMfdiC1a
         IrPjOnkBVDLfZWNkjzLTBaWTig8CYIAehLSKHIyePjO1IswEpxrKcw3GVAqPm+5AONyh
         ZcGULfG27xmVrxGIvwNx0oJPF8/oPyiqcef8k7bnmW6XqJ81Y9qonUsUIyu7tnaH/F75
         9AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254814; x=1788859614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvcz145bWmmDM17NuFw1MIOBpRinQuOt1aSfmpsmn2w=;
        b=JXl9E5v1fU3n7bkLLh36+au8VT4XbCGOYt9ub4MDDx5TtKUTG0EcG+2ZYjlLhVQGYK
         xtMhi7ZpOWtajmtgtieQICWdilfVGiQUmyf2SuBVjm66EJdlOMaaiC+jYkK/II/JIhP2
         HdQFxhoBOZLr7CafYGDcuaMEgFAbyyNo14zQopmzihRqVW7r41M5aX4EyAgFF4htAuqz
         G+v3WJ3o7wWYnL6tPtDYcDlb92duci+wmPP1Qi6XlkBZ1QCkKZQRvZP9H3/6zXOHBd7Q
         py9c9pKxCKZ7jJa3kfxDNVTru6Kfdmy2kvwOZPQSNgo6iw1VqQNdFoHNgKSsThl7cA5O
         Yblw==
X-Forwarded-Encrypted: i=1; AKwUvBy1r+eKKhm1Pq4wNmFvkJxOiaNWoLK90r6nR5q/uleMCo7PB44XYaj55ADOhvqj7C37SOhSnriDMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lZ12nC3jlde6RIsSpP7q4afv/VGAn7Q5hCHYj6TyRAojbyvrLR
	i8jHANig3zVYA/Tbc5LFeE/ThglpuPRlbfDYGqr1AmLBY5N9Yo3WY9Bq
X-Gm-Gg: AYBFou1ll+X8rnmLJrjsIdL25HzSRh7Vg0pUfrt5TjEH4GNESSdKohBBZB3NfFoAZ3a
	mAP3mA/+SaANHDIB9uWjbTiLskQva5qE0TE2I7H3jJuMCGNHM43N40rhtP36rJGy1u1SVf/SiB0
	wHc3us3mb439kZl5L3QBwppuoI0OnGLuJeecmeow0B/85A0omH3x0wTAtgRkXxd7emOriu2/YAV
	GW9BReOv6/A4x0iAF2CR4w8CwS/ONWoHmgX3BkOYJU8ojWP7aU3rtM/KGfwII8l+p2Gk3FXRE/W
	6OvoOWv4xbEQRnO4pZPfau8gewBScMSvmv7YrNwJaMrw4zNMPApxNoEICMS7z0S1EcPqzLk5rLh
	WxT5D+V8SKdg7CS5JGOjvGEWDBTWh0s45aKc14/YObkJLrIQikKh0BCUQmEyVsGT/WZbtaMaQRO
	htA8DV/k6/jazwp1VJ0RIrA2Bb8OLwjV0ajIeXCJX/3gw+8SzHi2vm5ZylZOg7cyl6kQxcSGCeF
	jB3y/kGJ7dF
X-Received: by 2002:a17:90b:4ac9:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39907aff7acmr8439695a91.2.1788254813186;
        Tue, 01 Sep 2026 02:26:53 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30004560eec.4.2026.09.01.02.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:26:52 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 10/12] dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
Date: Tue,  1 Sep 2026 09:24:45 +0000
Message-ID: <20260901092447.3028-11-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901092447.3028-1-sreeshankar0910@gmail.com>
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the PDC block on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8162a49d4..c30b88589 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -50,6 +50,7 @@ properties:
           - qcom,sdx75-pdc
           - qcom,sm4450-pdc
           - qcom,sm6350-pdc
+          - qcom,sm7250-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc
-- 
2.43.0


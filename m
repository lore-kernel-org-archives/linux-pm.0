Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E23AB283
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065847; cv=none; b=beZn9lqrjcaITY85PXz6dRL4QXGTlXoOPA7wFoul68S4i2w4ePrkckXQ0tPpabl4CkXIMeQzbg7Ho2PdbJYI3XwPDz1Ocmc11u4CFc4I7I7xHcYYE7qHZptVQixLC3JIx9lIT1D7QaOePK1LHgkEfJ/0X7trVYfSJdYWcyXx2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065847; c=relaxed/simple;
	bh=cf/KrJDQFnyQUw3xrqnSSlrwVm4zz4YP+q6euR/XWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Etp6a8OoT2colf2gDnNNDTVJPZZuOkqKrFm8tAX1u3PmJuKRsoYVIbx6fv8eu3Ug1RAZ92yrnikRN/Qk2bwdXHZw2/DLTfmiLIo/O4SHmAuZ4jgzwQ/Drk9VriNaGKXgGSgLg8gVfypdUjQII7Rm/9Hzyo23brQwoEic8I1TbGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chzL5fPy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chzL5fPy"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c20363107f4so509249866b.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065843; x=1787670643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gryQvCiECfAOb+HVvqPSFwmSjJ6dIN7CDf1WMgNH1XI=;
        b=chzL5fPynn5ln1dXh7xfn6dyCiwXWGcHkfab3+DGrO0X1sLv3GshmIllJoK7zN+exh
         uPuWqM3R+1tYm24AUaABQOmtFT1SQ6lyc6LOfCRi3Br47nRs1/DJ1c1R4IOFpW7900BO
         VuBmWoU4C01XpsZ2lI4VhJVx+zpJR+d1Crp2QPh2Hlyen/Ujm/woWFEYuD55LyAWXXmn
         M/YWOUYS2rYg1woMGxpkEwTqbBYYJo1y13cf8TZ817CgU34lsgFT7YGbLr0Kzmv1+8ke
         6NiCaKEnlqkH6roZtKbGs++HNAspfLxMcP1TubOR+yrx/qihgHEqiewp5LyXjyYMTMkz
         OlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065843; x=1787670643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gryQvCiECfAOb+HVvqPSFwmSjJ6dIN7CDf1WMgNH1XI=;
        b=VDDwEqaLqQ6cIfLTKTm0cv3IixBjPPZLr8Sjx/3aDSxMv27ZWuMCAwitMfQ+0mGCTt
         edFE+HnFaZPMC+6DPKMYXPIbsz7kj7IOs0HPqkIj70NvzOA3jpFZU/RPw3iwP754JE/4
         GoUNGzdOP+7IL/zGOCi0EkM7vbF3Tl0akCT0XaNPABvdzRsFJqdUsvTm3tX7yUZtn5Hx
         NTc72qRD5TUs4EphNME11QhxivV5aWyLAFmNtpbo96l33YJI4KW4FqWSE5b9PwD4rPkz
         EMwjpuKNWGwVoufEzh62G9QBOPT8BCfIynjriO5OZYq5U3YObW7mjzFUblv7kGDluxZi
         AbPw==
X-Forwarded-Encrypted: i=1; AHgh+RqRllXZo9L024C4Vc/6KLOwra6agjDzU2bU1ofxQfe+/W+xLQUlP/e2KEMuOkbv5zwDUK+yaIY++A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLm7Qn7rVv+xJj6Ics9kXhQ2E9Ekf9mZlBEghe9TAXPPpIlcY
	eVeJdFY1mdEwj638JVPMJynbdwWDsCKEcWbK6Y6IWqGdoIbOzMjswPUE
X-Gm-Gg: AR+sD12fyj97hismYj3OPdlaaWJebdbt1mzyxFThlMJhZwqlcssX1heC1uI38LkWl24
	DBrJ/AgGuNP8ad0BKJjrkrJsqng0n8hRwqhulHqe1uyg0i1c7R9ymin9LgByZFtDndjviqHnTn8
	Pgf7IrKnCjgcJWPn7531F11U02e87yCBEC9ROzfPH7FKHFNVl9+BDkx0mEYj035P88QgGRIkVg4
	FD7B9luLsZJsg7pLdqJ2gN+yszZJQ53ztLPXQvQcjaCK3AN14B/YmnWhPfUOPSnRYMlYgbuDzEL
	PI89BASQx/0wf2+i1lyNjePJDEgB4642noWemu2jYSvOshAs14I8tgCQfXMdaMpine2RKSbSiOy
	LV+/KalpmTH1DY8lc+JH/dd8a5upNry3mKQTCqlQn7ylTV7EnWKp1GuFMZ4Cc3v2if4AFJe7kGA
	cMPMjdsFzENAEUGV2owjPgBSnBZquNYzqH9+zhiQFZtrv6j3ZshySht7jMeszYNbHISZ29waxTh
	4BOtKiKRAju8zRw+i1k9g==
X-Received: by 2002:a17:907:934b:b0:c16:5cf0:3aff with SMTP id a640c23a62f3a-c2188a7ff97mr581814966b.18.1787065842648;
        Tue, 18 Aug 2026 08:10:42 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fe69cf4sm205772266b.3.2026.08.18.08.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:10:42 -0700 (PDT)
From: "user.email" <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: soc: qcom: add xiaomi,taoyao-pmic-glink compatible
Date: Tue, 18 Aug 2026 17:10:37 +0200
Message-ID: <20260818151039.409767-2-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818151039.409767-1-zstaseg@gmail.com>
References: <20260818151039.409767-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Zaikin <zstaseg@gmail.com>

Add the compatible string used by Xiaomi 12 Lite 5G (taoyao) so its
battery manager can be matched to a device-specific variant in
qcom_battmgr.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 16ad4f5698fc..3a74b5e51e9d 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -43,6 +43,11 @@ properties:
               - qcom,sm7325-pmic-glink
           - const: qcom,qcm6490-pmic-glink
           - const: qcom,pmic-glink
+      - items:
+          - const: xiaomi,taoyao-pmic-glink
+          - const: qcom,sm7325-pmic-glink
+          - const: qcom,qcm6490-pmic-glink
+          - const: qcom,pmic-glink
       - items:
           - enum:
               - qcom,eliza-pmic-glink
-- 
2.53.0


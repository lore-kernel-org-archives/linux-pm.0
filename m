Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2136C5B2
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583801; cv=none; b=n/1+1HVChZ3f3zlEMewnmpg1l4WJlezwNViaiKv4swFzGx9FWyzeI2mqRBF2QmKuUKBqJpCcKa+4tHeURzsmTxJ+zu7mXPHAsjqcz4aTEiTAZARf1ajElhREdXv38Uzj4RTDkMS4N+yOLdVAhfHwn27Lj6WN49mw5yuWjT0/ouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583801; c=relaxed/simple;
	bh=KyU8fbc7e+jGln1gvgBbCQwRZ+9nqq3IhPL/wCHuXiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuC03Qgr/l0m/E1vGTz75dQi9a0DgFPf2F0l92CJJZqnrR3l6MPEstQWoWi4pcTTI6tl0bltJfkY+KmzDTqf2A7NLvnXaevys+p1rFiGBNLFxMSVRbxef62JzY8vR+1GSHoH3EoXz7mTXbwWPOwdK5a6Je3G4NGS7nAMllIUa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E34Rp+wl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E34Rp+wl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cedda2ce6fso21467145ad.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583796; x=1788188596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWJvev8rwDkHrWVtePCBv0HB68OwkWKr1ifArwWeRlE=;
        b=E34Rp+wl0yz1IPG8cRmGYQ5QFdSCKhFZETCgIoT8ZRD8dvKXKrOXRM6kUm0KvrJh93
         8WTVJbbzrEW/tqqWeOxrGYBlx/rlBI9ez3Vsy44dfBMdUaoeuByTzAqSgToIsvjUvN8B
         2Pp4A39Gk4M5AlLi3Lj1MPhZOwdrsILoNRkWBuIOPxvrMGmqHCou7YAQ+GUnBfFAnkcT
         AywKo2tBDbUNcJouBD9b3jHVjAFSdmXLt/c2/pkAyCyNY8oQx41SB6glK360uE6oowHf
         i2gRTSxZ2fDKUe0UcWuOn0dmDfHXE/CxYDXS8svEYodY2npO2ys6WDptZsFrgsyr3odL
         SoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583796; x=1788188596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWJvev8rwDkHrWVtePCBv0HB68OwkWKr1ifArwWeRlE=;
        b=IAfFVSzpvDPHwqDFmcBDAl6lmQuxRQhdp4r3DOKTCrmcWWt7pW/OZsbuf4JNHP4XmV
         USQfW3eNtO4tYjW6+UBx/b2+H0xU18ID4JJzG3H/9M68LsK4JTiJ+VhucQv0jCKe5p4C
         7ApK6MtXP8QuriPFILsMjZRvBG/pIrKe0aM0K9NJiA8ZX9RVHtRFVZYO+c8qUaHFOvh6
         s19DxAUp+NxE+Ky+XZ340x4TSmgOeA/8hTBbxhpMi5lo263eyUuDuB+OBxdexdsTK1rL
         5RLgpEPywMZt1hSa4CsBVKsSm8udfliqgStEA5FG6bOUbjODjnknUSbteH5MAJTLfwUi
         Kgfg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/rJB41DGN4QEVfKP4VzNligub8GH1VcLyehhzVjVzdJRW8Fd6LXcTSA0JyOtDpkWJjmu0rUs3Yw==@vger.kernel.org
X-Gm-Message-State: AFuF++l9cyvlAm+hQCu6cyZ5xYviw1ESqAHUNpy9/mQy1mvUox3FDkdE
	1HcjQYSCpY4yAdhxEOwqlbwa6zheTCJSu5U77IPimqSjOTmXTAa1+/3L
X-Gm-Gg: AR+sD10zTDL58VKgx5hN6kCBNFpPHKCnc8xfpdWychvIxSxm39JF2TvjFlHr6GDyNm+
	gpUI+9qRVojEBjt17UndwQsx+m9mZB1ZoLbmwi8A1ycoOnUIIR8EIGJyHEIFmH1QcdXdIheqKV0
	ES3PyQIL/u3FXJjLDJtlxOSI7RjJFantbwgtQcS/YVCJFhHmhh8+1ZNH+1elVHrpl6uIDtzeId0
	y85jp9bAWPzPbwx8Asw7ynFVlm0FAAooxXGElRNytjs2uDTNXnb4sA9CtL+/h8fJ73uq53LKhal
	HONLd0fSVx+IXdB+J9stAqMlubkuc5AJCSbTMIdiG+arA0bAz28PkqhGVMB9mUl4Kds2d1ENexv
	/Wo21FFh1PgTMPJZ4Ue/u6yldLDaimU5xn1rKgdF+tEXdc8GC9nHw4mzCKqbVsbQaE88mfxEM0v
	G/mNWKNxJPR2mEgs7YMMv1ASjqRmRLMpKbX0P73JnLfULxE29oswdT5ylwFncjsDokqCGRZrcve
	HxlvQkArBWp
X-Received: by 2002:a17:90b:5646:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-395c33367ebmr51192671a91.1.1787583795944;
        Mon, 24 Aug 2026 08:03:15 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm30035247eec.19.2026.08.24.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:03:14 -0700 (PDT)
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
	taniya.das@oss.qualcomm.com,
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
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 05/13] dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
Date: Mon, 24 Aug 2026 15:01:48 +0000
Message-ID: <20260824150156.1310-6-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document RPMHCC compatible for clock rpmh driver on Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index d344b3386..df9e37f90 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -38,6 +38,7 @@ properties:
       - qcom,sdx75-rpmh-clk
       - qcom,sm4450-rpmh-clk
       - qcom,sm6350-rpmh-clk
+      - qcom,sm7250-rpmh-clk
       - qcom,sm8150-rpmh-clk
       - qcom,sm8250-rpmh-clk
       - qcom,sm8350-rpmh-clk
-- 
2.43.0


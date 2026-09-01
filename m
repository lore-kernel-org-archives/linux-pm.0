Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E15476044
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254785; cv=none; b=hrIAIep7QkOU29YUD0owXk0N2zKXK1RvpKnGMfrF5V2BQaqZ6oFHlCxAmzBSYy6jPn3ceIzYVLFal8tRgIKO58O06SBxfY7YJz1YoqXACaZvKXCUI+y8lAcL7ZfTtWjz+fWYd4z5ArtngCtPQTkQ5GCnPhdumrZdsyDLeDazem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254785; c=relaxed/simple;
	bh=SL1wdM6vp1VIszL+xuNFr+53xhHZT8pJnJOiXD1KxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2OfwQ0v1hdNgb0Pyd2MrOmLt76Zx3aGTZX0HlH2DM41mmvGEFuCJOxl95nhDnpdr/9AhYXiOhUECIzy3faF3m3oT65BiL7OS9jochqXKhBKA0I2m3PFeyW/n1xHqunN9GUVBAt2wD2CQTirYf4vHr2Y++ydZKoHS0hXLB/51U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfjcv7CS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfjcv7CS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e27035206so4416872b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254783; x=1788859583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RKT3VAzrTBQCbJUoz7WVF1Zm7cw9xcizV7Y1JN603Bc=;
        b=Wfjcv7CSNfV95EKHKsS0HtfoI+zeaZJr4NqeZhRIq8t5DodZDA34aWuKv1g/CvaqXA
         UTBkWeuke9tUs455N78MCxi644iUNsz0pmbXeikfRPqspJ7Niv3fY0BVy7fUHUl+gTMC
         1BWDK5/tcHUCh2GQN8VEpn5LxwFpMOOzMH0U03ussI2vdyQjQmcG/GaYjiHAhi6M8GlZ
         610bXsiBFRxIFPhmehCIr05ucpAmn6L7/6tikBIzG7kW6Cq3+StV57lu/lqxCgyz95qq
         oKEfuZEkwgaejnPvlbtr/prr1UyJTOn7A4y5oYMOwPiJFUonKG2h5MgYODQgJ6aXa7BQ
         SUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254783; x=1788859583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RKT3VAzrTBQCbJUoz7WVF1Zm7cw9xcizV7Y1JN603Bc=;
        b=UKtEU1BucSgUVSRzA4Q54RyQv/WHBjk/2cYmZm2YWhfIK0rDJFVVxA/+J16byEH/zo
         U8h8c7wlWYa1LBAO7A8te0LBz51CGj7ur/xKoTQA324oiFRmoi4FOLbTq6NEeub/0GWe
         mGAEyUUinlB4MHiadBjOJcPxOCvySgkboD1Cu509XVy9xnpPg8BzztDmbEMqUCI7kVR9
         /stcMh3KHtjUuH/B4Hx2iB4sNH8UX3SXQVrKl9Dl/Chh5jZ1NTcHcxAtvQ0KVI5GrfIU
         KDqEprBh38joYhAoQxdn7HXrn438882hMniOTlE1xwC23kMyE6ilU8E+bXF0q4WeTYf1
         Lehg==
X-Forwarded-Encrypted: i=1; AHgh+RoA+ZuVQzmdoxR0XuMe4C0YXz3XW5YUdvdPmsXJUyX42ufrDL8WhCLc0nbgbcKTfUV2o7uEzhL9jg==@vger.kernel.org
X-Gm-Message-State: AFuF++nxroeE5d54zIR18g+Yp9BdPwbqwb/LPyvOI5p5Qsqwn1ky5uNG
	2/MTWHIM2DtCvnb9w94UfJBAwkHz4XMD9dp2rT1SO3mtvkf2hckoxzAM
X-Gm-Gg: AR+sD13QrtHZjjgIdTZyDr6BsrD7k0dZblIPfhS80uf08Sk0nLY/BPDMmsOJ18tH6lM
	xUBLETFiLGKkYjPf+zEJT8stXmU9fu5vYrWEJJEnQpHBkrayWLb/fjIu3TrZ+KRDnsqAbEHYQHJ
	hyio9ZJ5iOAbjZozQZlDlXoeFHO2Y7WH5oPOCoN6EcRMYAz6gp1QZyBBQBtn076tbf/xAE6fxA6
	RRbFipHw/vvoBKWZBn1PxlvdcFhHTRGrHWQj/TnWjBnaoevyaGbZrRLlQRc+yqgwoPpFjwqUcqr
	uu8TI4J7l0t4zIveJmPltXBLjQ3bDTt4452709mhlDvIfjMlxSVpAdQtgrwP4ICKwV0s8Dr6TxB
	4RRieGDBespmVDFDZz2UVB4LXZ0+FKTRzGSvT54uz+YpHTmYK76SOC60yi0TdVq//uZ8LSfi1Ku
	CsudXx4VnsJKY4NCRfrtxYCDoqvKvhmiNNZ0dsdiWymnFNrpompddJDUHzxFHs66+OUh19BBlP9
	YUeu6QHEyE5
X-Received: by 2002:a05:6a20:6a26:b0:3d3:aec2:4dce with SMTP id adf61e73a8af0-3d7b0a5c828mr8639402637.26.1788254782938;
        Tue, 01 Sep 2026 02:26:22 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30004560eec.4.2026.09.01.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:26:22 -0700 (PDT)
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
Subject: [PATCH v9 07/12] dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
Date: Tue,  1 Sep 2026 09:24:42 +0000
Message-ID: <20260901092447.3028-8-sreeshankar0910@gmail.com>
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

Document the RPMh power domain for SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0a45e1f55..e08441915 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -63,6 +63,7 @@ properties:
           - qcom,sm6350-rpmhpd
           - qcom,sm6375-rpmpd
           - qcom,sm7150-rpmhpd
+          - qcom,sm7250-rpmhpd
           - qcom,sm8150-rpmhpd
           - qcom,sm8250-rpmhpd
           - qcom,sm8350-rpmhpd
-- 
2.43.0


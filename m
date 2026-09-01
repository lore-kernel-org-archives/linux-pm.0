Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B04CCDD5
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245117; cv=none; b=LPq16sDXtp+VD0ObHmhiRvdAcq1avCxPJKFoXu49GZgrHhTIBocKidpjFwJDbUjVleQA93wvaI23Z9cDMEM/4pjbA/NjTPJIoB3b9kea4OwjezmDZJgH7+72yODUK4ou2ye7p06VkjbQV1+tbrGjrOqWyv0BS7/doiRvmyqmn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245117; c=relaxed/simple;
	bh=ifqmFvQHebUZje8XaAAuBMN9RaGf9xFULb+csDNh1fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8tpfkPatkTr/hQSzW5a+BWJ7e51Nu9nEAxvmRrT3m8u2HwbvK7Y7SaWg96CV3DVgEOn/LguWQFx43xLriOvkckQcQB/LeyPWnlu+ptnP9tAWPETNEPy7Q/uKAJ4dYyizN3I5mer0Zzl0t3wmYDx8b146fl2tZl4H1J+h5ARDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFFG8HKv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFFG8HKv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d71ae3455aso8021765ad.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788245114; x=1788849914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5HJ3g3vUMid02qe6Hj9lnKY1TCRNcUH2lx/tar8eb9o=;
        b=GFFG8HKvpsRmln5VbeHUfJpZvtDvghuA+ojtTA8N4VJLFqHFbie/X5pRiUJ4DbK4fA
         xlJZAbeudTdeN27dYxfqXRkY06aIkltR9AcPbadIs2uqAZgnGhIfeN7slLyQkBdtAJSu
         Iyb0218BDQ8dehh4BPWhPGLWpLkjPIuUOJTDtLWcXBtKGpYr0kffTkZgyvrAOPgf7kbc
         UyzW9wNMqZTLVYfrO58HikiL4xJbv2JcBdLzj5+J7dnRMw3wFHGHIGuC2cNEqBhnBtat
         xR0RhONmM7zdQ/jT2UIhw9cvq2qK2XS0Vz+fpw9J98TtmJPg0oAJyrjXbcxtjBZb+npJ
         uJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245114; x=1788849914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5HJ3g3vUMid02qe6Hj9lnKY1TCRNcUH2lx/tar8eb9o=;
        b=rw9eTX2B+1aRMyzVjnnupg2ymimP8KeoqR6OagGQPrZNH7oVuErSQv4aNa8hUb8d9v
         bMXmZULqqwkdc/iYD3nHZLU69PY9r4zN84EDnDsX/ew+/Qzsx9Bz+yYM2Rt2MqfJRNIj
         P2b+4U8/gyo9m5G5t6rreK5lgqIF8dh6RB3Gu8FyDmkMqHekuuSahcsyC4YAzNZTIurF
         WonbIV016vT8d9g/SvtiqKahHhPQMqAhQlnvLhpLdQKaf19wB+Ovm+DmPMCBe8AI3NwK
         70b2bnPvkOtPSINpgAtORbiqN7/XqnRAXkSwBUOF3FsfWFdxQb7EHYqRgyTP/pziPGT6
         blIA==
X-Forwarded-Encrypted: i=1; AHgh+RrCMcCt8CwHA4Sd8vJSEKqNMvgOGghFmQiegcYC4mWZql+XsJkDcCy2AAgU8ZJHM6d2akxtpsGcPA==@vger.kernel.org
X-Gm-Message-State: AFuF++lRSHb51xH2/o9VYZLHaAwKr/a7xTFFMUXkRy5DF4YfOnLC2v46
	+9nauT4mgl+KTFTyHtMA4TtwlFWj2hdUVHbBc63e0bGSPowI0FSKFYku
X-Gm-Gg: AYBFou3mtFNRZnAhvTURspPppKW85C41zIPkWHxxehrzQwkfSUzWjsXKjYhNX4JKjZu
	AqoauM8dojQ6o0DDWTHBhLZeSe+cBltfWU1ILAUj8/Ra5AQ0T+vqWSMOs5sjRKjE9j4Ak1Xbu0I
	qEASJzuGzC1dQqKGgKUW1Elp26kOyrORHEmYjm/CPcTLQgsXz1TMzchoP7xyD/Mh5tyHnDV7hbv
	c842cwdKR4q6SeRL7DuZLaBvwQ6OmvXG6r0XNovWtiY5g7XK5sdQg/QGu31EjtZxJLiBIR/LQ7H
	UMVozHDFPK+9zp7F9qTePhpQlWDeP5NqNq22FELUR1gktkrojthq2vER4zh/+Oq/adrWleRfJpI
	y3GAWEmSmETEd2uSIStu4N5pi+bdT2x0frPIThhrZYnfWEe5py3+Qp7XlRCWMovxnEwGuJ1zbTu
	xnncehCrgA10wZ/3tWISG0iN5YJjDFqPtkSLCHuemLVpfMgWUM+euNwjsb9XP3LSGzLgvbbOfYc
	RHEW9CGQCOCv/ixqfH7KXk=
X-Received: by 2002:a17:903:1b44:b0:2d8:d4cc:5bb1 with SMTP id d9443c01a7336-2d8d4cc5db8mr338679535ad.17.1788245114494;
        Mon, 31 Aug 2026 23:45:14 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm37019784eec.27.2026.08.31.23.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 23:45:13 -0700 (PDT)
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
Subject: [PATCH v7 05/12] dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
Date: Tue,  1 Sep 2026 06:43:50 +0000
Message-ID: <20260901064357.20055-6-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901064357.20055-1-sreeshankar0910@gmail.com>
References: <20260901064357.20055-1-sreeshankar0910@gmail.com>
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
index 2b446aca5..45d3cc861 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,sdx75-rpmh-clk
           - qcom,sm4450-rpmh-clk
           - qcom,sm6350-rpmh-clk
+          - qcom,sm7250-rpmh-clk
           - qcom,sm8150-rpmh-clk
           - qcom,sm8250-rpmh-clk
           - qcom,sm8350-rpmh-clk
-- 
2.43.0


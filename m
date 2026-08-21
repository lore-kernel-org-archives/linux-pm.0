Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1AC43031F
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300010; cv=none; b=nVSLKH/Q+unEjTAdSs/g3dsDtOWnnvRlO9sre3ZWEoIaeR7i6ybTI8p8mC6/T2mK6Hml+BjCmASMVLSudgzz0J1vB2uEMPh2yO2u7w1DrluMeBenHWyyQdcVlg5CVQc/O3BBUwkI9Dh5wJbuPKSrr0ZlYgEp2yUecrwFbDocJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300010; c=relaxed/simple;
	bh=Unl00eAfFi9To3aFPzg9GlTfdXTVfm9Q5VowGJ6jvsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRThpehZ99j0LaGbYFyZZJ3ebcUD+kb+Yc+x5y+Pw0VRpc0JydFbT4LppQL53Dw8QYNSirXQ0LI/iu/dYV68jK4CN4Qf+WSwBwMxCDCOVYkVihKWaSm3maT1fRmMPBKBHlQbIDazIMcm2IUkuKIpPGjUAX4aaGJCT14qgBdk8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQOqBzp2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQOqBzp2"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb7926836eso546135a12.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787300008; x=1787904808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=BQOqBzp21Tqbs8JhsY/vedKWOJ7Ry2oNulIN0DAA02Xl0ehEzfRIHoFtUagc00uW0E
         uvAPHNDdsfgtNXKFZFHq0FhzW7qCaFQo5i7P1fooDI41/eu1js9XFOVA55RAhd9d9VyM
         WZyYb6cnmifY+hFAMERwU2Z0qDZY7i36UL0FH6okc4/7burdC6Bdli0ezPsn9jO/8z9Q
         GPlk+i1YW1P5iya7oWp//iGyZ4dJmPu6LsDBpCUlsuqo992RFxiONE/0DP1bOLDblJyj
         gqf80xw1iyHP/gj8twXq/pHhat6BkZNtobx6yflRCACgChpWxzLz0rEtV+sJXLHqdJ24
         ai9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787300008; x=1787904808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=HntpaZ64jnfpoQREB0ZKDGzPPYznekjAocrSaZ5JDlGm8afwXnyaj8jqZ6IM2y10FN
         8uiXbB1ryDFfNCZbMpLN2ZG4uaxTId4ThjRCxkbE4TrDWUIbNUYKgZai2sGGFdkbtBZR
         jZT2AT+guomYW8eF4crh706m0lbAktmkyjxxSYJmeefCnCf7gBQZnl0FfGfrnBY1NeSj
         ly8lk5YHc+4n6UaxWavRo48eLFDAGjkj6T+fWZenXir7ee0esoTItUJ4Bi39gsKU3O2r
         tDW6rFc1ARbgHHuW10Nsfgy0jbqo/jaZBw76zR2do6iRv6LAL0OiHm5AngohSb7hnGRf
         e0cw==
X-Forwarded-Encrypted: i=1; AHgh+RoTSDIwwzMzK3n+bZBxIWoS7/NEm5OBFrcW9JOen+trJma3eXNxszYgaoXx+2lMpEF/RY+6JkGBcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvSyWcbBjGLjIT1LyPTv+SSms1/G3/e5SRcWEaKZNGUW7ck9T
	AT7NxMr8pcHT/odzt0RQlyoD9vo5r9NOYTr4sFxBsigDiUs4asMWfxqJ
X-Gm-Gg: AR+sD128uI2d24U91h/2pODZEMBR9g8nTRXmKOzLhSgUnx2lKOfY67D/+E6cKK3Tk+t
	q9PuyasZCdBNPgleJM5ubLRp7RotFzMgGCWAzMPgvAZd2iTOGeMZ1D4uotcm2TKcsmTzEEcXYxS
	+oqlsLUquyT6ggw+Ck6iPYhabzOm4v1Cjqdwk5LWwb/u8E3F0drhlPvMChYD7HL5UO+bStl6uMw
	u/EcXTPZESdWqoBl7UP7iy5OZmVFa+W1EP29ujbWFzlI1LvEzljOqQ39y//UqYn7iU48mHbXl3+
	QPnsE16XSGpghh2r9RyIIUIrEgJbHlgNqH23nx+9OLIUx12o+TnAN7ZS1lO+bEuzxy6xKDbdX2V
	+zk+SPIdOn+f1ZwHlDRRcRFUkGPZ5fMtDe5AUMTYXg7HdHnZGiSShfpb2H3lZWVgACMTyXvkW8w
	q9TPRxL66thxiB5owUqGY6AuHS4YcCTvTMy/9RiwutgPewLpIgVlQ/yUz9Ub8ks7Dd7R89huTuU
	DOJ0E7vVCJyP2gM+g==
X-Received: by 2002:a05:6a20:e212:b0:3c4:2cf9:28ad with SMTP id adf61e73a8af0-3cd3000a175mr7931614637.12.1787300008489;
        Fri, 21 Aug 2026 01:13:28 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm22040786c88.12.2026.08.21.01.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:13:27 -0700 (PDT)
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
Subject: [PATCH v3 09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs
Date: Fri, 21 Aug 2026 08:11:21 +0000
Message-ID: <20260821081125.4522-10-sreeshankar0910@gmail.com>
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

Document Kryo 475 CPUs found in Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5be89c584..2a90af67c 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -212,6 +212,7 @@ properties:
           - qcom,kryo465
           - qcom,kryo468
           - qcom,kryo470
+          - qcom,kryo475
           - qcom,kryo485
           - qcom,kryo560
           - qcom,kryo570
-- 
2.43.0


Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBED43C06F
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583843; cv=none; b=TkyLNnQjQw6NNoBjHf38Y9f+08K+xJ6cdaFyMQuAsZ4luUJ911OjXJ7338leDAi7OB8kdBsTcqGpwJvFxsWoKSwcHTT0gJmV//1zrThEKPDYwgA75VodQrkAnvRM5GHfkhk1ZXo7Ng13eGTrn2fmhAUzAF+z9MgOm1oir6pv1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583843; c=relaxed/simple;
	bh=Unl00eAfFi9To3aFPzg9GlTfdXTVfm9Q5VowGJ6jvsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCLaD/Q3Nuw3iWcd1StlgnwpTpjbNE5kvQZShMtH1VhsCInYPV/9UxfG8+AwDxRVrYNR4T96lcd58Rh10jVGqpIbAqQYulyAq5Sxber2UFMouDWPGbuyM0+YQ+sJ5yfkVVExmmJWoSscSwEEUrm/cAAyQZru7O3sQRJg1DLK7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYUqAMCG; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYUqAMCG"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4634d881742so2013077fac.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583839; x=1788188639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=rYUqAMCGDlpuVipgjLf9BSE5JLWUWa7BwQ3aooNiZiy/l8pi1s5wR3z5A5vb2bCMig
         0cb+LQAS9i2ZP9X6mPmSoojy7gUKWElDzyK42+UFPgVcZdMZIKVRrOREjtqmeYF5kESR
         8z9/ILOJ8c0t5pJQO9TOM8BMeCxNVCjAJNZ3eNHr1D8ikfasFEn9D7Yiggk08xYNr4cT
         G4D5T4whUXOXy7kBe9dXKYDju7hodgdC9b1T9KKjjNsZGOsUMaI/mZXEqsaLyBpc1WU/
         Lf/m2wRH6p5GX5OXqhARRQIeOW6HvcWADIEjWquGr2DsZ45ghLGVbobMoxGqGCqivvcW
         n+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583839; x=1788188639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=a/kv5w8bViAfd4amJtXodRgjbasWVqxVCu6deE3UGKhjpSOnB8nlM+CZCMDSL90fES
         wWUOy/gmPUzvK8a6G5ACd/B5UZutEsPvC0TGD2gY7FHnhaWRwi5/bUmWG488ssYHZAgV
         Duo0Do7WiM3stHGIVEvbQw/1iCWodfu86ZgKPaV+rIzTTzxTHaVieaCRXwa1ZIYZqKL4
         z1A+feKN7Mxs+xGGasgZXF/vkh0hXFvWu9qvJlvAqH8+4m6EG0OK3d9iZfiBAl5BxEp3
         7U/Tt1P/zKNO1sEF8Z7eX5uIIVm28DeOmGwTBeEi1UWO5DI2WKheF+4DHD+eBAAvnjrQ
         Gqew==
X-Forwarded-Encrypted: i=1; AHgh+RoyoOluG+3Gr77xYNmLdEOvAQaJK6ZIj45GwYi3LniDjT9nLsUVSu0JG2knpWoToSMEzZrGMe9s6w==@vger.kernel.org
X-Gm-Message-State: AFuF++mtKSYVjO/R+qpPFEsUQ5U4cK6en66T0rqfM6EnCtCueUmC5vOs
	zbc6rThL+Rh3xpV/320PfcvY3tcqrY6zQgZMg1IJTJrwYmBUR/pd4zZo
X-Gm-Gg: AR+sD10koiYNxmoC0zzyMwhEDZ85DQa/d8xagDQLjZH0eNKaErx/xdZrNrnkra784Ow
	NLF5Gt4ORyoeJiVxSm9bXDjvD/AtIeLbL7HACq8Yo0f0xcRdp3B4EMxEOLJZYqmEbW2fwpBu0o8
	KRgz3Hfs0R3Dy0Szx7/6uri4v+ty987HQQAak+uSQV0/OwDbU3cdESy5eX9lYFST9yUtePjjLxZ
	yBjcteoWo7uRmtMvyMWDLDgE4NUzCKxBRWDWSe3J62imhDtmr2eyXowG9CLubvfv29s5KdGyJNF
	/43d5KoTnVd9ZNLBJBVH1VE2J5N6wtFGhnz1sk/mkPffDVScBQzf/XWCayyYJNSMeeHzNlbzDfE
	2hUO0WdDsaoFoZ4E6tGBIVUD/C5z9KbXBncw4omb+gChAxoDhWsiEzyYbte0+yzMG+b0rKxNFZp
	5eFpuXlREQFN81bP+Hbg7vdAtx8qsXH7yxXKlsTDBh8m30vor5tQh+im0J2kcT6NKTRumMkXrs9
	stzq6ExN1tC
X-Received: by 2002:a05:6820:83c4:20b0:6b1:4b64:13f4 with SMTP id 006d021491bc7-6b159284d3amr19040221eaf.15.1787583839499;
        Mon, 24 Aug 2026 08:03:59 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm30035247eec.19.2026.08.24.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:03:58 -0700 (PDT)
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
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v6 09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs
Date: Mon, 24 Aug 2026 15:01:52 +0000
Message-ID: <20260824150156.1310-10-sreeshankar0910@gmail.com>
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


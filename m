Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A9356A38
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326926; cv=none; b=mxSxJHvGtq9HqHD0CK28NDpYACvgJyid3p1e60mU6d9iycU+6796MXU3v5/aqiir3Uf0OEGFk84Yq+BSOKqzfV1O8WoFJSzTu5iaRvj7JYjs83qnvCsT+K8cSN/8f7VIjdlX1NbrdjA/TffjL81dAz02AVbVR52Jisc+/wO8EmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326926; c=relaxed/simple;
	bh=jKh+XPUoJmr7fIpNbx8/2EaPd/67MsZW4ebNDZ/8MPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGRJrqO+6biE6/mFa/3saQIfgC8h3E5ei7YzMN+kBlN7Nc7i4dYf5ItIuymO50q5PEqznbNj/afjs7X5c5ecPpqHuRplF1/Ve+BAkrA52TryKhn4ujdS4Cnvm35JqccV2HEEJUDgazf+lxBA6rht9Rb6kphx6Tct3H5EP7FDn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/4jkxkW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/4jkxkW"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e88b60121so829214a91.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326924; x=1787931724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQnqfdvjWzHpIFqKpmfnZN4AvVDc8IQ+C2JI25EK8GQ=;
        b=J/4jkxkWBvSQGMF3DzBFLupkWH8JYQIuiOmzEoBQcIDk8TAyhRcAwFwF78mWw+HJlc
         h2wufJAGQg0HHegQ9AsyXQg3RnIjl3qjVzHuc/vY0ZVds/f+lR6TwUU611OVgsxwLIFq
         l8G6bZREYTV5m3XYQY08GH5CjJKIWU2bk7PGV0iwpFTfZ8GgYSzuf14HxyUtaMxh9ORM
         zqIr/i/RdQaP3d4m6oP4G//o4ICn8VRFpxMZBj0Fow3LttgH+qgLlZLdNIBbDAOGC8Wm
         BoeEHNl+Kwb9bv8NFEuAKxHUNQbIny3Gb+Up8MUpZCOiPWoYfQF3c6FOThwVK28GemAR
         UMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326924; x=1787931724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQnqfdvjWzHpIFqKpmfnZN4AvVDc8IQ+C2JI25EK8GQ=;
        b=EIBDwd1M2m74NPr/8LzZbT0nuTiy3057GH628wvwcS72amB8kCNGZZWPQ1s6HnDEQd
         pWI87yztqqU1zarF1wPY891leBwJhinqcSYZAV5M0OUqjQtWY7gW2Q/NtgrXe4eNUmiA
         NEu62f3EGUnOhATRcFuO6h1mKim4bYQB7yh2SXtoIOEuuL4PaM3l8cw1TZgGU9zt1t/T
         1YTwIFJTSST6DJLwfuc+bLNFZC5avbvpfSe9SoCfmReX4edm2mDfbtzeuxUYQcn7qOed
         hqrTgjvDQ3TC49CU6f3w14r0yNpBosfgZ5Nkxp5X4h4quGj5RAqGq/kgKSOmV4CxgoU9
         ab4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrcnvFMMsSIl9Gj8KlarBlj4LTsrHMQ543f9r76ZtT2cmUSFwmpUveFqkjbwqEnSGrToWufhEbHVQ==@vger.kernel.org
X-Gm-Message-State: AFuF++my+YBfvTxGwLVaTNLUcp107kv0eOYV5p19EFb4R9QdXrGK5lfY
	zGeI9fuVc0N+iJcKhwTpB/Q43JeJPOF2BtbW+6ispJipEFBcHh3Lu/qy
X-Gm-Gg: AR+sD107nj97Cr7AMRGQGxK9rjfp7cGEvTpdwn3OVp57TejBOizBrPzIQ4YHKUNgRb8
	DFkrBks351Aj0tF8YcXc76f70cBdicaP9Qc5lqNnC6wSMHnApqvBgqCp8PJLQrr0xbIbbB+7Lpc
	IrLizdSAr6/pma1ArYfSmQrApM7fh2cyKMmi6tWDbJ9dDeezyyHDIaLMUadpyfeRS5GvKseCQuY
	xDQ4OaWY4CYPZAxwC6tWK7rsdNltZVSJ0u0iMzHdnwo0ObMXzuSxxvhF23fMQa1DfIWLqRMvKcz
	LDND3FOEEJ01V/ES7E/rBmplnz5z4Jwow+quTNqtbc4+1v8wcITWxhvS6Qdi2Nr8J7k/I90Phrg
	mZDiD1t7AopbFVqwJyiDTIUsWWEhLLJlyDDNe8u7BmgIVSmKU94B/O43BFqvYEnUe//uMAU1H1e
	BKbufGt88q9FBd69Mj5in0MS9BzI5szULSN5TxLwmXhXAgdNj6lTmUwJz4IH0SSOUjMKFCoKqm+
	cj/hw5S3/V1
X-Received: by 2002:a17:90a:e7c3:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-395c37130d0mr12860660a91.12.1787326924462;
        Fri, 21 Aug 2026 08:42:04 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:42:04 -0700 (PDT)
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
Subject: [PATCH v4 07/13] dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
Date: Fri, 21 Aug 2026 15:40:24 +0000
Message-ID: <20260821154030.2514-8-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821154030.2514-1-sreeshankar0910@gmail.com>
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the RPMh power domain for SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
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


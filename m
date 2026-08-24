Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37F321457
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576797; cv=none; b=f9LmPpuZNKH/CyqolDinPeIKTBP7qEyRZ088LhWgUpwCH4ylWL096oqUd3XkSq2nHNjNrtq5xLj3u3Hw4hT4fDIsa9iBTdhuv0NG04OjzMlP0/yvylVg1Xkiei0ws5jWi143FVLl4/DiUsoOa52OdF0OWflfEdHW6Q5EAQtpvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576797; c=relaxed/simple;
	bh=Unl00eAfFi9To3aFPzg9GlTfdXTVfm9Q5VowGJ6jvsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLDzjFYR2RoXwxpK7cb0QaEJ0SvTe8scrkjqC7+JgALV8tbH/k363sm6aMsuJ5a5KtHB84clphsS6ayjeUqcqmd0Uny/4q3fKmD1c3zdTlA0BqEjsNw/dgCOviz/zXrwgigQ+XznRp1ocbB7Mag777ZuHIOasNL3N+B9DN9GuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOn8zvgx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOn8zvgx"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2965303a91.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576795; x=1788181595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=BOn8zvgx8OR00F/IRRPkOS6UfJx55Fwk5teZsIj/GZyVjxbqpjlwH9f1bUTGpVhTPM
         PistBs8F0beWFzNyfvjNIFCRbVuPBF2VL6FvCq+OkTatN/VW0j0g3TMzyjGGVPRMKDSi
         QBR9V910IwdUQxze+YHHzgvooFmNWU0IKMrl2DQBY//EGA9fr4KBpSER8C0krBkHKBbz
         5r853GF41gRmBQG6mzSkO8+I7NQerUYB3kqaIl7b94TrCP25hWt+H24jEuCMy5mDSFPP
         wjZYgSCnELUXOZTUKQ/jAV/PeWsBEdqC+IgofyVCDBI35ziTx93Xmg8La5FXrI+Omhhj
         uyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576795; x=1788181595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=O/D/8rHi4xal8Wn4N0qmaHjNuGygfGwz/03L4PebV8el+8y+GLsy62glMgoimM4MAN
         eK2NS9WjCoU6yyerSMDQj+2RD4v1vTT4K3PgA2L0qVhedfj52lhhuoFGojExAi6P20B1
         iKpEqc2d8nekFMhEgTRXQS196W0T47rAOrNT7vHTmPqBpy7IcaivyAiE0DsONFX7TuLk
         uYEWDnrggdgpFhCT1Ylz93NuVMNny3ZWpBFJcoyQG1G7nXEu4RuXALZF5OnKeoCYAU+5
         gRxsq3Dkl1WWmlrLSLZyMb2kYBQnxUVTFI53RGRFa+6BpT5fsL2jBXqQxrQS7qsTsLsq
         jYwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfSzhsfPQ/MY+LcuUD5/4JHIfYZwYdlTDSHeLysb++1uNv5flC3cwsOEA2/XyiaNKvBGs2zz3O6w==@vger.kernel.org
X-Gm-Message-State: AFuF++kZcCir8v9evfy+KNYkwUYkz+C3pTw6LdMXuk0aGhyizMT7idT9
	fxV2KpKC8tUNGuclq2+2McFzJVn1ltfFOddvHQLyOuLeuv+KC73x1Ecu
X-Gm-Gg: AR+sD11fGBfotpXEv6K+UDFwSRw+NcANGY3x9D8hcg+gUQoOvmO6X8qY5FwRiVFQUen
	m59jSL5HsxSLNNdZWwlZ0gzgtxBW3dAMe1Zp6ejfoPFioO0fliQ1bi7NZhqkKPkV7gzkY1IrFmf
	g8Be1MFoxgfNz/XVcGTKMkDqxsb8JCKj41BxTKgtEupERHTVScR/X4pX2Wp0VbyBrHZ87W+wN7x
	dHy267uWetaAs1G4gmAJhn/HH/pZKIKXgZ81TRmdHnolDypUTAUqnpC+3h0RPhbOIFbYzaNMhRt
	5hIc2u20jD4s/GuqKtvEPmLi/9SDMYrVzvd8BMbgXXyP4RrCJhDJ5ZhY54wLzRc+ZVyojhhmhgE
	xjCaIrmTDDQTxfsjuX2fZVw11inGWUHV8LS5IRTp2m0RnLA3Yh9bqVyCUcgPvlkw99GJvHxbI2g
	/QvsjKgx1Ote2h5WiXw90DaA2050DdroUqExxfbjuqDawi5gg7AFKHxs520i7/suySV0Q4TAyxX
	CcRaaQTGTSN
X-Received: by 2002:a17:90b:3902:b0:38e:a52e:a3c9 with SMTP id 98e67ed59e1d1-395a04ea8f7mr37077108a91.8.1787576795390;
        Mon, 24 Aug 2026 06:06:35 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:06:34 -0700 (PDT)
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
Subject: [PATCH v5 09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs
Date: Mon, 24 Aug 2026 13:04:33 +0000
Message-ID: <20260824130437.2771-10-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824130437.2771-1-sreeshankar0910@gmail.com>
References: <20260824130437.2771-1-sreeshankar0910@gmail.com>
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


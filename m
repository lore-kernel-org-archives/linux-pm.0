Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FB430CF8
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300021; cv=none; b=pVbR57EsSoMB8Uc1oXsiOUjKx0kxBBn77JhoZ9AhRXb262rk0OtzYrdkyO1pbGkpQhK+c5r0vdoobXoUutttyRqzyEUVNXZ7hBVJw+WUt9VE783j2KRCgaWfJLoXJmQEk0Ljjj0t/Evb95AuIXXI5kJbnRVl3pQJ5jjAlFEPK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300021; c=relaxed/simple;
	bh=gKbqr+JbhugVzrK4haKucfxH1GbAmaJ/63Ra+8PimmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUPEjci6lOM0kO02kAv8P7z6G3pNgwRSPq9icFAq8VdHwqmudCRpcgKB6PiVLhJQOwgDpK0EhjFWNSy5JYR4FETE/MdZeOwe7yxBhXLw1QBURvt8dkEoBwUx29rffBEzRY/slFR7BWFnQ5LDwP9os19n683Th0l8i5gt8mGgBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo6Yup2s; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo6Yup2s"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e08baf860so698943a91.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787300019; x=1787904819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=jo6Yup2s1jWFxeAGZmELFCYNh03KUuRZJAi+kbVR8e4+Pzlgwpl6NpDG/wvsl20C2z
         Oq5T91YgMsU0EGW8oWpM1ZgUl6q9mJsMePkO+hOK33IfrX8Q+4FSGWbXCCYCJxGciIcC
         yLIrOkJl4837O6LycxrtPkS4GeRSBi/kh2Wei5pXMZYdhpez6uVGdCIu6wQHLQpqQWsU
         LdBLEcdpks2dR/dO9nv/ZJGpT/iznmYj82LNFx6gIOcDJDik8wpA/Va6BVI15qNzWH6e
         N9m/SvddwGYrVCPk102cbi/2i+Va9JrlVbWf/fBPKAJLrc/lSTfQr0BHt//aorpIdj3i
         /MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787300019; x=1787904819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=oC6IoXpARck2FWZRGC38aQmU+8fLtPE5fwIMa1AckphjdfQsSED34XC3g8z2JzS4zv
         yWHyNLUAOnUCYcJjJoXH53deeOu5kcuzuVXOHCNJ4y5WTbDcTsYfulfPQy/ZaoWvoTFr
         ZTteQFPr37Gy/Fhq1OAnO8eXcroI6NfRy02WQqOkElRghQ/jKm4ayH5d2pjIl4YtiIyn
         S+IYQWj0ZvEBX0KNGPlTSIvy+Ip1JocVcAyabXlDK0oV5kZr2DIFjiP0Ydq/A8Oix3A7
         0HC0+lPCbSpzr+hRScyWEbmbUteysPwCpqH1WhHf1UTqFYkkfGsoaJ+uXnMTjKmlY/71
         BQ1w==
X-Forwarded-Encrypted: i=1; AHgh+RqdlJYk8RQ1jqHv5P4gOu11wswG/AOElBBYcU4b6bERGznwYP3wpD7VqVrB0GGE84cRMP4pLfA1xw==@vger.kernel.org
X-Gm-Message-State: AFuF++mi+zV3FiOarolZY82R8c1SQuzbB+O6SCwTK5xVcCbjBjzsEPuh
	uousuu+3YMPgUv1Yugb2lknXTJcYPpC/J2gI9lppgPrd/ujv6u/CNm3k
X-Gm-Gg: AR+sD10xyAeNTgaAt770JBBmSy9IF+S1BgQnuCdnARM3e6tmJnPetuv5A9GRd9h6+qm
	ATAKSmeFOiLF8BSZVIDnz1E+EqmEuC1kyA/DMvgSO1gq7jb43E3swrsl/UjmknheGXYi+XIlBb4
	wozmu/sQPOkQ+HFuW/DfiWVgDhNGtqoOfz3OBVZXwgdvAYpS+TS89YMbvluYbEYqQJ0eHTw/KvX
	TeSEk5Q59dOaLyaNIGfkMmfVJ1ZvBHBTUAiZEMbGDhc82vCKqmxBhlUXHeGyPNWLk1ZhJuSjMdE
	Bf6SHeFLQPG5kJaUl6/CcK9OdqJT6u1BR2QKCGXMtzSzEAU/BxjTucxdxE6JyMfuHy9Kvx6cM/i
	Gv0uVzMlA/dEXbLJAMnCAyl2SOCY5cp9Ieve0SrYofd+81n+jB84jH/4F/aTyRjp7AGPBF0rKBT
	oXl9tnJMPyWj5OLVYD4nyPXQ7jIGccAN471aO2xZQeLjU1Q5D72D5dl/2gmZL9uSe6n+b2mII6O
	gUsSVeeni/c
X-Received: by 2002:a17:90b:5110:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-395c35dbf5bmr9219448a91.9.1787300019475;
        Fri, 21 Aug 2026 01:13:39 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm22040786c88.12.2026.08.21.01.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:13:38 -0700 (PDT)
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
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 10/13] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Fri, 21 Aug 2026 08:11:22 +0000
Message-ID: <20260821081125.4522-11-sreeshankar0910@gmail.com>
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

Document the SCM compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 037d4ad8f..0cbdb3b2f 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -74,6 +74,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7250
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350
-- 
2.43.0


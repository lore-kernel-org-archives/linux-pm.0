Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6737DABD
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124868; cv=none; b=iNQq86gk+79A5nokdajvGozrmREYDVVw6gi9EG6QW11qouI9X0eb8DLn9gxrdHJwXxwAPFg7SKiMtOaxWj8iOq79gLzhsFhzC6dOxBoSNunM4D1OB3TM2I4xaHTYlb+6REyhF88VHiHXhMiTd9dmNUAOGbFm4wOpi0ftb9o4th4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124868; c=relaxed/simple;
	bh=gKbqr+JbhugVzrK4haKucfxH1GbAmaJ/63Ra+8PimmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ow+Rxmem1hpq0t8lVfM3MCsAbURADqD4oLVO1GBstkgO9ET3f/aqGbgBoHl71CE1YcPVgTnw0Pt0LUVbCZpyWby+h3gPE80sLiXzVpKu90x5+SziYbW05Pw+GFcvpiAZ9Hetd9Zi8wgONsMgokwfA32ogEVJvYC3CynW3n/hBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qE9XFzBl; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE9XFzBl"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35ef6b49813so3359101eec.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 21:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792124865; x=1792729665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=qE9XFzBl9jyqW0qjMgcap3bqgVdBXPoEBrfDfWilfmV5PorLJ3FWrq/VqezFhGqBPD
         QUSXPOAhyETm2SawYS+NmOpbg7H7FiEyQ2YhE4toQyxzuYLIKSxdWx9ylCvQ8bhWckOt
         RqHUbrCpcc4UKTbbJEAU+/ix3JZDcxlSzKd97QoVeFCWG7W6EHBP7C+W8t8G5dbSDWh4
         g9G9KbWaFaqQKf6CqeTrPBlI7UhqoV4ZPJtGV5TeXWDTAzLLe6QR2Ab1V4My+Zqo9vmT
         Umxn4d0sz4+ebloIx8y8XD67YjuNGL4USKsC3lamrvzwe6gpCtueeTV0TfbaVhpC5W8B
         YstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792124865; x=1792729665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=G33DV/sUpqJcLIz/biYT5+wGDD8rth+mlYnV2DrM9uxehcxV+ZWhMGbiEa5VlSVBti
         Ubrx9W1lX1LDSnPx1ABlbSomftESxishGG1l1o60XXflkBkMricXq5/EkJgT2snHaPuc
         rCCVsne/icNUumL91B9+h8xVZJYD7O4wfXvTPyn9qmZ1XvfEudUUa+m5u9udVde0PoWO
         9XIgSVMxoOhq6G9L/lHsDc6t6v9AADF37zSR7FsEROdZp7+RQdMjyoexc3Vz64zClFOv
         6+xT5DnsaEKTA9aXst4xdKJ0DW1uEyWUwBUrK7LkDwbz+uTAFDebWmMzEtb7XXzloNaT
         2EiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhwOMijaP26beSzmB6CLg7HZzSpy3wUps8BT3aQ+wmtp/KF1X2NDgFJCm3Bmuv5VnFq0lNsq70GQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+ONloKJTo/YE7nhhsxUiaBANJHVe3K8bCSok1xz5pHLhC3u7u
	1lPyi1EB/ld/7mFIPKrSBlsUt91X3FcSZbUcegBxNs3xTracTZx/fph4
X-Gm-Gg: AYBFou3FYq/+8Bcga2mKtCcXIg9YHzV2tnALYhbQCXXDaP5b86Mb5BDN5LXdUDjQVod
	jHqmimcDlFWFrOTocHeX8GmSjdQ8HiIuvkYKcL6Jsit59U5FtMc7OLV8qrglM6MuBbFA7ONtZvm
	PkjczxsS32nzavLYekiPCW55cctXmFU5hn0jMX14Wew7jNSGKAdtBQJFDYqZO0AWH/ELZlzXJPq
	ZR8m4smx5RnxA2lKOrW1Vcz8KQO13nBohhSWVU+xpHnPSb9SnP4FzMDfy0Wi9vGfHngNFPfa9f7
	lWdvj066iPSRmA6zyFeKxqpqZrF9T5osDieOJMPBI1kWxdzqI+KSqPsazZNt+OWZ5eJ2iU9Srq3
	HbAQP3gNcVkJQX97dcc+MgkJUyFTgywQxTSbPVZVTQaG6R/u6tG+VZr5ieZhIdxU919lBV4RU8f
	eSTdmpYFsCmQ/pmqGmWlTBDi4C0MpEE2aNNiSdNwtjsNEZGbAbwQBQOyUT8QdoGQ/G+mV8kcau8
	8ZrpPEvDy9408Qxf+VYxs3lfBTCZAH3qTidWxNFsPYQH5F7drp+gA==
X-Received: by 2002:a05:7022:ea56:20b0:17f:7280:134b with SMTP id a92af1059eb24-17f72801559mr6984891c88.30.1792124864684;
        Thu, 15 Oct 2026 21:27:44 -0700 (PDT)
Received: from localhost.localdomain ([152.58.201.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm2644712c88.16.2026.10.15.21.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:27:44 -0700 (PDT)
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
	konradybcio@kernel.org
Cc: danila@mainlining.org,
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
Subject: [PATCH v11 3/5] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Fri, 16 Oct 2026 04:24:30 +0000
Message-ID: <20261016042432.824-4-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016042432.824-1-sreeshankar0910@gmail.com>
References: <20261016042432.824-1-sreeshankar0910@gmail.com>
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


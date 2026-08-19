Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5FC476079
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153186; cv=none; b=Z21KGAsuU73Iaku7S/lgNZHttA/uN1ZOBE6uLS8+iwVgmQqlQiKneOU0bCy2ijHYqKEjORGHvGs0VCNz5S84mXAct7caZCrSCI0N+P+0nRPiu6r62ZLdqJOnXDb9aIBkb7HPRchUHvAX82Th9nqVsrqZcuEBQeboL0hH0fmUnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153186; c=relaxed/simple;
	bh=LO0HNWJQ2iffOvEO/jDwBG49x7KRRSW4adIk00h3Zhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOnwvlLcR6wWY6smyukSQMLCKqqm3iIeVizv9A0qrq/BalmZXO9WVI2M9E5c7DtqlffgSYtJdX9IbuKw+7I3l1vI2eUPPRBNFw2sJzLQoNFMlEppnIALeGtpLho0TcG/iTP6aPIFKouFKpvNLD5kclaifGjTIKsUokjOM++r8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7aY7Iho; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7aY7Iho"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so14358825ad.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153183; x=1787757983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKE/6hDHMyslvqv7t5uf7DvgZ5SWH6bvEtV9dkip8cU=;
        b=g7aY7IhoWH17JpUNcjcKs+MCuglJkwbEH9u44EEa8pgZOMoo4BOfUV2doB03JjkRp6
         9EN6qG7KwPXTU59YzCNPUsKbsrIrSTe7XzzGZacRucRoLiqn/mjxoUkjNtoeQ4s6vett
         TcLsbpEWNXOifl1aP+jJzKOWF5Hmp8jeHGC1HVrsDiV1cXv0icXkiab4c/387OmSpT3g
         6pU9pKX1UPG/uucOmb23yS9w6G8xfdudzWvVYOE3dgqCTeOFQL8vlP+/l2eURAaJ1jGO
         vt4lIt6zJN54ILW6inO6PJeUI2gN8dB4GLb+orREpFcIVTwBF43G9tq9nNarg03Qv6G4
         sdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153183; x=1787757983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MKE/6hDHMyslvqv7t5uf7DvgZ5SWH6bvEtV9dkip8cU=;
        b=fsG1V53JFpyznnwvNNPVoh5CbE6+VVWP3SreZjNhwzQnCMimFOnFkIQ4Ey1cYH0R7t
         MJgKTyFbjP9Z620HIJvwrww/lH2a70NmP7qgy5BH74SD+Ui/AfO5G5dqFtZ59LU+izHa
         +Z7/Jz8lYdUPHj6/BNX6T65XEiLe6zw3AnIavuYSMgu5FUgAhwtiWWKu2NMTP6gaDcya
         YEpxwuxKRRe6l+HhhWzFT+hP2ZS0idnp8s3mAOvIt83IBPWRimkQyptquDRmwUjalPcL
         t9sNPLo/vGYUq/XSYK21BKoi4laXlw1Tp7kWgFumc1kGTzsE2bRdYsdohmTKBO2AtpoC
         Cp1w==
X-Forwarded-Encrypted: i=1; AHgh+Ro2Pt6DZAKOgmeiKd6lTrPitIld1nZZ6Vmdbmgx+bbzofamDhgcIIfAIB8mmuEtgsvARWk0Eft1jw==@vger.kernel.org
X-Gm-Message-State: AFuF++nV3GwruND5uPFShUYybIX1Hblwmqd8hfEiHLmfddjeEM5BXa3H
	ek2A2uyoYJirVN5aUTefxFmF+qtAho0hXBqBEDtb4axnhXUP8Cixb50O
X-Gm-Gg: AR+sD110awNnpVlfWGNAqXDVBwk+fg1VDy8ecQcUSI/s5BE9KZlT2FP50qqlow6DgGw
	kRVdpmMqyKrY7nNCC7nbpgX6OTqL88IeUs6u+E+m7eUcGaU3uaPuC5KypTYAWPW6rQl5Z9j3YWI
	OODpYpvTrPTcJP/gas7AzjP6n07MexqchjxNOTJoZ9G1tRRelA5lPSJbFJgqIOcRl804OFeW46g
	o2G38ohOhSnjq+knLoLwfCkjAl6rRPQoil0xddrt3E6yvtadsQFs1nUrN0V5/qrEl+/7DGKqd4e
	6D9IwyaZmutGtqwHQo3kjeipuX88f6nIuZUttXDmNlyjZjX4UIQ4xIpZqBZH8DgH9Lvg+veS4Ng
	cExJYpStPGbzkZARzQmCfnH0752Y/t+2C6Rwa7LEJKOfQLAxRJ7dtVkSgoNdpozBqBMX7NQ9cxY
	TKgy0s63mlcnYVnrpE7kLc85fDE7ipYMkZ3V5LOVq9Pdmnq2A1QXfoCGXC8tmVekft9mETowsp5
	b5yAQsWNYc=
X-Received: by 2002:a17:902:ccc9:b0:2cf:82e6:a5 with SMTP id d9443c01a7336-2d601665047mr110683615ad.13.1787153183240;
        Wed, 19 Aug 2026 08:26:23 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm8232838eec.24.2026.08.19.08.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:26:22 -0700 (PDT)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 01/13] dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
Date: Wed, 19 Aug 2026 15:25:30 +0000
Message-ID: <20260819152545.3934-2-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819152545.3934-1-sreeshankar0910@gmail.com>
References: <20260819152545.3934-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ID for the Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 2cf433f61..b63e4a0b8 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -209,6 +209,7 @@
 #define QCOM_ID_IPQ8172			397
 #define QCOM_ID_IPQ8173			398
 #define QCOM_ID_IPQ8174			399
+#define QCOM_ID_SM7250			400
 #define QCOM_ID_IPQ6018			402
 #define QCOM_ID_IPQ6028			403
 #define QCOM_ID_SDM429W			416
-- 
2.43.0


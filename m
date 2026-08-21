Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802583630AE
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326866; cv=none; b=ks6MieLgcSnFvWxMWzq2OnluxRzL9rfcpPVo3dmfLBPS1jIUFdbHhApUijq5ZDFDekSCTAzGtvxFfMx6xz3A07Oe6i5bxPteMZDbkdKPShCWEqNwGlirdYPbLMrzab14PNhP1sDUfpZvM8LSB0F3Ip08czKz2Ay2qWPW+7D6zBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326866; c=relaxed/simple;
	bh=LO0HNWJQ2iffOvEO/jDwBG49x7KRRSW4adIk00h3Zhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpQVQcqa5iWzOoFe3+U2WU5AKCeItHFajOD/MgaIrsUrTkyYyNGMI5dDD+1BWrXnra2elU+hTLw7RbEqy+bAyIygjFTex7VEjm/NdtJDDBQ/qX4Dfe8grP3WGjb0fezcf3CUIwDEj73vObG08Q7UVDF0j90clIjuUHLFs9Au6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxRjeqEA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxRjeqEA"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1422320a91.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326864; x=1787931664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKE/6hDHMyslvqv7t5uf7DvgZ5SWH6bvEtV9dkip8cU=;
        b=KxRjeqEAIkNNnWXENVGWsdPpwY1eVNOWrVI/UkpAoi0wQD/nHcqMvKn1YWRbWAznyF
         TqNoTn9eoQyZWf81m7Ui0+xIbmNrtF2rUsCPDgndEacLiJd10S/ogmqOJHkjTmTJ7oCj
         UsxSW+qPwpy2exzQ4xNeo8B/RT/sdMivLJ66SjX77jDxAiI2ptVxAGx+WjF2ch6etaWF
         UJ4m19Gqhmlm8EEF39bb5l9yqN3Segnq4AT6VRvwdPDRwQoXXnv8UZ/5wei+ESw6FKM5
         IV+HYbDnc+uPuQHcvNHfKj1qShTlKtjkOb4zdGPpcNb2VdJUrQ8nkY9e7HVoyjx0njoR
         zCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326864; x=1787931664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MKE/6hDHMyslvqv7t5uf7DvgZ5SWH6bvEtV9dkip8cU=;
        b=cPtfffM1dC/+p1h8f5dcDH2s0DjQWwFQKAUsRkDxhoFWz2ECyNa5jY+RReHUhtfCo/
         2xEmKa6t5HEqq1N//vNPTeLt8RM43i/sUR06toIaWm0Y2i9biwHPC1h9+g6lAvQOdy4t
         9lhweYOW0PZXP4Sis6rvKBznT78PwZb7T7qRZGu7WNgo7JwXDPXlhah8dVpk0TX3BgGp
         aTMSOx3B+4n8HKu9s29fZFpgp8H4u9RsHk+2GdMVChBmqe1vdsIzlHbEq/6wkG6BBmU6
         u5ow390a2ipVeOYAlptnhJe235PtQUPO53tyhXIINLhYc7QLIaUICvGH7cP07aILn6Xe
         xThw==
X-Forwarded-Encrypted: i=1; AHgh+RopMjQ43uFn4pKHxwLsyuXhGkevAc1PV6KtWXPm4O5PuPoZxaFt4eRdKEBJt0UxCqST6k2P+oW6cg==@vger.kernel.org
X-Gm-Message-State: AFuF++lv8W4MX1BhrS9dxrleYy7Ql7qR8DVEbMkeQ1jY+Y1jL2e/LmBE
	2glmKeI/yVvpCGbQQntZEo2pm11jF0NOpxuCDG/HhlrR5QUFkFACtXDb
X-Gm-Gg: AR+sD11Xc0iFDqshCBQw6utrX4V7bFqAMtFvDZjQEPvMjTlG8v8f4mReJopR1P2KnEO
	+675uAOQiZ/guCOWGZWo/OsjdIWB05tFvEQ+Exu4n/qpMgjQCqrgdUGvkgnfIPV/R3zoGT0co9b
	/3/MsxqD2zpzCUu4iIWmy8a64GQVC3pZmDg/3W/KBrfQv213Ii6FkRseHf9UcfjTAmrR/fKi1UJ
	f8A6VYhoz/KPJdFiU9RLhxwzrkQf1la6Ntg62ugdp5SZ92owYpj5DxDTu9Q6PqSe1qWvhrzqoZI
	xXWisuIYKaDUFPhOxNCY4ABjz6BN63q3kTLiZ/CNXP6//Zb0QcxD0ILYRPSWd4q1l5GltdqdmjH
	xtRrKwf1ZqMqRLpn2tB6WzdWYj9aus0NgYsCakIAX0VJRqoFBrxMpIAJ1SoQ49FWMzwQqswBrpw
	ye6Z/dTy9QdXZIoyoTkNSGvhJsw05FsxQ0u0w6xcOcbk34GPgtrw23QnQRL+OfjxVhggCAhj07Q
	SqLbTI6P4MQ
X-Received: by 2002:a17:90b:1d49:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-395c3566ba6mr14771965a91.6.1787326863798;
        Fri, 21 Aug 2026 08:41:03 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:41:03 -0700 (PDT)
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
Subject: [PATCH v4 01/13] dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
Date: Fri, 21 Aug 2026 15:40:18 +0000
Message-ID: <20260821154030.2514-2-sreeshankar0910@gmail.com>
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


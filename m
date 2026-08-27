Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64C4C77A1
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853199; cv=none; b=KCVV7YSlqi/VT+D3sfaQ+Ar0aApm1vt6/9pvK1FMffIEFfafQKDpttMiulTdF+RPtSWUsnscUCrLm+sEvy5mj4XueGjvZM7EP8mpEHvJscOUtR5lf2epWOcJJDcgRXjGpWol9Xzu06NqfvA5FZEWS1ovy87qC522BtSZeGoVqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853199; c=relaxed/simple;
	bh=ItYoLNnh/itsBdfqIb42AjjkJMdlnXNAkIHidF5zyeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yz7c37SrWWLdeqhLkq8OA3a5TyMp19bmY6VF7VxXkNWklg+xFUJbqzGaintareqd3DTYtq6XMi1pzKuIzJSIz1GLF/LMH3hRNSAuUIpq0u+Dwzx9OYO6TQRcdkFpG2J6HOth5U2chvRCHo53WiW99tjbofF8aDWGmJmxZeidnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkHbSgXe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ID8kaomV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkHbSgXe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ID8kaomV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHYBp34084907
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C6e0CuKO+gMRclt1VJTiG7s7VdbGf2b3bc5vZVAaf7s=; b=RkHbSgXez7KatwTr
	4FyAAyx7HlHKvwwXWKclK5ehgzUEX8GPZaG1PwKPW5brqgytQ1+6FlTccR0L167g
	aO8kSI57OUH8P1JlGgdmDH8bRhwEvnaAPI8mapMy324ajW+igDqlk3VcZSsJLJ5O
	YUFh55k6n6/NCgKS4QJZ1T0aSO/ffUU2ULuMEQim9tpiBa8/yHufcvUdK0a7KF7r
	74K0zSMt3QRQ7BCG5TMljp+ZTy/f8qyoES6OAnBLpDswdsajiGAS5sN1D/7gBqcE
	jnGsN+HeN7NuCOB6KNqr+OcscHsJlNw9c9wB+oCi4up1j90UXj9ggsMrexuUlVlm
	0LpWNA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7stt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:53:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc18ced1a5aso294311a12.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853196; x=1788457996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6e0CuKO+gMRclt1VJTiG7s7VdbGf2b3bc5vZVAaf7s=;
        b=ID8kaomVzq7hvUeNWx7gd8GZZXDdeepUCel+kNgDnEsyR2EppxujUFaOYD8WE2s6Tw
         /g9nQPbtkGI1Q+0WLqmYKet/OMl1D/PElMh5j0GfYpDfuSSwAXNBgvAJf2nhEFZZD9OV
         uQvmlioalWi7Vt8Ku0flC8asWPKzrgodpFwH7Rj/tX1b+Aqfg4DkaARsK50kkmZXTsJU
         7xyiZosN8HY6/K0NOPD1xWYHilHPnWpCZFjYDTX/fWX4KJS7WamRCOMlVDsANikGs44b
         BPPF+/uwmwLquV6Lh5c7xIKU84+36pUMX24hqyW/rtCiNcu7ObnqJB5SEXH/ur2bP0es
         funA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853196; x=1788457996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6e0CuKO+gMRclt1VJTiG7s7VdbGf2b3bc5vZVAaf7s=;
        b=eE39vU07dt8cYzk9fqrn/KNRwYB9vihYYjNuvGSeGUbdKbGRqkd2F7Qvdmkw65xyGh
         kkwyrmDh4Se2Qo3gvAZ7yfQHkdvXvlf1prxuHEA0nFmpi2PV3gnMThcKlV9DoptCn53Q
         IClvUZtvkFXNpthgORVmzcLiFXLbYz+7Gi/qpJ2aMcPnmHlrPaFuyvgxt4WDRLSleIQI
         YW3K2/sOI4FBD5VuFPxtmfBAhTGL4N5zdfZkPqLO45sZ1rMnxeScDlNMmrFx2NEG/2vL
         YnrB/lgpL1GEh4ZBFSacaQHAkol3AjvBIR3ARadRN/AlwFqweJNqKFN9HBH4nXxPzPOF
         zNGw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6PTeVHdM9H2Sjj2VKK1H1Npx+jzgOZ/WiqDJBaQBKhKt4OfKm+UvpPPZbsY6nSww7lDXn4x4kJg==@vger.kernel.org
X-Gm-Message-State: AFuF++lEzrPKqP9yZ7ZfPcW1BLS/7UX3AtdPi7WPcSs7cNVVWyA5wV8n
	P+Zo63BK7BF4PigZVZ4c+AYksDe3y5Km1lJwGp+mZ8tW7IKmaG6Z4ti5Aaf1Pd1JrrTT9JbkMp2
	YEvG3Pjsdfgy2EJ9Ui9w5kifmSE8Tvmw8IgeIcFT/L59EjFhhwZmoVus4Z54uLg==
X-Gm-Gg: AR+sD109WSDCq5BW9pa7waZp4Jqexow3gTUwTO+olbIykFBEHy9XfYEmeP+VDymtQkB
	RrVI/wBVRIuQya9Muqx/AdUxXBoIoEN0FZKMRGyX734EmuDSc9rolFnCWDMnI2fjBSLs3cOHtAx
	V+AroVRRG//8eE4VW23qZtQn39PAV45cTzRob0e3MTNTm0zVIjxX9+upCKJj/G5UwCWSwtrLpFh
	zZ8sRdzBydc6/YaEU40SxTgOloQHw8c/GMH6QN9XUHQ2WdgTTgEgTKn47HFsk/hvAs1tqd6zIp0
	EYNBvmt4DhfzzkT6myZrCQGlHc7TogJyxB+t9hackyvjLBQGqGIR02WTnkI5TqUI3uvMhNUKICC
	fpigECSB4fzw8/Lt8G3bXRTT2FSTVHxAb2hAZ+rFb4UnuOZmNUZgt0n1qSYgHJ8AwT/9I3DmItE
	sffUePMTxBhlTx3mY5B/kAZl4=
X-Received: by 2002:a05:6a21:496:b0:3c4:1916:9d40 with SMTP id adf61e73a8af0-3d2672043dfmr1491375637.12.1787853196001;
        Thu, 27 Aug 2026 10:53:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:496:b0:3c4:1916:9d40 with SMTP id adf61e73a8af0-3d2672043dfmr1491257637.12.1787853195497;
        Thu, 27 Aug 2026 10:53:15 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:53:15 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:17 +0530
Subject: [PATCH v5 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-14-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=2321;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=ItYoLNnh/itsBdfqIb42AjjkJMdlnXNAkIHidF5zyeE=;
 b=C22RJD5sgzvXUOzBpV9SoyCEBIxzbYbYsy92vpBFw5E8Raay6bzCVz+AMEy5zCta5NZdYmEjX
 +fifQkm05AXCQk5irvSl1ZhVhXNOkL2Zm9HU3RI5mZzga5NYVGEcGxq
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX0WLz46JhfxSK
 VOE5niX1c3dQ7WskokNeNW3Hccj3WWEMwWnOj/NCkLxNm5S6eLr4jVPAjcMWkd6AGVaaBhj9ISq
 UsAppkzdBEFYeyT+z1NMHCmq3pn6O1n9NnaRNSXkwsLqxanCO1n9FyLCYi1vlxW1iHuhu/h9v6a
 QQ/GnCR2bLqDBqlA5mjyzXCPB1im914V4iaHB4jltDoiy469ybFW0hGhKY2jWW4J+DOvNs4mguU
 1EGTLBRX1KFzWdOlzWInAV2FSlVYKvmq1IAs3RawDlxuyBJ1xAOL3KHcC0buU+BAMYSTdkRI5Aa
 jlZBgDU72uW4wRj+yApx9k5DwHnynR9yP+6EJmBGZkSzNWrSPlzwDbX/udvsBQCnowPk6Sra/hZ
 kM3l0NeF/5F9RlId7tfe+fZEN4WTLwGn6EMNKMilECi5Y7zJEEqqK3zQxo+uYnsfa+jjrOd3lKe
 heZnHleSctxqJ0DqjoA==
X-Proofpoint-GUID: xmUrJmkAOzkDwhT6-Lfa2pIrk-UR2MnW
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90798c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=vXfy1ps2I0IJequeNBIA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: xmUrJmkAOzkDwhT6-Lfa2pIrk-UR2MnW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX6a6MKMGXtdY0
 ic/wKAzzeLFnl/dWgyvv1DpNa2tDPvIvkJcNRGflKXQ6OxPVYIQJaDrWc9Y9Zh+ZR3MpxRjXgQw
 hAe2KRvX0XzXyYyCB6fRFTFSYBPFnTc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Document the Qualcomm Kuno IDP board and register the "kuno"
codename in the SoC naming convention schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 Documentation/devicetree/bindings/arm/qcom.yaml     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index e7160b63d814..179aadc86a9f 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -30,7 +30,7 @@ select:
       contains:
         oneOf:
           - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
-          - pattern: "^qcom,.*(eliza|kaanapali|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
+          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
   required:
     - compatible
 
@@ -42,7 +42,7 @@ properties:
         - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$"
         - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
         - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
-        - pattern: "^qcom,(eliza|kaanapali|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
+        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
 
         # Legacy namings - variations of existing patterns/compatibles are OK,
         # but do not add completely new entries to these:
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..ca02a2f0396f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -175,6 +175,11 @@ properties:
               - qcom,kaanapali-qrd
           - const: qcom,kaanapali
 
+      - items:
+          - enum:
+              - qcom,kuno-idp
+          - const: qcom,kuno
+
       - items:
           - enum:
               - qcom,mahua-crd

-- 
2.43.0


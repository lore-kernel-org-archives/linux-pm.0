Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3B3AEB4E
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260555; cv=none; b=fwnxnIhGB3O7F/88+wfmxdaDJwNO38FWmtint6ArFmMplQWcUU/HuexJAXn7rn4zqoZ+JVxIZSI17vfBN/uZ2FSQTimLHJpHZnsAXrDUm8kk3wA2kR4B/W8zEt/3k0ZDoN4XAEO4FPmyT62QdcXkqXKsTPNtjSlsomrAo3ODVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260555; c=relaxed/simple;
	bh=yDpptoQ318yeiKfxnWYGidGQj1zxMMuKvU/iB4nvzIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDGiCkX7Pvp210FXmMlKDgQul9AbNUl+oiaLUzzCBEkNgjFzvhBC/E4WQ7AODMpSVNAUhlHUyVztIj1CTpPplLszdECyzpvtiAO7VSKlTpMll4Oo2hfj56vLFu6yQcCn4TRxQYo6UO9P60B4xIMXXVOXifyF3yS9Wwu/yM9uCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctJwLSET; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OPi02dT4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctJwLSET";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OPi02dT4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6795cNut2454728
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aXPd+43Dh8ydYhJdKmNR5tHhtLLvvzjeXJ3yyeszk8k=; b=ctJwLSETjF7l86tS
	pbvFkFId+/0N/cqd+m7hp3/Ggv6/aLKx03hnTwJDaZsk1tDr/geyZmDg73hfFLbA
	mpm9eZNh6iIZf2PrZPOkzaJDNd7hhVOS1KjONrFWGUil6L1c7gs8yku4J7zR0VFX
	bIUR5JvrYzWK1gOTOOFhcXsayHX2pWdezknqvRM1R48/wdRK2ZITB9Y2LWCIdeAl
	Oy2puPinlKPNTOAm/EZFy33bS5AMUdgf1k6rBSNAI8rOAk4nUoKzo/hUf8hOlhqe
	cKHEmnfyl4W+3rhGDmaJybu4FjDs9qc7vzOIWisQIk9exyAe3SLlLiLbBHGrMh4I
	L4z7wQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwudqjjw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:29:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-381250979d5so967987a91.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260551; x=1786865351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXPd+43Dh8ydYhJdKmNR5tHhtLLvvzjeXJ3yyeszk8k=;
        b=OPi02dT4hR2UdSbQx7R4ZMq6Bgi944kmCq/VHsAOFv0Pqew2xu6gs1qRm565ljJZZ4
         LtnhTivfgbkgKnrzqcHf2fRmyssxDFHZX16nZBjX3cVCziWrwKm+rw8jsWq+iG9bdLJr
         MsOEhKVe6nqXCOuuz0tyHwClmyg4LGxEJjEfEa0z1hWZ9Ysa+IMN4TVHinQIOrtls+PI
         6bETzGEWq9+VF4WgZPIPBwp3Oru7LYTrbNreK+XuBn/kg3fcgO3da5QPU1SqdXah0d7t
         o2SPirp+J997j5TvTD6n++b6mQ9sqzHm/oKDCjqCiH3HcXCG+e2GC61wEhiPFdwsbtvP
         MpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260551; x=1786865351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXPd+43Dh8ydYhJdKmNR5tHhtLLvvzjeXJ3yyeszk8k=;
        b=MfIQUAqp1KNrDXzALO3FVpYFyxv3RX03tmhmohYchcNjT4qRwRfkanwkMHY4umNHzA
         bi6/0Z74FV0ZzaZhRP7SmkxqNXFP2Sir9QvjVquxd7yDNkoEOipSOTo9eHbibJbAnK4F
         mlvjvtQ9j7zneWjZNRGvaqCqgpCpr/gBBkY5M2HnW1bXASzWOumnX0cbkez3d3wbaA+L
         vMj7BMSsuvyJ3+Dv++9AI3pAiC3ean/PHBKCALqd7mhe5yCXdRX30flnskmqvZZdwGrU
         PnLSYNdmdL8An40/kqomXHsWH7XcvVZJTZZ/HUknFsBX23Ja+6GlKB6pzwGLch4b/hfl
         zP5w==
X-Forwarded-Encrypted: i=1; AHgh+Ro135NwyIZqLeCnEVKSB0G/QZf2fqGOGKANY/Fa1Iv1gFBtKKehOWW7YTpgiRKbPPwCKGyxA+zDIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygOvj4qpSJUnPbc1k/+cmhPeW4Rs1ibUAg1p7zEtR27e+Ub2Px
	3byWTA2hKsLMQ6zEzCf3EvMygzRWjGOuCyBZamBMT6zOhxSrF6RbD05xhADYZTM9BwjRJpyZXH2
	GMyL/VkJvsSxmdxNlOS46MIn8KQrbLDBLpAkLKZpL8jkyza78DjiiQtDg+0+s3A==
X-Gm-Gg: AR+sD10PJ8xE1btMqZ8M0CX8/KnOcRy+u8Ev1Yhc7YSA9luVYSOILwMRXgor1jORnSw
	Po2mjTo1YFXfrwMGK2G1/eztVN29/4p5D6bQfwA37PkGkO6gVEdtI6LlkSepULd+kdp//QrwjZ2
	b7RvNu/62OIbd3EP4sQJM7kfF/Qt3UkJnW4WLTj2su3YHBVCIFBUrSCu8lRJD0ndllE3RpC+5u4
	TuAQd+T52vyjQY3fYdRdgRlkrvZNUybPcBPigYVvWQeeK3Yw1ymvmG/PUJCXEXVvbpEk9J1WCUl
	+eMa7EzEbZRugbFWpv+C5bFGd5QPrKzXbzf/jiw517U0gZfeSDa5/mBuNIU1GYu2X8TpgzRyGZs
	NI5ebht/5hXQhnj7LTEepb/VXDrA198wx93AkHBi4MMzNILnY0UxxhXO6fDTtHp/yJPpWw6YT1z
	SgNLiVxglEBsmJtPMfQG+8DQc=
X-Received: by 2002:a17:90b:57cd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-392823c808fmr10796694a91.14.1786260551139;
        Sun, 09 Aug 2026 00:29:11 -0700 (PDT)
X-Received: by 2002:a17:90b:57cd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-392823c808fmr10796652a91.14.1786260550644;
        Sun, 09 Aug 2026 00:29:10 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:29:10 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 12:57:13 +0530
Subject: [PATCH 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-kuno-soc-support-v1-14-5e0ede4a0c72@oss.qualcomm.com>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=1098;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=yDpptoQ318yeiKfxnWYGidGQj1zxMMuKvU/iB4nvzIM=;
 b=ETosO0NaDHsTNsvQjh+VYCy2Raw6ZBUH00eLt9FfB9gT94ah2j8+qp8WWnxesCJ18renWtQoc
 pC1IdC9taG6DqoPET3Djr3vAVJoKDkfpUtJEFWxtKZETGDyNy+iMvrA
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfXzpxa6S5Y8bab
 du78P/d8NmP0QXpuzifOWyW00F+TosWCewEZSLUoBLqfWMv2HKKMpgBag8TK9c20m0KMUv5xbsr
 z3rCBnFMD9k+bIaMTL5TnOUUtO9nn3M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX58njGeTByfk1
 kYyAysXrhon9QyMZHg5sBGRtDqTlJUfpMHxH5zxCztkgj8OmA4sI+iHKpIyuOQBFWFGCpRSWLs9
 z1BRvC378JkgOhuDBpLvE98TYkmIDX4siyJu/Q3M4D7b7/Vmbr4Lda7JRFZkRi1jFBn3Ripqibl
 U/wAlgT8hdSFvx4dJzHcFWBuQ1q5k2D2DNuRuFbGffQQuoJcjWD9V1StVlpoGfSY8hFCYJU337a
 r05EZ2MhEH6N8soIuIV7T8dQS2BRvyV5OXpakJwXBaBrCNobVoiDUVAyOGInht0ZqwPdy19DK+n
 RYKiF1idJG7z3yKR84/SzKfUkuMnmTcN7VE4ZtOv+fKAHMx8KXrsdABML1xmmKSvmAaDJ5nIWzs
 vBXlXPi1/2vRyMMkNVb4NIS6ziHUEXKHIRuBSGBNm/uIKdnBK2pjko2XqAx+Mp1G8CUlWZQt2e5
 IRCVl3MnL+ZUvYM3iag==
X-Authority-Analysis: v=2.4 cv=BNCDalQG c=1 sm=1 tr=0 ts=6a782c47 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=RWDngw_kE3xeK5VWhnQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: XZJCJHmbFZNQd3nfzHBcYyTjc746QwBa
X-Proofpoint-GUID: XZJCJHmbFZNQd3nfzHBcYyTjc746QwBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090063

Document the Qualcomm Kuno IDP board and allow the legacy qcom,msm-id
and qcom,board-id properties for the qcom,kuno SoC.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c7c9a9279684..f87ff5d923f8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -174,6 +174,11 @@ properties:
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
@@ -1322,6 +1327,7 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,kuno
               - qcom,msm8917
               - qcom,msm8937
               - qcom,msm8939

-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0149482B
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328573; cv=none; b=qlAHS0m22mI8QrPjf0Bh+cW1X4Y+I0neJNVpNoax1Kt4lfatgy71oeEfXZyddPDHhB+Kp002CpI456U2x6qL3n69o/cTiGSLv+c21joCzsL/vn7CAfaDH0VhFYGc/2y2gAf8V/CTRYf8CXS6mh45qsFymhXjzB9TViJjToAhHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328573; c=relaxed/simple;
	bh=ZHsN8zM/JbhignLDIxWKpOEJ0dJLsvtVmGGylPc0eUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=borQOWBkjoNGEmK5IhpiE8im2uVu5r+T6EJowHTPaj5iH2PKk6T5AE7lWTS1PRctDfomBWD/TWgEw8tjvVAyNzsktMQTmLjSFykTAJu9AeCsDqor0P6kmaJlxfexLsQn2Rq7/Tc5vOhSrxItmZuZypt6sk9ztbpq5yDVP9Lpehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FbSuQsMA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RFGg6a75; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FbSuQsMA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RFGg6a75"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmVvm1641180
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=; b=FbSuQsMA9sGD9voT
	5IaGH3EiIi/OTZuLG8vKc9zA4Z3DaeBixdMWvdfTUEKqdd3PBGdpFpoyXc8qweAf
	j1E1tKFeNxV7yiIAAKb8aJY5yynFbmyqh8/hAD8mIhg8e/ECvma5Xi0+b9IMCuwr
	MoMfkp6t8zUU6ZjglAnWs/EWYaoGV9vuc94oO8z7nCIq3q+SxzwgoTso+ZQidL1Q
	ghSVox4FohOz3TE5pUoJQpUMWIPHBcXembkdVC9J9z80zg/np0ucA31A5iJa2yRJ
	mX9BcyO0fqbNpifGjlGE0UydBnMgXaQsFzb0+eD9AjB05Cl6bgwj+zxj9juCHPop
	nz8DcQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ebuttjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:30 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ab7bb257bbso1727835b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787328570; x=1787933370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=;
        b=RFGg6a756xYLlFgMmr6POeUQGP7xjfe9hCVYpiZUCdicqiGB84tRgoSluUvbeHXodk
         KTrQ03IiH7yLN3qBoqc0zXHoFHS2f1ERDRHhYPYimcqC0dVm+pFGCxR0adDHTS7HRJG1
         21L+eepo7JEE9fz88BDEVFGy4RivDWeMW2R9LjMmBE/Ro6J8/McILjDY0H8GzCD3PIAV
         8NDTqeId5zyFvlmEboMG7x7FYz1aptR6hKFysgaXjN9HL0nFl0DWgq1Zh49enrKjiIWI
         gc/KMcJv+kvyXCyiU1IZjjh3I9Njvo5KdC608D5JhDXzBBH9npqZ/zANP3QKHUUo5GOY
         93DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328570; x=1787933370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKKYzTTyUQNx49FteOTvUbeUFOC22ARPMGkTLmOUYjE=;
        b=sLR+eMw2LI/ODLranbFqNA7L0zVi92hFz6+PBuo+zfVnEDJ0EAAslHCgiBicr+7wG3
         K2zFJhFMBQ+AhGXyFoODShkJvVsbKjZLXbcSEr/fbWUONskueTk7cGIFfBh04cxr2zM1
         czmHX6pitn1gsg9R8S1+5KPV47DHGmij9bVuZB2KTLsHAGdKqjOjixenjS9yMW8P18Z/
         /XGVQllSCet1Bj71YXUKHhrtaoYDzO6zPI3Fia9kfXLdu21oMHSJkANlpuClmt1xblyW
         MVOYvVlHyeS5PG36ie60ORDW3SepzEPluTar+dTsytu1xgE7PGVX9vZf2Uba+A0gzs0i
         nstA==
X-Forwarded-Encrypted: i=1; AHgh+RqscK2ow7zTxCxU0KN+0xMEQFiH0KW91Nlro9DBcC7voWWcK8VHwUYflmv4wO70At/olpp4n6DUSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGMM4/aBaqgINBzZikjebJ2DmLCE2CsIlnEQsQTIWY3ANa20Q
	wIr04X8P+nSRsAzyxOciaoEi/NV7cQ2hPtjQPBaakAMnChG7zEk580BqsbFcq1N8uTBRF1bj1sA
	C6xCfb6pMSOsb8+3aNVWZJQhPAGQpe0cyecfGA85TIqOFFMJHjjS/0ScpklKmSA==
X-Gm-Gg: AR+sD13IMdqO3M9WzHNgGp5OgQa4wOLxy2YTVRaMegoOwq+AcZ7R/hASV4e9t8oJOgQ
	nUYzsPEt91YBjxxC70Kd0NpGofIl/EH4xlMN4qv4fnxLYcFdXc4QFkJfIRLotf5a0ABYs+VeQmU
	WdWZTmRdVLo1bzk8GoTLrb2zB1mNpIGUEUnUvx9BH+uHYhqzZoo/gafXaJuv9tegPXPZtSPgLCG
	mNqlsfqYV45zr+QE57lBd4v9VWceWHIge5tRcWsEhN3x9aqFkoN3CIrUVl2YPUaGafVDEpEt45m
	XP2B8VZ05rFFB0xtlcs1yLlmpzRmxrVNtjW+08vWO7LM54KwA6crhpUvuY92evtVB+pDBQ+lGSz
	BOk/9i/q65/q3KFpOY08vqRJvcSHJkFeXIfnrtCSgX0MnDAFcJKbiN+WKUaa/iBTyDGOqbZAQVt
	8opbjJLQ/ZneWEhqsMqrx+2Wc=
X-Received: by 2002:a05:6808:192a:b0:4b2:8e51:91fb with SMTP id 5614622812f47-4b2ef38cbe8mr7352831b6e.16.1787328569760;
        Fri, 21 Aug 2026 09:09:29 -0700 (PDT)
X-Received: by 2002:a05:6808:192a:b0:4b2:8e51:91fb with SMTP id 5614622812f47-4b2ef38cbe8mr7352770b6e.16.1787328569363;
        Fri, 21 Aug 2026 09:09:29 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm4804321b6e.13.2026.08.21.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:09:28 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:38:55 +0530
Subject: [PATCH v3 02/15] dt-bindings: power: rpmpd: Document Kuno RPMh
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-kuno-soc-support-v3-2-196e2b306368@oss.qualcomm.com>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
In-Reply-To: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328540; l=871;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=ZHsN8zM/JbhignLDIxWKpOEJ0dJLsvtVmGGylPc0eUU=;
 b=ZQq6hRuOT3Sv/p7Iga2o5Z4xvQ9K+e6HZ+qa9CVj+pK4W5CH8S/NVmAjuwyych0jxhamOfo9l
 Js/JNZDemsPAg1fxECd3OG7G21mKItHm9LrkYx7HK9DBgMn6nY1ZEKT
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: Ybp6vkvxjEPAvXFDCRd3O0j_gosSsDEQ
X-Proofpoint-ORIG-GUID: Ybp6vkvxjEPAvXFDCRd3O0j_gosSsDEQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXzYvvbmewb3Ud
 TBX/Ft6lKIqwbTrMKn5LQjz1ZnqPXCYEC1ag6ACQouAxqrgNrpldOenAaGSoJ6lNObhHsD+S8Gd
 It3jD+azwiaKso5pObldUTO7I0Wy+C8=
X-Authority-Analysis: v=2.4 cv=QJlYgALL c=1 sm=1 tr=0 ts=6a88783a cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=lHgBgSUrZIjjmBdF2hoA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX8Fa9Pv1qP6n5
 Dkam4M5/IxXtMb5CLD9hiQgtLolaAhhwze07FdEKcv/qC/PSS/86TG4WgVwEJGmAAcKKkAjCUUP
 PNxQ/qxhgVp3ZxodIVha+CAZJkUQ2QOWWgnj9ZbsOZpmCE3Bz99W2W0sNSRid2+DWczWqkFWWO+
 sGq3nn23iaSaAq0gnz99V+/uejftz0DjaxkZCuQ0E79ZZ1EEq+fy96iMxkZVLu0Hp2TQOzgV2YT
 Yq+5ipQH/cyziBvQ0bzOLQUWMaxaFKfehnUWUcghcQWoNjNCkm1lXRNbTdybjMkLdBL+kX/slZc
 FNje3wUbKxJDP6ziWqeQK8mlGzQhtoHZ1b4bJI7F1jFE7FYkH6yOYJKtv57xfszZQrlOj8GtNXe
 FgrOUHH3x5iZwKS5+SvzNv/xwQ8BcrfXN2Gi2oRKlLTh7Pw5esqo7r11cpuyG1AprjHmV6lL3LD
 ysacl39S57fP+CXVGgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210126

Document the RPMh power domains for the Qualcomm Kuno SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0a45e1f55062..7fc3927efa27 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,glymur-rpmhpd
           - qcom,hawi-rpmhpd
           - qcom,kaanapali-rpmhpd
+          - qcom,kuno-rpmhpd
           - qcom,mdm9607-rpmpd
           - qcom,milos-rpmhpd
           - qcom,msm8226-rpmpd

-- 
2.43.0


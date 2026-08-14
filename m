Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6A33F8C1
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692765; cv=none; b=GLvBK1tVCFB8rZjcgRu+fIabXfkjcPOPnJ6xNutI3/PbpJOEvTDB/kziPjdcek/Gi4slYVphzg93cPvV7r07+Bcs50rS6o9xWmvxezAf10+3pBt0wCB9t8okzNEJWxa4FS2TbgGiXAvXsPfKvWydjxcB+yEJvIIXHbsBij6G7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692765; c=relaxed/simple;
	bh=lLT782FdZyRPskpp4opbNA4IOV3INNb0OEUPXEsUiSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzIRR72ByjS2gyz0OJ20okUTVkm1bkk/b2iHQxV6aojecX8n2i0KkNwttzdfpreGw4T5O8M6ieTHtdvk4wleimOjuc7oAlBh99J7zUQHCvVATN/5djf7io94/O5XQEzJD9d6KfAQi4WcdAa5XNYbjhVsazPu0IYnzDfLIWOVAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yk7TcyFX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Isqemrlm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yk7TcyFX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Isqemrlm"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4QWdx307880
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Jgmi8wIPoCDQdyFphlVzecqrFuQqOuAqeN/auAyVgE=; b=Yk7TcyFXpfXHEiYM
	OKZWAYRpq7iwBqV8Xw7er2cFPE6P/LnOQJb/1rWdgXG0punTGdfUKgL8O1Bjr90V
	JEiuciafApLfSAM/NitwRI4j1MIlcapFGQDxhnruY1q2dQ47kBROGW2jS34p6PKm
	2Ku8lRQ3Xp3xoGXR/Ki0lfbPwQmPeSPngRNk1dj4qStwtwefNDsMXKiy/M/qWUIC
	QEOblOOU1/Y9JDUUwN7bF3R1jHEk/2f52O9UtHQ67YwxjZLhHKJFZI9KdSmtBHDu
	b/AlgJR76mHiCTOxPcB+tjgoW9onz5COgRuoOI69kICnnAuEpdqy8UKo/3AF/BlN
	meNU0g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2f2xeh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cccfa32670so8304115ad.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786692740; x=1787297540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Jgmi8wIPoCDQdyFphlVzecqrFuQqOuAqeN/auAyVgE=;
        b=IsqemrlmQiWkybnmOflgTXVnYyZz66Pqrwx56dDWMtBtHRQRvenUH/AASRcPGnRNkc
         OWUs+REAVLmUa7bXn9Zcy2oB3L3mQ2ysXBbW/cX7iesdtDs6qC54NaRu5uP60dOifOBl
         Fma3Okd14KZA+4fgeg47PS/LSlICoSLIOAJ/ViTrqG2F3OJ6sqTUHGrOZdMKnHFH3f5S
         mDJjuHvfWaj2BCiRE3FDC0dx4si2jpVDVocBLPByvl4sIRgGAEWNE4uchAv/b7kiwkc3
         DF5N40xdT59GvylmqnBlJWCVWSqnDMb8zf0kJ5grVWWSlkE/pvD7W0La3JPD5LPa0DU/
         2esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692740; x=1787297540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Jgmi8wIPoCDQdyFphlVzecqrFuQqOuAqeN/auAyVgE=;
        b=A+QdkJ1seKwg5BOZwt6HZdmsHhErHFiGi4Rf92qrPu/glGDlELJNdoKQV4WXHK5oeb
         rXVz2NEIT0byAfzh89LLmeLx1Sf+f0QgL6JyL/umISZwaDHyj6xQoi/dMaOp30MMt4vw
         VVSz3KWwBEPdnSuMHKnWqOu4+m3ekEmXoTR9uMfL+zKmC/kW1zzx2pHulRvpBrwV/1b7
         rLpnVksWGX/mQjeBPGRMeCpCYmbv2lD/OJgxOCYWfw4rw2kgz+coTIRgAnD1pEBu5+QO
         0P1HJSY7rRsMKcU2YUYLYgJx1M6hGi6kF3jcKCa6hyrH8bj4rLWadtXhv/xwrdC4leWd
         6Eag==
X-Forwarded-Encrypted: i=1; AHgh+RoomIZs6pNFtcDbyg7uEwtnMGu28lwaxHn4fVpVd9yOE148HjPxbfvX/FyOitazfi3oOLGaUo0GYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfPdNMEPLg8CxsTJHw5OumMcxpBYwZLQ+UPKfR7uesGRAMAD3
	CJb1omh9hNjpa2osF3yXJcAGgS6Iy7o2/Mgr0fZmUNRzXMm+dWYi27zsBaCG4hPNS4u9NnjUXs8
	wO7V3bEuI1Wc6LfhRVC+0SRH+66EkDVLMMjNy00nqnhcVDd/M0hNBZC0vkt8IzQ==
X-Gm-Gg: AR+sD1238ij/zUFu2CcxVGSqBH/3ROfkAdK8sV7iKI71WELZc3L+2p2wSPGKRyU2Lot
	9VKUqGnY3CDLGTLRWKt0gNNdpR5myw0U3pfIgV6Fs4yiee1ubRVKLGU4PFjtGCXk/F7PV1r6Een
	hc11y1U/RRbeE+gq36yErs+LMWD1qgkbbaVVZ/GJINoTldI1D9H9KVyGJXL/zEjRflmQwCNGE4y
	pPhS8FPpJ3kJ5VkH00RIWhKgAutv19rAiAbddQa1ErMC9TvD8E3UfbEOn/GXv+tmX7C44vpwxX6
	h9+z5s4SmEH+14tgS6DvegLnOsSV9ulneCGNkI3lTXNxR/ZFAVKLTnrTtOI8guM5erbS/fK+La8
	XOYAUSxv2pAR09FdzdQBLJoGXESm1GxLYeYSI3YYMCRRXZ7ViDN7MA7GNa0jo3zg6C0oOqmpuCr
	2dDmDSXo/uQj14bJCBeQ9sKiA=
X-Received: by 2002:a17:903:4b50:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2d3b0eec2e4mr44891145ad.13.1786692740054;
        Fri, 14 Aug 2026 00:32:20 -0700 (PDT)
X-Received: by 2002:a17:903:4b50:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2d3b0eec2e4mr44890695ad.13.1786692739653;
        Fri, 14 Aug 2026 00:32:19 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm1062280eec.26.2026.08.14.00.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:32:18 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:01:33 +0530
Subject: [PATCH v2 02/15] dt-bindings: power: rpmpd: Document Kuno RPMh
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-kuno-soc-support-v2-2-3079794f0f73@oss.qualcomm.com>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786692713; l=801;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=lLT782FdZyRPskpp4opbNA4IOV3INNb0OEUPXEsUiSs=;
 b=jDdmD78RpRBpRWF34hMwTuXF0ZnrvD+D2rjqsQjw/43sLItFVbt4tdFC24drYcgzLI/5fzvfY
 fwnnvkQ/oibBSN8xWcqibqoln9lMeEGWd+kpB6pUZSv6OpNSU6jyRXv
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Authority-Analysis: v=2.4 cv=FeMHAp+6 c=1 sm=1 tr=0 ts=6a7ec484 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=lHgBgSUrZIjjmBdF2hoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: rhty6-9laNozqwhnyGQdQpece77Bqg3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX382hBfOHIlMn
 OIfCWZUZcm4MqPJ5mxOIB3FGLiUJfko0JVF4L8lkjW9RiLs/n3jRP7kT88hY37cFKw3XF2qrJ1k
 e97pYoLI3pZqEzumEkW4A6og2AR0L7a7n7nca1J7RI6AUJn+xroC+Vik+JcgoTPMuE1yyL/CtQ8
 9Vah1miymGJ6/ogM3f9FDRuAckpz6Q4kLXtVqQp0/yLgfaepMSVkC4sFgyIA2qsh8/VJGe+U6bH
 +dun8DoL6tRKQu0dm639sQkXF4Sxk9IJlMhaGavqUJG8YrL+piWxj4h4/eTm6bd531LwLR0FjXS
 UHVd9iY3LxV73ff3reZkZb/G2HfzWtCIV2D4HsZBF3lMTkg/yhAjYUOcDcZFeNVEN5474HVaRU/
 FCith7dBoVK8i/6PsjVSDZOcQ8Hx+ccVZonnqBF4SqZUd3paBFQaizyQTgWD0+WEajJg0uBhVBG
 ++n++VHRLgBINZgrG9w==
X-Proofpoint-ORIG-GUID: rhty6-9laNozqwhnyGQdQpece77Bqg3H
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX4ahGzlFz0UyT
 Ev4KpnX/4xVT/yzA1k2BxYjMh8ABtOWEQYM5JaaUSV1KZHjt+DRARsmPyme8h9Rv6RqA92FwpB4
 r/lOuEp+dNoNHPDbcakXLbrmNrhEMWQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Document the RPMh power domains for the Qualcomm Kuno SoC.

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


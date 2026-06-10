Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C33A7829
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079178; cv=none; b=DCEg9FEPrUY3Zev5dpX2n475USHQBf/JqN7XpVFBdOZGlQghn7EMKQJtJGDAIBj2HL352KjOei3RBW2lr5DC7669SqOMDIBS47SGZQNPvGKHl2GOgcIz+60BzVUgObwg84wWOZwX5WaqUZMLms9YX7TLHtZcW7W0PvV8WWeNLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079178; c=relaxed/simple;
	bh=7DFnNTv28IGdngqta0O1QHu/B/uxIDqYYhl0XGm2Pb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lf5GtgqB2e+6u+AtHlQDf03rs6q6K2GpyKKLfCN+ovsICJlGOH7rs0RX9PzhWrCVy3dkfbyqipPjOevD95tnk/LjqVAhjT5UopPJrubQAyMGGDk75cIdrctw95jsFtS5OI/8kxEmAac5Z8P2IqEc8V29ZtwMK30JzkhYqdwuQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnVo1AW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cxLOkHFt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnVo1AW9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cxLOkHFt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7igbW471736
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZnAhfc9juLM
	6ofZhbvJAs+UfN8U7vmcczY7bB1K8lAI=; b=nnVo1AW92QHI1QBLZVnYiv5DFeU
	BUap/wJYPT3AOIOt1PIIX8Ze3aT/99m4x/QWPkiyuMnlJN1/Y/9tjtIwfXs6rWSQ
	QumP55HpsF1TQkA/Db8wLTHnO7CGtHMhHIUSSsdQFF+TFOTCNZ0t8s9J8/NkgJdt
	NRpJ3U804lCR16ztInjq+P3Jl+SWjoiTt4Pjaxj9aL3WCb44kRiyGwrcVpGMzwbE
	amBUO1cCpxYMb7V1CH7Lgcyu2NwAM/XdVuJtiTJaeHzN02+/CPbBrcd9WYrUTN/a
	nIdQCTBPdFKgAHYLFB5nYAGdRLAh0BPimrtn1q4A6vtOx5w61AvXBRJ+QKw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epxuvh6gs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:12:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0a99db8dfso70847425ad.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781079175; x=1781683975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnAhfc9juLM6ofZhbvJAs+UfN8U7vmcczY7bB1K8lAI=;
        b=cxLOkHFtp7iLYnDdUuvf0HtW9xj+qaHEouvzopRWZqC3YAge5MVYeuFpeCacamAE6W
         E/9lI03zHiYrssqYwFr8gX1K+8hunJIV8pGg4krsVCUecW+JgBFszmlHUazlcgbw5uV4
         lFTG24/OsrE7UzHl6tFqncfEdM9sY23PbDE+jXpODamTq35CxAlJS3rsBqZjxfVF+84C
         8Q2Y4DJ3IAYyWqYeyK709LJ5mdRpU3Qqdj1rzcSwNhdZqw/2+SglRVLHyHTRZKTN5rTf
         iAey4DESfE+uOPY4rGSgIzp2LwDdUJghU9hUBxxBbrtxKS6ZH2AgXJcZiLAKCTV8yuJd
         +VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079175; x=1781683975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnAhfc9juLM6ofZhbvJAs+UfN8U7vmcczY7bB1K8lAI=;
        b=mrFCpGeODmLeLlHS3GwIAz5RwRsjX7exKUx5bSA7mMIwiaXc8e4WXchzbJXeFbVRrX
         Oll9COdL+pHkz0gqzPEian/eJWUdva+Xdn/j9QBjqSKRHez6D2cTuz6UXu0IYD79Eukh
         q7B7K9e3vySBrzg+sCq5dVSJULrCutKLgghbGWRnpdPrIiYBeex7yNxdct4dE9HW0rWO
         TD+oVtL3DiUug23zSRg5Ys+/BZwlMdBPwNfenHCdkgwS4xQJrzRRbM7tAXcouE7C2UG9
         VFLe8Uxn+srORGFUxehJob1b/zUd8xmFp8ZQMiRacOP5mG5hj9Ejn+JO3mGCfTQ3d5H+
         xAZA==
X-Forwarded-Encrypted: i=1; AFNElJ+KnxSeDM7LOrJdWU6zSh9pPLrSC1Kx1MNYXBYCstQ2kV5Kyp9hoRtmFT1hDer99RX14/HuCU/pdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtRYtsSfVBK/CzeumdMfo5ObA1YwDShPI2bLtV/R9riZGpBMk
	koScH9sMIve2yhBMzUsWoSpgl3qD2b3SFCEpKS3HAyc5eO+l1FEwPzHtUrViU/3p6cJg3iyRuxz
	EuEd20gPPmKxnhI2BW1CwI29Hzik4qlpxs3qxoBNR2MZRVzIE8xRjXnEdD+AGkA==
X-Gm-Gg: Acq92OHEJD53bhFKF0ZAXx/MB750y6nsHkXSxDkYMeN4ISV51b+swD7TlFNkBhXcNIB
	mbBoVIMCeonfiRW96KTFq6eMX2veI7yosOENlND/uoSqKq0bS7fRRTVkotdudBBQ1hm3dnTjFe+
	aarCu9btCgbKL09NOMLnwRTFahRzW2UhaSfpdQ+zCdTAcLRdRAjTeqveUOlXZLJjoPtbn3l3SV+
	IsLXjABPOT7X7vmO4PA/8qMyNPDOlQ6JDwKYtSKaoGoQ2zbeWP3MvBntqwCxbNkOOenI4OB16MU
	qs8P2/XthVJ1KCpjjz/z+DhWwck69Ts1aTeqHSsLWAnqCgzXJlMhbMjTTJN8NNNwgUSZUIWxkCJ
	PKPM1KXf1ZosZCppu+bdZg0JIv/ouUSwEfmHkGhuKI0NTPcfpCobZafakKP0/hjUX1IgyyTJPVR
	K2bIA08OkzysLOZ7HwQ2mU0XZTpBMZxwR66dFDQwqnwZUu+WhWvmEYMw+M315enA==
X-Received: by 2002:a17:903:3504:b0:2c0:ab82:6b9d with SMTP id d9443c01a7336-2c1e80edc43mr270505335ad.29.1781079174753;
        Wed, 10 Jun 2026 01:12:54 -0700 (PDT)
X-Received: by 2002:a17:903:3504:b0:2c0:ab82:6b9d with SMTP id d9443c01a7336-2c1e80edc43mr270505155ad.29.1781079174334;
        Wed, 10 Jun 2026 01:12:54 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8679esm228858575ad.21.2026.06.10.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:12:54 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: thermal: tsens: add ipq5210 & ipq9650 compatible
Date: Wed, 10 Jun 2026 13:42:40 +0530
Message-Id: <20260610081241.1468507-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RO8vF3UwXvRnZpiBDDYXxWgzcp7U73fh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA3NiBTYWx0ZWRfX2ubHC7OUxhg9
 JdBU2u6Jp0RYPvQekLWLljDr6bwLznl1mrf93VNfxAzWo1ng4c5aRkrgSTP8LlnIm2bUCl9OAHJ
 mPlwa0aXrm/ozaHsacoNshcee4q/zRQZxwNmSqTxG1Yo0DuMr6600jA2bq5qbxbL6S1NDYcBnGy
 mg09UO4uZKopPlLiXvA+NSDDJJgUIMYwWK6JBcvTC/ibmQvtDaLHxCPLlNuvyM4cOEc4xIUxQNg
 OWnFkoWH3MbJKVkJBqzj6nUac0b1nUQpg5FK6f9XTMGjhaHImdlebDSYarr/8x92gQHViJrdBeg
 x4R/qyDyEwNII8nbrmW56XI+TrB2kIpFau0xZ74EM0YH+kInvsWosDa6r8tKo24COSqD0S7bGTL
 R0Ad3MlVOyWcX3kyW8H4QhSnKjpq0dH0b/mEoE/8tZBBl0HGWqkpXlEg59J1GWHQd2rVJv3+n+y
 6jXHLkaEuAxbHr4Y60w==
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=6a291c87 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Cj70nMFs6DzugLwqs6cA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: RO8vF3UwXvRnZpiBDDYXxWgzcp7U73fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100076

Add the compatible for the thermal sensors on the ipq5210 and ipq9650. The
ipq5210 uses ipq5332-tsens as a fallback, while ipq9650 is added as a
standalone v2 TSENS compatible with combined interrupt.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v2: Fix fallback definition
    Include ipq9650 to all applicable constraints
---
 .../devicetree/bindings/thermal/qcom-tsens.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 7d34ba00e684..5d782c9952c6 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -92,6 +92,13 @@ properties:
           - qcom,ipq5332-tsens
           - qcom,ipq5424-tsens
           - qcom,ipq8074-tsens
+          - qcom,ipq9650-tsens
+
+      - description: v2 of TSENS with combined interrupt
+        items:
+          - enum:
+              - qcom,ipq5210-tsens
+          - const: qcom,ipq5332-tsens
 
       - description: v2 of TSENS with combined interrupt
         items:
@@ -303,6 +310,7 @@ allOf:
               - qcom,ipq5332-tsens
               - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
+              - qcom,ipq9650-tsens
     then:
       properties:
         interrupts:
@@ -320,6 +328,7 @@ allOf:
               - qcom,ipq5332-tsens
               - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
+              - qcom,ipq9650-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
-- 
2.34.1


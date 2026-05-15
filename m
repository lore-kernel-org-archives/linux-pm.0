Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6188439004
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838029; cv=none; b=qAaDWHBVn9Hq8gJ0lWfMrMz9Cz3XMYcN4wnkffjKOoWGjKh2elndePJXc8CrSYXUvQDL0EXRWOfId1aPiuO/Y3+mAF6wnEoxYNaVFlKsUTsftZGSnBfRJruVGNKWV3mHUuhtJ0BurnM+gWwJd52pCVlhdKd0MYRXzcx75+wBpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838029; c=relaxed/simple;
	bh=HAWDvyrm5udfihsD68H57lsz6emuSAfI5NRycP7TtuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KgXKGzwvpnYs/Ee4LV0ECEh0B3UnzmiQzHkUC9lUZPU+1R5/ZlAaMB8f5XlRH8nb3981qk/OxKk8RP/b9kD15PQfMVclg+7PrHqx2vdDlcieX3WK3N/KRHon5TTuxlptUn899FsK/lyG1IDBvqDfqFUP3SLDGEVZKqYZaqKMdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqKeo9bf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R76fslI9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqKeo9bf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R76fslI9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F8kZ561714932
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jK+M5Q/wDupeusbZePUMdJ
	tPb5hvZH41yoSAbH7ILag=; b=bqKeo9bf/aTbKAW3qOYUso0jBvS9KRU72hNLzn
	OAL15hUlk9uNu0wR/sprb4WNfHKgT0W0IMble/tVTGdHtXEn27VKzAbxuN+RfmEl
	quKo7nAhPr58klkO8xJzwYfNeZCRzC219AAeCReMI9NbyxYKIHFapoBXLaS8krR+
	PNhYDigKyRtS35rTOrpqvzDx5hLfpF2VVuSkDECvQy4rKv4ik9cfgoCCHd+OuEut
	qd+ylal+PZRc6D7HpxzW0cbkGxUsddKSni7/1FpTHwwcNe9OIHF5FKCx13v00nmS
	+HSJml8I5x18Q3zD8UY447t3XwM85EFFqcTn/IgLPIIGcG2g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5tyxsew4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:40:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bc763c7256so138121095ad.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778838027; x=1779442827; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jK+M5Q/wDupeusbZePUMdJtPb5hvZH41yoSAbH7ILag=;
        b=R76fslI92xA8aaFNBMlV/w+3hx3EPGi8YBGKKiTZAexio+e71z2fIo29DWS4c6vxg6
         rNfFWBLK1WHy1i7psoNUjJY1ToSPojI8RuyCcOz412hBgXImyacoHkCzAyeJQ63xlvEp
         7DtSLyPDz+0j0CKF4+C27nA/8gWM7L2gQw1RUkjtDMfZXqeTFDnK+I8TUY8m/TYVWtwm
         h55lMQpAYSFXLVeXyRtkCp1Oxf+IWedPx7m0ozfH9GeNvgU7P3avih+gB8hSo1Ey/Ug4
         S0o52atfrnr0U6u3R0BhRrVJTbDXjz1xv8yRRNS+L+BPPeXROQbp4qAh7UJuJBuZ7F3k
         jeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778838027; x=1779442827;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK+M5Q/wDupeusbZePUMdJtPb5hvZH41yoSAbH7ILag=;
        b=sOSwT4y2lFJ3PaeTR1kdBlF/OMA42XqMY50s++8KPJR2n6Bkop9Ds3gGEW1wApPTxR
         RYDPCNVmGRNqf8ogUVk1+AziBgs1Y0bW2G5C0pF3mpz9NkRR6yKo+d+GDmp3Dw5t4SEK
         a1zAo+1Dmg1LM6z9UPmm3n44YB11B89z6NyyXmhMqs+MGHKzlcwgrN3groheVck7Uzcq
         50VgGtUCADGN7g8hoex+jF4Rz+BEfJv7CJTRgqMujudm0ZjEDt/w5JuECaXz2WdWk+aK
         Y2Sj9ffd/lNFdtUiBc1Dbv++4jhvtx2fMgWk4uyuZba9lAdOmEzdPeqk4avY1eU6De7G
         TCOQ==
X-Gm-Message-State: AOJu0YzdMUU20zKTTaar1ko/1+V9ydnTKtAHOygojfFikKx171xnXHgn
	GxNGkUS+TNQXUYpYaoph3pg0U0z6qbrCnjCvISUPdEy3XjaeD0xUZzzJwm7jnGTVT/rdhMeVwF5
	zVD6jx95ysKLd0zYkz1T+FLGkTydfZ2a2BD+dmBX8xpCtJvy3pcFoC5tBDWUdGA==
X-Gm-Gg: Acq92OH/h6EfisbFNEJSHFcwfdVKFRSvxvNHnUhRwraeZoSvSr9GkYYGE0rty9Us255
	b6yDOSgVuLm0R3REYswwh0iN4HV3ySH7ZVbPHVz3degyukh/vsEeJIyC/bFSWz1RgeLyX8D+84q
	vubYT1piYv77nadDVipWeg3JuP0x3tnCEMdEAkdYoddwP3KxYd0WF2vajMK/JCkmsO7GbuVoScg
	CUN21cO5YI5khnsHo9BCilL/ZUlLhN661fbxjVFJJiE4UIy7vaYf2+qZ2AxpANRweiadrUydQWm
	QNsxo+uv0JMEGMNSVS38A9u3Pj+aMqkoRxbFG19ZuQ1bRBP4mIvglu0/jbYYDt8U77cHK3YwvYn
	GQVgDMI6noTvAdCYsS8ZYo6eGL3Re57VWKFUvK65ENqszUy63o8rR/yengLW77Cg5+7CyMohzJd
	f5X8UimidHCoUhORdDrcEFNNFCt8x52c4XrLxBNuhGNOVd3pZs5W4=
X-Received: by 2002:a17:902:9042:b0:2b2:9d60:5eaf with SMTP id d9443c01a7336-2bd7e77b6b6mr29798415ad.6.1778838027209;
        Fri, 15 May 2026 02:40:27 -0700 (PDT)
X-Received: by 2002:a17:902:9042:b0:2b2:9d60:5eaf with SMTP id d9443c01a7336-2bd7e77b6b6mr29798175ad.6.1778838026755;
        Fri, 15 May 2026 02:40:26 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd60275sm50068725ad.7.2026.05.15.02.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:40:26 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 15 May 2026 15:10:20 +0530
Subject: [PATCH] dt-bindings: thermal: tsens: add ipq5210 & ipq9650
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-tsens-yaml-v1-1-8039c62cc249@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAPqBmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NT3ZLi1Lxi3crE3Bxd0zRTQ/NkSxOLJAtLJaCGgqLUtMwKsGHRsbW
 1AB1R6aJcAAAA
X-Change-ID: 20260515-tsens-yaml-5f517c948b89
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=dMWWXuZb c=1 sm=1 tr=0 ts=6a06ea0c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=W2gPVXlb2yFIYVFQQSMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 0ivMEIY3_yo2eCaHUlmBPNZSWcrMp2Ri
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA5NSBTYWx0ZWRfX3RmKxahm8f3c
 2GhbNPWFKwwsjga7H4KrHt0iEmFG/jYQTci/MtmU4LSYaxqRrRxYoTPXALVb+p/OG5TJyfLus+g
 z2MWntyryM40ARnfrTcFhg7p82SRsDuqwEymv9cMhjJAxSLJKJDb8Q1oLWN6AnNb5R4kme/N4+H
 mvoGcfNZBIBo8KBt602roj2xjgJlC9NIf/SSbhn/uh4MECSecZe0FYXlzM/MlGfXCW68uVk3Ppo
 1+IwPdd0P2YKdYPdCa8Zw3IxyOTAeBYmanX7PlXc6ZLxRAyWn29FwWHGjzl3I0hAY5/FVEE+TLR
 KenIWG13L5+LtpA7iWCbH8bOpf+iBT0LpxV2hEJH9wlaCg+ZvDP+sP7M2T6R4uF9UdYaWApmsLT
 x20KSUoCB7ovY953Aco5UsdoIgBBGbo0a35tR6befs5AMH6ppPh0XLoAtOrvHrW+e5lo4P2hHhh
 t2tIzfg+nDc7Ec955BA==
X-Proofpoint-GUID: 0ivMEIY3_yo2eCaHUlmBPNZSWcrMp2Ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150095

Add the compatible for the thermal sensors on the ipq5210 & ipq9650.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 7d34ba00e684..fd8031f7f6ad 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -89,9 +89,11 @@ properties:
 
       - description: v2 of TSENS with combined interrupt
         enum:
+          - qcom,ipq5210-tsens
           - qcom,ipq5332-tsens
           - qcom,ipq5424-tsens
           - qcom,ipq8074-tsens
+          - qcom,ipq9650-tsens
 
       - description: v2 of TSENS with combined interrupt
         items:

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260515-tsens-yaml-5f517c948b89

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>


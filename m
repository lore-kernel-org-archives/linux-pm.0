Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB33D9DB8
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279751; cv=none; b=QwfHQ9y/qaF4ddVdoSD0RQqLaG68S1DVo7kJ3xQrXcUrP3ejXRMSPZPID594hYh5gJyfbptFlBTfPDxoCJ8Z6d6xJjv/rO69jR/A1jM+/pfM3VSQ+Dq0rXX0Le7P0qrIwhicM51XxehS2RORYT3f607ojtBpSa62oUOzJ/g2zkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279751; c=relaxed/simple;
	bh=4ILdF662z2u6x2IY2rjqWvc/s2+Zi9YDhI++XcZArq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eaaxg4ImOXaYsppYFLHtg93/ApFHevKyXXvkLYcJ5F7qbd08IOYBQsQsmxi1/42t00j7PCh/Lunwtj2COzMoAg27YHWc77ijmCFGDdd7pQKuAs6B6RrRDRNkNarfZlSFiFm99DSIumxUDjHBrnAGTOR2pr3UDhxLZY7lBdeyJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngsrVX75; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ai32asCf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngsrVX75";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ai32asCf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9nRVc446712
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=k1f28/6KDyN2fSvJNAc29VeIyWKxYNJaMtC
	E1CrdHJo=; b=ngsrVX75KKlPefKTNPr/cXO6wNNGOfVEP5eM40bSh1toILoUhE4
	pzxaIARg6YxixmxUBMNTM7ItgEiTaWqIWAkBhO+e7uQ80ajBiLfah+lgNiqeTPHo
	+HjUftsKGlUQsaTdxO8eLb8VOO6wzsFkHeyOaiuXbdTtk25cCSsdUK1gs/WrzNod
	6s9rwM4hysfaRHRAs8eG/pWk9tL33JIF0W8K14BFsIZnd0OoDf4xRsKZzblnThlb
	PE6KfDAGs+kkbRk8HeIF+3gceTVB586Vqm8vEjyfAI34sQC2pm6p+W2dhOUGaUVV
	fOA+w1rwmWcwsw1Ky3WZEKM4HQSOGuwgQzA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrghuw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:22:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36865d109dcso4480467a91.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779279747; x=1779884547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k1f28/6KDyN2fSvJNAc29VeIyWKxYNJaMtCE1CrdHJo=;
        b=ai32asCfzNZRQ/caE79CGP1JtuZMEeZvuwqy+PdBZwQxCWzz5NPdbjWcf8phRX/ySg
         A6hnl+wk42ZAOsqRXL4m+ttbeDIpcRgXrmiMHefj+Sg57RUA1pJ1suzSA4cQQRahKiQ4
         EPiabCpTk8govdtwFARcPkYKiwX5A9hok8vjzKrvxLvTybpFwiiMKrqlmEL1oiPa8ZMl
         0B943KYc7pLSzdEn4pMVO9ORAh74BLPh5bmCc6drrCeI32b32DAJFc9IHrE+jDiGJV0v
         KZmZTJrfpQyjsK4qLEkOREg9PoTNEl9CI10DQkhGb4Q+B4rn3mweZPmP7Gqc5+mx765u
         B8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779279747; x=1779884547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1f28/6KDyN2fSvJNAc29VeIyWKxYNJaMtCE1CrdHJo=;
        b=ddWo3cRGV9F6wGHy+KeHDfRekKuliHQF2kH0DLLy+TmRQ6Yqu39Gq2zItJpZoyYkB4
         z+8RAWs6yOYLEMRSAdmwZxmyoKXjkJlwGz6IQV3EyQ5j9VBCq1cO9298jJ+UaO1Dx0Iq
         NzamZjhC7IgKerxZ2qWh8WnmAHHD+SZb1A+Gxo532LwOAxNAsl7V24xwDjpViI0AV0oM
         6mNbOEUXPiwXWMf6YDBWT86OlvPdTmQwgU1RH8jd7MEdxQfdp43b2kIyzEnTnTBpYZBA
         uCw4Qr4wObNxcU32YTiY/jGbsqMZLr5zWuc/x/PsJG1dex9JtReDSQb/1gf2Bnwhmoxn
         NHYw==
X-Forwarded-Encrypted: i=1; AFNElJ8XRoK6lyldE6zD9GhYomIwIftGA3CPROtQL1iHDHEy6xHPqfRSjqZ8v57uOpt6LFkSh2qRrhPyhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuljfUUzZ6vmsFnd+2OF6wbnb2sgLkwrUjuGw1ZXds3AsByNKd
	q5JciTf05EoF6TPspYTQ69VdqFOeNWSqVmCQDiz9JT08vK/PsV26XtQfQjrzf/cjRp1buoWvW8g
	2NBYfefAfpixBMM+dSR2qe0W8Q/L8r6LBk4nUNljjJCfcyXBxSNF1UHv85ZBxwMl0iOcKWg==
X-Gm-Gg: Acq92OFUn0jSfJcb4PmVTF+TFBXrnvCuMnHtx5fiGtUEuBj5JKEzpagGJqiadMlAY1D
	nJoiRbzJ9XFBX0xI0AyBKpaJGyn3i/ZdSCChm+CRD9npC5V6TpsYijEWYivi5JsAK20xqNC6/V9
	HIaAra47TO4OG5cl4rQEKonZE2ODPQ6iIFQxNGPwSFbT4vl+j8HDOTq71z2Tos0Cgl3iDfQHJDe
	UVDfw3GjFgPWJLtzCd2TPAYsBaurfTD+Sp1Gl6/hktX6ITMAlo14Ut2mRh1WXSdEyXs1n5NKQ0b
	7+cJluoY/c5QiMwg0p0AmTFvI89FtuT8XrGpmBw1odyAa9yOxctojQ54QYQ377upL2bFDT7j+Y0
	6Px9mKiPOTiEUWtI7WnWgHakqd8s9pK6vsQRwUMi14JN9xUjw
X-Received: by 2002:a17:90b:1dc9:b0:369:e4d4:79c6 with SMTP id 98e67ed59e1d1-369e4d47b5emr9699305a91.20.1779279746792;
        Wed, 20 May 2026 05:22:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc9:b0:369:e4d4:79c6 with SMTP id 98e67ed59e1d1-369e4d47b5emr9699257a91.20.1779279746209;
        Wed, 20 May 2026 05:22:26 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695126f9eesm21888793a91.5.2026.05.20.05.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:22:25 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: Add Hawi llcc-bwmon compatible
Date: Wed, 20 May 2026 17:52:19 +0530
Message-ID: <20260520122219.2372694-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P7CsY4xeAUS32V25omrNMummGnEwHgy9
X-Proofpoint-ORIG-GUID: P7CsY4xeAUS32V25omrNMummGnEwHgy9
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0da783 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=QoF2PQS7ko8hjqv0A8kA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMCBTYWx0ZWRfX3UrbMgUityT5
 6sFGNbD1/8wFLS4ZWQtQcs4Xxo0kqP4cgW4r+/gmk4Dj/kAvgp+Omp0V9+R5pyHRgn49fiXDy8P
 WWC8Z1CiQ3uNF8TPkOoUynQdmeSJPIirmwIHhaoZXXdPjnW2GK2THOQnzZodijhqwyzqh+oM4Vw
 esz+Iqf5psUovTMAHBpSAvOET7rk08WjeyOE6QOhCXyU1Y43e2xk/g/h6co5JkxtsEDk0l95h1d
 tVERvnS95fAMf18ti9HJU2xzgXiDUoeFM9jvuQcRQOur/MuSTN0q1oqgAMqrw8O9SVRS/SyVmBH
 QI4OENYHrNKrOlSGZuMGgfH8rea6yZ8jpxgIxQyuNyehI9xR3Occj6ja8S9Tx29cvCmjmAsPghK
 ShsvaxEH7F2SU9HqJLk6ZFAdb/imgQoJSXnFNKy+15zDkytjvEE9y2a4ti0CscoDiAAjZN6aB74
 unUR2pUQPJrCtTOHh7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200120

Document BWMONv5 instance present on Hawi SoC for monitoring bandwidth
LLCC to DDR.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 82b1d94d3010..ff64225e8281 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -46,6 +46,7 @@ properties:
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
+              - qcom,hawi-llcc-bwmon
               - qcom,qcs615-llcc-bwmon
               - qcom,qcs8300-llcc-bwmon
               - qcom,sa8775p-llcc-bwmon
-- 
2.53.0


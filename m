Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F42BDC2A
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988108; cv=none; b=rDc05ijf8huxf6avfkfvOB/x9QwMhR+t/ibe+/ex92XmSr91VpvXeENlLtJLUMeAigHES2f6PyDEYnvJ90o+yQGH118oiqXtERN4uMzIxqYIQ9jW71e6KO10BBRnt/tXYkxfYa5prcx/6vpgYbBXw4nfhvs47IXNo3PfrfRH4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988108; c=relaxed/simple;
	bh=v5y2S4KEuK9ll8FKbt2wx7n2tKCwSSz3NBpnzhwlnk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oh1ceQbic3WORfPjTxtoVylGmZpjlCBmoJ7A/6G0gDLyLeOB6cD1AcmpZ0tuTCf6J3aNZOf7RBtRl+o1Co/WRo8/LbNaetJe4x1eaHjRB3acQFnwh4iyNwwT4DwK3++ddTnwqzDYShDSXz3yftGtQlIme2Lev6BUcAvIPky9zXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpjoVaxE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YyHVvp1D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpjoVaxE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YyHVvp1D"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593warh1060948
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 06:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bmrPzwjDfZQ
	LqRIOrgrQTwpDk+/Ro0GV+O0RqY/iaOE=; b=lpjoVaxE16wYOx+Zsq0sSEpgjfN
	8jXABXV+I7hSYqYY9nHWhrsXv3eEHZScdvTRvIRrfAIaWqMTj6r77FEXPucIskjx
	LgRYQglFPMlhx2dGGPRtLASE8m0ONZMt7io0zzi+z01aG+o7obhByr/lgjuvm6lO
	/+dVEOi62/6gAUJrrSDgEj4G1rKvdPObK3djT1KhmS35wk3di8p+HrB55BEG7d+M
	4AGR/XC7p+tDaZReYnmIxXhBLUWBL/ePh+UfcpkxrwnbBTRkNz1+79+g17zQmfx8
	yEA3Rat7NBk4nA7+0qTH21HvlDh0z0bd+CsSeOkunnZFXYsmcAevjaqOJIQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun44ws0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 06:55:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d992fa39eso6361219a91.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780988106; x=1781592906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmrPzwjDfZQLqRIOrgrQTwpDk+/Ro0GV+O0RqY/iaOE=;
        b=YyHVvp1DT7H8qyHuChbrv6/aQdLv9uKQdOUlz1eml9JGSps5C/1m36NpvrspRpwmNK
         efIFpHZf6kk7a7d+qz5mm7b3SIHLeH0VhfUI6z8Svlxii3C7UO00uJ/LBWdCv6/mnCAM
         UHyGOG69s4xryT2gJTgkwFWXd8pHvQrCjzw2jTPh+6DBRl4V+bA6gKxEvZR+CTDEs6MB
         RwdDBcG1jdcWDqBQ541iT0heiMNiRXAsT+ju77uL9MAuvn1CBQXclt47H1peyv3s6Vty
         YIthNn48ZaxqUfJRtjaNjr0lgaOqwCVKlyZ7WLof0/AJws2jKyzSTwPhslQMU1+YnfFv
         js+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988106; x=1781592906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmrPzwjDfZQLqRIOrgrQTwpDk+/Ro0GV+O0RqY/iaOE=;
        b=P6I+NCnTbhJiK6fxLcgkgyEjTr+v5jFJyvvMSGv0qcm9qE1XiuY2QX11Ttz7OVxMwb
         egvwhxve4xI4P6fXgfXqxB+YKhZu4XzXz3lYoIjqLa2iG6IfuOmg2z/hR1cy6VoyIMxk
         69nd7HzFbnRnZ9Vq6Cwmvkdpor4B981BFtmdAuS9df4loS0I1R9nt5QHt3Y2waAZ2Y+0
         wLwOcUPQUZvolyJgxyYPqWem6MSvE2dF5duBXHiR1efYOdDkd8CZtWTqBwWtRZfOVXMv
         LkeEXZbDcY6XVJxC9ZlvGbxcoaN9fRUEhhF51b3Mg/vpVvQ36IP9MW/VmwPtLCvhXiWF
         8dzg==
X-Forwarded-Encrypted: i=1; AFNElJ98Di6JU0av36J8DqTss1xBm/WWQz9NN6lp5/JS+HK0UVo93vOAaN/9T4qulffsbVAsCEFrpXESBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDv4Jx6h9DaUKnFEV76T9qFfljavbaXlLO92OA2SDScD6xPgNC
	NGb+CrLce1SBhxDb4WsFPr7g/M24CA5CzgsKYyxY75BhO6WGfQL3GVNb6lFt0kVoMp4PYSH6U/p
	EGEkj9QCxorzkA6BKQEKg8qpI+HWqExvfz3BHDSrlaqyMAGc4l2XyYGMLstc31w==
X-Gm-Gg: Acq92OFvr7YaB5NNtqaGaxQZTn3CGbdN4IlRId3ajnXEe2N8cVvjvjqecmLnmmGaxWA
	4lubTfJKwyU0/plFV1d4X0IZ3XMvx0WeaU6viACqCs8D+C6EMvhpcxmahXKZGuYnqMpqpvM29tY
	BGcaPyVaGXQu9HAGrbojwq9snlECqIFsKMKn/C/t53gCCmCsLRgsXH1cRcen672+usiEnmDxseA
	5jdZqr5Ha2M9ooPXlAfrl3vTWBwLx1Tm6axUNL0CmuwCCof+3feqHiFUlU8TT+FPDngVUl8/LZ2
	sKayhJtGBtDar6C5YrI0BDb3A4MNAz40IUa4xV5H1BPmYPN+g5HsqA5dCnqKggFSfbhPAmvJwR4
	ZQK6AUzOzp2VgOPxWY+A46RF28BS7l8KTugwsrAR1RdBKg5lyykJEPyObTuDgbTE8uMS1XpN8rh
	hlW/y9nGFjtDsV+LL4/NkcobjekYs7s6ul/+jqUWCc9tOZSactR+CqR0kkGtocNg==
X-Received: by 2002:a17:90b:3d8c:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-370f096ad7cmr20967660a91.18.1780988105736;
        Mon, 08 Jun 2026 23:55:05 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8c:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-370f096ad7cmr20967634a91.18.1780988105205;
        Mon, 08 Jun 2026 23:55:05 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712fcb3a9fsm8607926a91.0.2026.06.08.23.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:55:04 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2 2/2] thermal/drivers/qcom/tsens: Add support for ipq9650 tsens
Date: Tue,  9 Jun 2026 12:24:47 +0530
Message-Id: <20260609065447.4024695-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609065447.4024695-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260609065447.4024695-1-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2MyBTYWx0ZWRfX/mMGfWdYnN6R
 1Ny8eTdvRgT6Sw5UpyHedlJjIYH2xJjwXt+lA8yhjy0x9QJFW93OO0iX4NLKy3nwuRN8TFPQKWa
 MC5V3dR4hHoMt3OxVYWnpB2auWBQAWsNZLFlorUoELf3qU+kC7ORrizKAeKuD+54WYktph6dIGi
 eDpRg96NncaSeit7ghb6Fs/+zjeqchixC7rJ7ylLQgBZeTraMMTH6SZgo6a1SWHVTYNDgVRbJBX
 WBlV896Xp7cBGTv9GjyRi674hF72KPZFzyKZtxql9qe/rOPllnYV16c5Z+wceVzEEYRVph8eTIf
 Kx+lqOscye/zkfFFeymAAdJL22jVU2XMX6GJXjr4GBpXARmw/VJfc/ooNCuBkVp/HnrlAHZYof2
 430FSzs2olb17o+S03ovn1s/tMYQht4fDWUYYIMBtCknxdhAagrhmLtKKcWq0gZ1r50f+MxqAH8
 3fD2n8CCXhqfg5WEAkQ==
X-Proofpoint-ORIG-GUID: hX9aS6PwBRe0NZQWcJ4e73DzdPBc0-q7
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a27b8ca cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=nMt2SIcdhh0IZDtwxJkA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: hX9aS6PwBRe0NZQWcJ4e73DzdPBc0-q7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090063

ipq9650's tsens is similar to ipq5332 tsens but has different number of
sensors. Re-use the ipq5332 data for ipq9650 and modify the sensor related
information.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens-v2.c | 8 ++++++++
 drivers/thermal/qcom/tsens.c    | 3 +++
 drivers/thermal/qcom/tsens.h    | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 8d9698ea3ec4..ef1fee2266a3 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -300,6 +300,14 @@ const struct tsens_plat_data data_ipq5424 = {
 	.fields		= tsens_v2_regfields,
 };
 
+const struct tsens_plat_data data_ipq9650 = {
+	.num_sensors	= 11,
+	.ops		= &ops_ipq5332,
+	.hw_ids		= (unsigned int []){5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
+	.feat		= &ipq5332_feat,
+	.fields		= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..e7bc622891ca 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1122,6 +1122,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,ipq8074-tsens",
 		.data = &data_ipq8074,
+	}, {
+		.compatible = "qcom,ipq9650-tsens",
+		.data = &data_ipq9650,
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2a7afa4c899b..d9d50d32c962 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -657,6 +657,6 @@ extern const struct tsens_plat_data data_ipq5018;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
-extern const struct tsens_plat_data data_ipq5332, data_ipq5424;
+extern const struct tsens_plat_data data_ipq5332, data_ipq5424, data_ipq9650;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.34.1


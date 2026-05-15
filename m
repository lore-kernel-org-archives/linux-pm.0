Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A53CF68C
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840298; cv=none; b=eC/0k5U+TNwGFl0YtkwQrt1s8Rin0ev9BN8AehQgGkRPl7btPuYeEnuDY0fgiD+mNywjvWuOGeI9KtNKCERlddW6AkuF3vKd+QgIlxyLDk+cduQtaxP/ifMcUQGrMxzyomsKLccThs05M1LPF2tb62qnrPtl3DDn14aSfBB4Sws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840298; c=relaxed/simple;
	bh=4DFguP5ocXIhscD9612EjRRT4qcVHurZ7nEpTS/Os6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAmAF5YpsVx4T8+R/OqoelyYgshflJSGvKcfuQun/EAQLrYD9+oVKkXu/H3+lRGy8bJ3gNf4DCe8M/kEV8sv7KT1ocB1mbYSfOGgy7qcjbl41u6csSjq5u8H0l87jRfrDxk1TOWkkLWdpyVH07RFRHHljM0bG8Uvc+uDbymF9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHmObjrM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OkrIjzQ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHmObjrM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OkrIjzQ/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F4lg0q1847947
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RRtHwwrJlUuQT5dHlsNzlxDia0oliIuU659w8IfX0lE=; b=oHmObjrM3pih1WsR
	EbZChk1bXouhMg3iAPtgBPT2Ym3rjPE9tDke3L5twPQoFJclII1IGDOImpjh4Nt9
	YX4/vSVZQ6pSrSuaJZ/IKz8uT1wXUd5BG8paYabwFIqt/EqgH1w2XTXH0cWAdZP3
	hPIfdUAkO8AOY0aQcXBz9qWnDXEF4VXF4+uV41IYAVDkYTLFYHSMv3abRTlzy5rR
	u7TeA+2MqlQZ4eG2zUBpp+dV/2Wgdt8GdMiJMm2FGolj+kjgVyQHuyBF9qW0dUx7
	o7Bi2VhuaQDgpGpk0rJ+shVwlcLPLOOYJ2chh+HjIX8saUV1IofVVCDir/upYbrc
	UPq2Kg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t2rwt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so484635a12.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778840294; x=1779445094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRtHwwrJlUuQT5dHlsNzlxDia0oliIuU659w8IfX0lE=;
        b=OkrIjzQ/R6vf+ALwVNHJ/0Q4MXpXOUDZMy3SIDfQSNa1UqEQrYe8gd/lkOyVvkGHwE
         C3qwXbTV02dPYva0jVZOdOUYgVbGPt/wWHb+4SnZ4L4/DaU5PabO3ICjPZnx6PEl3t3U
         jM2Hgl2yJzUZ6Q3FvVwkXADcOoSiRcAp1hqXKGX/LezgicTw7X0hjH9pNdb0511iO68v
         lVQL2dvn1OTUyk9vhzq8SsAHIKmKRW19cEJk4tuiNOwlNrCIfnd4Sa8FdHcfISCkFHqI
         UmWMb1W78re65ePVXikcdI7k/zRMTbzkOtZlwRmnyAn9mN8DSHgxLmKRP6ZNxiqk5EgT
         2c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840294; x=1779445094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRtHwwrJlUuQT5dHlsNzlxDia0oliIuU659w8IfX0lE=;
        b=JPNTw2BaxDxxkP3ku/IweT68XWBojVxmcFZeLg9lGToIhpx08zlOTo5aJCpgHB595N
         SNDff9twTzgYSwPl/UoMcjvFQ8NGI1PxbWS+//27rLykXL5jnD73uiTQYKYM0ccv18s1
         MCy7RuBZOQhYBL7THQbetCqk6VJtDZXMZT+Ag6Qa5XnF9NDGNcan2chLJk5mPL24wx7W
         O1Go1MJcL18tESlaELmbCEcpAFyE7E/c7HLU9skdx4j5bEidSrBLmA37XDf+s+DKugMK
         FYqHUKv2k+JZZOxcVt4AvB2+EQdMwQg94DTrWe4s1APpU+O2LdRfD+f8LKLxSSH/dIZF
         dtcw==
X-Forwarded-Encrypted: i=1; AFNElJ9vo+5QBBkE1HlzBTd9DhWvFdmGgi5NyEw5bHWq65ktz79cuFy0pGr2oFBK+BeQbHS0YaLfR2+q6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YywGQQzlWZARukBB6X6V8zVi/gTeJawqIiAwVdT1KycxXuAWL/q
	gjRjuutbpjYd3L14WVrDt6c0+lX5+1UP4uYD9P15eGpysLDqGO38wRarziOrZiiOBU/uLFtZBxh
	5Yi/YKcJ6YuxjB6VAwa6dxNKm36R40SDRdF9sRRxO/bxpHE2xNiUzqQLE0HVgjVMmxDofzQ==
X-Gm-Gg: Acq92OEpDSuBoN+MifRzRFzfVtEI2U763af6K4Vlb0fE1Mr2Lndma/JW7unGYzSqHmm
	JYST+yTOz4k3XYhDxf1e/EeGBGPV+GdR/0UvRrv+YQoGm2xj2KOgex3QkCgfKIg00TTVhjeSyfV
	MyiCbpe6RPWuGGlWozUm2e+1CtvbpZIrpGD4Ji98wUN0L3Yl2UF5H0cst5pBVtfeUJMhrM2hupb
	re2xHGXEPbjY8TqZs86r6sFSC9b1gJ2xtsdFKBNAjCDFgKkHXetjiU1nFD6pNDhegXbfgE4RtuG
	o80v+h8mRuy1CuLB2G1HSnaZka7XYiBmLhy4HOi58It7vh7WN0ib6fGIGx9C0zbSzhlPuAJl4ZB
	bBSKA/Sdlh/wlWq5yrcPlX3RaZrfdDJJ3j+g0Hiie9MmFKmRwpNeTxm5iXy+nVRTm2pJJi/WvC+
	3B5++LuJHmeGPBhoLgd3is2LPmPSiei8eX85ckuQiFdqQFpx6ma+s=
X-Received: by 2002:a05:6a00:3981:b0:82f:39df:dd54 with SMTP id d2e1a72fcca58-83f18d87730mr7534387b3a.8.1778840294411;
        Fri, 15 May 2026 03:18:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:3981:b0:82f:39df:dd54 with SMTP id d2e1a72fcca58-83f18d87730mr7534344b3a.8.1778840293808;
        Fri, 15 May 2026 03:18:13 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm6878482b3a.49.2026.05.15.03.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:18:13 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 15 May 2026 15:48:00 +0530
Subject: [PATCH 2/2] thermal/drivers/qcom/tsens: Add support for ipq9650
 tsens
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-tsens-driver-v1-2-015ca76f1418@oss.qualcomm.com>
References: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
In-Reply-To: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a06f2e7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nMt2SIcdhh0IZDtwxJkA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwMyBTYWx0ZWRfX6z1rdNDiPTOg
 jR3/mpK4ui3/IGXmCjkQMugIpZcS1DuKRO8DKaLXLMLsLwbYzVwVNEHJUPotIrNxz77Lcnvwnl0
 1aVjVkVVQLMEiVYcsC8AHJIFFhicTGDuPJpN1EZxkfJcIFfIK1m5QLp1jXZYFt/pVnaIp35Dcmi
 zLb1MM6zI0oEXpa2oe6gzlLHXi8RPB+0bSKeaon7Z0BC4zfvgmYPFYd/oBp9fsOSRQTQsp1/7Se
 EOElsD+7sSXpygxNfO+Mb4BNh6u6pG1NM+WAsdvPQXJpE5de0YWcoIRyJo44U4LzgEgHpbZiGkK
 Q7KRToJUwjHaTjR/wL5Qykdjj8TC5NPWgq6+obsBsX0D6k68JReVj/sBdS2w6g4YMaQY8IMcqlY
 0a9kQwRUc9OyQ+tMCctczy3fysEpBeSKde1x5lElanSUWIE64ronV/CLHl0sfGSPajXzznPHXvT
 XqYDimQAVSTVC8uiDkQ==
X-Proofpoint-ORIG-GUID: ltVRzFe3NN_FHqazORx4D52s3ag5kNh8
X-Proofpoint-GUID: ltVRzFe3NN_FHqazORx4D52s3ag5kNh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150103

ipq9650's tsens is similar to ipq5332 tsens but has different number of
sensors. Re-use the ipq5332 data for ipq9650 and modify the sensor
related information.

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
index c0c7ecdb9c2b..1d7c2d85c839 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1125,6 +1125,9 @@ static const struct of_device_id tsens_table[] = {
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


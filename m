Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081658;
	b=uTMSRxvtydy7e2eTAqxVed77tKiKWeBMUF31HRB/0fdY6TtnulL1EkcwI9CJTFiQvelG
	 TDs6ZRcTQkTYpFZe47TWGRVtULb1k6bZtJrouxjsV+D0vLyaoYr2GuLWS/4KgAHGDAMiD
	 98wP1haPf6BrKikPmOYPDW6l7HyHJbAAW9LiRMyfFWBhERVq7FC97tOKKHlC7O9AX/KGI
	 +psnk1MIRk/V/nM3pp5rDHR+yFZPwLj5Ov2j812AwAZ7Q9JPY86kCOTXjP5OZVqBeK3gI
	 B+ZdJGV+KxsibpfehdEz27m7Xqw2rKTDBN/WgYyOe4Cvu2IOvkKJn1wfMiVZB1eKlhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081658;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZqIffnRm5kuqX6NDeua1q1tgycJ7AiE64kY3jMaq2YM=;
	b=ZSbwwHPYh4G+nBpfguLtzFGLo1e/Z4Bg4K815f4qMV372DJ4Y/m8MlydcHkbMD02ELi9
	 SJFlYXWa8qT9ZcO9iGRkE487CnWVmIGW16e3eCNxWXhX5OoWGSrNI/b752P6d7JV/N+rW
	 8h98pB3KmpmjdiTswnAo6nwpnGJ5cGNxb63g6Y1/P53ro1BcCC9Kb7rTnFpky/sk9UqpY
	 J7MnKT15UWdGMQ9duMJfj4PGALGISZuYvTf1MXITk5zSbBGyPVLyi7Nw7n75UKJI7BJkp
	 HdCLeMY1DKrMfyvHdXOcLeVTomatGbhtn3/yzvwyU5nMKJaohTd5CU/H+0/keiCnQAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a351Z22h;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="DNgGeex/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39A606A336
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E39A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a351Z22h;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DNgGeex/
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6vQI22671919
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZqIffnRm5ku
	qX6NDeua1q1tgycJ7AiE64kY3jMaq2YM=; b=a351Z22h4liQGhJgpad+Lv6gKVU
	5Ro/fqTCJmvu/lJwVxJggf/NtnoTLdomiEeQ/c0TlJjsP+OG13gDoQh1po926PQa
	m33zN6my5DdAh34eOemHxIVC+WLlVo/HmaUF+YSIB2OoRup7oUTwQmz2iFk6D1FV
	aY3RlRDnYODiN1LyW9RLz6wLC7Iw+cfC8PRAg6112P3xKZAr6yTi8KmYL4kEU+vY
	IM6UXH5M59ElohUmkuG7z5dpYYFAfuGTw7TjeklJqGPH/8XEZusWD5Q8dCD4KTF+
	OpEid/Fxc0PCY4BdzPmjRgZ90MMJW+B4NFXJlhHYOeOq8mPkNzpATwPHGbg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9p3v46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9210e1277efso48205736d6.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081656; x=1795686456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqIffnRm5kuqX6NDeua1q1tgycJ7AiE64kY3jMaq2YM=;
        b=DNgGeex/0NWrOq42ea4oLXVq+VZQGogUP2uB99xJycsgviNAZZq/sbDSfpDNogZU9Q
         OcTLsjy8x1pTgn1sNZ0q7ySv1OK3tlS4zd1ppAesqfSKsYeT2VngEeGVw6al/lljjAt6
         zympFUjKSbs6J0cl6O/hJHJyKczdsABQFh+janvsOTNmcOF1M7DYwtDnI1xJUPyepGWY
         DMRGWE193ELV3QV3bzFthgykJFhO8HLzqzdXeYL2CHOhiVsse30p13bO81zwrcFv4vXQ
         hFtBRjxRJ/9deGCvbePoXLvSvUo6L+JshQvyw/crsosARMq4AnOhPa3eg/6wCuJg8vKf
         dkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081656; x=1795686456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqIffnRm5kuqX6NDeua1q1tgycJ7AiE64kY3jMaq2YM=;
        b=IavhO6tQC4z9tcmnEw9CPq5SmSIVEb7tgJBEGsdjZ2elgsqiYLWRnkHYG5brLk9ArH
         k+AYeWUNUPNKa3vwvVEQ+ARfhA5/WPbiGtq1qkfuCQiOM767si5rYK+uROIh7PCGuMEz
         UB9mDj0wvaEEmWDdQPyTUBFwjtvm5J1Dt95mgj4Zj+dgCbalG1X4F5ToKOpfCnUroT4p
         qZ0onRZDTS0kOJiEGtW6mGRYxrSzYiSbYfZpr7YjO5rRkWZ0Axs8ASr2u3GAru6vMF3Q
         jHQsvBp9G2jGioy+LS4htw8+U0Lesuce4PBXJWE7SJfxUcODPPMuOdIg2fJNxSE2Jnym
         mhdA==
X-Forwarded-Encrypted: i=1; AL+hErGiAIwaB81Vs1oN9+p6S7YAqXyXgrM9qqGEzZz5Kx+tVLyIwZPBXPfn1iLDklVAZPxImn9PeQuYPg==@vger.kernel.org
X-Gm-Message-State: APuU4Z90RDpEroGb7fMYydMmYhNX76oZ86L2/rveDlrKYU4tXP9Qojtk
	SS2djeorZLB4qBCqHkWoj4RyEYpnO7oNtPZf3IZLqIw2A5p1qhc6iiRT5pAfqqBmcQnjoQAl8wh
	j1YOIp1VxHtXENWxyR+/pJvbyTD8ZbTamPFwt6Nv3pZQFKWjf/pyRgYqaPdt4Sg==
X-Gm-Gg: AYBFou1LkPvasP0CO7blycKvYP/wcIcEW5XUq2aWiQP2Hikqh+9fXrYb/44cueVmlT1
	zkPTxhr+7Re8KvPnuRhObU3cqJPFwN8kiLyARax/oKJQdOHOVaJLeisdXCDEkruNG02er6qcbwv
	ZPpJEXMekzCDs6bIc4PpzSRWdqZOJANpnwAhOBtLZLmaaFrVJ0Mu4dZ8dv96u5pDKy1dpnDGD2m
	c1yb8irUHVz4R2OvaFVbPW6WT0t4vU9omo1T6gB1yOuUBzkmSMFutlHP7MvKJeSe4zKb/A5xgQ5
	nhmW5L5RB9Tyt3FCjSqlgvzBzuE2PZ3j9b3BbUrw4nUcgQ/xcf9VBS5O5f1+0TuZtyyGHng3cYE
	U0r8ffy0kFqUMGwx0KJsRKjQy5WuAtKKZi5SkFf2lW78u1mLUboJyXfE58V9yDNIDN8vyIwgllD
	2Z
X-Received: by 2002:a05:620a:199b:b0:93e:bcbf:4ad with SMTP id af79cd13be357-949995b3038mr919834785a.33.1795081656321;
        Thu, 19 Nov 2026 01:47:36 -0800 (PST)
X-Received: by 2002:a05:620a:199b:b0:93e:bcbf:4ad with SMTP id af79cd13be357-949995b3038mr919831885a.33.1795081655661;
        Thu, 19 Nov 2026 01:47:35 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:34 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 02/12] thermal: core: Introduce private thermal zone aggregation structures
Date: Thu, 19 Nov 2026 10:46:44 +0100
Message-ID: <20261119094706.3439040-3-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
References: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hJJ8CMNdUxd7dZHS6Y0IKTQS4yIkyLkS
X-Authority-Analysis: v=2.4 cv=LooHWXdc c=1 sm=1 tr=0 ts=6afec5b9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=YehjXlzMaFdFp2m1gDIA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX8rikU93oGTgu
 KzxXnJDFBIdPc/QQP1xL1GTftmu+BN8+E3toJ/sgvLWFBdDak4bwWnG+ce31x2xsfgyOgGEy+EG
 b6ikCr8p+FDwObA+svEed4eOiFOBqI6ZSzmf6TVDdBQUxJ5vC0217FpQVRL/ebHJ/yRypN7eSpt
 cyx4MuiWtJK9maH4BwlJaXyw6mbBrevknOshAOuD2v1eyFyaifh2QBxCejUXT3QdpEZYTNA1GyS
 EKmYXR28C9rPfrOTQCwInvin9URY9ACi0Efg4cdYYDtgQm8yF29618VMkWmtxRen5Tqa8pYshA/
 zjy6wAexVw5rtcc86Buv/39vQTL0o38W8Zz8x/38XsoMRXrcko09O+kQIlSGKZ0wrFygeOgMVyT
 ecApZTH4F8tKLxnnBBdsDjZcNcowVSu44TtXeS3nO5sXYUhINLWKnR7XDSsKljh8Xss6KfVXZ93
 6/Y8vViD3l8gV4kcWaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfXy1WRNSZ4ByVp
 XxEWX2hTN23tgDEp6gLqIbkIbmN+acFoOi1LQvJOmUioOMJ7qw1cetS6585qpV/U84XkIbY9c3C
 X1XQ6VxM/R9LG6NvcG6fVgOyCYh6k3g=
X-Proofpoint-GUID: hJJ8CMNdUxd7dZHS6Y0IKTQS4yIkyLkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190038

Represent a linear combination of thermal zone temperatures with an
array of source zone pointers and signed coefficients. Reuse the existing
offset in thermal_zone_params for the signed constant adjustment instead
of duplicating it in the aggregation description.

Keep each coefficient in the aggregation entry because it describes
the contribution of a source zone to a particular aggregate, rather
than a property of the source zone itself. The same source zone can
contribute to several aggregates with different coefficients. A single
coefficient in thermal_zone_device could not represent these independent
relationships.

Define the aggregation structures in thermal_core.h and associate the
description with a zone through an optional pointer in thermal_zone_params.
Keep the definitions private to the thermal core, with only an opaque
forward declaration and pointer in the public thermal header. A NULL
pointer denotes a non-aggregated zone.

This establishes the firmware-independent representation for subsequent
aggregation support without changing registration, callbacks, or
temperature handling.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.h | 23 +++++++++++++++++++++++
 include/linux/thermal.h        |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7b91717d9d74..a5fdf5c24b6c 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -63,6 +63,29 @@ struct thermal_governor {
 	struct list_head	governor_list;
 };
 
+/**
+ * struct thermal_zone_aggregate_entry - source zone and its coefficient
+ * @tz: source thermal zone
+ * @coefficient: signed multiplier for the source zone temperature
+ */
+struct thermal_zone_aggregate_entry {
+	struct thermal_zone_device *tz;
+	s32 coefficient;
+};
+
+/**
+ * struct thermal_zone_aggregate - linear combination of source zone temperatures
+ * @entries: array of source thermal zones and their coefficients
+ * @num_entries: number of entries in the array
+ *
+ * Represents the sum of each source zone temperature multiplied by its
+ * coefficient. The constant offset is stored in struct thermal_zone_params.
+ */
+struct thermal_zone_aggregate {
+	struct thermal_zone_aggregate_entry *entries;
+	unsigned int num_entries;
+};
+
 #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
 #define	TZ_STATE_FLAG_RESUMING	BIT(1)
 #define	TZ_STATE_FLAG_INIT	BIT(2)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 306ad17aed89..8be61b0c2684 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -30,6 +30,7 @@
 #define THERMAL_TEMP_INVALID	-274000
 
 struct thermal_zone_device;
+struct thermal_zone_aggregate;
 struct thermal_cooling_device;
 struct thermal_instance;
 struct thermal_debugfs;
@@ -192,6 +193,9 @@ struct thermal_zone_params {
 	 * 		Used by thermal zone drivers (default 0).
 	 */
 	int offset;
+
+	/* Core-private aggregation data, or NULL for a non-aggregated zone. */
+	struct thermal_zone_aggregate *aggregate;
 };
 
 /* Function declarations */
-- 
2.43.0


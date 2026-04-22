Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001BF39183E
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879815; cv=none; b=rdNhi+83vToXL7TjTsgRNJAFdlKpG9hcjH3oBE8GMDz9SOjH9Ui9vvZW5gCt3OzyuObIMnhPQ6oqK3rnFR+aqlWCfbMMKemuJPHhnmvQWMtaUwHZvvjCYCB9RqheONMcguQg11vJHnvDR9yJFXP8zgsPFS5q6p1Zh8PixP8T66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879815; c=relaxed/simple;
	bh=2qBk2ep3/UzHtxWczG5M1hr5BLVx8K3kTzC+hO/UzIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5neH2yP5hb3XwePoLtlOXBWu5vIknrnhx9i5ydOEEkp542i2JQlGys+qLWxvHz8NQFJoR07plj9t3Cp46yE+HC/yPUE9QFtIOaMhbEn0eI3zieLlPWbm0JDwcnGnKQE1hMhkpoR9qFVaMBsIhNA09RdxRO4v37MLZ+8ElRqeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFqx4ZK0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TGFcBDqu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFqx4ZK0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TGFcBDqu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MFdA4K664097
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ocRAnxbNzf3
	8+DhYm3zLq1MLbyIrBdT46oxuz56xG+Y=; b=gFqx4ZK0zE1RJrNUwZAMZ+jYkMO
	I+eHmCgc1Ge3ZtrY61jSIPrKvc1wPf1rJ8PolgANmNqSTsr0gjAweQcTIM5UqW1A
	vD4b7puo3+aKHlxxQCmDuIovGCzpQF8IPO3TLQjlJUKaHRBF3DX8oILp2U+PaP9P
	NTm1la4rZUKQtye1q46tBflAgLypPFklEPavbxXCSEPibG8U/dIqE5CQCuFh8+7w
	bSa+hDDTc8En7EUuZn9Gab2seV0zM9cxjSVoOTrH332klUr6te3spmX+Lj8ItqKI
	05zEWlLNd8UsGzObiO9GwJlhXF2mkbULB7UYMZ3U0mHBNozmnvh9XU3ka9A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgsw0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e5a336b44so41073251cf.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776879812; x=1777484612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocRAnxbNzf38+DhYm3zLq1MLbyIrBdT46oxuz56xG+Y=;
        b=TGFcBDquDBbAB4zvue8vKQJ46ydXlbMC/Y+UR8aNX/7N1TdjVk+q2MOIgiQ2aWKfOy
         zCb3/bCCHzH76wOAdXngmkPWP87CmOj+mj6AiM1mmEXPrVa1k7pD7tDyP2TaZJKtdSGv
         vfVs7HWWQZDzwci4P8s1RrQqRJnBfQBxTFWn+lLJudmmwyyr7KgYiu8HVJt4P+dOZeJP
         r3sMaOAFzD6s9wMTLwqmBTOS40nXup7M/6j7sOcOlp4oMor29m1mqg4pZNAEZmUk28Tp
         /NWeSWK4cY2/qDKkK9UHODRC5m6ESuGML7n6xnpXtF5lLEYurAENFJeVoUeBMgh7rStU
         Nucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879812; x=1777484612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ocRAnxbNzf38+DhYm3zLq1MLbyIrBdT46oxuz56xG+Y=;
        b=QD7A+KjH90Fe36dSvgCD4Yi+MrkcG3tCJTelWqMEhBq20w95p6HUgyg72o0x+X4FdT
         jKYO4Dtn3YuXmn0liieVrYBN29MaLodclKSUk6QRHBE5XfVQruLgnlcliFkGKHjoPl1X
         ez1ipYqSSWh9+jAaPlIdNiTacuxYm1G4DR8mBdTwDiH67/ZDEWBw+i2MlA0NBcgps3sw
         w9qGQlGJioCcpEcClTNvGfUti9NFJV/xRgn3RKOKfa16huUkrmzqi2H4n4Fht9zGXU0g
         BPcTFykwc6eyW+kDG17+Iyg5iJd36D40sdbw2jDC/nI+veWPThlHqk4JCLknHNsKnUri
         6BfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9H9ZevNJr0wFQvAeY4fzrEfAfaAnuqidN0Eshzkdv12EmnEnIXpS4pI3ePnfdnuSNH+8+3ZKmvVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhcPPftxDePogFFrwugJDm0XxBI8Vy6S4waTNAZ6rwTvjK4m8E
	s8tgo50oSZnJzY9RwvG6fNA6B/zyn7qd1/UVOtVF32O5i3TE4ubdCydRt6pUrt983BAq3USlW6P
	udFDInDEqKCLQQ1hHCxnS+nhWntdjyhuALxpgADOBN3GI+t/m+Q5pBsYpH9LteQ==
X-Gm-Gg: AeBDieu1bYm2izTEoO5jxKSF1wIgDLqfGHOVHaOnwxZNjNERIPG+Lniy/3CoDb3mu36
	4osrWeTRPYwyq6JjPWQYEoU7FBFReP1d89/6INCAfXuI0Z6nHgtHpD3Tye0XtDBABBxRfXFZHMr
	87jBQJofaa9bqcfPs625RxLG7Aywj+J/Z54540STrqd5A4KPlk4ccNediVdp1as7aTBQxH2tx33
	FlvY2XUUws1hMYDDSD//LlwKfn4pVRZQMJjV1h8BjO4g7VXlwWK2yD6NRjeeJJU0P4oViMpuAdt
	PAYjH+onX4SKWQL/ImsNTlnA2l3nQi7s7P3rokVzk9z30hFplFjQ3CCjFK/7TE0ZKuLmDZI4Dww
	WWNMDQ4uQ9SbkcyScdyHoD9oZO4FoLW3Yqaqbb9IGWGksOj8szzcBt4eH8QjV
X-Received: by 2002:ac8:7f55:0:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-50e3664bc7cmr315858121cf.14.1776879811928;
        Wed, 22 Apr 2026 10:43:31 -0700 (PDT)
X-Received: by 2002:ac8:7f55:0:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-50e3664bc7cmr315857311cf.14.1776879811420;
        Wed, 22 Apr 2026 10:43:31 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm142511965e9.18.2026.04.22.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:43:30 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 07/12] thermal/core: Put of_node field cooling device structure under Kconfig option
Date: Wed, 22 Apr 2026 19:42:56 +0200
Message-ID: <20260422174305.2899095-8-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
References: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: epQWHX87XTw28IZEtg7Ej_uuP2jnm4D5
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e908c5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=5aU8Z_IAf-MFAndoPNkA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: epQWHX87XTw28IZEtg7Ej_uuP2jnm4D5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MSBTYWx0ZWRfX4rAaUTpbug6t
 OWSTMAdIwgucgzue29uSGJJJecrZVM2ypekV1eqLJrgdhPe3uGVvhyj//d0rLgt2lrjeWaBPun7
 KPMHE2tLWkjxz8BLrgkDQCe4vddb2sDr6p9LtjiN2xNK8SNiwdzFot6xAN5zCbQJrjmFDopZ57K
 mg2mjSQ2W/48s/wwKFAxd4zEcI8P/mge09apd3Iu/b+cfhhjHbYBIqDmavpJJ0BK6O/Ksst8hoo
 xZP2a7OlPXLHfGBMhvwpbo0/8yVPZ9ZW0OLFA7QxfJlUUtGGOJ5ZRX6vSM0e2T/q90236hvC+ln
 hetFmXMC9Uzi6AMPCsbk+l5mZskzO974QS/M0xXh4Ex2Hub1pVlKbu5sotfFJuXc0PXUtqh9foy
 dfO2v9CdrciuzroNHMLWPSiHKk92c4LbQIv66L3WDnNg11G8Pz80TgSbFiklDUXSCf2ur+RKbJu
 8QmXuhXn/Sq554UuSRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220171

The device node pointer in the cooling device structure is only needed
by the thermal OF in order to bind a thermal zone with a cooling
device. Now only the OF based drivers are using the thermal OF
functions and do not call the function with a NULL device_node
parameter as before. We can put this field under the CONFIG_THERMAL_OF
condition and make it go away if the device tree is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 include/linux/thermal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ba2c8b4dda87..0a95cfeffa74 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,7 +125,6 @@ struct thermal_cooling_device {
 	const char *type;
 	unsigned long max_state;
 	struct device device;
-	struct device_node *np;
 	void *devdata;
 	void *stats;
 	const struct thermal_cooling_device_ops *ops;
@@ -133,6 +132,9 @@ struct thermal_cooling_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
+#ifdef CONFIG_THERMAL_OF
+	struct device_node *np;
+#endif
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
-- 
2.43.0


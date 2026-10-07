Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CB416873;
	Wed,  7 Oct 2026 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377794; cv=none; b=oafVYpUcaI/LuxJQ5ExDlIAy9At+95fz2FLvPwfUCxJ1wpxgU1tHY49FXGCyNzxy/XA6/uSgenuGgwKMSPITzZnp/hxZxDYSTnqSVUWDfjFOZ9PsUMTGjKF+OafOnzuenljZIG3MXYQcKu03cNYC63203XIc2k/YYZreDTXJIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377794; c=relaxed/simple;
	bh=Wc8IB0edWVGgQ80Cx3uFojUV4Vhr/RFS1m7KR7vHpmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbYcEIDCs+3jWyEIxlJZzDkrAkebtIl4tTyPX7RcAagzxPOlEOTk0i8iUNFe+BSHBpbee4FW84M5a2aqRAGHFQ/omWvVhQOTf9z5i5s4Ms0Av/9IcTJB3278lr7ZpjuSci/VDSkypmDl1hvhK1Xvfd2fcuK/QNw/hfxyzXRcj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKziODL0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKziODL0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BV9rf3687353;
	Wed, 7 Oct 2026 12:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OlKUE9ylFAD8NCtlw73fnFqtcH/esRsqk0VoFtGwfZs=; b=OKziODL0My/UpEjN
	BCenq4ulv/GAwdbHpi2n0DBdClNwKOZ7zdt2iiF3KK6S+jaEQW59HqgdCemh7kvG
	eqRtlzbRbYix0GhRYsU75VKCPdbyNd+hEeJVbQ6dPvuuB2jz0RC9X6Apw68VNXdN
	ZbX38llQXko/HXRDqMObhlEitjdd6mHV/izvfIpPaz8YKlFXArkuaybHcHYTo6qr
	3xKB8K6CRturB60GRz5oAzaBMaGkUu8vsKQ+4JI33R/415G7E0RFLYpAEcJXXygo
	k1FT0mbdhwdody+vPKYk4cplFYTQlYPeZyvWkWosLn0kTRlFOmtHOJSzYF4/24br
	LqRLYA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mgr8ffh-13
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 12:55:57 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69776nGU1872895;
	Wed, 7 Oct 2026 07:06:49 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69776m1r1872875;
	Wed, 07 Oct 2026 07:06:49 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:36:36 +0530
Subject: [PATCH v16 1/6] power: Extend power_on_reason.h for upcoming PSCRR
 framework
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-pscrr-framework-v16-1-3642c277bebb@oss.qualcomm.com>
References: <20261007-pscrr-framework-v16-0-3642c277bebb@oss.qualcomm.com>
In-Reply-To: <20261007-pscrr-framework-v16-0-3642c277bebb@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MSBTYWx0ZWRfX3oxSvWMz6kTp
 +ZPf11W64awXyARBDXTWn1X4gh0H3K5PwIusu3mBI0N3QcHJXTfVQnMeIoctXp5D7KCRfPctGta
 EZymNGnGM7pOagmEiuQxDcqYngTdVqdIqOHF239I/eeukCKC2F2dMyxL+iR4CptC4Wo7v2ZaD2v
 Y9szHAxYELUz/EOZRFEU0ARvvPLJ3kyIoPxFKRVooFzAIonVaqPZaCb53HazLzISDqIxJhc7XPL
 xmLOuSpgJB3yTXxkRaGvFOuNOTgeJ0dm7L3SNh64pKIH0jT6ycQKNTJMlqK4MUUiVsj6/FuSRr4
 TZs0vvBHRKdD5GFB0ODE4zyj5UIFAmzjNebu+IkCdKNGae/NaWn+aZExryZSRqqVhtU1acl0KCT
 MrfJLGqC2iSnpE6AHQbYXb/eBZY5ZmU4n1dmizrpOq9tR19AI1BhVY0a7zEt1iwvvXBJMp85gCb
 7K33b528gv1d5UTO7bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MSBTYWx0ZWRfXxqcDGBbLppGK
 xcjya6kSr3lgbl5CdXk0Wk3h9yGz4WLYYO7G4YHurOo7O1S45+aC4HSr7vni9of1PZ8ie8IxnGH
 eZZ+wggG48rHDYUp/2hP6ymhheLvHf4=
X-Proofpoint-ORIG-GUID: tjQEDfzAdyoBBiJknVG1ixBHvfS4U1qA
X-Proofpoint-GUID: tjQEDfzAdyoBBiJknVG1ixBHvfS4U1qA
X-Authority-Analysis: v=2.4 cv=OYkNnRTY c=1 sm=1 tr=0 ts=6ac6415d cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=QX4gbG5DAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7kjejDXy1mYeYQkWB3oA:9 a=QEXdDO2ut3YA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070051

Prepare for the introduction of the Power State Change Reason Recorder
(PSCRR) framework by expanding the power_on_reason.h header. This
extension includes new power-on reasons:
- POWER_ON_REASON_OVER_CURRENT for over-current conditions.
- POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
- POWER_ON_REASON_OVER_TEMPERATURE for over temperature situations.
- POWER_ON_REASON_EC_PANIC for EC panics.
- POWER_ON_REASON_EXTERNAL for an external reset source.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v12:
- add POWER_ON_REASON_EXTERNAL
changes v10:
- add Reviewed-by: Sebastian Reichel ...
changes v6:
- add POWER_ON_REASON_EC_PANIC
- s/POWER_ON_REASON_OVERTEMPERATURE/POWER_ON_REASON_OVER_TEMPERATURE
---
 include/linux/power/power_on_reason.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 95a1ec0c403c..13e61ace14f5 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -15,5 +15,10 @@
 #define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
 #define POWER_ON_REASON_BROWN_OUT "brown-out reset"
 #define POWER_ON_REASON_UNKNOWN "unknown reason"
+#define POWER_ON_REASON_OVER_CURRENT "over current"
+#define POWER_ON_REASON_REGULATOR_FAILURE "regulator failure"
+#define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
+#define POWER_ON_REASON_EC_PANIC "EC panic"
+#define POWER_ON_REASON_EXTERNAL "external reset"
 
 #endif /* POWER_ON_REASON_H */

-- 
2.34.1


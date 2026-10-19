Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69445038;
	Mon, 19 Oct 2026 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395556; cv=none; b=AKR3dUKxeaHMBtHyb/FrPzjKLMZTGUlmKvFKpUszKLqc+ZUG9KmhZK2X2FvhgcOnZJPWbM8rXwm8dMy5Ui6VQ+QqJKuNkRr1WyzGov9INY5Kp8Zqhh9p5+X13i1kkW5RpsIv/p5is5OnFmWQqTgNPCAoAbjQ+ssCa4r0ckInsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395556; c=relaxed/simple;
	bh=Wc8IB0edWVGgQ80Cx3uFojUV4Vhr/RFS1m7KR7vHpmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2i4iAHZHw2N115Qtm2x9r6+XPEi0vgoGk+Cw/geXaJptrHUcTHYYjFkOmHHUmX4iagqBDGtaqUcIcbzR9uy/Mm/SV2YYIa//Ix6LrjDOqcLYPwiqTYwtTiTOZT2pCDO806X/BuoLYPNWURr/7j0IOXRh+FT3JUSmnk58Ru2GYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hAxFvaV8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hAxFvaV8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4j5eo862815;
	Mon, 19 Oct 2026 07:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OlKUE9ylFAD8NCtlw73fnFqtcH/esRsqk0VoFtGwfZs=; b=hAxFvaV8AWo4hgNS
	k1J/0xR7CGCqn1cxzPPiD8ZQHwWsU7eYLLYCZ0HjuqNxQDQYwKKiRjvte6QlnBBX
	0X7hzzpN4nsNSe0V49TDNV/9nfRSQIrJ+ThM789+jEcZed9azzLSbxLy3cLZGRTE
	fIxpHyxJM1RhZnLDTpZOEeTMiZfuM9BAIHbyXKrq2mQbm3zqYJx9Vywn8Bf3RwhF
	9HdU4yqqCYpw9wo+64YbDSy/ujVWN+UXFVabWKOZ03Kdgni46vLC7x4IrJMpRqXF
	549XGS7OXbDsgG1yjcG41kLexknFz7WhNQTy97Yo+Jv3E0HDEdG+WpaCiQgQmoiT
	i/1ffw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9nb2b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 07:38:59 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J7cvnc104260;
	Mon, 19 Oct 2026 07:38:57 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69J7cuGW104238;
	Mon, 19 Oct 2026 07:38:57 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:08:32 +0530
Subject: [PATCH v17 1/6] power: Extend power_on_reason.h for upcoming PSCRR
 framework
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-pscrr-framework-v17-1-69ea6cdf4731@oss.qualcomm.com>
References: <20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com>
In-Reply-To: <20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com>
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
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX8FSAp2VXqtJK
 PKMzhdbBFlN6IGh8pCKVhs+RMpyJytBnYr+VWkOd45MN3sblOZJ1AXsOlVqV7ItavBLrtw+jgQb
 FoHWR2Vam996Td0v5sGUZpWVK9SQfM4=
X-Proofpoint-GUID: NN4aQ82y8k05SWoCkEeFxJVoQgVRGCUs
X-Proofpoint-ORIG-GUID: NN4aQ82y8k05SWoCkEeFxJVoQgVRGCUs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX05cpEbpkRONQ
 sPmMRfTPEH9aOzKEFXvhc6jSwiMx86cmLPOSChvgQC5mcC4Z1AIpOA/AAldFEgCqJiGEn+f9Mw4
 QWplg4bfg3Ts5rPaqPfM38h4AQQTMFvuTQatE+uEU0Qm6245TqVtAKhiYouv5e+/OIOzmE4PxtK
 pfR/HjIUGMaGC7zmnrvFQHjL/prKvxWCkpkJXNAdnXb1EwfJEbzFyiSwqFh8hzmXjDZmHbUb81d
 F+Acw9bfrj/1d3BHP+Ei6jc5u5xCg9f1zKFm6O5opSUXX+uSnu9CpBCkzMiBqnx58MtEcJFbzMr
 Zz8ngyJ21eWI+/HatSQGMJh7E88zIc/cN7+iLBhiKzBAobSg1+cQCTxHmZHHqLEZ3Sf261JmJPW
 pJYxcAJOzkHHnM6AJ17T/Pwe//r/JIqDPMMQG6hcNJwOF/DYFyVPoPkZls5wQDMdZMfTZMKNaIW
 N1VbKza3H7WmftaNp5A==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad5c913 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QX4gbG5DAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7kjejDXy1mYeYQkWB3oA:9 a=QEXdDO2ut3YA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190030

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


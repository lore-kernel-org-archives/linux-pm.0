Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06D4EE86E;
	Mon, 21 Sep 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012465; cv=none; b=UFu7z4Tg2aU5mKOSFxx/q4kAAwDpBOu/MNnDPyudcosuqE4WBvAkoIKASKU1UhGpoF5ADFBdNHVittlQWu6nFbvw/s1Y2QLj9p4qfi6iRaoBSrWmpBsI2EhIYja5FBZsClRMvL5Z2XBGKO2tpqhvdmVXqqiITgWYNwm57DpjvY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012465; c=relaxed/simple;
	bh=doy8CQVTkGDgR7A0QYfdmidqT7C6L19D+j8DtIbAz9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVRx7GDcoqtEClXg9uw1Ddhhfrr5WJwj6ln/cmSFdS3HYOYUh2BCcHau0vr2sqnYCC2RCNOgYfzEWd8GNjqBc0L0t6GoLSk+cvI+bWO/dQ2UoNB6yRzLcn8D69APujwHZuJsUOjYN86U+MOs9i3vavCpz/vsBY+NrUXjuq2VmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I6vl1+W4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I6vl1+W4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LGUmsJ2707960;
	Mon, 21 Sep 2026 17:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jEFAOUvkcm/hQj/EyLQud5GCptVe5eN3gxABCz93kmE=; b=I6vl1+W4t+i7i5zO
	scV1GtuagLIdFx7jzt5TmmHineroARZCGUY2Oa5771Evz/eFf0Y8kmMAjyYR+ovm
	R9YY/pA03e8kATRAz+QYtxijIHRA+1HgHffVR/Iin2a5CekVhzZy1C63PGfYwUda
	XHBta7++6nwIPB0pn+OLENuES+T7vTjwGpKMvGBEsCSlK3Prw0zmQM3ruDza+BhW
	U36yVTt/oC6cqkpRlRpxUqnvKc9QCrcb6QR7yj1sUmvMmcBbllYUAFD7h0euOl6k
	pWI5Hf557BsGq6R8d3guRHZAmBdofLlc3ddU3nE2gahDKq+GlNYBt3V5XBrIc6m8
	8KZauQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu85vg9tb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 17:40:42 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHecwv1524343;
	Mon, 21 Sep 2026 17:40:38 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68LHebcq1524318;
	Mon, 21 Sep 2026 17:40:38 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 23:10:26 +0530
Subject: [PATCH 1/6] power: Extend power_on_reason.h for upcoming PSCRR
 framework
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-pscrr-framework-v1-1-a5ebe994a98a@oss.qualcomm.com>
References: <20260921-pscrr-framework-v1-0-a5ebe994a98a@oss.qualcomm.com>
In-Reply-To: <20260921-pscrr-framework-v1-0-a5ebe994a98a@oss.qualcomm.com>
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI1OCBTYWx0ZWRfX9hQSn+1ILibk
 uua3dDOHtv8eYnct3xP+bHrWDz6Xz1CWa9liS7WoL25YwPj8p0YM4E1S2xhasdjKyX0hm2rhViT
 ou6dlh6dCEvAuVo8Oc9KXomLn0jYNsY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI1OCBTYWx0ZWRfX+OS/Mm8t3uZw
 /4AiK/l0fMq8Vap4qWCFWlAF7xgrg795o1WcndYHZQGtD5x3DrJHjTtTyWrgTskgo54pIQIYG8d
 HKKmd/ZMyByvSdkdOJXuDpUxOUB/2gPvU9MulPr0zmaUl/JqXcHlqw/0D9XA5esgMRyX5AW0Ypu
 hIbGtyg8C2+TClG/6Vbpq+WAiAhMNR+ljtNyF9TpxY/4Ai+U+BjTqdGDb1sSEflV0e7tTfN8d4D
 Le+cUu81xhBVDwbcAYupmF+JmKLF+j7JTKQALzuqzaWEnndlj+x2htAI/s7l+ANp1UoArd5vPQv
 tgIJ92VK9u8yinHqEDfOj4++LOT4z4YJZ88mIoIZ+Nbly7X7SbRarueBmA/fEjVnIQ+FrymlNXE
 cMFTNnWR8Hdz2U7kacUTaKJFK+gVmJ890UCaBkUYFkcpMGq3LYZ2AQVOS3nPWp+zgojXHpawO3b
 9iGFny8baBD760/YjGQ==
X-Authority-Analysis: v=2.4 cv=E8FYNqdl c=1 sm=1 tr=0 ts=6ab16c1a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=7kjejDXy1mYeYQkWB3oA:9 a=QEXdDO2ut3YA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: TR2ABAuOHAE6N-KUyuB0_fzGG6SITz1v
X-Proofpoint-GUID: TR2ABAuOHAE6N-KUyuB0_fzGG6SITz1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210258

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
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v12:
- add POWER_ON_REASON_EXTERNAL
changes v10:
- add Reviewed-by: Sebastian Reichel ...
changes v6:
- add POWER_ON_REASON_EC_PANIC
- s/POWER_ON_REASON_OVERTEMPERATURE/POWER_ON_REASON_OVER_TEMPERATURE
(cherry picked from commit a6fb08a81864e2ed17cebba9f249af3d44e42c3f)
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


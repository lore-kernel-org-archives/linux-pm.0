Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697210F2;
	Mon, 21 Sep 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009871; cv=none; b=bmM7my5KrzN//h2BRhNOLh60ynESgoe5qR+uSrvDKdXKWTx7n3i7nDTGblmFH7Z/p4s/anoylLTwverubsV7ERhotV7lD4ykPEvtRMObnmWYrpmWQKH80twVSKXuiWqrZZdOOGEwWXVd4/eZKyqWHveRXVA3qThiQg8ChVpw2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009871; c=relaxed/simple;
	bh=doy8CQVTkGDgR7A0QYfdmidqT7C6L19D+j8DtIbAz9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lP/AGtBopPER4QG8rTmBu9pwPlj0DKZJx27QyBeyXUQekVogePTdb7y7EJLLfHx1savZ9uCKt4+F035BhwWa9OV1yXWo2HoKafOHnjKPQgKt4HgTYK/ramFZzDbkyD3K+7/eNWLntv39W0WhN6YLrs3d1ANi1GSV/Tc2OefJRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=icj0lyWj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="icj0lyWj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFAq7H1438653;
	Mon, 21 Sep 2026 16:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jEFAOUvkcm/hQj/EyLQud5GCptVe5eN3gxABCz93kmE=; b=icj0lyWjVBS2wEFb
	Zl4siVJhVunSYN1YYte7IJQVi0/AKdv2CMG5X4u9o7pBgBKlSEBI/rpKu6Mbk3so
	wt8yrPvKI3Xx1wbv+J0iDSXKfw3pj8IkIUr/AhJngkJC4tKAnAJmTSJot0VAKWbg
	fn309kxXxhZM3r2V8KbHPD2flVmqwjTvoTPVppWo0+r2GYP6SUsr7LtydBvUkiXd
	Y4KBP/WfTjzw9NZ1RhO4/ZuIv00gViESx5UJg9Jmz/FkQBZUq2ACiQ3Menoy6Hsy
	bnJUastc0JPJwMbFYpvLFXa4/cGBt5g4ZrPFkVdVmIojqtuRl9ntrYHRe+Opqq5q
	K6LIag==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5jyrk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 16:57:28 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LGvNFG1464271;
	Mon, 21 Sep 2026 16:57:23 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68LGvMa91464229;
	Mon, 21 Sep 2026 16:57:23 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 22:27:09 +0530
Subject: [PATCH v13 1/6] power: Extend power_on_reason.h for upcoming PSCRR
 framework
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <pscrr-v13-1-dfc57fceede5@oss.qualcomm.com>
References: <pscrr-v13-0-dfc57fceede5@oss.qualcomm.com>
In-Reply-To: <pscrr-v13-0-dfc57fceede5@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab161f8 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=7kjejDXy1mYeYQkWB3oA:9 a=QEXdDO2ut3YA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: WSGOzgBtPC3-gc5vZHWMPrbI3yHgWO4c
X-Proofpoint-ORIG-GUID: WSGOzgBtPC3-gc5vZHWMPrbI3yHgWO4c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI0NyBTYWx0ZWRfXwsVRyEy9dEII
 gPM0kToH0gd3HzA+ANdnLERDBkYtGAaJPisl/jRJQ/69pcqUXnk8TgsJICTOqkgU7bNao/wjIql
 TwlSp14KV39BxNdrGmtY7wbabTNgo8Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI0NyBTYWx0ZWRfX5lOg2xmsRIvV
 oRHY6oZAOliXSNt+DBJ2UwRkrEDzlnO/lZzmG8+Tw499WN2T9/LpTaPtYMid+NUk5PagqKaTF2U
 hgfhOxB3/Oi9tjFEmFiyXatBndLi8+pwLQq1pMy5r42eIbh6pxnhi2zGaswOnf0HG3p2ql+7i3G
 mQUnN2N7IsZoQItORbzyGuZhphFVhZtD2dAPKkYW8T10Yg3WgiUxlK5LqCl6rSlBv8luQc7Onz4
 d5VvKtTeoQzbQTMmeng5MKjmvelyd5j0d+4q2BK9Ynn/wG/64d0LOSGY2zBcZAUmrlKLh4nItJo
 8nPzjFriGMENMcs/2CEt5VTwW8ySolMTJDrt7fxOrXr4E9ya38R6+J44xlU8btN+ynJk6u25X8a
 WEpbvfYmYmR92buAAkg3d9T5UCHpQvQRu3LfZYExDeiILZ5AvqaTN5VwAw7k4/J0CNF1I5VWt7n
 CUvBxba0L3zg04XkOQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210247

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


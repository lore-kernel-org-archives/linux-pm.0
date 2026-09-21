Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6CE4C9E13;
	Mon, 21 Sep 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012740; cv=none; b=WpmEsiU2pEmCS7wGODZpIAdl2UVTk7Z/bwsMGkzCdz+JgRWmf8AswR/xKXBpQvpuIl/2SED4IHQswSg3uU64MvYipDiwZ7QH8WYq2sZh9BCCux4u6bX1/HB82WfS/fjbaWegRxs3gL8IgrW1z8BNwXYLinavrU8J2Va5BLgUIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012740; c=relaxed/simple;
	bh=FHzNN028Wl7cxVh7NYXgrkxS7ahQnf7fNUunvOT8ZkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppL/tnvPR/b+wCa+Yofw78TE9V4j/RoemcQXJzhYaIm2SToWbkXDitOnd+O22n0ibfWkP4peHciN5YM9646HgT2QwrZe8WMLfj7tnspjqxyquvs/BrO/lLU2brfh96n9lXL0AN1Cc3y091384H3wbwpCNNjCwY7kX8+bQYHdos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIvu61FE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIvu61FE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFA88v827749;
	Mon, 21 Sep 2026 17:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z/mAy5pF38WxS6+ONcT4R6fBRT5kBAMVlmEJjMoX/2U=; b=gIvu61FEeg222iua
	qn0s6CPag6Cq9WxVeWrF934dJMN87SrYxAWxcIqJTVp8P3PXa7P6xNjZWP1PrvNz
	SoWHEQtjJfzjsXSzCOMyTaUEzvhAra3c57z3pWiMjHbsLeDaOXyfI90KNGjikoQr
	5xfNepnDqVZukNGMZb4CoIllG1QRo7Y0D5rVrGnq3k8CiLtZc2m4mWKV77XvzF3a
	bBKYK9wMiaSEIpYVW8ITvqXMXHFEG0En/KjpvrjXR7GvhWWezZFlEhWgSh55yQdr
	g32ucDnQ/bm4cV1n5T9j5T9rRlosEMokX1Tjjf1lsnA1xCUTB8qpkbdFe0tltH4P
	4JJnMw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gt9tc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 17:45:12 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHeeWw1524380;
	Mon, 21 Sep 2026 17:45:10 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68LHj7Pt1531207;
	Mon, 21 Sep 2026 17:45:09 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 23:14:19 +0530
Subject: [PATCH v14 4/6] reboot: extend psc_reason with power-on and reset
 causes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-pscrr-framework-v14-4-a16290003b7c@oss.qualcomm.com>
References: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
In-Reply-To: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: fy3lVZDonlEQ8a5gLCApYTFwkQrHB3aA
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab16d28 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=uHPRDBdGixKVNKiypX4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI1OSBTYWx0ZWRfXweB8kR/BcXub
 ePdVqK9xF20vgEsNCIHmUECRtzSECBUPLB1OPXhlf659JTIFQn/AGxTQsjo8aSKCbj27hFODqJ5
 soGUlxqj2zxmGYk5+cwV++2CqSz+9SO1Ihx3+vg/2yWTr2ZYufVpLn8dy6vLf418h5oAXyyA0VU
 6w2FYYKg4OJEWlZtRKQe1QBvjDv1S3DyJNrqUj0qiptokhHdTGB3LEBe+09AGZg1m7ScSGfPGqn
 1i+onkQiVsH9iN/eoAPD2736MZxUWh936Z83RoTN1Fv7Jw8hvajnvOMlWxCHB2Ii4JrxIdMVIvw
 T+HuF0A+jyYtQpnEt8umMOYajFb5du+k7HLLdRsbSguMLDT8GR2CnD5b9RlAVyXiARM1+XBlQhq
 XcDqVX+bmSk7c7W8i+p9OuqSZDs/f1gRzP76N7ykyiXL70iaiGbSzQ5IRe94KWuNl2exIHiDeJ7
 Lf9LDNtR7E5JXMFB3bA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI1OSBTYWx0ZWRfX7BCEczzmrAge
 ktwueM+IjY96zDXR/YVGWCVRWtDk3N14vGYKPFxmQhm7BnG2uklPV1WKeZqJ02iNEw/1AfsoJ+M
 GLkyg7j3kBW/q3+XNX1JaYn0fSamMeQ=
X-Proofpoint-ORIG-GUID: fy3lVZDonlEQ8a5gLCApYTFwkQrHB3aA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210259

psc_reason covered only the protection reasons. Extend it to mirror the
full POWER_ON_REASON_* vocabulary - power-on, watchdog, software,
external, RTC, reset button, CPU clock and crystal failures - so a
provider can report why the system last powered on, not only why it was
shut down. New values are appended to keep the existing numeric ABI.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v12:
- new patch
---
 include/linux/reboot.h | 28 ++++++++++++++++++++++++++++
 kernel/reboot.c        |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 4c5327dd7645..13f004ad1066 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -225,9 +225,28 @@ extern void orderly_reboot(void);
  *	management errors, or an unrecoverable hardware fault requiring
  *	immediate response.
  *
+ * @PSCR_POWER_ON: Regular cold power-on (e.g. via a PMIC power-on request).
+ *
+ * @PSCR_WATCHDOG: Reset caused by a watchdog timeout.
+ *
+ * @PSCR_SOFTWARE: Software-initiated reset or reboot.
+ *
+ * @PSCR_EXTERNAL: Reset asserted through an external pin or reset input.
+ *
+ * @PSCR_RTC: Wake-up or power-on triggered by the RTC.
+ *
+ * @PSCR_RESET_BUTTON: Reset triggered by a user reset button.
+ *
+ * @PSCR_CPU_CLK_FAIL: Reset caused by a CPU clock failure.
+ *
+ * @PSCR_XTAL_FAIL: Reset caused by a crystal oscillator failure.
+ *
  * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
  *	value is useful for range checking and potential future extensions
  *	while maintaining compatibility.
+ *
+ * The reasons mirror the POWER_ON_REASON_* strings in
+ * <linux/power/power_on_reason.h>; keep the two in sync when extending.
  */
 enum psc_reason {
 	PSCR_UNKNOWN,
@@ -236,6 +255,15 @@ enum psc_reason {
 	PSCR_REGULATOR_FAILURE,
 	PSCR_OVER_TEMPERATURE,
 	PSCR_EC_PANIC,
+	/* Append new reasons here; the numeric order is ABI. */
+	PSCR_POWER_ON,
+	PSCR_WATCHDOG,
+	PSCR_SOFTWARE,
+	PSCR_EXTERNAL,
+	PSCR_RTC,
+	PSCR_RESET_BUTTON,
+	PSCR_CPU_CLK_FAIL,
+	PSCR_XTAL_FAIL,
 
 	/* Number of reasons */
 	PSCR_REASON_COUNT,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index e53fb31bad06..5d4ecc82b35e 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1102,6 +1102,14 @@ static const struct psc_reason_desc psc_reason_descs[] = {
 	[PSCR_REGULATOR_FAILURE] = { "regulator-failure", POWER_ON_REASON_REGULATOR_FAILURE },
 	[PSCR_OVER_TEMPERATURE]	 = { "over-temperature",  POWER_ON_REASON_OVER_TEMPERATURE },
 	[PSCR_EC_PANIC]		 = { "ec-panic",	  POWER_ON_REASON_EC_PANIC },
+	[PSCR_POWER_ON]		 = { "power-on",	  POWER_ON_REASON_REGULAR },
+	[PSCR_WATCHDOG]		 = { "watchdog",	  POWER_ON_REASON_WATCHDOG },
+	[PSCR_SOFTWARE]		 = { "software",	  POWER_ON_REASON_SOFTWARE },
+	[PSCR_EXTERNAL]		 = { "external",	  POWER_ON_REASON_EXTERNAL },
+	[PSCR_RTC]		 = { "rtc",		  POWER_ON_REASON_RTC },
+	[PSCR_RESET_BUTTON]	 = { "reset-button",	  POWER_ON_REASON_RST_BTN },
+	[PSCR_CPU_CLK_FAIL]	 = { "cpu-clock-failure", POWER_ON_REASON_CPU_CLK_FAIL },
+	[PSCR_XTAL_FAIL]	 = { "crystal-failure",	  POWER_ON_REASON_XTAL_FAIL },
 };
 
 /**

-- 
2.34.1


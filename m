Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8640A92C;
	Thu, 24 Sep 2026 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233834; cv=none; b=p/8vpVOqcKW5LqLW22DI8SeMMkNpyhcFizzyqVFG9ZYVDAHTfocq+1YVYohg/7FlQ6n1WyrgIAP4i9lJ0QZnYwKCOemp79IG+AnwaLgUOaQ6a6WZloevH51/22AlNZvth73nZvppu5LhuR50YohJOZQ5dEMJShvQb9eyHUE50VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233834; c=relaxed/simple;
	bh=epvvkkRl9jSBg+rXxmbLC/l7ALzG03dIYMHO9V+6CvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cb/JkEC7DmXRtRIaDL7fs+cJkxpnI5v266TjlciDfIKD8ptLrJ5Y+vC8Ej4oKIefeietujqtiunjXU8IIiPa8DFCYUCimbKt1xJYAKmvzOBmEbt9j5baFbTexzVGxVaW84bOWqn8AdwPRTvqjya4j4a6YUutLlqyLK1ubK6b9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JtlAK/ib; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JtlAK/ib"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eaKO772807;
	Thu, 24 Sep 2026 07:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RiMw2pzMrpirILqNk6QFkiOOTSPhR3XPCw/lsto94jA=; b=JtlAK/ibzT7RLeo+
	W9ROsUMN8swz1e0wzGFlP9AcnJaDKD9ugt4rqQdR9KINtP/MGHfm6U5xSJOcG/3E
	w3x7lns4f2jZz2zug6A66kvwBiH9PU33NvOWtpWQvo6CJ0GpPmcKWOtcDn6SdOa4
	2iBBgVAvdJLDtAIGrXjP93BmvTW/A8JZ+aIkP9QOvAmILeFYBdg6lJ9wEucPN6Vm
	+++uat2gDpS26/f23DWDux+KTqAytBMR364gu3g2MgKDlT/p4cLosNPwJwGt+h0j
	DdVqwSlXgWSMdIFhTkaG19RQ1PxL7gSi5jQDpOyY7VQE9IbKqO3KfXJUJzY5p6fc
	lLwy5g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr909hg3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 07:10:05 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O7A3Pk2215951;
	Thu, 24 Sep 2026 07:10:03 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68O7A0Cn2215790;
	Thu, 24 Sep 2026 07:10:03 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 12:38:45 +0530
Subject: [PATCH v15 4/6] reboot: extend psc_reason with power-on and reset
 causes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pscrr-framework-v15-4-7af87107e0d3@oss.qualcomm.com>
References: <20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com>
In-Reply-To: <20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfX0WZ/ySfo7t58
 34hCYZP31xL9hWHuMy3tb8+sc5i6kMoOlq6rIBWjNngUIz8y+A9FziZxdQFAPqLuu0Km8I1CHgi
 hpdSZNfCHF7MvfK8p9shF54JbYcJ5sE=
X-Proofpoint-GUID: Oz-rm4Lh-iHXSkOs7LOy2vMOBDcJM4ca
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfXzixLX0xC1prI
 0aDgrkCYv4K/zeSHPX8Ql96+gUuUEDSUEWJxigvFF1ydxGCqjnIpODdhdbva/9PjDtesUSDH9Dq
 rZEBwDCOs+lyC5c/zAbm6u61CMZH2ejgky84pCQb1N7NvuFpi9Lx8wyEv0l3Onm/VzoNTAi3F48
 BekyLR8LNDgUcex6haVjypasyvqPpvhgIarsMXzkXhEjGWYHFb2V4+CAq7y/LAAbnFYDHUZEhbu
 JMDBDyR4QX6QuCzYGNjynsfYMC9VJxzR9onOd2Ep7FFiGts4kZDal2S+qhdxEUtnt9paLCKozqZ
 5I6bGLGwZ1nwqBGLMTVMzGDNLYkvXT4ZKOx7CtxOqDGOex3giGznWveTFG20HtAekhJ9pU+BZpy
 9/T3nJ+771e8SxgS3U2KWFppTBWdIGXqbu4qLlSIreT6lm7AqZnUwI7aW2wHYuJcOkdPOu7BiHB
 mWakaAekrq/MY2vztmw==
X-Proofpoint-ORIG-GUID: Oz-rm4Lh-iHXSkOs7LOy2vMOBDcJM4ca
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab4ccce cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=Vje9-6R8i_NmrIIDdkYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240030

psc_reason covered only the protection reasons. Extend it to mirror the
full POWER_ON_REASON_* vocabulary - power-on, watchdog, software,
external, RTC, reset button, CPU clock and crystal failures - so a
provider can report why the system last powered on, not only why it was
shut down. New values are appended to keep the existing numeric ABI.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

changes v15:
- add a static_assert() tying ARRAY_SIZE(psc_reason_descs) to
  PSCR_REASON_COUNT, so a future enum addition without a matching
  table entry fails the build instead of silently reading a hole
  (Matti Vaittinen)
- Add Reviewed-by tags from Matti Vaittinen.
changes v12:
- new patch
---
 include/linux/reboot.h | 28 ++++++++++++++++++++++++++++
 kernel/reboot.c        | 12 ++++++++++++
 2 files changed, 40 insertions(+)

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
index e53fb31bad06..7094c7a8f315 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -7,7 +7,9 @@
 
 #define pr_fmt(fmt)	"reboot: " fmt
 
+#include <linux/array_size.h>
 #include <linux/atomic.h>
+#include <linux/build_bug.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -1102,7 +1104,17 @@ static const struct psc_reason_desc psc_reason_descs[] = {
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
+static_assert(ARRAY_SIZE(psc_reason_descs) == PSCR_REASON_COUNT,
+	      "psc_reason_descs[] must have an entry for every psc_reason");
 
 /**
  * psc_reason_to_str - Human-readable label for a power state change reason.

-- 
2.34.1


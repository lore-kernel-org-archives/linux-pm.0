Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315348F844;
	Wed,  7 Oct 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370627; cv=none; b=N9hYvSLF5q9l/AQDNGSIXU0KE9KB97MNvT43KyocF67sd83fgc/cQmubKj/oEPlm5Z8RhTIytJkCCaeyixavVgRFF0SrJrF8Ba2hFho+DiXm1hfBHchUwgob81rWuB4ktfixQfWPAHqS1hNijdiGZMU79eAYsNCYA4UuphNCmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370627; c=relaxed/simple;
	bh=re5/vtBq8yw/jifXhYlUrjdqPXF8WnZK08qok5bzY1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a4OH74HnhdOjDxHprfFs6DxaNEz1s1Bg6KZhN6piYAF+OIyzwq7Lf1I5dzCsF6xwK3Oc4b+JYH0T81VBOP4B52w4RzvZWIPUct1EGVaq6nrOSMBvO8pxXIbKgLt2oGF1gy8Z+l4e6IbgNMkBctmmQarGJ5iDyhOVk7UJSMQo7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cjzM1WAb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cjzM1WAb"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jbkF3298317;
	Wed, 7 Oct 2026 10:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbaZT9ZclFk/IbdX3+0WEBhlYkLn3GXBRn54MSdCcBw=; b=cjzM1WAbmLE4tqdK
	CwwSkWv2+3vNK6devKDddfGeMjPFZja3sx+bkDOTHnwxS5vvdl622tDjTZ0K/5SI
	GyUpQjeSRFCZXDm5J+HDivN+xSrKltlV+KFi0KoHotHFf9LObXsbRZZSSYUagPpp
	4cl8zl6IDAdf428Cn2ZG92KZF3n2MpBJRzO+aS3n9b/Mdj1ErCwZJcAGNUY8ivoH
	4PVAyXZFZ7085fuT6508I7EavN0kQiMrVf6kGOjUtqEGbE9lwN2Ud3lMsXrTzqNA
	aVW8ykfFP7I13onk/7uqUM4YSuu/9dn9gt2esiS23zKzJNPp+xfN2v7SjtBRtbTH
	90UCCw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdcrqha-29
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 10:56:02 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69776o7I1872925;
	Wed, 7 Oct 2026 07:06:51 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69776m1u1872875;
	Wed, 07 Oct 2026 07:06:50 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:36:39 +0530
Subject: [PATCH v16 4/6] reboot: extend psc_reason with power-on and reset
 causes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-pscrr-framework-v16-4-3642c277bebb@oss.qualcomm.com>
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
        Bradley Morgan <brads@mainlining.org>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: ax5MUkkm_mQSYjnnlNnBniRTMY9nARL8
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac62542 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=Vje9-6R8i_NmrIIDdkYA:9 a=QEXdDO2ut3YA:10
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MyBTYWx0ZWRfX/SJWWVXrG8tP
 9DJZa/RZBNU6tztbPeSj+VayHTOpA20tPoX/X/m5fTKy4YHtYqdnXzlRzbsNqPrk7q6ukV/bD0P
 tTH3fBbTZhdBJ30YZOttpfXOGuNNeeI=
X-Proofpoint-ORIG-GUID: ax5MUkkm_mQSYjnnlNnBniRTMY9nARL8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MyBTYWx0ZWRfXzyUUdMkkX4ZC
 MaKAz92AAKbeuwCVsGDnNcJBpZjm/QFbz7aojjJ6rf57j5ftMpWEPZ4kVfV+ljYJxqpFr9QLHE5
 vTmPNZuadrJs226swA7GUXUn+LAwCSmk5Q6CSroqKgvy274JlVUdVSvEKMewx+uXCAUx0MYrd0v
 iBN88ct2BvPTqsqNPVJrfW7BplQQPfGSI+jbuNny2LLdZ4Q8XvdxJYtoWaUFctnAo6+FCgJsexY
 i/gsz7fBVege6PcOGJIotn08btdbg/bMPqaJSHZpNREfb4uoZojrNINL8GibQ3hznEy4wOB1G3Q
 jWQyiIgaaPHhKWk/Blzlre/u3VXjbXicHDEwadzIfolVm9iJ0QYlxqVFNZXYYBpNnD5+f9OcN2L
 9mdujXspG17t2c2bgRaW4wKOiBT6lIwmNIecdOrCIGN1ZyNKu8UhV3/jwtyRjqDwO+/XEn0NfLw
 HJdfVuIs7sBD6OJ0VKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070043

psc_reason covered only the protection reasons. Extend it to mirror the
full POWER_ON_REASON_* vocabulary - power-on, watchdog, software,
external, RTC, reset button, CPU clock and crystal failures - so a
provider can report why the system last powered on, not only why it was
shut down. New values are appended to keep the existing numeric ABI.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v16:
- Add Reviewed-by tag from Bradley Morgan.
changes v15:
- add a static_assert() tying ARRAY_SIZE(psc_reason_descs) to
  PSCR_REASON_COUNT, so a future enum addition without a matching
  table entry fails the build instead of silently reading a hole
  (Matti Vaittinen)
- Add Reviewed-by tags from Matti Vaittinen.
changes v12:
- new patch
---
 include/linux/reboot.h | 34 +++++++++++++++++++++++++++++++---
 kernel/reboot.c        | 12 ++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index b0fac2258413..a3ca139f48c1 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -227,9 +227,28 @@ extern void orderly_reboot(void);
  *	notify value ACPI_NOTIFY_CROS_EC_PANIC on ChromeOS EC hardware); the
  *	kernel only relays that report, see cros_ec_lpc_acpi_notify().
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
@@ -238,9 +257,18 @@ enum psc_reason {
 	PSCR_REGULATOR_FAILURE,
 	PSCR_OVER_TEMPERATURE,
 	PSCR_EC_PANIC,
-
-	/* Number of reasons */
-	PSCR_REASON_COUNT,
+	/* Append new reasons here; the numeric order is ABI. */
+	PSCR_POWER_ON,
+	PSCR_WATCHDOG,
+	PSCR_SOFTWARE,
+	PSCR_EXTERNAL,
+	PSCR_RTC,
+	PSCR_RESET_BUTTON,
+	PSCR_CPU_CLK_FAIL,
+	PSCR_XTAL_FAIL,
+
+	/* Number of reasons. Must remain the last member. */
+	PSCR_REASON_COUNT
 };
 
 const char *psc_reason_to_str(enum psc_reason reason);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f153b6349369..613a6ecb5808 100644
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


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF73E7BB2;
	Mon, 19 Oct 2026 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395563; cv=none; b=mSi4zmOzP9qeCW8i0HqwtvILv3S4HDhNJWH/zk82g7Y4MByqfXxtoE10xJHIZF8w+HMKicZY2wJXSGM6Wb24qV11XJt1LAy7zgpP+00opF2zGZSFyppamX+xzWRm3HD6gN7TGV7Qebc6HW43KiEMBagxT5S2lDT2hqBOLev7q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395563; c=relaxed/simple;
	bh=re5/vtBq8yw/jifXhYlUrjdqPXF8WnZK08qok5bzY1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WMtKfZkRg0hZMuA7hAllc0vc8q+XMbfKG7CUnOhHdbmo1q7dBrEcPyI2Q+qEsw4RzRZhgNMT144lOL0CsaRrhDNt7MDoB+v9sWvWVtLt/IRcqTCcP+pSJUey0H9dcSjVlAOcopz7k8pPwTh88kQTG63m1g7gO5rIX4BFqL0adw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KAIC7YoV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KAIC7YoV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4irsA2768390;
	Mon, 19 Oct 2026 07:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbaZT9ZclFk/IbdX3+0WEBhlYkLn3GXBRn54MSdCcBw=; b=KAIC7YoVHgjUkVsz
	w1Mf4SeVo7k/1Nk4sAxcKKPdmuIHHR9mEi5ghKCMhjTzPGGgGpIqeLkBFw8bqpzK
	U7ied9Q0CbIHPCib+xHjbzC5EdNlvVTAWhTEOXZ4wZxou4T3gM0mHCVhEwUYZ3AM
	xozddT4ENICnM/vx4dmVUPjZaO+ry0tRFjR1SLEmECU3FAOfTFSlU9+VOUtLWQ89
	CgJhU5AJXnUVeNQ/orlch3dZeR4jdnazh6yvAfaQXfTBVEYabGvgy/cD1Qzcky0z
	ifnoBhYSgCXioVhnlK9EyIO7ApgLPL5RUTU0++dIlpYVCcOKwhngkEDw66L15R8T
	yU1LmA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys5mqt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 07:39:01 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J7cwQM104327;
	Mon, 19 Oct 2026 07:38:58 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69J7cuGZ104238;
	Mon, 19 Oct 2026 07:38:58 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:08:35 +0530
Subject: [PATCH v17 4/6] reboot: extend psc_reason with power-on and reset
 causes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-pscrr-framework-v17-4-69ea6cdf4731@oss.qualcomm.com>
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
        Bradley Morgan <brads@mainlining.org>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfXwbA8l1R8ljIu
 EmInxdbTb2qbFaDOCk/ivhwOIUIC9YyOh25QgGGSx+EZgoO16LqbCIfyKr3a1EBiuY3UMwHqRSS
 ydqxyx4MF8UDX+y6rhaXqxrvEoACTm0R9Ul3aeq0kAAvPLbbmeNOWjMA5uOBhedxawqO4Dkx+UQ
 pxJKBmeKCqJ4+GfifROCa+VvUd4SXeqUb3NueHIg2lOz0uQBVxRwdeKaO2i2NFJIqgHknixnNNX
 XzWAdgkYVaWdW8dl6bemHC5du23TKQBFOC6qjYJh5G+QbArmYchYSMKK+R2af7VH8pNvHEZXVFo
 9yKyOWt5k+3b3e540u6iopmwXASWKvDNBmoN1Hn7xez3kw/XxtL/YvVtIEtX+pXDENyntGwMhrw
 WYjZ2LiHkqui6NNl24UPXAYUEYa5dW8mk8b9xJHSRiWk5h2qZwlJtt5++wbGuzHUgt/Oh98sBhp
 qTfJadK/LerBdL84lXQ==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad5c915 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=Vje9-6R8i_NmrIIDdkYA:9 a=QEXdDO2ut3YA:10
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: i5YATP0bW67qRFnTLpLpBSCCmFOp2izh
X-Proofpoint-GUID: i5YATP0bW67qRFnTLpLpBSCCmFOp2izh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX00+0Y6qDA1B1
 QUl581aNpPnbS4pha+pQzv3OQoR8UPFolEWkkP2DlYEWcOhkwLyEQEFn6Ylnfnskt9w8+Hyb1hM
 7FFXRoKJMuOepklmv1rQpEVHDbfefAk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190030

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


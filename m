Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC04E2F13;
	Mon, 21 Sep 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012461; cv=none; b=s4gPjCoj+SRUP/v/ftGPAy/jqI4PoaPeWONhqfiSf9LjiK8tc1OerriZvgzSaNDzvOqhv1dKsfJ84R9l1aZu6bwMI/3DGZiAl6TrnFbatt6CFCAIZJQbLLt13Kyl8jGlb1Bp2rxZgYY4QuAAcfiTWAaGf2IKOc+Q4Wm9naVSnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012461; c=relaxed/simple;
	bh=FpT41VuJx/RhuA3s0Y6+NIa72g6zJh/UBOwe5H0ThfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKoOj6StpVtBl/OdA+s/LleLZknANZzqPYUr8/yHkAfiJ6I41AZeQB49Pxb3GOZORaA0duhnZlEKC6hqAZFLDhm4E1pXbCy6T+e0vfO33TUo0w761DWFf+/uIeyr4Z7AZ52i5dAAHsM12QisvLIyeLgXTuw4sPVovt4orq/nXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YebHuBnH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YebHuBnH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LGUiig2707774;
	Mon, 21 Sep 2026 17:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XcuNqUtiQ6YkSBBXPvackNvDBCGeX7CHs7k1WjQ/M8M=; b=YebHuBnHeALEr2wB
	c/4O5WJyGmdlRsnWUGlZRXqBTT/HAoTAgepttPAcIv0ic95AkNXlU14ZNHqytqdJ
	8407FNqfx6zc0Tj9SskfcJs3mICeVmXotZq7EwTSBtEL+QdIx+YoRK0wL+ifxes0
	yo85uHK+fr3fAsWhEc1w2ADHANyxAhGzhBQGhUhif6v5V+p3brxwRRM7IRXp/lvb
	/Z+F9OfrA8FYLEFaGdJZ4bFf1osKerAxug2f3eYk4vtkU7nhepd62ABXsWZgynbG
	Was0HMxN8/O2ScRK+Zz8UQH8RlJ04naCWFSB9WDWM3CrMBXO1R5nb7ESMm5/n4YV
	H3hCyQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu85vg9tc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 17:40:41 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHedcp1524364;
	Mon, 21 Sep 2026 17:40:39 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68LHebcs1524318;
	Mon, 21 Sep 2026 17:40:39 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 23:10:28 +0530
Subject: [PATCH 3/6] reboot: add parsable tokens for power state change
 reasons
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-pscrr-framework-v1-3-a5ebe994a98a@oss.qualcomm.com>
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI1OCBTYWx0ZWRfX4odu3Hx9qTuR
 XrBNLM35nl6294GNCFHa9jOils2rh0F7AIGneRBYkj7r33tHaRuF9NVM/w27+DS91seTBlV0Y7t
 Nnd/EtVit9+g/yrSB/10VEamrf04tz8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI1OCBTYWx0ZWRfX9puUhBTCXfxw
 7EUHrp+Q3ClcukcCzRwqerPzaZTSXbC7sGDeRijxr/vhYXZME7qdtfjosQFjR71sjFHjqA5yN/4
 ss3YLUCzaefnK4X/h9e+xDApKg5ImKecR8+KMv4PzQoQAb6/sZTRsy8oY6fEvTRfjZqNpT54kaw
 Z9jpUmQCyMeo5hbdpLwaOFq85q5G2SYhR8YWwoofPjOWYumsM2gUYqLDPFVNRcBHCoAudP9JXJL
 ETzBmLjQEfugG3tGw5SKCne+UUbdA4LZsRP/9J6vMlioVkTi2HYAoBBGApPUzjNrx1AqVs0pDzv
 NmLT0bCgzeZ+ijTOJWhusdNXpkWemGo02K+RinF1fu9OoSCjwWJ0VQAiDNohIb3hFJjEaJjt6BH
 tIaOD+jcCI9bGRRV52sL73+6ERtZ8u/FsC1qMmZXtFAUemfsjZx9cLTFXvrGigQBHtYajzncS0p
 sYzjDjTh2vMqPpXxryA==
X-Authority-Analysis: v=2.4 cv=E8FYNqdl c=1 sm=1 tr=0 ts=6ab16c1a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=se0PJeKvf3ygCVTVq1UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wriquyE5rgTU-jcXkhOzzF_XKmC1aY1Y
X-Proofpoint-GUID: wriquyE5rgTU-jcXkhOzzF_XKmC1aY1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210258

psc_reason_to_str() returns human-readable labels that contain spaces
(e.g. "over temperature"). Those are fine for logs but unusable as
values in a space-separated sysfs list or as a write target.

Extend the single reason descriptor table with a stable, space-free
token next to the existing label, and add psc_reason_to_token() and
psc_reason_from_token() so consumers can emit and parse reasons without
inventing their own string table.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v12:
- new patch
---
 include/linux/reboot.h |  2 ++
 kernel/reboot.c        | 77 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 08a7549bbc40..4c5327dd7645 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -244,6 +244,8 @@ enum psc_reason {
 #define PSCR_MAX_REASON	(PSCR_REASON_COUNT - 1)
 
 const char *psc_reason_to_str(enum psc_reason reason);
+const char *psc_reason_to_token(enum psc_reason reason);
+int psc_reason_from_token(const char *token, enum psc_reason *reason);
 
 /**
  * enum hw_protection_action - Hardware protection action
diff --git a/kernel/reboot.c b/kernel/reboot.c
index d5a45db82c3d..e53fb31bad06 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1084,34 +1084,79 @@ void set_psc_reason(enum psc_reason reason)
 }
 EXPORT_SYMBOL_GPL(set_psc_reason);
 
-static const char * const pscr_reason_strs[] = {
-	[PSCR_UNKNOWN]            = POWER_ON_REASON_UNKNOWN,
-	[PSCR_UNDER_VOLTAGE]      = POWER_ON_REASON_BROWN_OUT,
-	[PSCR_OVER_CURRENT]       = POWER_ON_REASON_OVER_CURRENT,
-	[PSCR_REGULATOR_FAILURE]  = POWER_ON_REASON_REGULATOR_FAILURE,
-	[PSCR_OVER_TEMPERATURE]   = POWER_ON_REASON_OVER_TEMPERATURE,
-	[PSCR_EC_PANIC]           = POWER_ON_REASON_EC_PANIC,
+/**
+ * struct psc_reason_desc - Descriptor for a power state change reason.
+ * @token: Stable, parsable identifier without spaces (e.g. "over-temperature").
+ *	   Suitable for use in sysfs values and as a user/kernel contract.
+ * @label: Human-readable description (e.g. "over temperature"), for logs.
+ */
+struct psc_reason_desc {
+	const char *token;
+	const char *label;
+};
+
+static const struct psc_reason_desc psc_reason_descs[] = {
+	[PSCR_UNKNOWN]		 = { "unknown",		  POWER_ON_REASON_UNKNOWN },
+	[PSCR_UNDER_VOLTAGE]	 = { "under-voltage",	  POWER_ON_REASON_BROWN_OUT },
+	[PSCR_OVER_CURRENT]	 = { "over-current",	  POWER_ON_REASON_OVER_CURRENT },
+	[PSCR_REGULATOR_FAILURE] = { "regulator-failure", POWER_ON_REASON_REGULATOR_FAILURE },
+	[PSCR_OVER_TEMPERATURE]	 = { "over-temperature",  POWER_ON_REASON_OVER_TEMPERATURE },
+	[PSCR_EC_PANIC]		 = { "ec-panic",	  POWER_ON_REASON_EC_PANIC },
 };
 
 /**
- * psc_reason_to_str - Converts a power state change reason enum to a string.
- * @reason: The `psc_reason` enum value to be converted.
- *
- * This function provides a human-readable string representation of the power
- * state change reason, making it easier to interpret logs and debug messages.
+ * psc_reason_to_str - Human-readable label for a power state change reason.
+ * @reason: The `psc_reason` value to convert.
  *
- * Return:
- * - A string corresponding to the given `psc_reason` value.
- * - `"Invalid"` if the value is not recognized.
+ * Return: The label string, or "Invalid" if @reason is out of range. For a
+ * stable, parsable form use psc_reason_to_token() instead.
  */
 const char *psc_reason_to_str(enum psc_reason reason)
 {
 	if (reason < 0 || reason >= PSCR_REASON_COUNT)
 		return "Invalid";
-	return pscr_reason_strs[reason];
+	return psc_reason_descs[reason].label;
 }
 EXPORT_SYMBOL_GPL(psc_reason_to_str);
 
+/**
+ * psc_reason_to_token - Stable, parsable token for a power state change reason.
+ * @reason: The `psc_reason` value to convert.
+ *
+ * Return: The token string (no spaces), or "invalid" if @reason is out of
+ * range. Round-trips with psc_reason_from_token().
+ */
+const char *psc_reason_to_token(enum psc_reason reason)
+{
+	if (reason < 0 || reason >= PSCR_REASON_COUNT)
+		return "invalid";
+	return psc_reason_descs[reason].token;
+}
+EXPORT_SYMBOL_GPL(psc_reason_to_token);
+
+/**
+ * psc_reason_from_token - Parse a reason token into a `psc_reason` value.
+ * @token: A token as returned by psc_reason_to_token(). A trailing newline is
+ *	   tolerated.
+ * @reason: Output; set on success.
+ *
+ * Return: 0 on success or -EINVAL if @token matches no known reason.
+ */
+int psc_reason_from_token(const char *token, enum psc_reason *reason)
+{
+	int i;
+
+	for (i = 0; i < PSCR_REASON_COUNT; i++) {
+		if (sysfs_streq(token, psc_reason_descs[i].token)) {
+			*reason = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(psc_reason_from_token);
+
 /**
  * __hw_protection_trigger - Trigger an emergency system shutdown or reboot
  *

-- 
2.34.1


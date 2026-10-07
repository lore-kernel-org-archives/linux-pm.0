Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9C47FAF7;
	Wed,  7 Oct 2026 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372607; cv=none; b=gIy/ZOMJo7ASEs4U3zEa29nUhQThhHvSgtB7XQwO+mIFS2bKNgV/JErRmR1Pgrmh7UQOT3kjdbuRlAxct/O9mb+oNruoIxKLj7qD00/zNSR5EoY3lgZc+XjAmMu7o1UxYNGEGMTlf0Dko7QP3G1EYr4nB6KOGLQB7Jl+C5yyCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372607; c=relaxed/simple;
	bh=rR5DWVXy5oHMvUGUbZcexdtU2b1Gjc9Rtnar7g8u8Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1jKnmQFx3w3ynfj89yXZPyHSdJehK0SIWJyrIIOd49I/omgv3oYC3CcWZtlXhhuvcuKh2cVuFfrW7POoNU3r3fmBFMrwarVgjTXEIIlBz98UAXavnEY16EVCaugA4XXMnMYZU6fOD9IoLXf3secRe3jbDYFFfU7dkgiPO/hFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V+fvei+4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V+fvei+4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697AbooK2686654;
	Wed, 7 Oct 2026 11:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Vb8950BJ79I/V9mbxoM7hzQg9cKgqD+1gH4IuZTiG0=; b=V+fvei+4MMWim/aH
	mreiNVCFJ9rgkGKFjBNmFYLyN4Qokd0lYJr49jaZDMT2qsWdGGKH7mKmeOrPDSsx
	ymycbqkWuA2txsOwyBgEPkZL0aWRH5cnFvIEc7Eddr4+HjVqkRtQ8y6pzN8vZb+r
	7MGdR2bgKFR1VojSeq7UlV8SqJmV/lM2Aqf4/mWeZcnlEBarfA03wpfISRk1jHtH
	nkBAIp64DS0+JHEC4XRWe5SAS6kY80Z6AmGGczw020eGQj4ZnRc3BXxcA04Da4LN
	axNlXIkIseWkFHUU0HbUptHsRHwcC0C+X6Lt+rLVFdgYqnI3F8EFNW4ddEkPRCKE
	vbhFRg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mge04nh-152
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:29:17 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69776oqi1872914;
	Wed, 7 Oct 2026 07:06:50 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69776m1t1872875;
	Wed, 07 Oct 2026 07:06:50 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:36:38 +0530
Subject: [PATCH v16 3/6] reboot: add parsable tokens for power state change
 reasons
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-pscrr-framework-v16-3-3642c277bebb@oss.qualcomm.com>
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
        Bradley Morgan <brads@mainlining.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NSBTYWx0ZWRfX/5Gtc0+agZ0a
 w1iK3LRtQrpkOq4P39fkCYvvszWdpUDWIJ2kj8imt3N5l07eAFIQzTI1ZPlX3ITu0abPehEI+5N
 Taz73i+kcM2wrr3wEAlzI1j46sUrg10=
X-Proofpoint-GUID: Y95X__1G0qzJ7kLhi_9FOKP9chKD5HaU
X-Authority-Analysis: v=2.4 cv=PdJqFShd c=1 sm=1 tr=0 ts=6ac62d0d cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=0cSYWeX8DinV4I8qkw8A:9 a=QEXdDO2ut3YA:10
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: Y95X__1G0qzJ7kLhi_9FOKP9chKD5HaU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NSBTYWx0ZWRfX31E3wCgLTpdG
 FKN0GlQz8vmGgwxt+M9LpgSaz+BjWdALq7RBG7bjlHQP2TmKdiOzH1AuVQXYNMc60ZxNtAQ1mRg
 VE5iQhblu1YFOW+HTVtztGddrU8Mw2TfiMMWcQtN6UX2l6O+L73o5A0IZLZHRX3BV7PJ0JmcCtF
 W5NGHkI8xa258oGZil1bGS8cXOaavSKDIWsVsjpqgSaCOTJ2NwAZv+nQZxS8gIZH/02eKUtesdl
 vGcK+4bsaPvJkdotzo6t1RJyF8R/Uc85PyvOrV9GuysUqkwtKGQ+esX1sMcf7KjNXkYevbx6OIG
 eHlugxvx6Yq/EBXCjGp1GMa90hdWE/C0mlkPZy1NriTpE651F6keXtox9eRk9aKnzt5PwrzESsv
 8SYRtQRZny4TahY3LqMkW60XMCb5fN3KcmtUxSEawlu0sVYy8Sbt7K/fuuyI97CdrIpqr6Lh1WT
 lKOsfDDLmqn9b8V+oEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070045

psc_reason_to_str() returns human-readable labels that contain spaces
(e.g. "over temperature"). Those are fine for logs but unusable as
values in a space-separated sysfs list or as a write target.

Extend the single reason descriptor table with a stable, space-free
token next to the existing label, and add psc_reason_to_token() and
psc_reason_from_token() so consumers can emit and parse reasons without
inventing their own string table.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v16:
- Add Reviewed-by tag from Bradley Morgan.
- Add Reviewed-by tag from Daniel Lezcano.

changes v15:
- Add Reviewed-by tags from Matti Vaittinen.

changes v12:
- new patch
---
 include/linux/reboot.h |  2 ++
 kernel/reboot.c        | 77 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 190b5838fda1..b0fac2258413 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -244,6 +244,8 @@ enum psc_reason {
 };
 
 const char *psc_reason_to_str(enum psc_reason reason);
+const char *psc_reason_to_token(enum psc_reason reason);
+int psc_reason_from_token(const char *token, enum psc_reason *reason);
 
 /**
  * enum hw_protection_action - Hardware protection action
diff --git a/kernel/reboot.c b/kernel/reboot.c
index c3552653a881..f153b6349369 100644
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
- * - `"Invalid reason"` if the value is not recognized.
+ * Return: The label string, or "Invalid reason" if @reason is out of range.
+ * For a stable, parsable form use psc_reason_to_token() instead.
  */
 const char *psc_reason_to_str(enum psc_reason reason)
 {
 	if (reason < 0 || reason >= PSCR_REASON_COUNT)
 		return "Invalid reason";
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


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BD40801E;
	Thu, 24 Sep 2026 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233832; cv=none; b=dva2p44n18iILCssrB5Hvs1rFnGrDUBdXEaXdqPGLU9S3ug3FJw1CGeN4FCW2T1i+CWkrOuktZfael0N+8Dr1CwRd6a84TH3zgIFGImKKYgwvRpXyPi23kmQyzBR/fHEydDzWK9TfW+CJ6Hjjkb4Sy4UUFx5QhEj5vHcWNoPZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233832; c=relaxed/simple;
	bh=7XdVllis+fOWu3k2foQ0ifOqNog1Fa1+TwpBWcIy4mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adncECkZubPFdTQzOMo4DoTVQJHgYRKhSNGIcM4hRNXPW8/bBXR9fENCBL8issfeVVvMBmph1T9HUHCZWcqqe960G6n5KVlDUwYQS9tVKx2SnycTwWAjL8YpYDiukqTKoQrUOceueswSf8YrJ3SnX4vKLZOxOcjlrBWTXoVlv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mr5PWlj5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mr5PWlj5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5e9Zr772433;
	Thu, 24 Sep 2026 07:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Vu+eY+XrDWVFZMIcKt+DByXEoTWp4ZGOa9YAVXEHvU=; b=Mr5PWlj52tr2aLAk
	1lTWduaDac39ZN/9zjdxlTXNwGWcr2KSQCn/W+asV46gT1CxP01DX1+GNxFTD2MN
	BkoQYUGrAlIJtmRkL+8a8JL/f05fCFHQEAcBNqtiif7L4RnhAY0zsj2N2pJZ7HiM
	DHk7a5jiDX4uamnGhqOFIreLWSOqniLIk4lX6h5uyodAEXHHH8nHrGwR4z8WAsqD
	8Yt2sIqf1rUpvG12cwT5aGJ9lH2/OPMhygSWl4aJ7nCqeRFyQ+DrS+OAf3Gh+tR8
	zfrzHfzL2+L4EcjctWL3Fs70JVCev13Ehm1HtUrQmkkS1DzoY+zuWlhHG6ARwuj0
	CZUNqg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr909hg0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 07:10:04 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O7A1TW2215804;
	Thu, 24 Sep 2026 07:10:01 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68O7A0Ck2215790;
	Thu, 24 Sep 2026 07:10:01 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 12:38:42 +0530
Subject: [PATCH v15 1/6] power: Extend power_on_reason.h for upcoming PSCRR
 framework
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pscrr-framework-v15-1-7af87107e0d3@oss.qualcomm.com>
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfX7xH73xdOaIhg
 KmPN/1za2qhseMZXx3D/JFN18PGisF/X4gfXnibo7vFzKx3G1rvwJP5aGOyVX9boHauoZlp35jx
 +5rtf9rui7nyliXUMvLObLouTM/yM50=
X-Proofpoint-GUID: Iy79Rm_WCrocH8WaSHrzwx6-rzFDwRAg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfXwTV41nMr8658
 bxLNyhAx098fM8UaqmPJaS+vt5IEAluTvJwzL//HAiDnOPCpJ8mW7zi4Qmba1WBt7On+31VQIq4
 wc72n4azdfFYSYNkYBBYsrLH2hS/1P27bit2UckrYlgZE0uUag+5lvympaJdKL5e9dz4EJAPnXf
 gKjF449u04j1owvjSmVDP0nsbgwdTviivAtfaLBaEKuugwpIKiyvpx+9TxjWb4afOuuTA5tCOIk
 6qEbQJwsxg7MT78mfa1K/a+5zGytELvRQZHtZNfKz1vA72Qx2W6S9Zq3PjUPR+Fp0YopfsX2dE3
 AUSGNDPlHpU9kVoYF2EbE4Qz1M0So5xiRT7oT8XHKUWh0YS928OtqrlofDlcZa0E8DeCYEOSnj5
 xNNU4l0ywo/4IjFX9SarIHNQVIA/Y1FFogggnPZpaWY4RdxIrC6DGQZRQKggGgbnfFnZ2GLCLnR
 +fhsr/jGIvqHzpu6rpA==
X-Proofpoint-ORIG-GUID: Iy79Rm_WCrocH8WaSHrzwx6-rzFDwRAg
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab4cccc cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7kjejDXy1mYeYQkWB3oA:9 a=QEXdDO2ut3YA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240030

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
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

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


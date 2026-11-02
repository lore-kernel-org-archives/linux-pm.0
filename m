Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619691;
	b=3jy9HWBjYP0ge/9fkFDA/GGxli+4CxkUGaB+fO8l9NWMdRNRRnilWX60MlvekpEkvyEH
	 f/BUgFkfWVa03WRWq95UC2IjK25Py+WJuk2wi3ItVWxPxiP6dS9eSfcU+d13MOP78EegQ
	 91a3oczEeVe51RMYGr/ixFHTV5Fy5tCRiN1VhoxzF8jvMBu8MYlAgCkaargt1xv/oZVBG
	 fIFf8/rFuD7loaFTHykajT0iklQRDgJPDBb3zhcLYZ37g30t5+Vlu8UrBH9stHmhQKXzU
	 99sz/BU9b4Cf7862D93NgPM983hniQDfb5jCjzK8Z1dDmq4HStjSo3srTQbjvaT8BoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619691;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DfILuvUDP/rD7AiORGLKXm/sfLDG2w5A0n5tcVIlud8=;
	b=XNzmaNL+cSzt8Tdlb+v+z0i9DSP3GGcavAHh0gI8Vd6YheH+OHok6S4yUh0PDtDWQ3ue
	 e2D3trHaKxr6Wf06NSWWtcZDXDoW6Js+ILiYlGE3bhhrQwRvPb5uifg1YQTyI21Auo22N
	 QsRqfD6JZ3a0aTErn8S36vqNSh00S6xFI7tOYq9nAwB2y2pjHYkP6YZxekLGewZE1eecV
	 6AxJLs7vYx3rkaHru7pPInB1W5t/0zoxvebi8LafTlgYC63mf8DJNsy7kSP1QIc/s/qvl
	 Cj3B5hq6bwSNMmLkQ5P1NyX8iQx/mi8+PK4iQm1cYeW/RlQ548vxPbc5jO8OX0emYMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQOd2vIc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEY7hCov;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D31606A32E
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 11:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D31606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQOd2vIc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEY7hCov
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A1F33430382
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 11:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DfILuvUDP/rD7AiORGLKXm
	/sfLDG2w5A0n5tcVIlud8=; b=jQOd2vIc0qSvFzdlIoWJFtraM0Wj2KSCXgKGds
	Xb879iAh6AtMO/ZtVvJNO6VM/g/Lb4mo+xbiUIM8MqpZgujL1FA0L3ZLxNDN9wsA
	RTsN9cO9hQSLGgk/n5nKM8cJquLI6LJvHkOnJZSwQESoGLK4nbP2kCzOIiSuEJL2
	1mQBRZ2hjreRZq6xFh829XNwbn0THf4vT8oD4Iui0mrzhMRAiMqgDmEBsqfdWxVv
	UQt+nvikhQi1W1HaowRU8H/fGLTnGaN+RysSsdi4P3To91dGN5UVVvQksmISSBnL
	x2TJFqDlNZXxo2sg6Y2+e4MG/GwKiLzUmsVLVlfTfXCQ2KMA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmes3bs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 11:41:29 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98f0cae5b9cso311068241.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793619689; x=1794224489; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DfILuvUDP/rD7AiORGLKXm/sfLDG2w5A0n5tcVIlud8=;
        b=OEY7hCovYWTKdNqHJmzc2O0JAXc9FTPYxagmtf1XQGjSg/koaOkJKfZFvGaCL7oWYV
         5r1FN4ZP8IQNv3IhCrA1t7T0DMzaWoqPY7v1brYq+MUfNQyPnrpAEtg/Yb1HVkIgafmi
         PV8FC3K59CSXStrGkD98vOONyDPvCyilVE6Swj1HPgsm615sGHcbHj3NADGDMJn9qoW2
         nBQSibwe/s0t1+ixlCLnefBJ6uXClLDEywcVeFtD1fD8oINf2jfEnap1JeD+cdnZdX/q
         2SXu20xY2OMlOdBRxInqSt6MMCBokKB9660ZT/5zTkZRGehaDNDjtOedIB+gX5u7mVtI
         gBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619689; x=1794224489;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DfILuvUDP/rD7AiORGLKXm/sfLDG2w5A0n5tcVIlud8=;
        b=jIFvVRKjnlMtF50e2d7/IMw0hVho6EHE+UfkBthlfCx1W9muYQgyOLLyseDFGoN7s+
         i7zJhAbV7Fv9SnbtOwnkMIBHQOlNkVq4O1JBBbBJqSq6OUzh2BkXz60v0kK2gN03hMxC
         TdKmZAy9TeC/zwGZ4TF3wrKadxKvcHagDmGAAKhJ/zTrdn8xDAt/VdmBog4MaQXaRAJh
         Nhhn2slHHna83bsw8a4Kyp1+L8g02eCWx3/TKAV3SZ6aaiKzZ+ewhuN5cXNciT1u3CVw
         wOzdIjCg4Fo/jOZKQYoZWCNetYrZvSr9zx+2rpVNw1yyRHld9GSRgk6xsqEWYtIcqxN/
         PP/w==
X-Forwarded-Encrypted: i=1; AKwUvBxccT0YzBKJSvcaUwqQMqb3bShJkDl56yimtT4p7a5xOB3U3FD1x+2YNI4gPh6+o5bDGqkMSx9HcA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9uZwRhflRtK7caDCWgBg4E1WJqslGn2hhtjSltVFqgWegwrB80
	cXscCUezXA8OjnK5rdfxoxpJQUexejbxPrPYwYWROsXDWcY9n6I1LWCCE2A9nAsw6xbMSrSdIIR
	Nl+PH5wVXCyzf2Rut5+HNzeKhrc+8zpOPXr/gK6+6f2dvfcIb/fgXsWhd1qGbew==
X-Gm-Gg: AYBFou2ES0Xm8hzl9qvA7Bg7JF31PFHAir2LT1TWqOoJvoe6OPec+zR3MpMIo/cOCCg
	RBkkx/TKx9o6/lNA8aJ7LifkwVSdVk5dvzmglvtoPrRsjv3MtX1154T+gzKczZOp7ZaNIyiC8dD
	yZASuXYh3P1f9vsA0VuOuD/PbHBKJbLmUezqXmbOm6TGwf+/Z8t3OvNKHpwptesu12NxDt/7pdw
	dkqwxnAdj64QrStL96Rs799wBqhUGhmE8XZHtn9ASXRNymlZIH1HhCeoFYn5gC5a8B0DM0lTnCr
	+RWkPyXo/ieuMYRlTW2s8LHu1Hqs5Uvq009OT44Ge646RN+EGZl+KQ8WFvWQu2zTGW4/98tJsoM
	mMVVYmIN7XxkroFAHYSQ/+5CktV43KI8EOqfxPP7KiO6F1CkrnEv5IEOWDQ==
X-Received: by 2002:a05:6102:5487:b0:7c1:75c5:c4c with SMTP id ada2fe7eead31-7d072605206mr2815186137.25.1793619688653;
        Mon, 02 Nov 2026 03:41:28 -0800 (PST)
X-Received: by 2002:a05:6102:5487:b0:7c1:75c5:c4c with SMTP id ada2fe7eead31-7d072605206mr2815175137.25.1793619687806;
        Mon, 02 Nov 2026 03:41:27 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d511sm19275953f8f.8.2026.11.02.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:41:27 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 13:41:17 +0200
Subject: [PATCH] power: supply: qcom_battmgr: Fix pmic_glink client
 use-after-free on unbind
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-battmgr-client-teardown-uaf-v1-1-972fc5a5e0c9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANx26GoC/yXMMQ7CMAwAwK9UnrHUhMDAVxBD6jjFCFLkuAWp6
 t8JMN5yK1RW4QqnbgXlRapMpcHtOqBrLCOjpGbwvT8613scotljVKS7cDE0jpqmV8E5ZsyHvc+
 JQiAK0Iancpb3bz9f/q7zcGOybwnb9gFbkk3sfwAAAA==
X-Change-ID: 20261102-battmgr-client-teardown-uaf-f532fdc44cc4
To: Sebastian Reichel <sre@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4946;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=x4fAiWwCWzADg3m0fRd4Wwzu9DytOUqrL7kGuWcpYQQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6Hbleob7tW6ZrMlRVyafq9Zo2qBIBRsM3WdQH
 +kJcv40kJCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCauh25QAKCRAbX0TJAJUV
 VlFpD/414DQ0ZY+4lpuTbLvFvdOUtv1fxWzc8zIF3CvpB2iQHchcbcLUDWmXA3LkmVOgWYqPtKA
 iJJTfht9oYaFJ7bKqbLKCcY0Mi2KPGxfvLW0wEvtFMBzZDT7lbG0c3ldAKIkmxa/ZuxSrdpXdAS
 9JsFRnzxfn0t6k/rRs+3jAGzTbmH3tdtozTzWJflktYMx74Mj1I1dmKcKYHI5FvfxK9qwt8gDQg
 HQzZxteuhyQ3cOKEpB9ZowIopN1B21XXSLqusz3pD3xOjOzXqJABlxN7YCMhUr0/YxSK8yfydZs
 DezFnJhgYZ20y6uS7heAY8aQQp/IOR2Ob7s3BjogGYaZhPf/0LeG5v/VIwu8rt5EcGeR6xC030J
 UrVhqHEK4ls3/D/u7fvE732ltK3r/SvfOitB+dpIVSXbYr9o9SpQqstE4akBDwrCtkcXIDK4OtY
 T2Mm4cWFjrhP2f3KK55IZL+yYCaMboNeaPwkG5nJm3Z/aiAqI/fuk2B/Jm27owzE1uazXgGCCpz
 ln/ZLWtm2/RebgxP9F94eKP655xBD6YncNnOgJS5P54zPCqBnNbUEuu5/H7s3HAvS4M+aq+hFty
 O+gj3T5UWzmZouOL5ocpJVf0nujT8f/ygirJYAAvuWBTq0k6yUCc2JD0ZP5WUn9obSoOA86xpJs
 OMeR84AMnxg9BzA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae876e9 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ehDivE5OXch7XbvYWcoA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX0m1v+k+MCHzO
 3fJkj5UO/JzhQHKtXUyM7r0v3+xlTygFKgwDWb3Wjt0fQDHjAICFuU3U/mnihqsDtfTZ6ouyRtC
 g7SKmI0IiO/rmg7bKOg8BrI4r62wBfPscQ2aVGrK9FpFJ2VxCZNjO4WKn/LsiZbHh5xqRQvzSg/
 KXTuWOvN/zXKOmMDw5tatcxmHmHWW39wliTgCJsguJ+DMQ0gvczr/pJVIwElYZNZwMBuAztN667
 bsmpxjYwcSkzj7QAfad+kFt8wguyvDh7HzNi88iVDehfl5WmOCue+wTNJ9gcL7EmQGR/Z/sEM5R
 LnOe0RGCvkSfjexaUu42ysa9Rgd1Cgjc0+b+IMGlk5eUB28F4K2Hf9vitbG0cjLpVJTtOwJhiuC
 xtbx3rlwSTIjsA/4lAVn95EcFaLAsHCj5jwQWbmqfP/FFtYnZQjjvb6JvVC+Ah+V+Fi4mdtQa3s
 8eus+jifmem9p6REsGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX2k+A8cke5TZG
 dA0RrwD+UjmtJdDThuXfH5bAhrgRp//1clkS+7bWdGyZoIbULvDf38K4R1RGE/u3dHWua8GjIpx
 sRvU/zTkXdIdJUBXHFMWHbimQQOCVK4=
X-Proofpoint-ORIG-GUID: qVbU2aSNZpAWK4I48MtLyNVlnS6Qt_X8
X-Proofpoint-GUID: qVbU2aSNZpAWK4I48MtLyNVlnS6Qt_X8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020046

Since commit 4e40befedfc8 ("power: supply: qcom_battmgr: fix
use-after-free"), enable_work is cancelled by a devres action registered
before the pmic_glink client, so that on unbind the client is released
first and can no longer requeue it. But a worker that is pending or
running at that point still goes on to use the released client in
pmic_glink_send().

The power supplies have the same problem: they are registered before
the client too, so they are unregistered only after it is released,
and a property access in between sends a request through the freed
client.

Fix both with a devres action registered right after the client is
allocated, which runs first on unbind. It disables enable_work using
disable_work_sync(), which waits for a running worker and turns any
later queueing from the client callbacks into a no-op, and then marks
the client as gone under the lock that serializes the requests, so the
power supplies fail any later request with -ENODEV instead of using it.

Fixes: 4e40befedfc8 ("power: supply: qcom_battmgr: fix use-after-free")
Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org # 6.10
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Found while fixing the same class of issue in pmic_glink_altmode. This
completes commit 4e40befedfc8 ("power: supply: qcom_battmgr: fix
use-after-free"), which closed the requeueing of enable_work but left
the client in use after it is released.

Prepared with help from an LLM-based assistant.
---
 drivers/power/supply/qcom_battmgr.c | 39 +++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 636d6f6acecc..b37b2f665f7f 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -5,7 +5,6 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/auxiliary_bus.h>
-#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
@@ -339,6 +338,9 @@ struct qcom_battmgr {
 	 * firmware, as it then stops responding.
 	 */
 	struct mutex lock;
+
+	/* Set under @lock once @client is about to be released */
+	bool client_gone;
 };
 
 static int qcom_battmgr_request(struct qcom_battmgr *battmgr, void *data, size_t len)
@@ -346,6 +348,13 @@ static int qcom_battmgr_request(struct qcom_battmgr *battmgr, void *data, size_t
 	unsigned long left;
 	int ret;
 
+	/*
+	 * Callers hold @lock, except enable_work, which is disabled before
+	 * client_gone is set.
+	 */
+	if (battmgr->client_gone)
+		return -ENODEV;
+
 	reinit_completion(&battmgr->ack);
 
 	battmgr->error = 0;
@@ -1626,6 +1635,17 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 		dev_err(battmgr->dev, "failed to request power notifications\n");
 }
 
+static void qcom_battmgr_release_client(void *data)
+{
+	struct qcom_battmgr *battmgr = data;
+
+	disable_work_sync(&battmgr->enable_work);
+
+	mutex_lock(&battmgr->lock);
+	battmgr->client_gone = true;
+	mutex_unlock(&battmgr->lock);
+}
+
 static void qcom_battmgr_pdr_notify(void *priv, int state)
 {
 	struct qcom_battmgr *battmgr = priv;
@@ -1676,6 +1696,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
 	psy_cfg_supply.num_supplicants = 1;
 
+	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
 	mutex_init(&battmgr->lock);
 	init_completion(&battmgr->ack);
 
@@ -1738,11 +1759,6 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 					     "failed to register wireless charing power supply\n");
 	}
 
-	ret = devm_work_autocancel(dev, &battmgr->enable_work,
-				   qcom_battmgr_enable_worker);
-	if (ret)
-		return ret;
-
 	battmgr->client = devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_BATTMGR,
 						       qcom_battmgr_callback,
 						       qcom_battmgr_pdr_notify,
@@ -1750,6 +1766,17 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	if (IS_ERR(battmgr->client))
 		return PTR_ERR(battmgr->client);
 
+	/*
+	 * Registered after the client, so that on unbind it runs before the
+	 * client is released. The client callbacks may fire until then, so
+	 * disable rather than cancel enable_work to keep it from being
+	 * requeued, and stop the power supplies, which are unregistered only
+	 * after the client is gone, from using it.
+	 */
+	ret = devm_add_action_or_reset(dev, qcom_battmgr_release_client, battmgr);
+	if (ret)
+		return ret;
+
 	pmic_glink_client_register(battmgr->client);
 
 	return 0;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-battmgr-client-teardown-uaf-f532fdc44cc4

Best regards,
--  

Abel


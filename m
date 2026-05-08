Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B4372EDB
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263524; cv=none; b=YgPvldCRTsP2Gn6CofRPatC5xho73Sqp6i5kR02YiiF6EDY9JKgDNjm1gvvjfzSwG9ShcGJ1gU1IGl+p1v75saQ7n+stSzkF/OsAZfZKRpMFaKxHB3ZIxyMpoXXg5mR4RwPBx51LBLiyGqeSzxzGXqnsRaJTHb/cl4zHjQcRkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263524; c=relaxed/simple;
	bh=kAMQAL6wkuF+CX8MvwA7YeSoJb0iZkveDB5XcPOzhng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYEA7dA65ZdX7NXR2laoHPK6hEnB/JC3lFnPvesSS8HlD/eVYou6zazBFs/0dIZbgnHUPnWPqtmZV0NCuKhHcjAJNhFhcljVNG2/dfV9nXAkKEyyzKHGh7OXDZPAIaTqVmiX0UGEEP3gQYv7LvLL16I+0XtwWY6/mnXRqzWZN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NdNxme8Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+NFJ31o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NdNxme8Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+NFJ31o"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G50NN1116707
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 18:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lhCBH35y9J/
	zYddDzCgtrQotABln3FGxqD0H8+Q4LkA=; b=NdNxme8QVfziCHoIttBzSYFQezL
	eLcQA0qv9Y6wFYLM82gnUgicuqj8SCsvzLlzNUTfkZei6cDI6BZm46jnK/7/aJnd
	ORbLzGtMoCiCLK0n7aVG41nf9/089R62JQ2prZfwMghqah3z7Y2QGbT4PgS91hhP
	bs93JAl+37NR+4mqBvj0Od8XQwLgXan3Sz+QbvcEOAnYy2qIP4+RyIY2UI8ssOOq
	GXjgS9AVz/CsvLr9COBOaz0kT5O/fqrad1LixqZ/VSzcf4LYR6tiQEGvi199kJ9f
	KqBfPB/5JdiRDGmOgx2dbZ+bx4b7Bm0LrcOOw5xHwl3gJfsmLhlxomwmmiQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1pgdj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 18:05:22 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-62f471aa288so3181748137.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778263521; x=1778868321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhCBH35y9J/zYddDzCgtrQotABln3FGxqD0H8+Q4LkA=;
        b=f+NFJ31oMX02pc0tFLdjhR7HzX8DklZOWG+Ky/4DTNyq+b0jHPeoquS//xnd6u25xf
         yeRG3b8/AW8eOZoTfJ7Eh7wwvGf8RhjVcYMPiF3NlXmSZwSdxtLzaIWoZ9oHig1FGbSP
         /zA8NePSL9Bw0kApUVygxd2VYS3X014axDqSbzhlWgy6QAyZZpbq5wagmAaOPct1avCm
         M5eTAe+MR5B26JEPadpsjv4ydfV9RD6lK/dq5F7H8G2t21xT+dgSKgn+h57GCU008o2L
         g4pmszI6lgA/VZ3HG4AF77FfYmzmQKmreTXvOUa/sqZTCeNOb/cIcY988OznLAsZr/29
         VMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263521; x=1778868321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhCBH35y9J/zYddDzCgtrQotABln3FGxqD0H8+Q4LkA=;
        b=fm/bBBwZmWc4Dl0qK/8XMOG6c0m0ZTGkzfiKb6BBshGGsFpKD9LbaQ99hFyLLRu1GU
         Ip77hRuj9MJ9oAEPB+AJzb7TTLtDJHM3TGwXGZX3nTwL+ulUyhM1gUK4xm095+dwwVIL
         QGHz+VqhetKpwr4JfSPlaiK+TAHJMDQjAyCca2/0eQwUxeWMiSdKcSQQUlqSLrL9pVq2
         P14KIAI/wV5hsmi/yixC3wl9SffTknitS1iS+on6tghzdiP+qwt1kHGnUQ6z3xBExscH
         o0XKorBTEu7FChgDtemDM/JeqV5zJ20qs7NEEe1/pho4YOOFgSh/AoNTGmOsPx5RwWuF
         qkmw==
X-Forwarded-Encrypted: i=1; AFNElJ+4Q3RYpbLDbCPYp6nXvYrGabR/j3Cavgb9KNdlR15f7lzeNmtGr8+Ah5zdgs3C5rCLYUbsC8moFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVFhc6Gy/An6eogLT8s6lnDY3lQ4GPbH2sFROUKe4t39gdECv
	GXTlNQgMd0tiC8fQL8jSgH4RkRIhLzZzObWxkIwvyflQFC1aH0t6bL8TAkhCO3MbGAncMYEDX3P
	MCTR2obYGALJXVxbAUn7ABBnvMeK3p1N/1loR3Ek3C+kOm5rMCHDSF76Y8Y/iSw==
X-Gm-Gg: Acq92OEINIS1jWzILQVBtQ8F72YJJ99VUhMBVNAk47Q97PNJgfSWAm1xCpxHTOzPmn4
	cVj8io13x1yF4BcbDOkd+jQCAUbNtesDS56ThzbMHcjJ+HEMhU5t5L1Aq7ZHfcKMo4/ZZueHeoB
	Vq6iDdPGvOxQ7CNLdBN3X/MHkXK9FqDkBvuywgn150XFqSJUcCdUryRofD8yR6qcJSqjBMeyqBv
	ti0S6EOFg+SN6zRhPu+y+rpxAGb5AEaaU/h8KAopbZI/dkB9UI64O0TigXWA0PeyEd5PSSIGBvT
	JaXID3hZmu0Dzdt6HiTm4nkWtseqvx89xD/S7k13UB4RZAJsPRhmeQ/PiLmUT3Ua+C8Z4WXpIww
	+LXKLqa7LnnBkQ34PaThGsEVc3PVj1AMGyRTOWi/5Pjqsotgd/g==
X-Received: by 2002:a67:e70b:0:b0:631:8665:350e with SMTP id ada2fe7eead31-63186654a0dmr534046137.30.1778263521009;
        Fri, 08 May 2026 11:05:21 -0700 (PDT)
X-Received: by 2002:a67:e70b:0:b0:631:8665:350e with SMTP id ada2fe7eead31-63186654a0dmr533985137.30.1778263520466;
        Fri, 08 May 2026 11:05:20 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd32afasm11654825e9.5.2026.05.08.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:05:19 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, lukasz.luba@arm.com, rafael@kernel.org
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] thermal/core: Use the thermal class pointer as init guard
Date: Fri,  8 May 2026 20:05:11 +0200
Message-ID: <20260508180511.1306659-5-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fH9sKsQCBLIEU9EUvQDg9kRenzSG21uH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4MCBTYWx0ZWRfX87E6wCiILpTF
 ub0eVBTgmN11nqk2BuVSiR/KZKYAWN9yC+q/JHrznxLMcWAROJz56B3ytwXC/y0I71KhvD90J52
 FtD2kOjOyvaWTR3MXNK/w+sbPwK9+Uhl3WaWnHLShIjWfIEvqaKkS/sbTiKMM9j0Li+uNawVNP8
 jWG1vH0fOENzvxHOg++BrlI6dlYk8DYZQ1UoL3QnJUMYQu9ATgSAvvBS6yl82nSzprahvXCGkvH
 dJOtlNlm1YLNvK/gBhf/AJr3OnU0ujhrHTCHw+4lsBcqCHfyrCE/Vg5SfIedCsK9QIM8Po/7jYk
 WNmkqj+dKi3miF2vXbGwXdw17+G+p9mbOBRLX14/Y/g1tygn/M7plWrFr2WVhl5sxdI6NAej79c
 GYNhaE364b2wkkJgeSsUUC0+i4WOtERKO2YT9+sV1vf+grK1KH2tmr/QYZGOXR12kFdVta2/yI6
 I3rKokt3q4zgoCmkMlA==
X-Authority-Analysis: v=2.4 cv=COwamxrD c=1 sm=1 tr=0 ts=69fe25e2 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=2kgeJGiveZr2WTZnyR8A:9
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: fH9sKsQCBLIEU9EUvQDg9kRenzSG21uH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080180

The thermal class is now dynamically allocated and stored as a
pointer.

Use the thermal_class pointer itself to check whether the thermal
class has been created instead of keeping a separate
thermal_class_unavailable flag.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 748ab76823a3..81f6bbaded65 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -950,7 +950,6 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 }
 
 static struct class *thermal_class;
-static bool thermal_class_unavailable __ro_after_init = true;
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
@@ -1053,7 +1052,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	if (thermal_class_unavailable)
+	if (!thermal_class)
 		return ERR_PTR(-ENODEV);
 
 	cdev = kzalloc_obj(*cdev);
@@ -1536,7 +1535,7 @@ thermal_zone_device_register_with_trips(const char *type,
 	if (polling_delay && passive_delay > polling_delay)
 		return ERR_PTR(-EINVAL);
 
-	if (thermal_class_unavailable)
+	if (!thermal_class)
 		return ERR_PTR(-ENODEV);
 
 	tz = kzalloc_flex(*tz, trips, num_trips);
@@ -1834,7 +1833,7 @@ static void __thermal_pm_prepare(void)
 
 void thermal_pm_prepare(void)
 {
-	if (thermal_class_unavailable)
+	if (!thermal_class)
 		return;
 
 	__thermal_pm_prepare();
@@ -1865,7 +1864,7 @@ void thermal_pm_complete(void)
 {
 	struct thermal_zone_device *tz;
 
-	if (thermal_class_unavailable)
+	if (!thermal_class)
 		return;
 
 	guard(mutex)(&thermal_list_lock);
@@ -1902,8 +1901,6 @@ static int __init thermal_init(void)
 		goto unregister_governors;
 	}
 
-	thermal_class_unavailable = false;
-
 	return 0;
 
 unregister_governors:
-- 
2.43.0


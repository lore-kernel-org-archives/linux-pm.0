Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19536F433
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263522; cv=none; b=IY/rj/L9ZwTZ9cU0jFbiKl08UHp5M81c9aqdqwknqC3OtwxtSW0aQrg14ho47JHBjm3Sa9aVVEZ6UXgVd9ICqG5TZ/yg0/MsIGC0XUr6Hw/5WwrokWE3x3GABMtrGW9RK07CvAI53k/Jx5kU3sj1Ly1LFcwWEatkEeR8zVwb6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263522; c=relaxed/simple;
	bh=Llpuo7ptAkoG1U7XPGvqcjBxPcBuKxYKyRljn2+GScw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7icAho7Fumrf7IFeb8PysAfyGhz+xZxT2ck/UsUWuYyIgK+JAsv7l4y144ckUP14/e02dVI94XuZdHPnlu0FlLTiGEzjtsbdpPRc+LlZ5e5mxRV9FKEWK4c8Y3cpfKgdzQgRG/kFfvx20lMHAXo+t9TqSEfp8hA9I+VnRTKqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NW0DDFRN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwBUmDVU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NW0DDFRN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwBUmDVU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G50NM1116707
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 18:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bwHWFphaJiJ
	LzQOfhxubcUS0JiF4OejVKSh/+aqeLSo=; b=NW0DDFRN1gJ1PWlk3nP7HBsE6/q
	XPYTnKWjZrrPpCZ9ii6+uJS74SSFiJWR+IzjcaIi8j6wJqRdvPpwM+yA82TevPtx
	otCZehqoqiKjm8/Bw5QgNnRKAIUAwZuHpmndou8OqMtZtLgti+c/XLeH7BUoS1bl
	oZfOSye9pZYqC02vmxR2jvvNLmpFsRYKmXdwAOOHg/Qghl4OHT2CMpE0fTWl7Dtf
	qRdoEtkfhWFtNhv7BxXuDbeh0AGjWRUTS+UJy27JXC6DyJIYZZIDpdqaIqE9xDbs
	PoHYHoVd9mShFjmwcmgNZBe+pMrE078eIah/XmIDiRPY7zghjvtOJk6as8Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1pgdj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 18:05:20 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-62f30279e90so2148284137.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778263520; x=1778868320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwHWFphaJiJLzQOfhxubcUS0JiF4OejVKSh/+aqeLSo=;
        b=iwBUmDVU9z+8ZUwq15rSw7iEejG8A5+Mk1clsPMlxNPMus68u4gG3PByUSrgwAekvK
         E9/kn3lE9Y+N2TGAqO5+Z6KkgaUSINMW9d6CqgLCvHJvZwIlo5pKn5jUICEGT+szY0uP
         MLVP+mLe6EoDAfQFhADdiAo+vPu8eFz4aBIjCMgkjIaddNz3GZuy5fgOkNEN6DuQm0Oa
         rqM/JRphKOuM50kF55Z5aOx9Rz8GzkESLdmQfwps/+/TfBpVdSuV1r9/OkwV7fTpixtj
         SuSXykoT3mzKdSOGb8Qpcw21Bx3JDzTNkxm77GzMRYCn9kK/f1jBRN1/hqLOsBMoXZuj
         12hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263520; x=1778868320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bwHWFphaJiJLzQOfhxubcUS0JiF4OejVKSh/+aqeLSo=;
        b=rcuoHPIQhiQwKAsoTw8FNLzEeCugcCRwo8S2n3SNxt77fFal/TTA09cGE+M0pB2nVR
         AA+toJ1hRYViHd24zdo4o9gRI7GX9jxJNLeYFmDkOC1mq8+bDABNs/cQeIa8uol5q3xO
         iZ339wKMutR7mhrTHI2VJs89eatTetj5HlL/FTD9OUxAvBdXAUJUoVB0/AhZsKM1dD9w
         m+1RQBPScft3Es+MwMquBs4ddXkqVZJ/OSJiittcrdPUvSC/3Z+YRegTsWSAjHfpC2NU
         KVPW1RtVPSVEmIKvFDN43w0TNvpdxStR4qmwdPtY+PUTCL6GTS2232XdH692ypNN8/Fw
         JXWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9G3fxD/2v9MmL/RbcHk/av/3nXapRR5D12VgGcUllOArJsygkFxSgJ6kbgGacTekUnw2snxz4Drw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fn2q5XbHmVgtBVmFCW3QHEiiKFUGzcW7KSt3zn5kAutdcTxT
	inE85uRFEKxW7iDU2YDu8PjOMZ5wnsGzaHWcyKHR6lCJ5uLQXeaGhGItBa+Zbejf8X68FI6eqPK
	fR1A8vMW/DkeYGEZp7DqL5TX6PbRvAm/zxA04x4BTSUmnLfVq1ighdecHQ6h0QA==
X-Gm-Gg: Acq92OFPyeoMCLuP2pNeQaWbEr5B3NLodiB4fNuaNCrlT2uyBOSMPMvrIWWg9WF3KfI
	iYXw2SceTC5O9j3swBT5dm4XspVrcEsBAIbT4CF5DhZMkndzLq/wXbdvTqeQ/uWkA4TJhvQlj9G
	uQaUvFRhZfomgAMNbjhZ/Ev9jgit5iE5SIEWg5m0jpI7u+ZYp4T7eE30RC0uP3zn/cOBkyCh7R6
	Uc//LbqfWM0QvlqQ9AQYtCyzvUuqfGLj18qur+ZSY235saByGTEoBspFBGx2HXCNwXYB+UiN4bJ
	Wtwtwqb2TXVR/5ozY+0kDMvjwLieKwkQI5dWheZkpS+8vO/aFnpuXkRMdSN979HvsJJjV9h3L54
	g9dMoTj185aR5RYVcU+wvoHEcp4vz1C3/LC6y/ZwHI4ti/qMns/PvWS9CZEdp
X-Received: by 2002:a05:6102:dd0:b0:622:702c:fd3f with SMTP id ada2fe7eead31-6313eb02d16mr1824529137.21.1778263519740;
        Fri, 08 May 2026 11:05:19 -0700 (PDT)
X-Received: by 2002:a05:6102:dd0:b0:622:702c:fd3f with SMTP id ada2fe7eead31-6313eb02d16mr1824481137.21.1778263519303;
        Fri, 08 May 2026 11:05:19 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd32afasm11654825e9.5.2026.05.08.11.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:05:18 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, lukasz.luba@arm.com, rafael@kernel.org
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] thermal/core: Allocate the thermal class dynamically
Date: Fri,  8 May 2026 20:05:10 +0200
Message-ID: <20260508180511.1306659-4-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-GUID: DI2NuA5qw415kPZM6bV_RNlkSPPmtV2d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4MCBTYWx0ZWRfXxSxT0DlymKVT
 /j7yCeS30vRmYlOxIjPiJDSFUJqTACMM/eOYLNm01SDWHe3oDukf4OGQHs6lsl8heZtvRVq64bh
 Bm4l65tnjziVfDzzNVjs/mR2BOGQEMqpycttki6keOFSDhemCRLsyUKZTPfrtCWodYnRiDnQmx9
 aJwWa9XXrc2LNmH04w8Pq+ULNBSQDlEk/RlDyQTuHWwmMEJf0gDUJgYLFdvujH1AaEZwKNja44n
 Cfz5aJi6dnsP9cSk7Unk/zJZFfiVRvmQAQeMIh5bHvByT46jr/7W33xWKrOuIyom4tSclSQrWTK
 WDJsqud0twL3gFbUFth9tPxwzN+06ycfy88EG/vSx1IC7dpgQZOQF0s4yuNAUDmUF9ll0J1Omzl
 dR12D89owIBgnuMnNun4Tr8zN+/wepRPDs0xuMscFkcAwOLc2rn8t18xiG2e71XGwLc4oEV0q9j
 HKbNgmzeWhr/QFUPcuA==
X-Authority-Analysis: v=2.4 cv=COwamxrD c=1 sm=1 tr=0 ts=69fe25e0 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=_90HsjT7k80V3hT8LC8A:9
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: DI2NuA5qw415kPZM6bV_RNlkSPPmtV2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080180

Use class_create() instead of a statically allocated struct class.

This allows the thermal class to be managed through a dynamically
allocated class object and avoids keeping a static class instance
around.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a79fc4cdb078..748ab76823a3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -949,9 +949,7 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 	kfree(pos);
 }
 
-static const struct class thermal_class = {
-	.name = "thermal",
-};
+static struct class *thermal_class;
 static bool thermal_class_unavailable __ro_after_init = true;
 
 static inline
@@ -1078,7 +1076,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
-	cdev->device.class = &thermal_class;
+	cdev->device.class = thermal_class;
 	cdev->device.release = thermal_cdev_release;
 	cdev->devdata = devdata;
 
@@ -1574,7 +1572,7 @@ thermal_zone_device_register_with_trips(const char *type,
 	if (!tz->ops.critical)
 		tz->ops.critical = thermal_zone_device_critical;
 
-	tz->device.class = &thermal_class;
+	tz->device.class = thermal_class;
 	tz->device.release = thermal_zone_device_release;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
@@ -1898,15 +1896,18 @@ static int __init thermal_init(void)
 	if (result)
 		goto destroy_workqueue;
 
-	result = class_register(&thermal_class);
-	if (result)
+	thermal_class = class_create("thermal");
+	if (IS_ERR(thermal_class)) {
+		result = PTR_ERR(thermal_class);
 		goto unregister_governors;
+	}
 
 	thermal_class_unavailable = false;
 
 	return 0;
 
 unregister_governors:
+	thermal_class = NULL;
 	thermal_unregister_governors();
 destroy_workqueue:
 	destroy_workqueue(thermal_wq);
-- 
2.43.0


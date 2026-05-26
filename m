Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976623BB136
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790748; cv=none; b=qoVP/FFCdl4FzPWT2+8Jmg4XQn2Z6h2rZNSDJ5tQmZ6F1k5Vm2VQs+00f2RUqocHCUkHT+5bJbSuhlUaOBy2z+0KQ7+GUO4F0T+UwAl2jAShuBLlia7zilud+bKCaHD4QbR7oLnVAbev4MGnIwMviteB6ZqlmBN1KX3GrEq0DL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790748; c=relaxed/simple;
	bh=3PRqDBzu6gwg3vTreiFL4gFGbUN01PFKN5S0Cr+LoL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZH4Mk7OArxgg7buWNFb0lYwpzTXtngvHgYYi4SJl36I1CkF18d6pzeJXO59BghjXeWHl9LoThE134K1ECXRqSVotZKpivIQ9iMV6zxubrjQutXlBo96twcORqqsHxRQYbSStw9vlsxCYDULJInX6tPaT5OPMr1HD+QBv0YoC0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CIBGT111; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DbQy02yn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CIBGT111";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbQy02yn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q6Un4a3263552
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rji4xxWneb24wn8bv5LJ/Y
	er4lrNtS6+L3//4OB/NzA=; b=CIBGT1115nSYnL12B32ab/pAnnyXAzaOLQENhm
	5wQFRbC6qtI9iDaNAoTL3MwqQr9ns53q25dEyOUHqhD19PZTNx7HR1e2sL5cAz0G
	Cff4BPImoNszAPbLd388XxrveZKNhDN++zlMAAN+LrcumZe1E7yEZpJeJLmv24Kj
	maDeAVEILbXu9nbtQRoC8kXqnuYCSOQtDKVKfGxgTLnhbmNQOEMVyVVXNjcO2PPQ
	WTYllcQcLzIyvVBEFKt8H6ALVfr2H+L+BQvlOSlljPDjmlwoy7gZY2JNpbJzSkIl
	AJ42svSt+IdjNFAb6ZDwNEk/n4PfiH+oYAb8ikv/3+gULUwA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs3x04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:19:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba3245a43dso115959215ad.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779790744; x=1780395544; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rji4xxWneb24wn8bv5LJ/Yer4lrNtS6+L3//4OB/NzA=;
        b=DbQy02ynusu4ve8K9FfzCcWRUdly4FInB9W1NBhoPT3hLkz44vFR4PrpLEkzcWqicw
         fvn1uYdZlZj0IRiROoofH1oxiOwsRfVbm7IfXHjvMl8jLkTsfpEgNjh51z9tlj7cIP+f
         5uHQ6F2uBK55uuyB4k2KNffJNsdMaSvsrcbfYW1Q9oa52MwFbWIszdyaglqV3kE6PgcD
         tOZWXPzfUH4sEifXVwQrRermyL6Z8NbHFwh34IiiHeuna1QEYWWOn357fUqUlqj3WI9O
         NJWlMTJ2Zd47S20SfIXOrICtZYZsSCF5fdc8le+fQx6Oe0bGlImVNZANtnzRcPlYTxBi
         PTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790744; x=1780395544;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rji4xxWneb24wn8bv5LJ/Yer4lrNtS6+L3//4OB/NzA=;
        b=O69ZLM8no0R2Rgq+5/Iyy3ZTMpl2z7BvXUSVW2Mr2KgYuHMo9YkBsgqg7t0503NlYV
         ShdnFT4/QzsqhIF6xNsbTZQiFQ2vvKEckKUh71mRqBOwPLcTOa64fW6pRLwtLgd39NuU
         4T4/lhctx4DZo2fmbnSIK34yzZTOPGankI4MDDO8ik0t2HH52vunxaGynW4eaO1hIiI8
         zoWnkuqKjajmCLti58q9Q0uRfUdeKF4V8/+iXAY3L+wq2j1adtuuLQlIeMOKo05dq7QR
         gtudhnE0fVmlY1VFcRVwqyZEBru3hoFXSTbCK0zf17kuvK+6XJamGXAT+4wTZ7OZZ/CZ
         gRxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pTjpYfz0tgPNCmWgZ2+tiS+Ze97rFHuVsmylTBWdYyP9SZfalMiGB318AuhpCbxhTDiANG3WoFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxctVvM+qkaJoN3Ef7Pb6Jra1DEROvP6z8R4fltFBibebCE/wRO
	wSc5u1ICkiOLwl/xr6ChXFyVfqueB1qZqHroMK19rvd8N25C+QBuc+WB1SSCcAPKy8pB7GCL8rB
	XD4XlzM3uDixxh6gll5+A0nUJtvNsEoa8unitZrs5OiIsz43MVj5ZulAAriiL0A==
X-Gm-Gg: Acq92OHldez46AZAEU+LzrBG6rLay5mCTAhJWEqK8zYG2r91+Ta2vtWgojQRjwrVCct
	kY/CoXKWJ22v5vOlWgehIR7UV5Yd+yEIJYUPsEzpngVlfHM27Y4K8aAXZD+AFXlvtUDZSiJYB2G
	Qrc9ZuDv2h7/NRpYOJp+x0BG5GhV0NFeYIc4TLNOXoeDxlN5Bsr8bwtj/OU0JQX3YqgRXSX3DV7
	Dw+xP3nGPrvZ3U8WNe8QHYjs51d0l8PoGwRZXGLHVnXbmDwIwTxzA1ebOsK+o9GPZ/Mj2VD4vKf
	AhT2MenQXF5N+6ZsBjoYIhXAJ+aTOOxOyJ+pUeEGb4Y+mwiQy0P9amZIM589jJ9bggLDFi3GhJB
	/7TYFnMohr0L6khPA3Yub1NPSHCM5k/WPrSPlokTgpNhlY+3biPgXiB4=
X-Received: by 2002:a17:903:3c2d:b0:2b2:42b1:adac with SMTP id d9443c01a7336-2beb031af0bmr185779575ad.3.1779790744432;
        Tue, 26 May 2026 03:19:04 -0700 (PDT)
X-Received: by 2002:a17:903:3c2d:b0:2b2:42b1:adac with SMTP id d9443c01a7336-2beb031af0bmr185779265ad.3.1779790743905;
        Tue, 26 May 2026 03:19:03 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm159941105ad.36.2026.05.26.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:19:03 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: [PATCH 0/2] thermal: qcom: tsens: refine wake IRQ handling for
 suspend
Date: Tue, 26 May 2026 15:48:35 +0530
Message-Id: <20260526-tsens_interrupt_wake_control-v1-0-6adcd75555b9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHtzFWoC/yXMUQrCMAwA0KuMfFvoCqvTq4iUtYsalXQk3RTG7
 m7Vz/fzVlAUQoVjs4LgQkqZK9pdA+k28BUNjdXgrPO2c94URdZAXFBknkp4DQ8MKXOR/DS2j7i
 Pve8O7Qi1mAQv9P71p/PfOsc7pvI9Yds+MJQrS4AAAAA=
X-Change-ID: 20260526-tsens_interrupt_wake_control-08be7b86591d
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779790740; l=1373;
 i=priyansh.jain@oss.qualcomm.com; s=20260515; h=from:subject:message-id;
 bh=3PRqDBzu6gwg3vTreiFL4gFGbUN01PFKN5S0Cr+LoL0=;
 b=tVB31x8VVRsR5cpVeyvy4Xcc00EREhvd9rXPce3t/+sJ8wRg8YZlTLDg9DT50jsZEwhVYUvi3
 O0LhnideJptAPEgfAICpNu5zMOs1Y/CNKUzgePU1gZexmzuwB9RPvxL
X-Developer-Key: i=priyansh.jain@oss.qualcomm.com; a=ed25519;
 pk=xe57jjgIoTuNHN/Dp00kZl1mAJjmROaH7JV9sRxEoEQ=
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a157399 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=O3d7Xy5pjfPrWY6nMl0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 4e4WdQ5zz_OiU8uvb5PBlDxcDWQes-vh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA4OCBTYWx0ZWRfXxX1+C32z6PBO
 nNI8oo2vzAszSdnK+d9/beevJsKxGH5Z51MhF8RrcuubTVgC46KyLpptOFF0MSxOIsaJv2BSc8D
 pwZMpUNRsqCeazp+cCHa6jKA5WNj+ns3tzznesmBTqoP7yVUY2t0WjLjTl/8QO90ZgDASaFj066
 TADdlKzhi5IxUBi7EZ1pKkirG9hpNq37mcu0e2Vk6rYa7dJOeBg0PapRcg+ZV0P+jo+dxMi7+A5
 2ETxrWTeYeDEHyyGQQygr14W4s5fRDRfv//nvLXOlSJREVqFDbiAl0mATUUOwx5x8t+J1sBMHsW
 bdVeIQJXFZlQluv9AP98DIntavpVLcuX9BaHNoux3OQe6JH+LJu2N+ZHVdzI8KVsKoHVVd3Ieno
 deAG4+z5Ik3fWwdezb8v4xanFAXQmi2MAMq5iEl2YhxkZ+B9Fs/Bw2qIrPy4bqnQGaixtqDEoac
 NQUDy9/bfB9L2vA3g3w==
X-Proofpoint-ORIG-GUID: 4e4WdQ5zz_OiU8uvb5PBlDxcDWQes-vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260088

This series refines how TSENS threshold IRQs are used as wake sources
across suspend/resume.

Patch 1 moves IRQ wake control from registration time into PM callbacks,
so wakeup configuration follows the actual suspend state instead of being
left enabled during normal runtime.

Patch 2 adds a platform-data opt-out for wake IRQ setup and uses it for
automotive TSENS compatibles (SA8775P/SA8255P), where parking suspend
should not be exited repeatedly due to TSENS threshold wake events.

Series highlights:
- store and manage TSENS IRQ wake state in suspend/resume paths
- keep existing runtime monitoring behavior unchanged
- disable TSENS wake IRQ setup for selected automotive targets

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
---
Priyansh Jain (2):
      thermal: qcom: tsens: switch wake IRQ handling to PM callbacks
      thermal: qcom: tsens: Disable wakeup interrupt setup on automotive targets

 drivers/thermal/qcom/tsens-v2.c |  9 ++++-
 drivers/thermal/qcom/tsens.c    | 78 ++++++++++++++++++++++++++++++++++-------
 drivers/thermal/qcom/tsens.h    | 23 +++++++++++-
 3 files changed, 95 insertions(+), 15 deletions(-)
---
base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
change-id: 20260526-tsens_interrupt_wake_control-08be7b86591d

Best regards,
--  
Priyansh Jain <priyansh.jain@oss.qualcomm.com>


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F036B067
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527924; cv=none; b=SWUBZaQQBUSFGXkzeI+R8Vc3GhkX659AMTdK/84vL4zqJ8JgTY3YMMWuE1D6TAUcwa0DKODYTRavkcdqAPMu1IbLv3FubLtCTi0SthhqRPeyTWo80p3LBom2YMgKHdlm/YXSiY9EtVzAElGmyQbX213R7pNQ4sj2u6sikDW1nnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527924; c=relaxed/simple;
	bh=YK+n9SPQAGZB/s+aq80dow0+aYbP07f9J6el90ZDUj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8wN9+DISXqrxgE/rxQQdkVJkeg/Wk/R/g1V8lTkdfqf/ElAaKJhLe9Qi4xq35MqL/vMR2PP8GtCH6kFVm68ipFoctBUo5VuXN6IPXInk2RvbIT5ugG+XQ+j3vl9xCeBeceq2FKs0fyRzZLsRMXZtplTYpXErxyDJ/QuBagcu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqULfsmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N4JNScjT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqULfsmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4JNScjT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U3HCMo3729488
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 05:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5jn+54zDWh9rVbo8vC/YEZCMwFj3aAoKWhNMSLOUCbQ=; b=iqULfsmGpcoWnc0H
	wDWp3/fVhQrWBD/kcwS0tNpVrd+4u0RzkAtqQFUqFCjfXKebvS63Ok9EJuHAYOFV
	YKilWTknQZMYsc05pvkV+voJjOoglfyUyaHtoq96k38jBlh/JC56a6VpLSKM2P4W
	pB9BDlTdS+7U35KytGLQsoAKM3QGE2fJPCID1JUPCegnuVKe39OSUj8BVGevLvkr
	LKZ+XzAa06KcFxCm0qc1738anzxrI2q5JHLdHcbGySPR3niUhBpTnz9zfFmWNG2z
	kas4otA9wf7B8vnp8VuTtJgaVlT7QYiKMpM3xszDe5kcXy5zfs69/QTT9CtxUy+F
	r4Y3EA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duy1w8d88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 05:45:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7976ded5c5so561905a12.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 22:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777527921; x=1778132721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jn+54zDWh9rVbo8vC/YEZCMwFj3aAoKWhNMSLOUCbQ=;
        b=N4JNScjTf30vtzapJjDMN/blD3DCXcfxTKQgvHF5wjXxL7Ks5BAS1VVyJM+1zCRxVd
         NlqtdZOqlwwVmo6KbQbC0A7C1a7aF6rY33Q/6xmbeI0V71eTJ7phQzzgUzlTAlJJlP1N
         r8oUOLlvKDKHL33ugtwoQ6otcQ4PhKGQvrgZxVwDQ4p3L/sXf5oDHn4HdaJKmOvai1Jo
         kDH/DlF7iKM5wF49YQBo+GPSAGt6hxOhvt7AVfyU/WpAJe14zNmO5uPNIU/L8I0Je8d9
         4tHL7jPlcdLuhK6C3AyHF9A/Omw8KeuptFPnsc9SRZ/SYJjrWKD6qtMlXGrLZ4qKCo1u
         +ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527921; x=1778132721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5jn+54zDWh9rVbo8vC/YEZCMwFj3aAoKWhNMSLOUCbQ=;
        b=OZ1hh/KOyhZYDIU/I7J+R3VL2y8XxmPeX6W6hgllpQfVYSI78JU6SVYV5HBV4vz8x9
         /e+EZUccerRTw+qIQP4IxQkxKxVQiXbbqiScyKxgqItFxr318py/RFfGM8bNJa7ROKfa
         M4t/zUeid5r7dQ9z7n0NCBEROuUqySqnI32rwxPjE/wKuTjE88aXKSq2pfjzNL9PEgyG
         teoTfRCASer6XAK+mwGRZAPJv06ds8p/u+IXWXzAklA6DAeAAt47E0qj23lNvB98Gf8C
         CCrEppBPVRkwSOcGLd6s6h0k6/yalH5EZ13YGoJ8O5gw3CdltF+KdZlT10cm9TY6ZgRM
         5uuw==
X-Gm-Message-State: AOJu0YyV+Wgyjqn1mOKZ6vdyd45dM7dewdoxO21Q3x1OfJs80vEJp2iR
	N5wuPZbNVJldZppmSsMMP632r/ruDwJ+QkUZFTicR5Z3+XKvvKBJpHpbDBaD340FJaxxHlV0m6G
	isP6O/XKJhYpueu9qOsGPlNAcRI2jcch8EaNqpLVWkLpHFIGwiX+CUXi35FGsJQ==
X-Gm-Gg: AeBDiesrf56sr0cEp4y0uIBh22fDADI7WHjs0DVoVT46qIzAiKI/bi7YTKasAGtxKN7
	GrhKOrp6cuspJef+RVJpP4O8xBGE5FMGP7gQG5qtqPo3BD7iZ0IYYpQA7pYfKhyu1c+HPfHtgmh
	EwYvUYqQ+DrS32vw3eek3P7hxsWsKROs4J/nuXHc5VSQxemY3E2DaE6MZrHkdtiiuLkURvEq6fH
	myAmbmhvDts38/JpDJQTJyMcSODbGRaE1XgXhA0Mu9OxnCwaVq9oEDIh4gW+bgA8OtcQSHRcN0L
	tGuQv28Nsi77KypnJcaYjQr/CzSpWvBhVVoYeeptemMYiwYhUXZlVWDJySla3RXX3nKjW2sCkIT
	my1ZiMYWVIS2SI/Uulai8vLehnuaXdJsI+92zuQRxGHVGwI2qNc1Khgk99CsKYoca7Q==
X-Received: by 2002:a05:6300:2109:b0:3a2:dabf:fef9 with SMTP id adf61e73a8af0-3a3cf7caa16mr1647222637.27.1777527920591;
        Wed, 29 Apr 2026 22:45:20 -0700 (PDT)
X-Received: by 2002:a05:6300:2109:b0:3a2:dabf:fef9 with SMTP id adf61e73a8af0-3a3cf7caa16mr1647188637.27.1777527920150;
        Wed, 29 Apr 2026 22:45:20 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd64f21cbsm3955231a12.19.2026.04.29.22.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:45:19 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: [PATCH 2/2] thermal: qcom: tsens: widen temperature limits to match hardware range
Date: Thu, 30 Apr 2026 11:14:21 +0530
Message-ID: <20260430054422.2461150-3-priyansh.jain@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
References: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MI-rHVa7YodMJemWG39ObDrMiWbdT1Il
X-Proofpoint-ORIG-GUID: MI-rHVa7YodMJemWG39ObDrMiWbdT1Il
X-Authority-Analysis: v=2.4 cv=DPy/JSNb c=1 sm=1 tr=0 ts=69f2ec71 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=7FrdJh-Z1z6zKSyd9LYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1MyBTYWx0ZWRfXxNBiOMHnrOQE
 t5T2o3bp070bHGpYVKMUz1tnKN6ZMuBz8TeGIkmKFuGGPhkiUsANKcfkffv5QyJtCu27zZFgfkA
 Q6lgVDfd9DZv0dVF1EbNiSzGZJffiNrdzlr9DaS3DPMc807yue/SqNWpeBstt/iA/gpM6AGTvUB
 rTsEfVKU8WYmz803LUAUMI8dvKNA4TWAVj1Bgb6mMIQJIBHBDD/iOG0rcpGLkI+3NM1VWJVbRlh
 Wub3daxIggi0iupzseGe/rIEq6LgliS6Ti6Wki+SS0yLj2bo487lWa/nxP6z6RD8K8/LXPCoihg
 PtVZMeNq5Dbo86hP0aW49+Dkk/Fb/jWf+Q8/gjaNSMG7nzuR1IFRN2O0m+if5fQkXl+cwAlxBWb
 GjR9i1HwjoICGAv7YYUba0RgSjn4Tk5zDvdOmWWwJlXusEymfMTn5g+P95MYGLfCsqlIR0lxQDA
 AtniCuyQA4cWIZNZFtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300053

The TSENS v2 software driver currently clamps trip_min_temp and
trip_max_temp to -40°C and 120°C respectively. However, the
TSENS v2 hardware temperature threshold registers support a wider
programmable range from -204°C to +204°C.

On newer chipsets using TSENS v2, devices may legitimately operate
beyond the existing software limits (for example, up to 130°C). When a
trip temperature is programmed outside the software clamped range, it is
constrained to 120°C on the upper end or -40°C on the lower end.
If the actual temperature continues to exceed this clamped limit, the
threshold is immediately violated again, which can result in a
continuous interrupt storm.

Expand the TSENS v2 software trip temperature limits to match the full
hardware supported range (-204°C to +204°C). This avoids repeated
threshold reprogramming and ensures correct trip handling on TSENS v2
based platforms.

Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens-v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 814147735ba5..3bd654c8dd6e 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -54,8 +54,8 @@ static struct tsens_features tsens_v2_feat = {
 	.adc		= 0,
 	.srot_split	= 1,
 	.max_sensors	= 16,
-	.trip_min_temp	= -40000,
-	.trip_max_temp	= 120000,
+	.trip_min_temp	= -204000,
+	.trip_max_temp	= 204000,
 	.valid_bit = BIT(21),
 	.last_temp_mask = 0xFFF,
 	.last_temp_resolution = 11,
-- 
2.43.0


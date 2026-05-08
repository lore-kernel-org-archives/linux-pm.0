Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FE3CFF67
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234848; cv=none; b=mVRHinxTz5TZ6zc2GDkzEjmF39UbGdpUPMfYNBlmfohpfVQ3nhmHQ0pzsXE3721MXCwAICwqz3bU4rUu26lvmsubhJfk9fT7m74zs3NepUIkm4k1dFuqYfTuNv4lvOXUgtIBwE01QbbLWwU0MOv5XU8datiY6sDF6ujHV2JyYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234848; c=relaxed/simple;
	bh=K1PkF/HKL60jDLLEFswrhHL6DnKbR0KAodhPWW8cEn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0f8dpVcyiv8Zt00KQjL1W+YizWDyQHLUXckxXCw+NsCcH7X9MSLuNNhWRffoYEnirfqATZL+8s0kMC+A6VSME4XZsgMhrorp3Ru93vS+QgLNxg49Tw4r4f2GYUPZ0b/7+SGwzd2JJccKYKkGuCPElXO4KKYS/sIUtJnf6VYdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBWIdeGd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fpWMU7sc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBWIdeGd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fpWMU7sc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6485orUR2778224
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 10:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C8KwI92gtzTb/NB6oii2xcUoz6aQYaPOKHI7qWqsg2o=; b=RBWIdeGd4IP+gTFk
	+fCpepqq5hwa9ebACMV4f8yGsWJSiFrYq+tOe4ovZPE7rsktZJGA4UNvL/+ik3lX
	38yC5RsGAIRH5nLTKbm+gFQGFnskcs6Gxl1pPn6uZFQ2QJmezXzcAumJFVSSCksx
	G4MaZkkJykI60ckqxwRvxqT9X4W5+ojCr8hgHffJhnnARRNBrd2Or00//cweDZju
	K1mt3SnIrOsWbNQfv2HezY3piM3frl4tfy5r1XBhd1kTNMQfBk2BNJbZemGX6zvh
	zpJ4Dth0PheVodYFti6FYmMFuWJfGfiAm4sktdueqwnj597WXggwAa8m3tguaKI2
	c1A0xg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1285jhp3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 10:07:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7977177675so1025389a12.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778234840; x=1778839640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8KwI92gtzTb/NB6oii2xcUoz6aQYaPOKHI7qWqsg2o=;
        b=fpWMU7sc2cDmmvOuEI2R/Kx0g8Uyww7/MyM1Pf1Qe8zirlyhfNjyXwwGkwtyufaeLV
         AAnpWuRVEIVi3hRHRRYauXpKxVLV4Zr5fCOb++Eh2h2FPAznS8jgnebg0m6kXzRbuNdC
         jHjnlVym/XcwHR9LJt2oJqfKNNrNOA0fAF1qklfSkKFUdisq/WjXb0mwPxjPxN+cKAb1
         7+ce044Yp4onXqFDIAnNzSGR+ZH5zsyBhexFHSZDQd64eXS7OnzGntc+2pWBLS/r9PUQ
         NbaHT0+/5PKR0wfDCT/iWRKvDHcYr2WCRReEj93BycG22zEDbqj2u9NRDmNZwjArDIWZ
         28Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234840; x=1778839640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8KwI92gtzTb/NB6oii2xcUoz6aQYaPOKHI7qWqsg2o=;
        b=DUQAfUCvzhFoWmqb4sooNKUzH0JD087ZnHtN3/G8UWNtr3wXCaauw+lAThN0/N2OuL
         91Ib2tLJQ3hQdssZkDdOy8WpQlEoV5LCoFzlDaMf9iNtfkgiMf0ZFADeM3zKfHtK0OVP
         UwY7Ssgf54v3cSxR/b8BGFPB4ThT7kiECoL4gP8JVo2vsPRPi/aGgZk4JNRhl2NnCZyY
         4w5LU271xe7hMp76bWiq44TaWWZjPn/TDFuaeer3StQVD+FiHXB65saiRtjQ56JogN93
         GQePPjf4b3QEF5Itch6MG4i0F4V/IEvTs5QRMagknB87g6tUeemLdnkEJgSflgTOllf5
         5aWg==
X-Gm-Message-State: AOJu0YwnvDQAlgfJ7BJCU2WRJbIJ3B4pnubaawA1R5Izh7GbJe5L06Hx
	XE7k9/iz/hq1E9Vbl11CUxpvHJ4RtAYmxZ2pd0c6vDjRR3yKM65pjTCsfHsVkCRqKu0mqr0TRdP
	jGQftHAvJAKLTYF/R6rx83/izdytPrMiT9u7m2vgQCTZWp6ZQgT2LlVuw6GDQYg==
X-Gm-Gg: AeBDieu8UF6bryigHSmSV+zaeFryrqNpQlKWjaoPSAiO8RbpnqVSRdC5ctT4n9Ae2W4
	tryUWfSCEGJ9n/L8zzEhooUXy7Et21ozrz4EvSEi+C8DKrRnovpjgkoA24sQ+HGRjAz0Pgabyek
	Iwq/ZFUb5UzNFMoF5GRl33Mvoi/P6dToV4JxgygtWCIDQhJmZ6vvrc43B5D4ebSmsLuOLDsVIXO
	ZjseT15g8+jjclC162ATqgKnKvKk/FKOjRqiooVIxHZeqUIfEiINPVAWYQ1ka4+HF0242bY6Y2S
	GLrQt6AzQ0IfXbcwvi/p6k7/0vmg4GNrpNcWbqxJha/mTQLUUaok3fz+uT90BvKQVKKT5wyvIYZ
	y4xv5jC7uPBHJteF9avlMrPbgPXpY07QLehnnCoCmEkB2KOMtrTUvWJ0=
X-Received: by 2002:a05:6a00:a93:b0:838:127d:a16e with SMTP id d2e1a72fcca58-83a5bec5483mr10776935b3a.17.1778234839734;
        Fri, 08 May 2026 03:07:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:a93:b0:838:127d:a16e with SMTP id d2e1a72fcca58-83a5bec5483mr10776902b3a.17.1778234839178;
        Fri, 08 May 2026 03:07:19 -0700 (PDT)
Received: from hu-priyjain-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm15876379b3a.49.2026.05.08.03.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:07:18 -0700 (PDT)
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: [PATCH v2 2/2] thermal: qcom: tsens: widen temperature limits to match hardware range
Date: Fri,  8 May 2026 15:37:00 +0530
Message-ID: <20260508100700.772985-3-priyansh.jain@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508100700.772985-1-priyansh.jain@oss.qualcomm.com>
References: <20260508100700.772985-1-priyansh.jain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfXxeFBO+iRIfS4
 ay0VcVyBku8L2boNIScD7fIGZfOtCXibjIcZQffVDy2AEX4eIh3YUb0feyfPw7n2bjY3/+FdMwq
 8m/lT4O8NGZMHKwjsyRQ7AkMFWfVT4srbKYyySvm24u2Z4ACoJg2II+hggMFopaew79PJ9400Uy
 NWVblBajv+w0cc3qVFMeNIiUnKiv7/i+0jtkvTj89QeGhvqDl+Ok15JqD5pXFeT6h1auhB4Hmf1
 305AtSo4RH9WQA1BXZjSfdqTzyMoGSQ0KyUKaCI9M+tZp6v2K2PC7bI72mjJL3d/QPpGnMIAL3n
 a9CjtiTRazkB1sA4PyhvjS4FxjFMqTfsHvBVfmaTMSP0vgr5qs7bSY71WlyQMMCF17KV9NZCTMO
 2hCotlU5W2T4h4qGBpQRU9LY995L91oNyEJkE7MJvjMqOJBcZAm5HF84e4zvYFlnx0DMSK9yTuG
 46WobwjdHBUOnR8ScOw==
X-Proofpoint-GUID: yijF2b4qT6qyHdfCLUtpZyE7tiTi8e6Z
X-Proofpoint-ORIG-GUID: yijF2b4qT6qyHdfCLUtpZyE7tiTi8e6Z
X-Authority-Analysis: v=2.4 cv=NKblPU6g c=1 sm=1 tr=0 ts=69fdb5d8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=7FrdJh-Z1z6zKSyd9LYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080104

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
index d39d3a2923a3..7e967d47aafe 100644
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
 	.last_temp_resolution = 11,
 };
-- 
2.43.0


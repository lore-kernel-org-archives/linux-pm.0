Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29734E744
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263521; cv=none; b=QsyXW+MB9Gtqj92OS482yFds6PWzhWsHDDIeeFZAbUg3cFcP9arJdBo3TBClOWbg+b79joKY4UzBsodnnzfxV/g3wgrEV8Nu+outTND/nAHnhhLtQ9wlygTHk7F0psaRddRtxn0t0GQOESvQjLEl1mOBIVBJ9FYCVABIJfcwkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263521; c=relaxed/simple;
	bh=WJMyJmFToCbOVevY9ROtxcr/yEE9VOSjtfkcdMdIwqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX53N+4hyJjsLlyuGCmqQfnU5AYfI42hHBT4IobfngahhHOJ2LZBU+5mbsBpYMuwID5ehV6NuUKXeIDLOAtg6/pWPP2JxH8ceDWfoQOn0VMCCGQX70dszbpnkG3y0FS97t0k865V7GVaV94qaqqT38R3ocdQjQJqysDB4icyZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Or5oiUFP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JwSeZXwf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Or5oiUFP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JwSeZXwf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648GU0Ud145541
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 18:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=foT19rAZbY0
	Twn6/HYfBI6H3u3CDBMnzAzd7AHzLdZk=; b=Or5oiUFP4Ip5C/ITJbpjHN50ZBr
	j3JKGkMv28vXYAGXhTWlYK4/tWytyzSB5wBg+CiaD2AZ3hZLbgU9bR9TiFxQKmsx
	Pu38ZQhCfkOLAZnaE5jPvOqkP8XuUm20/Y46QaGCmEYgcRTmgLHeIVOXybarS9mr
	ZGC+BcFPC2m1CE9n2KKiCg6m5Sa47pLSkNdgqcEHKT4KhBBm4pJhfCrbI3RSogxN
	TYYdeuqAFiv1PgnYkghGVacB0JKDLkBmgN+fv7qHIdV76eOQDn30eCEigPaCRJ0A
	zqjPR2qlxQHhPN9o3JYEu+f7OZZdiPfmeT2rD7ci15S2flET1iMf27EW60w==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1kdc0b1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 18:05:18 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-62e53b73645so3167700137.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778263517; x=1778868317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foT19rAZbY0Twn6/HYfBI6H3u3CDBMnzAzd7AHzLdZk=;
        b=JwSeZXwf7tcFT8cQRmKHUvGfIeK1jhnQr6vGsnil4I1Ryoph/VzMuQYuc4BrB/5Ee3
         WKQ8oQQ4PIbkQzX5WROZgO4PvgC6p/kNp0JO6cWee3rax4VWpqX3YTbRZ2QuhJKoyvaD
         Z07SA58tyKhggwmYorctYDy6+ntANGF4AAS+v9kR648oBGDmKQRMsEBY+jy9vpirEiDK
         wKQh0FSmlRHkPo7J4uEc/viC+dKYQm1kFFU5NXiwpTZ7TScp1UfT7wU/7Nn4jYhjsQnr
         OKiK4Km352IGWXrV+4NVC4/glmwYTq6iebVsEyHUHceI2pSm1esvL/SARpEIrEi4j6LT
         0Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263517; x=1778868317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foT19rAZbY0Twn6/HYfBI6H3u3CDBMnzAzd7AHzLdZk=;
        b=HYAxFyyV3T1VdEFRWsxeo6f6PXixlWVKWPdpARErNSmX8K91SGitPtWJc8PPOTX4Ds
         BsIFLzMb3Bd3h7J+9F8NbNZ0hl2Myscomy5xsw1QDH5tYuer2HvKB+ZmWblEKlVsLtP8
         Y579qIFz7STTmsAK3rskID+mD3U6ckChp/K46NH2IafSIkWIMxVoU9cYCla2y5//h0vk
         G2vjcTtvyO1886UKw1qKTowLWT7oDTJjP3ILFJold7msnVROMkfLyUBOA8wmqTmUZ52t
         pnI7phbOkhzdF+V1WAQw//8GxLEk15hRAjsea92SdQUTLjB1f0GaVY0vVUgg9X8KHzwk
         GQBw==
X-Forwarded-Encrypted: i=1; AFNElJ/4LOmeLth8C7OMXgSLrt/eCK7iNndciunpqVBICDkedHmeGP6Ifl4EAzmB90IM655+E9cRI/ajLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYk0QWg34Cyts9pHZepi+KJzhGHa7hq1gLJ4p/+WQ8/E5B9oW2
	rZ0vQvuySfcUOVmgeUW4W/V5UszwvmYFGwECI/+FRUTUXXTRVUkYurDicTbFIa0hA7KfqFB4mPm
	X9f4+PDpNRyWWdLkrPwm0PRhLQN3i/OVCfolrkMBmDZgj5qP3+Il62YHQ4bs6eQ==
X-Gm-Gg: Acq92OHSNiW4QaavM34TwX9Fdyek3R0e2sHvI85DRnjoCvijVagc74Xr0k5G22lgXlF
	lNQ+4XT5BwKc/+14+tr6iOMkowxb7xZc/ws6MjX5Vxb7KRIRsKFDC4SmKJ63+RE90XI+VoBRcgm
	MYoVQlDntF3D9FgLWhftpqW3kFtrtYVQjI1rZ98nA3cNhUWGasvr+BfN3uZZgSPpN/avi5fyCSj
	97QwS3ndfYnte79gPGqFEk1SXHd3KNHUO3AkZ1w/kH4WImgf9v5CTWLeacnHKflNs0/YfcjfSs2
	yfhyAUTSO2/q65nBJt1MbdNZRLV3HzgOygI1eY9/C0PDnOQyojHGI8qIaAA9gy49nW7ZcnJlSEw
	Bd9eGzrsnqdvsKEGA00ORDJGohIqvngOn6sReI9Q2vNsgldCwMw==
X-Received: by 2002:a05:6102:6884:b0:602:ba51:5235 with SMTP id ada2fe7eead31-630f90ab0aamr8742430137.29.1778263517438;
        Fri, 08 May 2026 11:05:17 -0700 (PDT)
X-Received: by 2002:a05:6102:6884:b0:602:ba51:5235 with SMTP id ada2fe7eead31-630f90ab0aamr8742377137.29.1778263517019;
        Fri, 08 May 2026 11:05:17 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd32afasm11654825e9.5.2026.05.08.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:05:16 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, lukasz.luba@arm.com, rafael@kernel.org
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] thermal/core: Add dedicated release callback for cooling devices
Date: Fri,  8 May 2026 20:05:08 +0200
Message-ID: <20260508180511.1306659-2-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4MCBTYWx0ZWRfXxHFpEMRBQgPS
 2IT74FFI0LZtzzIyI9czx4yIRq9oUY/LVqQqTIcjhugvR/sAhlSr1J4Dmdfk3Neiwem6voXqsSd
 CHN1ujO1z1vYlB+ZGatH39SHZNOJYPjxRg3Ou74P4Qd8Q4EZerkd2Ns0eAlO2kT2XSVjAoFoXka
 TGbF3YI5UeA6ONR/l+1OkUZfqCyFL5O/2F/iNHDX7JHHGjVZ+OUraiq3oygQGVDZATf0ul9PVqU
 Qz0sdoisTSwRPTLhwvnrHG9fxkkbYB0X/hoDxcRwZ+J+VbeUVI5V9DHZs9v+fcdCdEPDNasX/d9
 BzgvlIxcH3cdycNnNuFW91HwhgqhPNrh3lKNxO92W0p6kxNlAHNV8QzSAmBHNG4B7hZbOV4EVMn
 885vOH1mSmk0u5xZhpUmVsrtCVNp8/IaOYJvW2CK9k0SEvJK/Yhx0+PRg+kHST8akFNO2DGEH1j
 yzN3tEZ+7QwQRx695hQ==
X-Authority-Analysis: v=2.4 cv=RZOgzVtv c=1 sm=1 tr=0 ts=69fe25de cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=qPbDZLIEKKa8xmaCxtMA:9
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: bP6g8WbFci5quimJY0S3fhy4353ESiYw
X-Proofpoint-ORIG-GUID: bP6g8WbFci5quimJY0S3fhy4353ESiYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080180

The thermal class release callback currently handles both thermal
zones and cooling devices by checking the device name prefix.

Move the cooling device cleanup to a dedicated struct device release
callback.  This avoids relying on device names to select the release
path and keeps the cooling device lifetime handling local to the
cooling device object.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f4e2dc46b8f..cf5d4a9c11fe 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -952,7 +952,6 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 static void thermal_release(struct device *dev)
 {
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *cdev;
 
 	if (!strncmp(dev_name(dev), "thermal_zone",
 		     sizeof("thermal_zone") - 1)) {
@@ -962,13 +961,6 @@ static void thermal_release(struct device *dev)
 		ida_destroy(&tz->ida);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
-	} else if (!strncmp(dev_name(dev), "cooling_device",
-			    sizeof("cooling_device") - 1)) {
-		cdev = to_cooling_device(dev);
-		thermal_cooling_device_destroy_sysfs(cdev);
-		kfree_const(cdev->type);
-		ida_free(&thermal_cdev_ida, cdev->id);
-		kfree(cdev);
 	}
 }
 
@@ -1040,6 +1032,16 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
 		thermal_zone_cdev_bind(tz, cdev);
 }
 
+static void thermal_cdev_release(struct device *dev)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+
+	thermal_cooling_device_destroy_sysfs(cdev);
+	kfree_const(cdev->type);
+	ida_free(&thermal_cdev_ida, cdev->id);
+	kfree(cdev);
+}
+
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -1093,6 +1095,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
+	cdev->device.release = thermal_cdev_release;
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
-- 
2.43.0


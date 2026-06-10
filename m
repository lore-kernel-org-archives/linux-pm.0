Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D333A6B7F
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079172; cv=none; b=WYxSRnDmmOtlyk7VGuQR1cQjvb8JVXIv3jH/ID6XwPI4rLBW/3gwS5jNvRWcxQMi+QLOtE2fP0+p/C7oHnXt4wjJttymSswokz0DsUyE1ELmoYwIMwwCZMRonYH7a8324b+QQxr3CpPcURzHDo9yDO7ZPKYVAAO25Sb9ZhIHAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079172; c=relaxed/simple;
	bh=7VWPbjsAj3atobvSe+7KvejJgMR926itbAPlgg6gfgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cycJ61o8l1ys54KIfqlp8PfYQBqQha9CFkgnNB8ZNKB00jHRz86ENxZNg1xi0TludGV+paghGxnHnD8RPuc0uQM5zJ+jAWHgap48BRbO3PkPYW8BhWpSjWzTMirwasIHQUOp69BLHkiPFk4Ua3ARm4MGk9fav1a/I9+Lg3szLFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bIqMvWW7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eBysDmoW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bIqMvWW7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBysDmoW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7hrpa3151704
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vFU0GJhNHWfPisIlgqzJ49P1CSL4kfjgJ9e
	1GCqIn3Q=; b=bIqMvWW7ZbelCa0elJDk09VqPtQNLo37EK6VW6JJeqhmi9PWfpK
	aDQmwp4E4hB351fvgZZEhizxTjX/eZmH43MyEQ2YeOrHJ6F2jMJY1UWNIW8Vz/ZC
	mrAwaDGTDurDjVMW1qXNdlWBTo2ULmr7ZXhGXKJ+NTemSsIrIYxWohnF1xOmnrCV
	ZA8/oFBmU9tKQklxBoS/dE497qYnd6KfuMz1xXPU3t7zxkr05BQZZKsvMB8Dm3NK
	83s97F6HfZtDQPn60D9museUOSSgkTbRhBpo3T42v/MTXRkNZAP4EPEBqDZJU6WM
	kA/FmjYWZdskzwxHz02d4MlV4HHK7wgm84g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnesemg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:12:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf0b7425bbso125383255ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781079170; x=1781683970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFU0GJhNHWfPisIlgqzJ49P1CSL4kfjgJ9e1GCqIn3Q=;
        b=eBysDmoWT7gK18+bx8cQoQRzKVKFbyvt+SxRYfF0RM1LpZry84fEhQisPEdMvHgbjH
         Ly9Q36SKZ8BXE+oWVaJRI48Mbsq1beh1eLUw5wuUSWWsd3Fqo21PrSRj9xAA4hYkWWic
         w8Pj41bYGs1I/D91Yd+VVaXi0eUt8Jlk2XbWXBIxygKXKPCSTJOuU2hQy/WNnVNjR9Jd
         NiXX9XW8PDFjHCD3ZPlbmbklKhJMz5nrpuQKOTVGjAT2gf3IRbut/wQJXyz23MEmE539
         14i0wg7ZhWk4QBy2WfXMsN3ybbo95Nxoiwr4GejfpWQiW8PuO6x8hdHOtcc2j3rONVET
         czaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079170; x=1781683970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFU0GJhNHWfPisIlgqzJ49P1CSL4kfjgJ9e1GCqIn3Q=;
        b=QQY3cVTOfN4QG19lFvnrRBNsv779VsUEuoAAeGdpUkL6EFpQlFchFgpMXU7YFbOGRQ
         k8DsKAsR+uFBQXXb6H9Q5T63gjvcg+bslKi2/d7RY2IeZahjvfi4HunDMV8nwPnOaSBf
         knTbi5jSA10RG1OkW2nHO0QScirvX5C617DLzXnKsETntH1v48ujKrgp1U2Y8wJ4IVuC
         u5PNmp49WdAtMnd1XQO27AprIIzC4jh8OeICyYKS7Wiv+SU/SB9lF6GY1CgHAKe70WPQ
         RqNzYgn+2MJGXY2DPr6b7CEaPA34lNSLRnBNzVq6EsdgMByQZY/8gOS5eoEx0HVP06V8
         mPpA==
X-Forwarded-Encrypted: i=1; AFNElJ+XAN/bCiImuyE//ngaNoBeXL/eHUHa4R7y0sHnhw77/A+mkZ3hGfcwnEwg7J8ODYqavnRyY+TDRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIecBGgFRsjlJSolwd5GKmD9eONBUU07lGGWHDPNPpL1LcdaR
	QzwT6eu4nRTzmgRG+BZD6GRGywDO8Hf9h2hUyE7jQBt1VPMvgfoaAX0lMpFPHKrRMGU8AkcUBLP
	NY4V2MLqoXqiem0vO3G/lciceYCGw0j+tjowxaTaSpcE4YmuWWuTm4tKSHL04+w==
X-Gm-Gg: Acq92OGQSY6JqlmfgX2TnoIvT5bwrqeuCGxG689Qwu8EuZSk90FmXAcJiqlTNJLc3tw
	PzIPGlrJbXTgK5kY31mINGyLa1Cu+vdQ1VpEFqOXy4eu+L6qrtOBdqEBR3NGxLh3JNlbAWLDn//
	c01vS3aEYKAf2rvR9JqK23+QwCqTOdwI1W9tUS8eGcipNSnRYLWCfZwRF/tS0S8rMmNgX+jM5TD
	EIvOk+eAwylyDthVNJNnSPtk5iqmHa544z7EDOdmNW55Bn2SlsZJlF1SZ4cf9UxpSdGST5HWrQ5
	+bhuGgPYGIIc80QUAgP5UIz8FW86MZnBFO23+s5n5rdUNd7hHrFcoyonL7DGlXYYJBEIp98OfRc
	mh+ylNsfe4lECjolrZj89D7QAD3nWcOuuPOVuRVz2Wt9K/3oC6GbJAEhn9cjQGTOot9HzlmvtvH
	znwBtsI8ZLiOnyZuJyyeGtClR7smL7mwohvOwUDsVvuG+2vnCLk83OonwKAmXeug==
X-Received: by 2002:a17:902:e5ce:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c1e77d145fmr268647785ad.0.1781079169905;
        Wed, 10 Jun 2026 01:12:49 -0700 (PDT)
X-Received: by 2002:a17:902:e5ce:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c1e77d145fmr268647335ad.0.1781079169451;
        Wed, 10 Jun 2026 01:12:49 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8679esm228858575ad.21.2026.06.10.01.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:12:49 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add support tsens in ipq5210 & ipq9650
Date: Wed, 10 Jun 2026 13:42:39 +0530
Message-Id: <20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -pgRjALZeEbVv6jr54lig-sJGX54dXJM
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a291c82 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=O98__aPPj8GWcYWuEFUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: -pgRjALZeEbVv6jr54lig-sJGX54dXJM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA3NiBTYWx0ZWRfX5xRnBehRqYuM
 ZpW0MMm3K/0aIflvR5D/haNy+CwshhNo5ZeRFvL0qR3Vqm/TWE5E9uWWpTnP8gnVay/rs1lyzIo
 +RSdRaeqNiB8QxgwzBs+LLyQBVJSZThZvttU0kntyQknM+SapwtLIROP2oLNBmFh7evQn9w6crU
 xHEyHlvdwlDHrX1hiMUzN59OBWj6dcqf0hyRHRxmUYsiFgcWIAWeWEE/hpmfsu1Dp2m6vpQOyT2
 BWWD3W/KJwfuA2VzH1y2hOjs5vgoX9mhhHW2Yi27UpGQFrqQnrHgtJ2C0nYSMHVhOg/DF2A6uNz
 l972tBB1WhjWSzbHzDIQq0AcahozJSFMtMxoRwPG+swHE8HmpBISBYXxhxq6vWAmsNVDTmU862H
 CJ9ZT2tAmhd89HGXHkimyhc3ay1hLG9nT5PnbQ0oJy37A3WCYDSqnUeDoosCNl8IWLB0dUAlxvN
 ImvhBD7OoTUE00+U+aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100076

ipq5210 and ipq9560 have the Qualcomm tsens-v2 IP. The tsens framework
in these two SoCs are similar to the one found in ipq5332. This series
adds the sensor data to the tsens-v2 driver.

v2: Combine bindings and driver patches
    Use fallback for ipq5210 and dropped the driver changes

v1: bindings - https://lore.kernel.org/linux-arm-msm/20260515-tsens-yaml-v1-1-8039c62cc249@oss.qualcomm.com/
    driver - https://lore.kernel.org/linux-arm-msm/20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com/

Varadarajan Narayanan (2):
  dt-bindings: thermal: tsens: add ipq5210 & ipq9650 compatible
  thermal/drivers/qcom/tsens: Add support for ipq9650 tsens

 .../devicetree/bindings/thermal/qcom-tsens.yaml          | 9 +++++++++
 drivers/thermal/qcom/tsens-v2.c                          | 8 ++++++++
 drivers/thermal/qcom/tsens.c                             | 3 +++
 drivers/thermal/qcom/tsens.h                             | 2 +-
 4 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.34.1


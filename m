Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA173A2E0C
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692632; cv=none; b=L43RjUimND3RgtjQC0TNYmYlmf2p8vTzbgk5OiAIuh9MQS/l9YxeK47bt7KPjmSF3RmXWm/ARElBQjWAWzmAsDrOtKtYOEuh0E3I4SPV7Mntrq7y6nh5EPyKuWN3zkdgbsQ0YGBJa59jPxZ4SPRHna0Ig+TNldfyhE+3J8EW7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692632; c=relaxed/simple;
	bh=fzd/vjb1u/hgb97IIYa6s1ipXIoqKNbwIvaC6OZFVtQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bVJN/EW+okrb/+oB69dWT/+iwSIibUQizpoMlcUvxSLrTaUMbEz1ScTNBR8JJ3Iq67ZmVMHqvnxh8uctU3sw0b7bBEG9PcSV3N1II7nIsYxU+T4r6VdlzDo3tnTLGSMJC/dQQSp27c7Sw0QRm/kRjcIikbX02tni9iTmoB5jKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=doj8WYW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VwTg53Ax; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="doj8WYW9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VwTg53Ax"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DH0JSQ2321422
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Jx1/70KZBMxN87YCAFelMj
	Lwd8H5nC5QRAC82Z/a19E=; b=doj8WYW9nQl1bm4XpaUDKLOxmiewaY7ayXEBEm
	Jmq4WomSg8Bxiawk7NqxRfS3kn3RE4sRIZ70aXSwif/98faBGT313er3vFJu8hVJ
	w875fu7uf6xEKWx/2gqMl0m/CGHaMXM315yVicnMAUUyEmSWrz+nBcscg78yxZ9O
	6DU16hlzV1gDW7KLvRuGNlfX7/caykeble/2hvlgfYWOH2IiwQtaxeSo48ZJbc7K
	2VRpbY6XYjXssA1K7vpNTZw9vM/M5L/BCTx6LNcpqg7ANVRzxp7obSbB2cyGlXfU
	zi6Hf7ky5E43F2EhOWkmkPdi21hQFHDq7ORNEfvuvJmQcxTA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgub52k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so6107868eec.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778692621; x=1779297421; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx1/70KZBMxN87YCAFelMjLwd8H5nC5QRAC82Z/a19E=;
        b=VwTg53AxrwR+Vs4qdgj0ANcI0PDFnwI60Te+TWNSR3YCPjFACnKET0T7fHXca9Q3Zv
         pT276dGKRje86tDNGlVF3YuQxY+t9B54iUrWr3lFWplhh9h610rhv5SO3g3X9E3a870S
         4Pj1URXj5VVTzH+/dFzPqOMxzUzIAGSqtkQmhTMWuEj4C2KV4aEkTTG0vK5ayhq/cTKQ
         3s00F7i6Ynm9bAAvbbZ8zrycfhE13UoYuy0+Zc6aBOVxgS6moql2ejXH0fjmAiCFirN8
         lNHS1hBxtHl8d5E/0KqkkAl7ATbbdUMUubl6oXKvkGk+AryOp305jIJyJG7Jd6mXNLGR
         hMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692621; x=1779297421;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx1/70KZBMxN87YCAFelMjLwd8H5nC5QRAC82Z/a19E=;
        b=Yf5MiJH1Xwq+q77D1gRo3t+npllzEal/bDx+G9eOFTO8pzLl9w1EYDbiKvGM3dVcC0
         51OLB8BQVvmNRwst4PU9ACJJRihR5gVUJ2uunarFKyQd1cfatSAeKU3R7ysjEmPe+HRK
         64XKbr0JFEXeBAUbQl6EADkZb8EZds5AXUtkKhW9qkz60uRYE1J5o2D9spXSGcLyHkkJ
         IiM91xiekr5mx8aRSX/Wm3GmeE0rGAaXB7nt5uVQKFkWM4v8qA4aSD/O03fg+8eqGlgp
         V6VE+CPYU6fl227NrmkgMh2KOErqSHdO9M/WTm9dXikMmyzFKJppCe7hVCDL70YMbCnA
         N90w==
X-Forwarded-Encrypted: i=1; AFNElJ/xhuAzcIGJTb7Ug18qOcTkeAKdFW67mGvdLHtEgjzsFdOtdhNJN+rzZyJubdCWmf78E52lYcfPpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVZThYSpDefM8NXHI6glbMfiycxeW9k0yCo/7LYGXOxhHz8tv
	zfRxALlYlIDpMKWOZGULOIBTeSSkTDIdis9EVylpVCghaExuSyj4gP//dYJOTjeLojzNssgkEn2
	vUfxaEk5GoVW354pCOUroZKCHg5iICDs397/PzynJJC/gEszcofB7icG1akb7JA==
X-Gm-Gg: Acq92OFVTMUMq8+EObM6bM42EBzI9uMbJGA5tPBkoa/dagbaL+rBlIJrJPW/YI+0+03
	pZImTDmwX3FuK5iAYrve2pd7zVqSob9wf26og4SrBAMK/uGJPSpDKK/N5s5XNvUVos0RHVWOEPS
	eTOxSPYIszTSjSxV76yr1NPN/OR3fgevkCV2NY1kjy2amGT8duwyhvVOmGe2Zm0wuf6tcqE8ucg
	mLPevSke4ilqDjXNVueqLH3iYz7oC1NKCgD/OlOS/HDztSo/97aCINSTCM6AAIfmesheT6rE5Dk
	v0L55TEGhEZhghuUoM8gALJa482wYNIkSJbzUBQ7iDHeYU3socmQUPWXPxmPmNSdZSZxIZLie5F
	wz24ilmsQJjwGdy8/hyTdwpFeO9b+b/T6el0YTuYxN+mj2noVMjoNPe1iXWyxz+gvE9XLSik=
X-Received: by 2002:a05:7300:ec08:b0:2e2:4979:eb5 with SMTP id 5a478bee46e88-301181a676emr2698552eec.10.1778692620780;
        Wed, 13 May 2026 10:17:00 -0700 (PDT)
X-Received: by 2002:a05:7300:ec08:b0:2e2:4979:eb5 with SMTP id 5a478bee46e88-301181a676emr2698523eec.10.1778692620213;
        Wed, 13 May 2026 10:17:00 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm23075939eec.25.2026.05.13.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:16:59 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Subject: [PATCH v2 0/5] scmi: Log client subsystem entity counts
Date: Wed, 13 May 2026 10:16:53 -0700
Message-Id: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAayBGoC/3WNwQ6CMBBEf4X07JJtsSCe/A/DgZYFNgGKLRIN4
 d+txKuXSd4k82YTgTxTENdkE55WDuymCOqUCNvXU0fATWShUOWosYRgRwY7ME0LzN4ZgsF1IIv
 MthfdaJ1nIm5nTy2/Du+9itxzWJx/Hzer/LY/o8z+GFcJCIjmXBhpCLG8uRDSx7MerBvHNIao9
 n3/AH0Dg9vBAAAA
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778692618; l=1518;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=fzd/vjb1u/hgb97IIYa6s1ipXIoqKNbwIvaC6OZFVtQ=;
 b=8l/21SLzmvsSoWLwwEfvmbO5Eh+2Zd3kiPyE2vcX82D5ElADwxGzPYS6H11r/GbzbkoITVhZZ
 vXKXed0fUU2Dshw//daOmL2IuIk3EdWjopaoUP7UBGfpOzKvblX1sea
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04b20d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0wi9YMwNQcJCIsSnl6QA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: KZXfYL7fpD4p9u7wYuuTcz1f1vaK0Kbf
X-Proofpoint-ORIG-GUID: KZXfYL7fpD4p9u7wYuuTcz1f1vaK0Kbf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NCBTYWx0ZWRfX1FRui69whXSo
 GTwDN5RjleTq+GQX630OO1HdhtPt/9kPOcNZ4sZh4vVahCcz6SKo8vu1/F7tqjYXWf8wga+s3L3
 CbQ3G0Eh/PxFCnFgy8fRp5cKr6WPHBDNMxO4SNLmqspkKwfWDFActzdoUzRTxiz7/Vj2DYI4csD
 DD0TRPWtbSgLvYXJMGH0QXMuAxADJRbIceYJ5vmnFXKYOkdqT6+NBuYc5dgZHHH6QkixBbGO5gP
 ZOLJI6ISPrF2JkyMRw+g8qfb7oe6ZDOzBeWBqqzaYdnf0PlkUptJ95wp+/TBpmwWgebmwLjVQIh
 8xnunmfk6eugQl0ktiPgb+FYBzt7gCvSaOyXOsOEUnbifCjbrAozP6J4iHG9XrkDkX7Oa8SMYtY
 xgu2ARYzz2d0Hd6EmkoFvcnDFraUDOb+QVxDF/hT2zpGjkg6TDyNpoUfpjzHzPX5Xi8PSqeVpYa
 NnK1RhSXA15b14Y8H3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130174

SCMI client drivers do not consistently log the number of supported
entities discovered from firmware. This information is useful during
debugging because it shows which domains or resources were exposed by
firmware during probe.

Add logging of the number of supported entities to the SCMI cpufreq,
pinctrl, reset, hwmon, and powercap client drivers after a successful
probe. This aligns these drivers with the existing logging in the SCMI
power and performance domain drivers.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
Changes in v2:
- Use dev_dbg instead of dev_info log level
- Link to v1: https://lore.kernel.org/r/20260513-scmi-client-probe-log-v1-0-00b47b1be009@oss.qualcomm.com

---
Alex Tran (5):
      powercap: arm_scmi_powercap: Log number of powercap domains
      cpufreq: scmi-cpufreq: Log number of perf domains
      hwmon: scmi-hwmon: Log number of sensors
      reset: reset-scmi: Log number of reset domains
      pinctrl: pinctrl-scmi: Log number of pins, groups, functions

 drivers/cpufreq/scmi-cpufreq.c       |  5 ++++-
 drivers/hwmon/scmi-hwmon.c           |  1 +
 drivers/pinctrl/pinctrl-scmi.c       | 11 ++++++++++-
 drivers/powercap/arm_scmi_powercap.c |  1 +
 drivers/reset/reset-scmi.c           |  8 +++++++-
 5 files changed, 23 insertions(+), 3 deletions(-)
---
base-commit: 1bfaee9d3351b9b32a99766bbfb1f5baed60ddef
change-id: 20260509-scmi-client-probe-log-173cf85d5563

Best regards,
-- 
Alex Tran <alex.tran@oss.qualcomm.com>


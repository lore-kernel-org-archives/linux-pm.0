Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B0246781
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046442; cv=none; b=Ksd5fd5Ph5dQEtTuMTQ78RQKYf6ke+3idj0rhEFho1a/H6nYDl5zB+i9BhXwmBZNS0pWUjso2o6T6im2S7ifoukNb9VD1rvgZzh3EpzfpD8A7A+X9qh4gvYDOo91eo89UvggUsGjY7yBx8beRgABVNNse58QsfVjWHudNbxIC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046442; c=relaxed/simple;
	bh=HzjZYqm7vAi1tx4pnndBYISW7omiEKfZZzMQA5Cx5yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGlkWyv3IJztzL+ZM9AIH14OZMVZwMutBxufg3TQTOujB9ntEunoTwDS3dHHjQnWnur67MLpFHcS4SA+xG2d4TWJFgbAi9QcTr3c++faAkZRbrzlBoWR/XaHOs/g+EHZnMmg9dqdNraoQ31KGolY6OXuFh/I7gq/EXxSBDv6Z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NePKo4RZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQIwzED/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NePKo4RZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQIwzED/"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OC79tE1823032
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 16:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Xu/Hi6gljTZ2SH/iawpgk1o2TY1lwdgvWw1
	ZQJbCans=; b=NePKo4RZV+cRhiXc+5MLx+mXJjr12P8P6ZmrevcrX2SzYrWYfVN
	1ky+ZNeS7FaHc9iBPvwsmTlrz+rZSJv4NVYI/sdI2vTSVMox1NJoh/Zk3Xx8aXJa
	ZoSX/1VkFeISlwWzKe23FKZHfmDXapu7uHXcO4VkmwDXV7KGXnBDUK+Q+V4cb5Kd
	DkWCXkz7C2w3bxebZDhxlOwfICtyA8Us9jVaGMQCdAqpWAuDiTqsiRflCNEvd8xy
	vEpqHI/jZHR+GG5bZbbUv1bEt7Ap19B7yPl86tT53M8/UdkDC3+QwFpe7ZwrxpLg
	Ixi/3WfQrG56o2gYMkbSpUiQgrClnjl/F+g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqv5ruqes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 16:00:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e423a05c8so86215721cf.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777046440; x=1777651240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu/Hi6gljTZ2SH/iawpgk1o2TY1lwdgvWw1ZQJbCans=;
        b=SQIwzED/WrAL+l/QO7DliGzOn1LFJuPfSzZ+VHSk8g/h3jKcYHIhUudvItvk7OS4nO
         cTWUNlslLZ0qRJcLZFa9zddpLKtB1FJiR8DVldBQH1LoX5OhZp4wpiz/msIsSt0S+pHV
         p9p6GjQ84HSNP4fOcR6IzFYKxj0fGoJYNpkeyJTDtr1uKMynSSK1HTqIzW+N73BEZfLR
         GHRsQpfiDN7yxK9p7EgUqqbvQiGIlOECmyVRQmrVcsBkFqNWBnLvEL8beXusD+tBWKqk
         eNqrZcA5HLPcLWf4qq7ZiO+oDG1vxB93ewRTIcnjjAq1472yZrbRPjYyptiM4jBBFAJr
         +tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046440; x=1777651240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu/Hi6gljTZ2SH/iawpgk1o2TY1lwdgvWw1ZQJbCans=;
        b=TYLzAwtFwvLrv2UMj6j+ymg2F/yhYY3SgXMPU2YZoFlOIliUZEQA1MSXmPDJHAgRXp
         lc66eOsmahrQNi+mVxKjFKzDjsTQ0AN3R4MmEJDxo0Khr4pVDC9qIjQX1d1kNUGW7U+x
         ml4iqOyJw7G3Dt3niW+e+tNrDK77QYHXpNGbmZ6fJRyvXbZOTg9Zlmh5ZxdK85BmWiJv
         CVIVf+r0NjIdXBZW/Ng8S9WvQZTn5v/oZGs0Afdvca5OTqQSUb0ZO8FrZGkeGBDMrxGy
         P3ZEPtyRaachmx0BM5aLj1w7EfA3vfmNOu0FFnITthA769RIjx91tLhNiRXrdYVrAEwn
         feaA==
X-Forwarded-Encrypted: i=1; AFNElJ8P8lXB8Ec5ydXzl/zkX2DDbexewlqj1VFsSSZYhelDSgiTgH7gWuNv2aE7cJ27uFapR+cemYpbNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yY/ugsEEKej4tcdXbpgWAd50REKnSngpe2uZO2gZVA8K4aap
	MEzr4hSuPFa9cr88JcKyZq5FI75L2OApS/PJuCML713SvkHT5T2Apakn/AX+olG3cgBIT9zfsec
	1X0TbmBuCUs39MWzrIKiGFbj4GZuP1Qyh2uCnSrC7KnZfjdry/vpdj7CKY8AtbQ==
X-Gm-Gg: AeBDiesH8lnbazmAgLs5CQ44YnhPH3MslFIOUnTh9akh3xrkne8qVY+CminNz6ThWYG
	PzEpi83VOVkVImywXR4nUrbKpvGMyYfPc4IUXzOwFBzU0ryXOEt2FaoUJ3dZ3JwWwR6SAvwKYuy
	A7jR27seqz3x3LuT8ikpj859vAeNAfx7gSam/yLzvQ+ZGSXkxeN4gmShxAhK2KbC0S0Iz440zJQ
	mQe/8zTLMK1xzbxRx9Uv0T+vzmAwK5KwdYBja225rjZevzU5jby9v+4+NOaxLZNB05yK0q+C+yU
	qpvpIhI/ldk8ljP1myVx2KrzDs1pVAUlMg7w8nMKLyLXVB3hPOGRgt4T49cacw44YoMnUJQBi6w
	2kauaRIcisw5i8FVGrCnNeAb8Gm/b2JzEkP8d0NxOlNiDlUN9yPkQtusPFzbx
X-Received: by 2002:a05:622a:53:b0:50d:9f3e:e1a with SMTP id d75a77b69052e-50e3661d421mr407490281cf.9.1777046435594;
        Fri, 24 Apr 2026 09:00:35 -0700 (PDT)
X-Received: by 2002:a05:622a:53:b0:50d:9f3e:e1a with SMTP id d75a77b69052e-50e3661d421mr407487291cf.9.1777046433866;
        Fri, 24 Apr 2026 09:00:33 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1ab3:98b0:9e96:47bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm25405491f8f.21.2026.04.24.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:00:33 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] drivers/thermal/tegra/soctherm: Use devm_add_action_or_reset() for clock disable
Date: Fri, 24 Apr 2026 18:00:18 +0200
Message-ID: <20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqiiDHdc c=1 sm=1 tr=0 ts=69eb93a8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=ggozHacZmVhwqr8k6bIA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: AG8F3uDh2jW5eKM9dXWU2fBg8tKmCaZQ
X-Proofpoint-GUID: AG8F3uDh2jW5eKM9dXWU2fBg8tKmCaZQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE1NCBTYWx0ZWRfXz12tpBYGRXQP
 7xXF04AcXFrcamq80h+hHGrrIefPV/xNtz0cAfk+krot5/mUk830WDft6asafbj1D9g2Y4+nNq4
 7x2ZDRYEFw7CxjqpAEMuFt+El8npSQNyvyjcBQIjGn7he+snHbeLslutDxyGLC/Y/R1+fsponN/
 o6FmPRvX1dc/Q5RtR8VQiOWSJEFc9PhY7BmopAVB3uMmaSX3mWbIBo9zSjxTh/tg6787SS0Qv35
 IjU2gDZp4IOFQEfUKeATvhU7yUtJUTdpMvNwe6nUYh1QWQhcAzM7Kn26JymKRZDnrZAP28YZS/u
 fMyStJFuhhSYpDKxFR0/tbM0OeGft0n3TR0tzb2Peo7fD9FRX2r1N5dk9aRLAE2Mj/KIQHSd3fe
 bsAUabesAluMu4F2QveD1lCgiLROAi9I668W6X+m+L9D2HVWODPxAw72+bS1oA8wi3HLlTp+OSv
 Ix2MXd5JNwb76Hpgx+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240154

Replace the manual error handling paths disabling the clocks with
devm_add_action_or_reset(). This ensures the clocks are properly
disabled on probe failure and driver removal, while simplifying the
code by removing the explicit error paths.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/tegra/soctherm.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 5d26b52beaba..40c3715e84c5 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1499,6 +1499,13 @@ static int soctherm_clk_enable(struct platform_device *pdev, bool enable)
 	return 0;
 }
 
+static void soctherm_clk_disable(void *data)
+{
+	struct platform_device *pdev = data;
+
+	soctherm_clk_enable(pdev, false);
+}
+
 static int throt_get_cdev_max_state(struct thermal_cooling_device *cdev,
 				    unsigned long *max_state)
 {
@@ -2175,6 +2182,10 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = devm_add_action_or_reset(&pdev->dev, soctherm_clk_disable, pdev);
+	if (err)
+		return err;
+
 	soctherm_thermtrips_parse(pdev);
 
 	soctherm_init_hw_throt_cdev(pdev);
@@ -2184,10 +2195,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	for (i = 0; i < soc->num_ttgs; ++i) {
 		struct tegra_thermctl_zone *zone =
 			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
-		if (!zone) {
-			err = -ENOMEM;
-			goto disable_clocks;
-		}
+		if (!zone)
+			return -ENOMEM;
 
 		zone->reg = tegra->regs + soc->ttgs[i]->sensor_temp_offset;
 		zone->dev = &pdev->dev;
@@ -2201,7 +2210,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			err = PTR_ERR(z);
 			dev_err(&pdev->dev, "failed to register sensor: %d\n",
 				err);
-			goto disable_clocks;
+			return err;
 		}
 
 		zone->tz = z;
@@ -2210,7 +2219,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		/* Configure hw trip points */
 		err = tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
 		if (err)
-			goto disable_clocks;
+			return err;
 	}
 
 	err = soctherm_interrupts_init(pdev, tegra);
@@ -2218,11 +2227,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	soctherm_debug_init(pdev);
 
 	return 0;
-
-disable_clocks:
-	soctherm_clk_enable(pdev, false);
-
-	return err;
 }
 
 static void tegra_soctherm_remove(struct platform_device *pdev)
@@ -2230,8 +2234,6 @@ static void tegra_soctherm_remove(struct platform_device *pdev)
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(tegra->debugfs_dir);
-
-	soctherm_clk_enable(pdev, false);
 }
 
 static int __maybe_unused soctherm_suspend(struct device *dev)
-- 
2.43.0


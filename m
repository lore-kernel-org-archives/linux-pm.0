Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C51401490
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804545; cv=none; b=jxaqZ9sFvFY5yu1JFv427Kh9VYyATV1Hf8/KyVwZls5o1T5qxA5wm152XXOs3yxyChqbmNhvWqqZdxkOvhXZBGk4gzZIlqXXaLjyivnMHFjYLtnHzZ0Fhdq4jWYdm7gPZnQOuW8vc1jtbGACpWFVhwprB9mHexs3a28AcsRhFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804545; c=relaxed/simple;
	bh=Lm7Ldwf/nd8XlZJk6dU2XO047n9DUPbJMPLUwvjO530=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giRLJHaibwD4ux5cGeec3DVGE2vI79XezxTJaZgmQ+vmr2WldezVxXMbfzhtpNHSBsdqUfC93qfjjvSO7QglbKfgmZ+Rlp8pab7MUsgasAYRJxJp1lT6WR2/6UOgkfzoeDJ3Mz0Ugkj3RYMnDnN5a9Vo63hYYxiIPkzzUgjH0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VZaNSrmM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iHqSFUxm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VZaNSrmM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iHqSFUxm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsNPP2705396
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4MjVSksU8JG
	qo/H1NTajdTHFfOaQ/jhmT1nmEKa1hd8=; b=VZaNSrmMUNZKOSp7UY52TVYNlp9
	1TY7ZcTrCTKZtOxhc+EAWJ6TGNQ0mDDvuKHP/Aw8lxIGBePorDdeztng5Jn7Ni+U
	gqjXbYo8beT7M7YiNV7+TchZePII9MDr+ymNysINik6yZhSbOV7/blYTGSMARteq
	zbRUmF3x4Wq1x69x7FrLMhcZ3v7NHKLpX/LURUOCtiwEbCCNviImsU5ei8l1qYTt
	Dsno1zlvD0gLoRJbV0DXiTlZ1N8GTadpKpIFl2OiEe2Cff/h4R4jhQg9NmWCQcQT
	suPxuqK29pi/NTc9gc6jLktanpdAa8s2aOzCqhlnoUZObsCRaSszYZFW87w==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5vgj7y7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:02 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6327b45f59dso4057062137.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804542; x=1780409342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MjVSksU8JGqo/H1NTajdTHFfOaQ/jhmT1nmEKa1hd8=;
        b=iHqSFUxmTZHHygeZ1oSr+9N4Oar1INAiZRs5fk6d7W5mTla2ngj+nhOASVsf82gNd5
         Kxte6oU+c76HC8iqCAb+GyjKYudDQSEpS7q14L/zP0KLAGZwGQfLIZxgECPbKj1sU6Jz
         W3ESj4NpujIlRbzRsUXPqCS/gZMEN5ivfn/mZMypnWMxOE6NTpMpRJrJu6xD2JX7Apn9
         QGt6CER8JEemscepN+5/HbruX3nWLj1yasdiXN9E09KOODxV5+v5c4cP7FI0B8sm+Rwh
         K65v4XimcHMZ8VxBphFKEwH+jZzUNqrkfOc67vS1tPuGe34g726S4MRTCSfE65sYo1j0
         pVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804542; x=1780409342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4MjVSksU8JGqo/H1NTajdTHFfOaQ/jhmT1nmEKa1hd8=;
        b=IbuKPZV5G/hGDPiKGXgHmMZsiyx0Pubyon/L7RI8lUVwj5OrcUwajZjs6/w27YMiXv
         MlcE2nwZxWTNdIoEzc/6rgu2OCotatn828eNZ/xSNmEipo9kRyIEJjWv08Rt+AW6k8D7
         Jkfs6dLLQeuKMeVAwg4EUU9Al3aVPHluX3JxEUS6zy6KBIoZGdQ3sOp1QALWVziT7M2h
         KK5UVFRnyMDGrA2dYOJ0D0h+zSwUzkA2Cr2g6u0OdrXzY7dGOBWJ8bmIpAeTzGg0HGjx
         92r+c2YvZDq/UvXb/r3fwyH+3m985+o4IjGLarnR/XCZckXlp1o5e9kXWNvwJgbblAZe
         MwZg==
X-Forwarded-Encrypted: i=1; AFNElJ/AanjrgrmMyNdzNMESJScsUq7XMQlBcH1gpzzr1OPu/qGmO93dhTKPyJ76NvOd4ULJDYmrXxlhpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQnH7ZwNdGdoo3O0vnVokRsXp7spLFSvJO5eH4tYKFeVIr1aW
	M/IrObyoe5OVTEytrhzhSJ7I9ow5fdvRKXO/1UuK5mW7Dog/I91POUw0Lb/yVdwih+bZG3w5jBJ
	Mp/WLV24V+xqR+GD9BqEVvdyJ+t9ZOS7bXYAbWVTte+1H3XZ10i1uBBJk20jW0A==
X-Gm-Gg: Acq92OFn8M1m+qT44EeBPIJ5eFg3cgvsgE0CD1NV481UOFuLJ4FAlO5wXLeSljGR52w
	hYZNAf2GIRC41pgcSvhXlDWhTA8vTHhjT33xQX8R/pptj60/MuLMzfJTEBeQaKsRo8gAQcLB+ct
	S4kwgtvJ3DM6AxPHpaDUi/+bh1bc8njdfA9I96ifXEmBLWaU1fy2Oxo0IpvB1wkC+Cr5UiYCWRK
	xMJsnv5S9x/jiEOs7HdGwujOk+gVmmecSWhO8dcqDFMPpTmk7YBDniwPLuAhtN+jzhkNlvO3sBv
	j/w4xkG40DauZV7yLRqIfVOqHsNnX4iJRwWL0SEvRNUkEIFa6vHIl71H5GnGbch1RCiqawGR6Ih
	bayHZpXfOQVy64s6/rqZEGwdLUxfmxszXLC76cjzyiw4DeBnW
X-Received: by 2002:a05:6102:5114:b0:605:4ff8:fc21 with SMTP id ada2fe7eead31-67c76f882d4mr8306033137.8.1779804542333;
        Tue, 26 May 2026 07:09:02 -0700 (PDT)
X-Received: by 2002:a05:6102:5114:b0:605:4ff8:fc21 with SMTP id ada2fe7eead31-67c76f882d4mr8305928137.8.1779804541681;
        Tue, 26 May 2026 07:09:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:09:00 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4 09/10] thermal/of: Support cooling device ID in cooling-spec
Date: Tue, 26 May 2026 16:08:10 +0200
Message-ID: <20260526140802.1059293-21-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=Lm7Ldwf/nd8XlZJk6dU2XO047n9DUPbJMPLUwvjO530=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalSAy26ags4zeco9TS/S8+d7c7yS3AE8cy1w uT5a5iZ0+yJATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpUgAKCRCoMiOKKk/o T9euB/9CrH+i79j/ckyjOltsSD1hwCzGBunUDyYta0BswdB+k31TFcee724V85VvSI72vdEFm8E JQTfpXTmZoH7euonXVWo26IvTZ0xZoHSVTFlg155xVVRXgdto6YQ7JbS4LfO5iKFcnC9VYzVxz7 QfbWLHro2RBj8wGRgRbFbD1be0QzlMwb2cwYTM9PpkaiMT7WKzZBrcXxUw5LeHY1SBMxjDolCsP b4Is/h7D28xamNMTQTpt6xRfhJv6fpltLJySwho7cc6q1aKr+G5wD0rInES7F/JlVf+UEYadLeP s7I+YNssC4LMkBrxlv7qedr+/zbRuVBG/0h3wp+ixVeVC19z
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IrYutr/g c=1 sm=1 tr=0 ts=6a15a97e cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=C9wMHiVflMXd_DM0zvkA:9
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: EfgJSsaurCEoQNxtXTBdwF--wLixmEEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfX+XRYeSNQkek0
 w/tnVzqeL6Mj9Jc7q1SOKgT1EcaOgx97fdysIOpgqSuXQ2/VTsYRnyf8gPQj7wOxuK97zkVFss9
 bneeCLwIi+E2bcu8YYhTcwoDbfUzMuX4g66M53qhY2hKZ8QTjgcqnyczBgvRH/VCJpQHp6AKXHl
 rdDVCn7Gs+OgXRWbxrOVYNkk6xcDMCU7nipesSTNlvBG8SbgCpuSj0nMoqjGtevC02gPtHtC2fo
 ouHpPuRIqR4ieYgVy3/TmCj/J3budGlELQDs5kRFgJolfkK34Pdl+lRiSSZmPgJw/gFmkfBXYqW
 dFYnRpED9Z+qI9RtZnEfF4GisIUkaFCiw89I9BxEYugxhN4smPr1jNMyjHgqBSL2nPLBlgBSqE6
 5JrQ1OoMt+YaG9u5Ry51eOgDsad8nfvrWzCRaAZUKe606m235MtHH2aww5pSPbsnGi1p/AP72ux
 kIZoVokU5KNLLzFsuMw==
X-Proofpoint-GUID: EfgJSsaurCEoQNxtXTBdwF--wLixmEEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260121

Extend the cooling device specifier parsing to support an optional
cooling device identifier (cdev_id).

Two formats are now supported:

  - Legacy format:
        <&cdev lower upper>

  - Indexed format:
        <&cdev cdev_id lower upper>

When the indexed format is used, both the device node and the
cdev_id must match in order to bind a cooling device to a thermal
zone. The legacy format continues to match on the device node only,
preserving backward compatibility.

Update the parsing logic accordingly to handle both formats and
extract the mitigation limits from the appropriate arguments.

This is a preparatory step for upcoming DT bindings describing
cooling devices using (device node, id) tuples instead of child
nodes.

No functional change for existing device trees.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 3584024b76f5..100fd8a0c8ce 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -259,16 +259,34 @@ static bool thermal_of_get_cooling_spec(struct device_node *map_np, int index,
 
 	of_node_put(cooling_spec.np);
 
-	if (cooling_spec.args_count < 2) {
-		pr_err("wrong reference to cooling device, missing limits\n");
+	/*
+	 * There are two formats:
+	 * - Legacy format :	<&cdev lower upper>
+	 * - New format    :	<&cdev cdev_id lower upper>
+	 *
+	 * With the new format, along with the device node pointer,
+	 * the cdev_id must match with the cooling device cdev_id in
+	 * order to bind
+	 */
+	if (cooling_spec.args_count < 2 || cooling_spec.args_count > 3) {
+		pr_err("Invalid number of cooling device parameters\n");
 		return false;
 	}
 
 	if (cooling_spec.np != cdev->np)
 		return false;
 
-	c->lower = cooling_spec.args[0];
-	c->upper = cooling_spec.args[1];
+	if (cooling_spec.args_count == 3 &&
+	    cooling_spec.args[0] != cdev->cdev_id)
+		return false;
+
+	if (cooling_spec.args_count != 3) {
+		c->lower = cooling_spec.args[0];
+		c->upper = cooling_spec.args[1];
+	} else {
+		c->lower = cooling_spec.args[1];
+		c->upper = cooling_spec.args[2];
+	}
 	c->weight = weight;
 
 	return true;
-- 
2.43.0


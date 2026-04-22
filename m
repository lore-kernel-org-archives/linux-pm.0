Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25F38F929
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879799; cv=none; b=iw9UJSVFCYjoLFinTNUuhwp+NQf5srjcCz7EVvVHlE6p7s/emK97rr8AY1z5b0cfQEgdnzo0ijBg86x2LD5XbtBFehowd1EfLwGKbmyFV6luN+qBV25i5GrH078JnuSVLhvMQImMC8hrkyd8E0lonFlWujEVzVmlguVNvEgANHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879799; c=relaxed/simple;
	bh=zWS8PuwEBAA/aKTsS1W5V1wcu3h80TjX0hW2zjl2YyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWj43QLYA2ST9w387cyJQbsFO8F8UvRvARkNMM+HNmdNviPnshf4NuQL9XVdesR3tm8OvLR9ar+S9C7alj2PBrXOuxuR4OWdzA9tPoR5Cjq9iC2Rpszl1ngbBPjGUUkpCxIS5rbE2AB+R++7fuU0jnMoqufDsNzjPJR7acyBdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HSSKvqma; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JP01g7Dm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HSSKvqma";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JP01g7Dm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGqZWu1218425
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YAVmnQsYcnQ
	YdpKJBDYnCqGDQ8o6FQwjhG98mPvL/qc=; b=HSSKvqma7woJ8Qi+alo+1LO+g3F
	APsb5flzPPCga7UTDbNJ9FADQ/PDuMLPilBhhyDDq7LMVGdXJzoRLxdIBgDCdYfS
	+mcJsC89mfQZ/Xe4T1LaLzO1XjWRfysO/gziDYQKYsIuKBP+8iYt8hZgXuhLIEky
	NVsYRhZA1LrLi2Jfgc/GF074nfLcZrNS/nL0bN0/wmo6w5vAHIwlyVgyCJzIaldB
	ID/t7fB5pU7fyiJf03J4m0DOXmnW8WY/TN7gn5hiB0bAImJbOqR/7xjDyyiAnOkc
	Nu9qTnlH3eVeNbkTEngP7ksBI+gXGnQfXOpAY05RfqwLkjIRF9SJCwOKXUw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282r5rc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 17:43:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50f13da9684so41125111cf.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776879797; x=1777484597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAVmnQsYcnQYdpKJBDYnCqGDQ8o6FQwjhG98mPvL/qc=;
        b=JP01g7Dmx0bqyyyZs/ZNGv+nH5pQQZWAjhX3Oj40DUfNls8lYrmwp32y5E1cCN/JJ2
         m080S45uNCWKNzQLdNayiOeok5NaBLNWkADLHgwkOOVM/KhqPLSPlDFEGb1XiK85A7UE
         B6D/ommwmk/23MxZxt/buzlHpyCnpTDW0Yqz90nY/Ta0B9zAm0VLqbz2/BrcENDlNIOF
         McrXEfHmHMNwyOxuguX2tarj9SKKxO8C6LSW3DyY7jggopctAYI5BamBMzRKytVJltjr
         CaXpirfmz7okoKzfWJZsZDHSCFWFwG8q6PgOUAYOxD8U50uLWPB5qYmzAP5Txt9cHOpl
         YvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879797; x=1777484597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YAVmnQsYcnQYdpKJBDYnCqGDQ8o6FQwjhG98mPvL/qc=;
        b=QLgG5jcGMPIpbrgku6koN+1Y/oe0ATj+yBPXlE38dha2Mcbd5F5PS+B49JmBctIynY
         7qgnC5IZFyhVSWnKbrvoTJwIgtV3FMgpTAFDpeeIxEDDFkej/eRwBzbO2q8oYIZ726WM
         Q5RfQIiuvXNnuSD/nTXtxtomIWsrVfPdsoRrghXl8iDNmrBUQRsJDp24H5puVG15lI1L
         8iHlLs5jPdbYr4bsxJi131FpZTLMWZuhqr0zIMwEtGymusb/q9H5EJfT2AmRp1Fp+qNy
         cmN39OVJpf8yR+ns1YjVR4WYDrLbys5aykCxqAM6qvV+z1GQYOHojQ3eLOVsLoBPksey
         krNw==
X-Forwarded-Encrypted: i=1; AFNElJ9KQvjt6Zni6gAXZrWXPHO70xtu5tnCvj813kZRgiSbagLjut5rP4L4/W9nyxRsHYfadBIMz4Hr5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCN50tabXpA0bvGpBqKmYjWjZcwTnXFWulgpFESi361AWH+jk
	hU8KIcDCd3DHbgm9wmv9eTFO0AcaEFqCbNcOrvj4bjOpNcwxyHN8EacmPpVjnBqLNdIe6nnkFnq
	Q01rFMsHF58ycGpK3buOhExdtxoXS2KbknLDd9xdaU9S0cyAR64bW7MNBGIQ2tw==
X-Gm-Gg: AeBDietpLmjnrznYZq1BYlHngfk/ZPvlekKOMNNEB48381cBKgDJ08TNXM6eQnl++4k
	0C3DaUwXdi9DE+YA/lavOIzQ09ZNkCzQpTh0PEm2xZzJJhThSr+Yi/nrnSWTZYFWiAIY7FQGXRE
	pEoU1YlO7VgxE84qplAxA9CXB0Hp1oCwIW0hErt7gLfyL7WvlqC3vj9bUvg+I5deGl25pokUbqP
	Z9WQ6z5EpYAp94e1st90xyQStBsfFwlVidbJrzEGYGDP49rqPnozCTItL1oaIQmwGeum1sbyrOQ
	lcD8TGa/YjpddUiP2UIzNXX9GIIN8R9nFn4BbRdbP8nIKbV6+U/ot+KbFL5q5IbhsJ8S4GyLIHL
	AVrJHCjU4DyqUtSYeA5ZkLoGBAOgMawwBYRWXRPC27muKGwWOFa+jykgeGziu
X-Received: by 2002:a05:622a:5516:b0:50f:b904:457 with SMTP id d75a77b69052e-50fb9040613mr96316451cf.25.1776879796213;
        Wed, 22 Apr 2026 10:43:16 -0700 (PDT)
X-Received: by 2002:a05:622a:5516:b0:50f:b904:457 with SMTP id d75a77b69052e-50fb9040613mr96315451cf.25.1776879795605;
        Wed, 22 Apr 2026 10:43:15 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a051dsm142511965e9.18.2026.04.22.10.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:43:12 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
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
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Thomas Gleixner <tglx@kernel.org>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v2 01/12] thermal/driver/tegra/soctherm: Use devm_ variant when registering a cooling device
Date: Wed, 22 Apr 2026 19:42:50 +0200
Message-ID: <20260422174305.2899095-2-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
References: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MSBTYWx0ZWRfX/e21nO68wJlB
 3tuJFd2v4cX6RlzOS1WpU52gnTKgCdldstQmhNSfctl6bfE5bpS1CKQ6mjBPwD6Qk7ocg4pySvb
 ukfpIP9gF8asRJN9IoCsBTs4nWsBZIdVkoaPUExMfYGYKh4tIGVHItuaMLBDOdvxNN6cRcuiLie
 tm5dOHbpeAchvNXB8Vnp0IaAqpggSAQB16xWz9KInWyZgsrTQwSIH0EogyOoqFROIAEEubN8SNL
 NIimP2Nvd/fkOfaGXPG4lEVVYtiV60cox8ruvapEB6wpiHXMuOltYfOdH6Go5m9t0viAbrenxLM
 fd1TjhFLJYimLjr11mSBq6VM/mckYqnoYferxgfVpm/qRjQLQmUqYzD0OBRiec222nymSo3PBHq
 qKXhDipNb1RtbiLDSusexv1Ba0ikmN58SeGDCBEYmTpFZooxzMpkNzsXqLAidsVskGStnhcAcuM
 jAonK7ar3DbBLus/K/w==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e908b5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=oPkgDEUO7JvNfMSusBkA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: V7XAxzHz9QkH69f9Z50MqFfHLZu3ROeE
X-Proofpoint-ORIG-GUID: V7XAxzHz9QkH69f9Z50MqFfHLZu3ROeE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220171

The driver invokes thermal_of_cooling_device_register() at probe time
but without unregistering it at remove time.

As we have a devm_ variant, use it and the cooling device should be
automatically removed.

While this prevents the cooling device from leaking, the unregistration is now
deferred until devres_release_all() runs (after probe() returns an error or
remove() completes).

A bug can be subtly introduced by this change because the driver still
manually disables the hardware clocks during the probe error path and
in tegra_soctherm_remove(). This creates a window where the cooling
device remains registered and exposed to the thermal core and sysfs
while the underlying hardware is powered down.

In order to prevent this potential issue, use the devm_ variant for the
clk.

Compiled-tested only.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/tegra/soctherm.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 5d26b52beaba..790c4c96a9b5 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1700,9 +1700,9 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			stc->init = true;
 		} else {
 
-			tcd = thermal_of_cooling_device_register(np_stcc,
-							 (char *)name, ts,
-							 &throt_cooling_ops);
+			tcd = devm_thermal_of_cooling_device_register(dev, np_stcc,
+								      (char *)name, ts,
+								      &throt_cooling_ops);
 			if (IS_ERR_OR_NULL(tcd)) {
 				dev_err(dev,
 					"throttle-cfg: %s: failed to register cooling device\n",
@@ -2133,13 +2133,13 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->reset);
 	}
 
-	tegra->clock_tsensor = devm_clk_get(&pdev->dev, "tsensor");
+	tegra->clock_tsensor = devm_clk_get_enabled(&pdev->dev, "tsensor");
 	if (IS_ERR(tegra->clock_tsensor)) {
 		dev_err(&pdev->dev, "can't get tsensor clock\n");
 		return PTR_ERR(tegra->clock_tsensor);
 	}
 
-	tegra->clock_soctherm = devm_clk_get(&pdev->dev, "soctherm");
+	tegra->clock_soctherm = devm_clk_get_enabled(&pdev->dev, "soctherm");
 	if (IS_ERR(tegra->clock_soctherm)) {
 		dev_err(&pdev->dev, "can't get soctherm clock\n");
 		return PTR_ERR(tegra->clock_soctherm);
@@ -2171,10 +2171,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (!tegra->thermctl_tzs)
 		return -ENOMEM;
 
-	err = soctherm_clk_enable(pdev, true);
-	if (err)
-		return err;
-
 	soctherm_thermtrips_parse(pdev);
 
 	soctherm_init_hw_throt_cdev(pdev);
@@ -2184,10 +2180,8 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
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
@@ -2201,7 +2195,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			err = PTR_ERR(z);
 			dev_err(&pdev->dev, "failed to register sensor: %d\n",
 				err);
-			goto disable_clocks;
+			return err;
 		}
 
 		zone->tz = z;
@@ -2210,7 +2204,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		/* Configure hw trip points */
 		err = tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
 		if (err)
-			goto disable_clocks;
+			return err;
 	}
 
 	err = soctherm_interrupts_init(pdev, tegra);
@@ -2218,11 +2212,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	soctherm_debug_init(pdev);
 
 	return 0;
-
-disable_clocks:
-	soctherm_clk_enable(pdev, false);
-
-	return err;
 }
 
 static void tegra_soctherm_remove(struct platform_device *pdev)
-- 
2.43.0


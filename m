Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAC2EB856
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622961; cv=none; b=gDl7Iz+eskwNNqUjKraRcQrgPs1dDezYm1iCT1Pr83UODbWMwuFVyZc28lISrjQK7WJy6Oh7ignTjawI59bswuYJ3fFzqt8cpiWt/zSwMtc6NjeWuFBw6qTvRJBnY1xst73gyMoc4Ilk9BRavwxCT1AQU48PRa44sCtwwOaDqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622961; c=relaxed/simple;
	bh=4oS6yClFh8/UMux6OzcPspzOA+Q1/uzIjpGNB1vd66Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7c3ey9v9rUl51TNMLhehsX5c1lueJJBR+CpBya7GXCAp/yfHtb3aywH2sDYqynjQOROFQahdDfTm6jJ0i+gyJ5jxFEYNjpObY9XXm42vJDcDRChGM2gVEsZDJj9riZePZUN3m5C6i5Hls5Xp3f64zMGWalOLFVkoJao7BBcBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NUjqxNE3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QT0OjeJ4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NUjqxNE3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QT0OjeJ4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J4f3LZ4182469
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ninBs3EPIXx
	rGkgg3vUVv88i5W2pCsOK6agLZvll/l8=; b=NUjqxNE3nA2ty1VUVPMjxDxISkK
	EPQR8xRaKF4SFgeuXeWrgXKQGE9FM2+64KMAQtl090h9mDbFYYZ6YkNy57xPPs4L
	bFjqzFap15DKTNFAllB1sVnX8MavPnqEJcls/gI1XegNdCslOTKaqjvtuxl0mdsD
	N8Di8W6OlBSd3v/8zOPqS7g42yq8Z4qvQoLQQqKVOTst79UF/gMfMPPACjHS8qrj
	UIAjyWCpS7L7ePb/alfFQpXmVTqqhq2HUV1/W+hnJkDtSoMyq3JTM8S1PQ1zL7TY
	JBpQcqTUopGNO5FbkPlw36TE6e2K7+TYz4a8ld61OwO0dSmd/D//utVi3RA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm19fu304-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d826ed6f9so78237701cf.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622959; x=1777227759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ninBs3EPIXxrGkgg3vUVv88i5W2pCsOK6agLZvll/l8=;
        b=QT0OjeJ4P3abBv2cRsyi06sgr6ZuJtl8TYxTXVcDgqVCsyOygrxklw/4a9zoPuiW2N
         f3O717RZ0qdeiKz98BfIYC2vRizb1u/6Bx+VlljYpDShNvx1yHZAIJ0pQ5dyteHRMa2a
         NFWI9TmiN3immj8/e478cAge6+qouzDvTjLRROZYesw+InCuNklArfZtUlt4dPlYb3pI
         LeaR+LBe7FK7cWlINg1TvDXP3r+VNqe6qfPMgVTfglygEFFJotJAGKI7GOohHv/jdg+N
         Bu0bxMFZbwOTBbfsFX4uj5DrPSGcuOXvCzLd044EmnJ6AlIbO9AP5CxOpvESwfyKkNcb
         g4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622959; x=1777227759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ninBs3EPIXxrGkgg3vUVv88i5W2pCsOK6agLZvll/l8=;
        b=riOzTx+U0FyxI72B3H5TfZ0ZpdrEP9SVm6la3fEgYNxt/KK0yMYqmCcC549Rf1cqpk
         MdoErPfxEfYa5NDfxdcoB6wBkhieYKRiPufWweryS0PqrHgVnOv4vWLAEUUBU8A/mhQC
         lNly/bfO0uHV+emAsxA4zed+LgrQBPmbLsXhlGGhH6NZTUIjZ58TN1+DD0R1MDVj7PkK
         F95HJikMeeeyy9ifASG6InM+ThrYygudooe8zlRqTMf0Qfsy7lf23AKgKEKRh6wbSXXR
         U1qffc+jX3luaoxBx2wHLnLY3Kt2z9+HGFwmoUKzyvMy+ZbqGl5oqHYwoaWKqWLydl0O
         uT5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9SGy2ZOQ+AVsji5a2adiT7KaL18HnfK1KZReph7IvN2vNJ7SLh0479wHJtwkLgbqmj1nvjNliBwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iMp7huwRiss4fR9i3lYEE1zXl60smWB0oZ3fJaOph8j/70k0
	CcNLUNO01FP9NC1QDAVnMk48gxOt9VrAKjF2rfMmGOmMOlfa/ajuxqvmDX1DKQQ7h8IxwSB33ay
	d4sHtyTN3PN0NPI6UJYohBgMGGa8MJ0eQ6Wzdk3kgDJ1JRiRhxrRaBQM+oCly5w==
X-Gm-Gg: AeBDietL8gnjpm7AV3bI4GFsXMSXTLn0pOQLTTJR/YcqUfvg71c4GCEzZ6dLegYHvf7
	huFu3sIsauncV7cdQ7trzrRc7l0hgaHWPrxP92HMELHN0cxMD5NgaDXCpnKzQsfogJUuhg3Q2mv
	bFitjJDVxK/4THuH/5wnGkdxUwkoPkwyENXAuogRTiA84gRF3yy/CWYV+b4+ohGZ8lw8o+b1BgP
	ldy+FaT3ed26maE3Ma7L/Ds5tpNjYKk7hRMAN/CyVpFbTX+oZ5CMfGRRzqIyx8JgBQjwqQ/7Kdv
	HZjKqiHuu2t3jPzAKMqvCIm9LfUqSqhQF8aEYFKz9qQ7OH35zBjwttkeJbgurkAMdzxTgeA6gaX
	SlVd3eV7kn5JpVIjRzK552Pik1kYSoYXJTc29vxiQ7z+MFR9H5bOx/b8Ua85k
X-Received: by 2002:a05:622a:199a:b0:50d:84ce:e339 with SMTP id d75a77b69052e-50e36739144mr139764291cf.19.1776622958808;
        Sun, 19 Apr 2026 11:22:38 -0700 (PDT)
X-Received: by 2002:a05:622a:199a:b0:50d:84ce:e339 with SMTP id d75a77b69052e-50e36739144mr139763991cf.19.1776622958329;
        Sun, 19 Apr 2026 11:22:38 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:37 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
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
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH v1 04/14] thermal/of: Move the node pointer assignation in the OF code file
Date: Sun, 19 Apr 2026 20:21:48 +0200
Message-ID: <20260419182203.4083985-5-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX1zK0W8eECEBt
 lhg60uQL1PaccIXNUdRF/GgbM1tQZDmlNG7mDhLyxXGmUSk0nQXU1TbP4KPAYMKlxZvtjIqWL1v
 e19spEXplVfeJRKNg2gevYcCkJi+QKEPy2vqjLVxUVFcRXpeaAY0ZwYLQQOUKk8qmG6CaOVdUdj
 KTLCplhEOmR+U5zowdUy+XETUqKQfjsE2SBrJcbXYEckj4d357CPpOH9I1Rh+R4U/ACaZvmZ/BB
 jEL7dXBRlXUrSNXvyKoYmWNXXBRpPLHfTkqDbawTgSArJuVWg87GXNH9JGMujaujxe/sxmx0mF4
 bncziekuMpacfHLldJDp3ibzdirzdzptf2JWNVuIyVbNVPifS/4Q1oinpZbkISIMTrEcs9vGHke
 Y2rYUneoT/QfL77z65BffkheoAyWF/XXJm0qc2ffmAbaxQ43yssoxQlSyQarR3JJCtIkHiKLFMs
 ZgvRXLo+Srp+6Uz0U9w==
X-Proofpoint-ORIG-GUID: lrr_lhVKkLgRjUsjbx9rKQE7ecVTjpl3
X-Proofpoint-GUID: lrr_lhVKkLgRjUsjbx9rKQE7ecVTjpl3
X-Authority-Analysis: v=2.4 cv=FMorAeos c=1 sm=1 tr=0 ts=69e51d6f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=DEwMSQuYoAZka129e_kA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190197

The node pointer being assigned to the cooling device structure is an
action done by the thermal OF only and does not belong to the core
framework code. Move the node pointer assignation in the thermal OF
code. Consequently, the devm_thermal_of_cooling_device_register() can
call its non-devm version resulting in a more intuitive design of the
API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 1 -
 drivers/thermal/thermal_of.c   | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 35cf170f3fa1..26231acea382 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1089,7 +1089,6 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
-	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 35d542aac7f8..85fc78bc9e73 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -537,6 +537,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 	if (IS_ERR(cdev))
 		return cdev;
 
+	cdev->np = np;
 	thermal_cooling_device_init_complete(cdev);
 
 	return cdev;
@@ -578,7 +579,7 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
+	tcd = thermal_of_cooling_device_register(np, type, devdata, ops);
 	if (IS_ERR(tcd)) {
 		devres_free(ptr);
 		return tcd;
-- 
2.43.0


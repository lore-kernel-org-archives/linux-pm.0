Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC43FE377
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804531; cv=none; b=RAwknitM2c99nwWjEc+r/iLujeu/Yc47su45VHHWzaH9U6lat8zaP/a0F4RTaHPjljCdIZYPpQVurHRkPZxmWpCv09gg9z4hbsZ2uykjPpVoh7FcDEsk+XfQX9bokhMHWb2uCGc6VrhXkI6cJ7pJ/Is/e2gs1EG2NuJUEGuQr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804531; c=relaxed/simple;
	bh=k8cNf6pQ9FgDrZOTphnMGI85hDwnR2f4A1GS/R7x154=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5w89rddYLNdgWiwwx3RPKWuoFS2j0UyYeiEyUvkgu2PcC8k/xMuemzdxVYi6kdXeWRtIUa/z5PAamwAvcYbexWRD4jYvRZt7OSbeZSRM6lhG2W9VZcH4lQgBVyBz9pv4Z9VoBChtBhq7jZLNr0qUCA3+N408Xv72Wrw8kekB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wn1vNEZE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ge0X9H6z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wn1vNEZE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ge0X9H6z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsbhn1575548
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gNIUoFMWInZ
	GWGk42JVKNlbIGQZZPpc24UB5yZQypFY=; b=Wn1vNEZEsjdL+v5SX9/0N8w70QV
	3rBavCADHitOhm9o5L9FKHfsLkLQvR5E17kwgFHeEbUSYjVp4IYdYSsK1Ujhv39U
	vIa0hGw1628hHNr51guhV5hO/X2iCt9NP2i2MnuPztSZFp8qg/WvsaLAyVjx3llC
	oVkSZp/NuAhH1j+oOBJi4QeGnt6oi8tVf2N+DNqxwI57s6e09KAIzWjBUw/u2zKS
	rtAVwZbhKeI7PlZeU39hFIiqUikHHDilsIhLImrFzQN26LXA195ma55jrSNcUAVM
	IyfUuoc7582g8mYjFGZRys29hQv9nKjAq3yalzVIoveVuJPE0INWaejWTKg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqvwvfx8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:44 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69d77736830so8850248eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804524; x=1780409324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNIUoFMWInZGWGk42JVKNlbIGQZZPpc24UB5yZQypFY=;
        b=ge0X9H6z/5B9I/Bv6r5zPfDHCYZXmYpTzd7Wo79N0YXD1qAdfDZQtN8MHDfdWxql8P
         9nA8fhCnmyJuZU1+D1olwG+6cAncbzp3YxFS0navb0u5+M41gOtsl36f22gOLCqaH9Qx
         HOyUSc2sl1l6f/C8J42EG3dCEgDGUaThvn/edAKUNOXDWZy0usRmw9e9YBuBAt9Vo9tG
         zAxf4njDv1If4pm1pqzFcburUbDx3sdhan5UPKsSJbERhrhoyvM+LD8fCelfLaWmIIwt
         iqMasWf2x69paEInZkzMg1TR7GWA8WmTVRoanXfcjRgfVa1BnCOIXJJezdZ33IrangEF
         Jq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804524; x=1780409324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gNIUoFMWInZGWGk42JVKNlbIGQZZPpc24UB5yZQypFY=;
        b=cIZKpRl0WcKDCV2bCg585DEhW+gztoqrgCsF7LBSv6yTH+uR9EsqRQrSvVaCMTVRHy
         GmUM8TwlriVaqG1bqNZGd7TbJb9tlZEyNTW04mClGXyCsURfqtzpA2YkohjIOAyAJna9
         +bs9B60tSLCFEdSq32ZfXk1c17XLcmLYxniVqcs0ZCFciW7e2SEFVJvTOUFU/trGt7fw
         5jEXclEV7S1Hxb+4fa9vmdpoVuCcOUK6eRGPBWjwsEPmbCLJIfBmRXL3SwG59SKOKgxu
         fxzlTL6gKXJW7HH4hJCPvUOR6+rTM41uknE8SZq/FdLUBDaxvinxetv3c08dksFIQBwN
         UisQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9TQOVcUqRuoNxadXr+WV4dij2Llylyhags+W5AZSK1o89k05ow9z7yzzWl5NlHmNEyr6eoCjFIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6Fx3veiLBtbodAKXvIhEasew4b/IMHlyux8AuJJaMX92Lgss
	Ebct4Vt+x9HF2fCma1dmf4h0OcabRhCZ5AGIYB0RbFJ+SDAF/xDpC7758nXS7RpAKtcGBzFK0WQ
	ulWBww+e+XXWTXqb5NozxADnF3LIygzYtHbJx5Vdh87Q5aKA6gqyyi77KqAZg+g==
X-Gm-Gg: Acq92OEfyHQ6jOfumI1XsoQ6eAlWA8ZBGAgzpYxttk7inInALsALqGLBaMaK1ejYtvF
	GPT2/okt8sYyrRhNlEgN2mD/6Eg7E8s2Wsph87ynoT8+cOT1DsYtXV7SlJaichey8ZWucTB2x/K
	4PX79zrjnXpkffvUlcxE9hYFOrXMEwuDOY7eVz3polxhYkebHJRR5/gTN9pZvjebMRnOyiX9uco
	pbC7U5VJj+H5/HolZvrsRFoblbqQtqlqnjDAcXp74rI0pMxg6VsHf/gEfuITL+KbXO8a5erFsb2
	x94HrM9pZ+aq63VcwFqZD5eK0mNRVWcZ/D6yGDennQkRxFRzFVC/6ZEXjIvwufO6cGqdD41DUsu
	pzb3EG5KT7zWAcr9xVzEp6UextPZn08dnnOSxxzIM71mkjCxT
X-Received: by 2002:a05:6820:4dc4:b0:69d:d95e:773e with SMTP id 006d021491bc7-69dd95ee464mr765727eaf.8.1779804523986;
        Tue, 26 May 2026 07:08:43 -0700 (PDT)
X-Received: by 2002:a05:6820:4dc4:b0:69d:d95e:773e with SMTP id 006d021491bc7-69dd95ee464mr765671eaf.8.1779804523504;
        Tue, 26 May 2026 07:08:43 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:08:42 -0700 (PDT)
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
Subject: [PATCH v4 02/10] thermal/core: Add devm_thermal_cooling_device_register()
Date: Tue, 26 May 2026 16:08:03 +0200
Message-ID: <20260526140802.1059293-14-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3551; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=k8cNf6pQ9FgDrZOTphnMGI85hDwnR2f4A1GS/R7x154=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalFjOu/Eupq0yeBqZgLiBN5RiMieKlkrkVaa mvJy6hAKNCJATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpRQAKCRCoMiOKKk/o T2beB/0Skz8U9R4RpW/ZwuLg1Msk6E/CpxJVCNrxGtGCA1yAUTVsrxnGSwTJNdKTK9GQteR9xJn wfFhAJsjSemve5Zv2+JenlljY99q8+Lj6e5Z+pRg+lGAkKY4RXt8T+OLui3+L+moEU6nYqMpKFX 37XcK36B3TOST1QIPD+whdavFLB/obSCz+EcmjevyxXYy9D9Yvdyr6i9iKzvsSfyy2jxAPOFues k8geiSjPdDUA4Vj7o5nf51lgZ3Y/AqZpn2qD4JWU1JvUgu4dwVHY3e/OYoNAveqr4+y0c6ldSwZ 4n0l0fPWHGTVYZ/7yRgbNblviqnGVyRiBhB2Rauoifw7S1zV
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SPAac7dtdv_S2gzl-VL240rVM49df3qA
X-Proofpoint-GUID: SPAac7dtdv_S2gzl-VL240rVM49df3qA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfXz1hWq38dOoni
 mvlMELp0exZxJNP7DYeu5zy2LJxJQ+mSNbuj114BG5HLV4zXq7hLqXEU0zo405hO0USzNBE4fNe
 bb8Fvc6vn5iC/7XzYiRq7MtfDFgVyzl6ScxNQ/Hm9u1l6fGnN4uU2Y+329yOb97Rr56l7mGz6vL
 LeTh/fDmaq5PGrWlrGjJOMAgI58BN4sX/sOYED6cluzqqDO0HQpBv8Py330FP8zfSsfa/gcOwX2
 rk9CDxrMwiPtQMISl+0qnrc7NB+v6SnI6o0q9nP1B7qA4a2oEMU9VDCLmQ9B7senK0PLK+91SoS
 VxNWhVcUQf9xK8ywlpo2JU1B/lz0+NnVFf/D+1tZiMRICjL0V5c2mjOkuG5z1NNxp/OfPxVdHoQ
 FS+hhWz7OH5vfBAHVeiQZ4PYePCHW7Xu39NMbVv2d2QDlzc/FYRAldCEYuNUbH1qZI0V2OHYrLD
 MIXAuNFCHKNQ07LcIFw==
X-Authority-Analysis: v=2.4 cv=M4l97Sws c=1 sm=1 tr=0 ts=6a15a96c cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=SnQRsxpfvtI8DkFpaL8A:9
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260121

Introduce a device-managed variant of the non-OF cooling device
registration API.

This complements devm_thermal_of_cooling_device_register() and allows
non-device-tree users to register cooling devices with automatic
cleanup tied to the device lifecycle.

The helper relies on devm_add_action_or_reset() to release the cooling
device via thermal_cooling_device_release() on driver detach or probe
failure.

This keeps the API consistent across OF and non-OF users and avoids
manual cleanup in error paths.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 35 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  7 +++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0b3db889d60d..bb4fc3ff2ad5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1173,6 +1173,41 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
 
+/**
+ * devm_thermal_cooling_device_register() - register a thermal cooling device
+ *
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:	standard thermal cooling devices callbacks.
+ *
+ * This function will register a cooling device. This interface
+ * function adds a new thermal cooling device (fan/processor/...)  to
+ * /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind
+ * itself to all the thermal zone devices registered at the same time.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+devm_thermal_cooling_device_register(struct device *dev, const char *type, void *devdata,
+				     const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device *cdev;
+	int ret;
+
+	cdev = thermal_cooling_device_register(type, devdata, ops);
+	if (IS_ERR(cdev))
+		return cdev;
+
+	ret = devm_add_action_or_reset(dev, thermal_cooling_device_release, cdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return cdev;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_cooling_device_register);
+
 static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
 {
 	struct thermal_cooling_device *pos = NULL;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0ddc77aeeca2..fc3f4a098370 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -253,8 +253,11 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
-				   const struct thermal_cooling_device_ops *);
+devm_thermal_cooling_device_register(struct device *dev, const char *type, void *devdata,
+				     const struct thermal_cooling_device_ops *ops);
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops);
 struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
-- 
2.43.0


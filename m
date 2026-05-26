Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B13F86F4
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804536; cv=none; b=q7D41Dab5qTMhqchy7PgBZPBi1RNur+qeAC1/FCek05Q65Hyjg4dLdM37BCZeZK6ccS7ZRXN3cksismzZYwIeS+cT5UInbYopgHOPdr3t/A47HNg9e6UKKZLWfcNu+FmB17xAVmDyDQpzIIOIbPRD9zJ4DK0qR4pNqz0xnoBS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804536; c=relaxed/simple;
	bh=xSp8RQ+cRp+iJjemcowCzM0VEBS3QUR7GBBaVegTYX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDzScpbHoMj4AuOA6DN564AeZscyIWxVv3NZKY+44bCxFjfXhOEq9s+OSz/ReskVEacSGYPlKIetbY6sVtWLQfPRibvZtrjbyid6yeUJdKhJ5XQgM4wGePHbILY44QIu1yvjVt29XQEJTnU6qRgcmtW5mpNE9DCI6ZXKFbZFURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lJj6yAaX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hDpfsWUw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lJj6yAaX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hDpfsWUw"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QD40K83693562
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wfbf/NakLt+
	bgZ1wLWlsVbdVA1bK9sH95wexcnT+hv4=; b=lJj6yAaXk8t7LpUb3fMeYSVbLKU
	IAnMGD+FVVIhvTlsqWbz1tyHcy//bmELzuyszvaADBZ9rKwtBAuFH8njcQeedbq7
	4iTTX+/Tx1rG+6epAU2AkLNmtH6JuUyYClcXwiw7GOCCWtyCA9l4Jl3KX8wSnnvV
	n/sVMZptxKjB7DB1DKKesRTICenS8jXhcOhIkwquAKAfcaXnGAWBVXo3JeeHE6x7
	ApATa+OAGHzPn7VGeHoKjN/g7/EDm2C4tEhrodgCDlNR2kie3ON6zGjyiSdXWFKM
	1HFTKskbUsLIPZ4Llm9nL+uUuh4euIo/AggTi5sWXl5990Ap10xJ/Eyv5+g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edc2ygcpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:08:52 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-95fe0c05d20so4255645241.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804531; x=1780409331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfbf/NakLt+bgZ1wLWlsVbdVA1bK9sH95wexcnT+hv4=;
        b=hDpfsWUwyzfDHiyAzSL5g9atdxn1bXrc22BGt3NQuz3Ku4Vr7cDJaZSMG6sy7LMprq
         K+tnec8tt3VY6S8ej7z63VNGOe62HgmMW610sGozgLihGcAimV8XlG6zBGelhHnBYKou
         A04304uTNJzH/BvdztQHFVsp/9DGPZGKO5O4mZOT7LKm7RPCeB4hQJisso8H4P7Om53n
         Dh9YCrZo1KDuuUszcQoTGR48sBLJUdsv6JGqws0+iBmfP2nlC+9WFmj5E2r1mMO5cSAB
         v+UTHYf5swDSIbe7cSP2ECKGGi23hpNS5G490VS2vJrUoVvMG0/QxfJ4iQfzXsw5rpz+
         cSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804531; x=1780409331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wfbf/NakLt+bgZ1wLWlsVbdVA1bK9sH95wexcnT+hv4=;
        b=o4UMa18AfsWXuZ2wvcnJI4qm+ne6NRDIedkq3ETTZ6duvix2h9nyIhkOEKQPRcPAv3
         PwoJpsTVdPIrKOWX8mbHPpyznmnDsHxIBBA2BQQspwJl/XWdc+vXEZq598NVt3+8tIgw
         JoNSXl6G9FTYPheQhK9o1Gc93YNkgfGqFMB5KC99H28AX3tgFiTx2zjb0YQt+4+0Fk8L
         cJpSozag5awAo15jjXqV3O5ZJDGoTeWxQwh0K1giHO1MYJKbsI2yEMOovv5WhVRkVj1F
         7ecmTS9VJ4FZaXk/ckA8SJ2jLuHwvIMGcqW6mNekV+ad21OnY5fFKyo4s8PtEB+Scmvr
         Ifxg==
X-Forwarded-Encrypted: i=1; AFNElJ/7EwUMCuwQGh/veKvz8Fu5PQOcyyBJjcM4cwlNKlD1KPW4VPlbwBLQObajbKXD++aspbdtrGbB5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NxuVlsP1epAgFpt30jjMMzLHBPdOLoDwviE7HiFKpBwGdyMs
	Iy8dBpU6TPZuT2b6RMM+LozixyDBrYhnNfX5XjQssp3qINItoEpmDjqS/UUQHpOzZXtkcE5m9dd
	tGAPKF4Tq5m2h5Dx9unalfS/LkWcCO7PgOpu0zxZaw+rCcnaHPh7PLDKNgCJoGQ==
X-Gm-Gg: Acq92OHzhAWJ/KllxVNJAWmImtljSPHYG5ec2uJlsPuistY0V5c0M5gaEuBOY46BkM8
	dMBhqaJ95vhw00YFfNi4KEB8TMnPqM3R9F5VWxK8k3dgA8J3bxIrpfqYie+wBNYiDcySq8bWtbt
	Jn5nuql5pjeKQfp4kcVoRhB2gQM1uNMKuASSV6drXh/F/PU6fq4uAYHspwtWd7p2wjm63SV18yr
	zo/LnnLknVUqojHOa6pBkcPPaVIl12R8mLX8+0yAWiiWcwB5XTakfVho1sPuCTN2fD5QmnHwhAs
	7lnEZMmQ3HMlp0yQvE1xKviXe8SjzkgnpGXTuXyQIFRTL+lNvKaiR1t4QDpq6XhuK7c4ZfT3DcA
	9g+ESdaZj4sHOYXorNLVgzE8TvZdbiIEqkhWfBS1OpLLXmXRD
X-Received: by 2002:a05:6102:580d:b0:639:3b08:d64c with SMTP id ada2fe7eead31-67c79bd7cabmr9314466137.13.1779804530971;
        Tue, 26 May 2026 07:08:50 -0700 (PDT)
X-Received: by 2002:a05:6102:580d:b0:639:3b08:d64c with SMTP id ada2fe7eead31-67c79bd7cabmr9314345137.13.1779804530289;
        Tue, 26 May 2026 07:08:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:08:49 -0700 (PDT)
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
Subject: [PATCH v4 05/10] thermal/of: Move cooling device OF helpers out of thermal core
Date: Tue, 26 May 2026 16:08:06 +0200
Message-ID: <20260526140802.1059293-17-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12718; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=xSp8RQ+cRp+iJjemcowCzM0VEBS3QUR7GBBaVegTYX8=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalKucFmTsdrqsXbMLt6REZf5PinEK+Q1QPzc nEW2LqZfdiJATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpSgAKCRCoMiOKKk/o T48KB/9HqxDIKZIrwEqzIY7zNJ4ZFWw4A+ifGkIflRahJIdTkDPA5m+T0u4IKVxLaEYBiAaZC2A Adrw8LE6240tVEkAviHleKKHvMC7CnpsTzLVm62pidyZ3HK5QUtYd867HtlDacbMnHew5A/HmNf 0HGSa30L/BLP7l43ievS951O3v5acOZXIiIAzN0BDTkxZ+ONG7hlYEQjthriPQTOJTFtpjA+tzq xv9nfd1uu/zi5QKtd6UlItYB75DzfdwS4aaJtpHMOUZjA8M/xJ7ZfuOvmz2yDdlY8nZBYX+Lh4E Fz/botPArGKIIuJzigjcD2uR6DM5ul4KFweh9G8nF8jziVPw
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: omU2wY9fWmsKT1cvBHSsc3vN1E5tAJ0e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfXwnghLMybxXeq
 TAelhRZ6Jlg1hvsm7sLEH6igWJKD/GzRnP8Sflnx67Uyfa33FOswqNCcuD4PSDhh47oR5U4avJ3
 GnWbRogaqbFFf/WQbHnUFgFDLQ1iRrY1fot1xkEYcJSoIV0urCyQeNq1IKjdsGSAjcRMFzGCUsM
 c8Mw/mX2ZaPjNhP0+Zbaeqto+yjAlq/nKIeJMTXNi9CSGO+b2dx4YJlrserAP7WvSKq0Icc208r
 hf44VbIySbBBZtiyByNrzFo/dgLTHdvbHB991zXELT39xBi+OkTJT2qlVvEr/gAjPggNBogqj50
 o7CC5ALTCLomfYsopDIOvNGaiy3KHtoSTUTXNH/cEazesPJWj6jXGiFr6IldWq2UVul4OgQDtNk
 WFGSU8fsqRLtF60ahnKpwck4wmpR4eAgWoQ2dDBzFcCsMIleZGMxwl8h+QyncQh1p1K83aoSKlh
 gvrfVg2MYvV73sGpOeA==
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a15a974 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=TD8Nw1XDtrUtcxPOY9gA:9
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: omU2wY9fWmsKT1cvBHSsc3vN1E5tAJ0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260121

The functions:
 - thermal_of_cooling_device_register()
 - devm_thermal_of_cooling_device_register()

are specific to device tree usage but are currently implemented in
thermal_core.c.

Move them to thermal_of.c to better reflect the separation between
generic thermal core code and OF-specific logic.

This change is enabled by the recent split of the cooling device
registration into allocation and addition phases, allowing OF-specific
handling (such as device node assignment) to be isolated from the core.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 80 +-------------------------------
 drivers/thermal/thermal_core.h |  5 ++
 drivers/thermal/thermal_of.c   | 83 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        | 49 ++++++++++++--------
 4 files changed, 119 insertions(+), 98 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bb4fc3ff2ad5..28a20d4b475c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -963,7 +963,7 @@ static void thermal_cdev_release(struct device *dev)
 	kfree(cdev);
 }
 
-static struct thermal_cooling_device *
+struct thermal_cooling_device *
 thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
@@ -1002,7 +1002,7 @@ thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_devi
 	return ERR_PTR(ret);
 }
 
-static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata)
+int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata)
 {
 	unsigned long current_state;
 	int ret;
@@ -1090,44 +1090,6 @@ thermal_cooling_device_register(const char *type, void *devdata,
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
-/**
- * thermal_of_cooling_device_register() - register an OF thermal cooling device
- * @np:		a pointer to a device tree node.
- * @type:	the thermal cooling device type.
- * @devdata:	device private data.
- * @ops:	standard thermal cooling devices callbacks.
- *
- * This interface function adds a new thermal cooling device (fan/processor/...)
- * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
- * to all the thermal zone devices registered at the same time.
- * It also gives the opportunity to link the cooling device to a device tree
- * node, so that it can be bound to a thermal zone created out of device tree.
- *
- * Return: a pointer to the created struct thermal_cooling_device or an
- * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
- */
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-				     const char *type, void *devdata,
-				     const struct thermal_cooling_device_ops *ops)
-{
-	struct thermal_cooling_device *cdev;
-	int ret;
-
-	cdev = thermal_cooling_device_alloc(type, ops);
-	if (IS_ERR(cdev))
-		return cdev;
-
-	cdev->np = np;
-
-	ret = thermal_cooling_device_add(cdev, devdata);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return cdev;
-}
-EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
-
 static void thermal_cooling_device_release(void *data)
 {
 	struct thermal_cooling_device *cdev = data;
@@ -1135,44 +1097,6 @@ static void thermal_cooling_device_release(void *data)
 	thermal_cooling_device_unregister(cdev);
 }
 
-/**
- * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
- *					       device
- * @dev:	a valid struct device pointer of a sensor device.
- * @np:		a pointer to a device tree node.
- * @type:	the thermal cooling device type.
- * @devdata:	device private data.
- * @ops:	standard thermal cooling devices callbacks.
- *
- * This function will register a cooling device with device tree node reference.
- * This interface function adds a new thermal cooling device (fan/processor/...)
- * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
- * to all the thermal zone devices registered at the same time.
- *
- * Return: a pointer to the created struct thermal_cooling_device or an
- * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
- */
-struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops)
-{
-	struct thermal_cooling_device *cdev;
-	int ret;
-
-	cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
-	if (IS_ERR(cdev))
-		return cdev;
-
-	ret = devm_add_action_or_reset(dev, thermal_cooling_device_release, cdev);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return cdev;
-}
-EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
-
 /**
  * devm_thermal_cooling_device_register() - register a thermal cooling device
  *
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0acb7d9587ca..e98b0aa5aacc 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -267,6 +267,11 @@ void thermal_zone_device_critical_shutdown(struct thermal_zone_device *tz);
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason);
 
+struct thermal_cooling_device *
+thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_device_ops *ops);
+
+int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata);
+
 /* Helpers */
 #define for_each_trip_desc(__tz, __td)	\
 	for (__td = __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 75fb7663c507..8c49d449d43f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -510,3 +510,86 @@ void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_dev
 			       devm_thermal_of_zone_match, tz));
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
+
+/**
+ * thermal_of_cooling_device_register() - register an OF thermal cooling device
+ * @np:		a pointer to a device tree node.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:	standard thermal cooling devices callbacks.
+ *
+ * This interface function adds a new thermal cooling device (fan/processor/...)
+ * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
+ * to all the thermal zone devices registered at the same time.
+ * It also gives the opportunity to link the cooling device to a device tree
+ * node, so that it can be bound to a thermal zone created out of device tree.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				     const char *type, void *devdata,
+				     const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device *cdev;
+	int ret;
+
+	cdev = thermal_cooling_device_alloc(type, ops);
+	if (IS_ERR(cdev))
+		return cdev;
+
+	cdev->np = np;
+
+	ret = thermal_cooling_device_add(cdev, devdata);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return cdev;
+}
+EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
+
+static void thermal_of_cooling_device_release(void *data)
+{
+	struct thermal_cooling_device *cdev = data;
+
+	thermal_cooling_device_unregister(cdev);
+}
+
+/**
+ * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
+ *                                             device
+ * @dev:        a valid struct device pointer of a sensor device.
+ * @np:         a pointer to a device tree node.
+ * @type:       the thermal cooling device type.
+ * @devdata:    device private data.
+ * @ops:        standard thermal cooling devices callbacks.
+ *
+ * This function will register a cooling device with device tree node reference.
+ * This interface function adds a new thermal cooling device (fan/processor/...)
+ * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
+ * to all the thermal zone devices registered at the same time.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+                                struct device_node *np,
+                                const char *type, void *devdata,
+                                const struct thermal_cooling_device_ops *ops)
+{
+        struct thermal_cooling_device *cdev;
+        int ret;
+
+        cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
+        if (IS_ERR(cdev))
+                return cdev;
+
+        ret = devm_add_action_or_reset(dev, thermal_of_cooling_device_release, cdev);
+        if (ret)
+                return ERR_PTR(ret);
+
+        return cdev;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 60e596e7d7ae..6d1862ac187f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -200,6 +200,15 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops);
+
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+					struct device_node *np,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops);
 #else
 
 static inline
@@ -213,6 +222,23 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 						   struct thermal_zone_device *tz)
 {
 }
+
+static inline struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+					struct device_node *np,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 int for_each_thermal_trip(struct thermal_zone_device *tz,
@@ -254,17 +280,11 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
+
 struct thermal_cooling_device *
 devm_thermal_cooling_device_register(struct device *dev, const char *type, void *devdata,
 				     const struct thermal_cooling_device_ops *ops);
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
-				   const struct thermal_cooling_device_ops *ops);
-struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops);
+
 void thermal_cooling_device_update(struct thermal_cooling_device *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
@@ -310,18 +330,7 @@ thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-	const char *type, void *devdata,
-	const struct thermal_cooling_device_ops *ops)
-{ return ERR_PTR(-ENODEV); }
-static inline struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops)
-{
-	return ERR_PTR(-ENODEV);
-}
+
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
 { }
-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCE2EB856
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622980; cv=none; b=KCvWALIzzHAZK9yDPjNUiDKxEvKAyvuCl1yHZ8iEk++NbTBxEovhiBlcrxxXi6voDpyheOBI6E+4qlclb/1HE/raFnbaDYj3djyR+HKkO6VBA/2Y51P77ppwvS9I3R3Oehv3qAP10MWp5WB1c0PDE5zpkZd/EfDwI23KLA471xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622980; c=relaxed/simple;
	bh=qIr2LSO6D+VRNnsB+j6abzVrqDrxn26emwJAxmPi+dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t69ynWxxl48Klvohcsp6UE4ejxFrj1TaeFIbbe1UbxbDHflb9mQAPIhuyk0hqDcLHDpE/Di85vpv4S/XnFjLWT/sGQcB5KFasMzZaFYaI1dl6kiqeswMMkeQDjRsfrPXhg80+DkfC+2zEnVn1mx/09qo6pSsQbF84W/Gc063zMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UN0OqZdZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q3adaxDH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UN0OqZdZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q3adaxDH"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JGCWnR124769
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lXWSi0Khw8K
	Na6a8CumjpgrQ3+rYxh7RbfMTB8P3ox0=; b=UN0OqZdZPzhM3bB+CXDRgAs+f0y
	OytcYSBqZXuPFbDyJfIHWR5qyEAYVVtDlIgI2tsV9cDK9HgAPpBaxbViwspLetUi
	qM8YxxWtOBnZCMUROzJ9b52XbZNJcToHQiNucQv5Gn0RZmP6+Ohn6+aijGJjNbB9
	aNA5ICJBVJ7sIv+VxMZo7cEQVpPBRscEAsqjR23ciW1u9eLxy88IiaFnQw/gJKCW
	w2iCCmbe/ciaytF57qiIMNUz0L8wYXHscw4QDvzAcvNdp/dS/lc4Tn4fBnjjjnj7
	mcWd17EYK0xPtVn2fIsLncxDulfbyboLoyDROZgDvOL+BZMJo+/knnNIPrA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm1hx31x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:22:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b44f7b7bbso52288661cf.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622977; x=1777227777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXWSi0Khw8KNa6a8CumjpgrQ3+rYxh7RbfMTB8P3ox0=;
        b=Q3adaxDHuX6+DbHiySuO5DQtd26DNlL9GQTtxxMyLTXMul2jridZPLEoAa0Rr1gX+V
         Zhbfjpq+8UrSl6zjnSpDGNEDemEbtVMHYZhe2rcm13qT4pT1SpijAWcJIM6ecSnbNuZk
         7/13nP/2p9YKRmypj9zsi0H+iw0N9EtAkEI9aUlQiW1tG27wxM2g1g4S3IVVsEOdZD90
         zrs1FT7N+HIuoJLekH0loSOQUega8oSFbAZafSX/OrUuueL17LsNquHZDomNb9TtXX74
         wInGxTTWBjMqvGpnkXCrq/EdfCMTPhlrFw2I/tsY8QoFHbJgfaBotgkZCCYrdvj7zZNd
         paXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622977; x=1777227777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXWSi0Khw8KNa6a8CumjpgrQ3+rYxh7RbfMTB8P3ox0=;
        b=kkRqEBb0OO55Poo12diqSGOLCunwly0Gc9artSTqg/z7jV68HblYF6Qm0UjkPIE5RL
         HtDXRB7CQIEs1lbgS45+sqLqqb8UYrmtU106qSOCaZ1spEjaR8gDuG5pzTl+bqdWbE+/
         3X76EALaTjXDGTTmeM1i9m4MAL07hdnZY4/nAbribmZMJ8kR9cD35+r7P32TAWdxI12S
         w0C4CkQzdUlnB6x8QVWwMlj/838UwMAwIhZXe97Zl3oYLxeaIFApTXYZukQp54siYAkn
         Znm0Xd04tXjQQlIpCCwToWjp59Czx0lSY01t7Zwwia9uNg/7UV3N7KuOwSEbaPFGmw0E
         cghw==
X-Forwarded-Encrypted: i=1; AFNElJ9KuhXuCOCxC++mxL0nsuwGrCNSyQyyb9eKU3w7lIDIpDYXwkx9cU2BoCv9zO6d5RIoBM/WbkdbOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv85aKMP1EsGCZbaptKFKjAYzvztS9d0AE8tAa+nOf3KqQf2OI
	4a4WhWGmM/Ah03ze8++CiN1v5hMbU/NihV+TDiM71E0oD6cjLQSB8v0g27tX7h90SQPYuMcMcBa
	Ss9++sUhzix435OXfnWFEch8QtXfi/cktiaIL3OF6ik+dwV/rLJVJ2VmXj+emHg==
X-Gm-Gg: AeBDieuGvA2SyqnGUfHq+XsLK2sAtLjMmxaop2EzRWzMOOlFCca2WI10gSXO1T5S7qs
	gsBwqquwwv6R7oqypiUxlTb8ZYv1yM03BI2tAf5eA27pw25YGrz3oF9WBsdyFXWuWyMciAa++Hr
	CqHyVTqJIZOt0MXoHpPLVVGk1qkom4VkHK0U11bFSEqlVx/+E7I9PIPaWUcx+so64FBN0NcKe18
	yMpHR2OknBxUC4wNT6Iz4dnP05O3E+tA4z/nJeFReIIuUilOTyYil2ItVL4CVYAKVSDYSG+5pyR
	HASGZF+77Xdzvj+CgpwfvvQY3bZ08iUgn6b6OyrEHGdMNi25jTCUNy3sZWcpVUvvJvb5JhWe8aT
	OOu94SFJ68otsbBy6sdsxxB86gwB49zfWx9R9mzPFIwJa4zpZLhQtFxhg+ZsM
X-Received: by 2002:a05:622a:1e07:b0:50d:9d8a:ebe9 with SMTP id d75a77b69052e-50e36bb058amr164434291cf.27.1776622976596;
        Sun, 19 Apr 2026 11:22:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1e07:b0:50d:9d8a:ebe9 with SMTP id d75a77b69052e-50e36bb058amr164433861cf.27.1776622976136;
        Sun, 19 Apr 2026 11:22:56 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:55 -0700 (PDT)
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
Subject: [PATCH v1 12/14] thermal/of: Pass the of_index and add a function to register with an index
Date: Sun, 19 Apr 2026 20:21:56 +0200
Message-ID: <20260419182203.4083985-13-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: O8LdUAnmaVSMZhdv7mA7OIDDGOc9dUtd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX9T77z+XhkXGC
 CPWt62Eoy6vcfvIg0q9J4tO+ky0tjO8JJWn6ZQFjKp38Mvzgw2w/3GXHMryffrLKxVyiS3YF0Su
 /u+PlBuj8Md83GYdfRO/e4rjSjX+o+2v6hTrF1i6026o8tgjGPax84t6Lv5RwluCzxKwZFG3LFz
 Xo5bzcTAusmKHRHaHDtIbK4V5KCp5SSShKflWdsDLuW40SoLWz9+QOQH/UAUnHfOSFkyTsNXo2F
 /BzpeFYNaOM0tqq/nllE7ehCQ7v/ho5Q8EkjV0b2r3KT/Z5m57ntNmqG7BpDl0tBlKTYZFZUFKu
 yRTsFe2QgqujU755elrkCAXWCFHgGX1c+Zzq/UhMLfdc0xZNAiI22FHT4G1+BuBtQCfC8VK0RQZ
 Bb4EtEiAetpKkontdFkxuiGNFKvJK1r3hnJeChrF/uE2t7iiVXYLbGYTcsJtqFA0kdSk/kdBc+p
 g9tOzJbJJ95JbdY6QcQ==
X-Proofpoint-GUID: O8LdUAnmaVSMZhdv7mA7OIDDGOc9dUtd
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=69e51d81 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=V4iKOSeYOELjiAWC:21 a=xqWC_Br6kY4A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=KHKEB8RYcew9Qe18FDUA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190197

Introduce a new function devm_thermal_of_cooling_device_register()
which will register a cooling device and its id.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 68 +++++++++++++++++++++++++++---------
 include/linux/thermal.h      | 13 +++++++
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index a728da1f4e56..d9bd7dc01e19 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -551,6 +551,56 @@ static void thermal_cooling_device_release(struct device *dev, void *res)
 	thermal_cooling_device_unregister(*(struct thermal_cooling_device **)res);
 }
 
+static struct thermal_cooling_device *
+__devm_thermal_of_cooling_device_register(struct device *dev, struct device_node *np,
+					  int of_index, const char *type, void *devdata,
+					  const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device **ptr, *tcd;
+
+	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tcd = thermal_of_cooling_device_register(np, of_index, type, devdata, ops);
+	if (IS_ERR(tcd)) {
+		devres_free(ptr);
+		return tcd;
+	}
+
+	*ptr = tcd;
+	devres_add(dev, ptr);
+
+	return tcd;
+}
+
+/**
+ * devm_thermal_of_cooling_device_register() - register an OF thermal cooling device
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @of_index:	a cooling device index in the cooling controller
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:	standard thermal cooling devices callbacks.
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
+devm_thermal_of_cooling_device_register(struct device *dev, int of_index,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	return __devm_thermal_of_cooling_device_register(dev, dev->of_node, of_index,
+							 type, devdata, ops);
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
+
 /**
  * devm_thermal_of_child_cooling_device_register() - register an OF thermal cooling
  *					       device
@@ -574,22 +624,6 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 					      const char *type, void *devdata,
 					      const struct thermal_cooling_device_ops *ops)
 {
-	struct thermal_cooling_device **ptr, *tcd;
-
-	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	tcd = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
-	if (IS_ERR(tcd)) {
-		devres_free(ptr);
-		return tcd;
-	}
-
-	*ptr = tcd;
-	devres_add(dev, ptr);
-
-	return tcd;
+	return __devm_thermal_of_cooling_device_register(dev, np, 0, type, devdata, ops);
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_child_cooling_device_register);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 9813f02db088..b7e5496f3e78 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -206,6 +206,11 @@ thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *data,
 				   const struct thermal_cooling_device_ops *ops);
 
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev, int of_index,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops);
+
 struct thermal_cooling_device *
 devm_thermal_of_child_cooling_device_register(struct device *dev,
 					      struct device_node *np,
@@ -233,6 +238,14 @@ thermal_of_cooling_device_register(struct device_node *np, int of_index,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev, int of_index,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct thermal_cooling_device *
 devm_thermal_of_child_cooling_device_register(struct device *dev,
 					      struct device_node *np,
-- 
2.43.0


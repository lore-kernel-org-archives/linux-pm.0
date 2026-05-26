Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E2400E13
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804544; cv=none; b=bl6F2wkEs6WzR6WZbD/AVGMbVFyA+QrZBf46LAjfJbibN384rZJAXQ8j71aU33R4qzX3UJMgxwTbtXpMGFimffIChU0zzvab4bbJ1R/0VkL65L/XIImgrBQnbiNK2zWYKTnDhcoqoKUgdOPEkfFpMeO+TyhEE9q994jx9NWkf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804544; c=relaxed/simple;
	bh=z8OD6SBz6vhTrneqzDOBO6KmX9eI93f0HTmfNRU10i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNo9RC6od1xvc/WDZLFbTTFpjjzrG9jPkDTxy+ai0viqU4d+CQTe+xh6wzzB8XKqmJb5Dyb/FwV0S8P6976+D90xWjCvyk6GsW11kHDLq6M2n9tl1/uwogoEXXAcPBaDpGK5IpfYRLWNsIhKcvvL+fezL3WfSOohgcGkMy2y+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iVgk6FdK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eg9+mvO8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVgk6FdK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eg9+mvO8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsXKK1430476
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dLi4TiEmObo
	hvWqP6xSvpTLLg5OaciNehCFkM4sW88w=; b=iVgk6FdKFOAGKCv+W4aFUi2+3kl
	4T8nOjJHwZZYr4J0EMuJae1EKW2NTabJbeUBd0I52mQaJSLk46LeN2RKZhZ1K+zl
	Q5H06A/fYmbNg+0RMxHfquhj3poXlWssSfyFwaBJF3ERXVApq5nfMxmd4hJbcj9x
	jGUmnFr9Sd/RtOf+821ipMyseXSOIvVIvBZ8wwmFbbpdJuRkMgkblQMU0iepDVWs
	boP7ymY1lJImG95LjuLRtzK+zuadhj8inkDcScCFr0VZssIPjIbhSiV/T1jHaYYs
	dVS68tBRIBfT3utnO0YPdajvsg45akq4kx1+XwCjz8/JnhK8VC+8GmkHZag==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv5e0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:01 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9569b029e1cso4691566241.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804540; x=1780409340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLi4TiEmObohvWqP6xSvpTLLg5OaciNehCFkM4sW88w=;
        b=Eg9+mvO8TZBDVjyEnepl638ZPxoALHeXnBaRP8nZdEIGesh4raiujn4bnx0tk4Jn69
         Ipm0gUnpcXDeZb1V+w8xRKAOxiJZviPSRDwUHi6obauYvuzthavPHpX5o3fkysZIrTaj
         re0iJnQGu+SL9arbdKn5kzuLxW9mfWMCKR6Q9Ed3iCWmUIif9B4izsmy3wnLC/68ITR2
         ISYeiq9ucpLsVDFmwHf3St3zTO6R88s0tiyX9iXANEzX6JsZyXbrzTFdLHLjMdTn+oJD
         ej8O1PkIrCnz07mo4GHYAUUVd4rnwQEeiefSwwer/KFHHhy6Tg4kFtAwzz2Hcx0G/15k
         lSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804540; x=1780409340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLi4TiEmObohvWqP6xSvpTLLg5OaciNehCFkM4sW88w=;
        b=sq7DRgiAq7TP83rbnaYWgwC/wK5L/CUnwZHh56AliekdSrBMEmLIwGC1uHu1SVR9+9
         CywP9v9EjiFS77nG9FfxmAyzn1RyLfdqP6q/dAbdVt2g0f54oZWyIFeVut4PLHfRgu/8
         TxNpYq7JrkBO9loH3EacF59oYNABfFIz08x3hlk9fcz3K/jk/9qCMMOVeuvhS/zKS5j8
         A9szOH2delJm4vVZKggFsVe1KgKLemDO6YaowDg3ljqGK+ovILcN8u7mhgD0O9g0b5mk
         19WnJwiiyCWdPVANDbL61pMAX4shMDdIs1BCoQ7aMqkW7cB1MC9QS61Oh2FSIKhNzma0
         LwCw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZxO+AROqV/aOv2h9qECanRu+aTOAxzREjGBbN4jym9/a5raWLx7tTWliMH89ZFzETvpckHSfE6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDGkbjFxee49kkSinDtVzAcT3ts/ruvnCvmfYyRBN8WXzoZkf
	WLBtZ8+dBVmir7sgo5XXqG34LGOLCJowh/yLHiNvDVVlbZbvcSbLZBSFfDgRae3XCEDLJUjdSHt
	dZnkxFvk6aAitlqz4X7A97r4DbHL9D4AkeVha46FlpAVhBmUJGYSTyyPJ7eU0CA==
X-Gm-Gg: Acq92OG1tAHQ6IHfvRwV2nkZDXEO0B760ogpNiAg0vnm1IMSkXSumjE2OBCXIU89ayE
	HXFlxGr3iLJn8YER2YHzIUdZ57IMT+grRSL1u7NPn0qzWYGgCdkLxOzEdzXuSygP3f0TKOZtg24
	xSiJQLdGApM4SJz/BR6GW40S9Mc5A64/DQhDahS0yiSFnxwwe7JeoejHeaKziXCSJAs8PYxQbRp
	+Wyh7IxRP1dqz+M72XORCo+raTkTTFm/RNO/01hSa447aYNSRkU7EsOwjp5TGJUc2Qa4sfjhr+D
	QLNwG3T3r5vkV9x05XcNVImcir/gfONA5ZWMqarUkzS5yF1ih6pKlMldfgEIy01TiHyo96+0w/h
	9NnI3iHXh5Gh8BCPXf9iUupwpnBOcd5xs3sk8khtWgsJTO9PePDezwfyG1IU=
X-Received: by 2002:a05:6102:3f08:b0:650:aa33:5f2c with SMTP id ada2fe7eead31-67c738b4aefmr8963758137.7.1779804540228;
        Tue, 26 May 2026 07:09:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3f08:b0:650:aa33:5f2c with SMTP id ada2fe7eead31-67c738b4aefmr8963650137.7.1779804539520;
        Tue, 26 May 2026 07:08:59 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:08:58 -0700 (PDT)
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
Subject: [PATCH v4 08/10] thermal/of: Pass cdev_id and introduce devm registration helper
Date: Tue, 26 May 2026 16:08:09 +0200
Message-ID: <20260526140802.1059293-20-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5343; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=z8OD6SBz6vhTrneqzDOBO6KmX9eI93f0HTmfNRU10i0=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalQPzyVx00QyiOmKO+cWxf2EPIsl9f/HZaLW rypI+FhY3mJATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpUAAKCRCoMiOKKk/o T9kaB/4/ayPUE2+dEPnc9mPrj17ntlSinzmVQ1dXiNjTxmtqOXhy/8eIGrwlRbI2f7RBwElkAkH fVVjzH1nPpo8366Cz6jjzKevixWsANHo9VL0TnzX5dDbGV60iZwcul8gaaQl3TYogOblqt1F0K/ noodSftrodDY0Pq+xdb1QYzzNTe1r1MePaV3DXdCObjfLJ+OQh/BQ0/Mje2ER4B4Al2P60jl6nN Qh/6S0J/Pe9duBd7eJmDJu/drZWk5afUytqxtp/k2Hf/pVdvLDSoFm6NFs9VHDwBHeeMkv7xYmg FbJmkK7OB3jTcP4PDm0Dw4fSo7UXxi/JTzT9ymdx9Vn5S5HY
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfXxOYrdPoDXEoT
 UgFiltbYg/kAoXsurq1HkrTo01Jr65SWWESOZHEA3MI6akV5oJ5Rzp5fdxR2ykR5U0i7naRqf7v
 2Rv7atFks3X2+XBg8vJqJehsD2VMGKrSwEy42v0yiL3O1PtMOxcIDxjwXrw/Cn36nxS5i1vwHGn
 1tFA1fEpVJPUnqeHicfBzlA8jQTTZu52NNJtq0SNAZtqhCJ1Ceweek6M5obsfxvS/YqwjboTpzr
 jFSO1wu8WQl8jnNBVQ9iZR5ngTuvaa16/rA1RL3ubwDNG8DydQH/b0aMCzUULV1ggGHAdbXGnwg
 Pn3Xu6lGvEBdz+t/gK7m4TA4ov325fU9Nu5hTeRd25f/SoBXpvVswTHjh0vvNWO9VweiCXKvxDN
 1Hsqp4kPhnisikSjtgNStEDzI1l1ghkPhB89ioLFhKJhKsietn0f5S+WhGnzwcbfPHvWVHAoYIT
 jNPkW+5ueUPfPlPYbog==
X-Proofpoint-GUID: 7lbB8qycbpX8yytKM4j0-wOF9sS4myU-
X-Proofpoint-ORIG-GUID: 7lbB8qycbpX8yytKM4j0-wOF9sS4myU-
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a15a97d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=vPPyk02ySupRDbnf7w4A:9
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260121

Extend the OF cooling device registration to support an explicit
cooling device identifier (cdev_id), preparing for upcoming DT
bindings where cooling devices are identified by a tuple (device node,
id) instead of relying on child nodes.

Introduce a new helper:

  devm_thermal_of_cooling_device_register()

which registers a cooling device using the device's of_node and an
explicit cdev_id. This complements the existing
devm_thermal_of_child_cooling_device_register() helper, which
remains dedicated to the legacy child-node based bindings.

Internally, factorize the devm registration logic into a common
helper to avoid code duplication.

Existing users are unaffected, as the child-based helper continues
to pass a default cdev_id of 0, preserving current behavior.

This change is a preparatory step for supporting indexed cooling
devices in thermal OF bindings.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 58 ++++++++++++++++++++++++++++--------
 include/linux/thermal.h      | 13 ++++++++
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 0110b195f7a3..3584024b76f5 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -558,6 +558,51 @@ static void thermal_of_cooling_device_release(void *data)
 	thermal_cooling_device_unregister(cdev);
 }
 
+static struct thermal_cooling_device *
+__devm_thermal_of_cooling_device_register(struct device *dev, struct device_node *np,
+					  u32 cdev_id, const char *type, void *devdata,
+					  const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device *cdev;
+	int ret;
+
+	cdev = thermal_of_cooling_device_register(np, cdev_id, type, devdata, ops);
+	if (IS_ERR(cdev))
+		return cdev;
+
+	ret = devm_add_action_or_reset(dev, thermal_of_cooling_device_release, cdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return cdev;
+}
+
+/**
+ * devm_thermal_of_cooling_device_register() - register an OF thermal cooling device
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @cdev_id:	a cooling device index in the cooling controller
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
+devm_thermal_of_cooling_device_register(struct device *dev, u32 cdev_id,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	return __devm_thermal_of_cooling_device_register(dev, dev->of_node, cdev_id,
+							 type, devdata, ops);
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
+
 /**
  * devm_thermal_of_child_cooling_device_register() - register an OF thermal cooling
  *                                             device
@@ -584,17 +629,6 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 					      const char *type, void *devdata,
 					      const struct thermal_cooling_device_ops *ops)
 {
-        struct thermal_cooling_device *cdev;
-        int ret;
-
-	cdev = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
-	if (IS_ERR(cdev))
-		return cdev;
-
-        ret = devm_add_action_or_reset(dev, thermal_of_cooling_device_release, cdev);
-        if (ret)
-                return ERR_PTR(ret);
-
-        return cdev;
+	return __devm_thermal_of_cooling_device_register(dev, np, 0, type, devdata, ops);
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_child_cooling_device_register);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fb7649439dfa..81be6e6061b3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -206,6 +206,11 @@ thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
 				   const char *type, void *data,
 				   const struct thermal_cooling_device_ops *ops);
 
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev, u32 cdev_id,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops);
+
 struct thermal_cooling_device *
 devm_thermal_of_child_cooling_device_register(struct device *dev,
 					      struct device_node *np,
@@ -233,6 +238,14 @@ thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev, u32 cdev_id,
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


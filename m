Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAF365A14
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777992302; cv=none; b=Uiu0hOgV8J9Rx3tkWsiMb7o24dCvtuHZYBW9nczRyJpsmdgAGaQYR1k/SOFB6fnPtWDxbnVtKwDiZ8Bq3OI3euQPUKJTuKhXbomF/OXH5xTBmKKJsa0Cyeey3dgLrFW7XnGWxLChk0aXaejXhUDK0294xE63Yw+cme5T6U96Ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777992302; c=relaxed/simple;
	bh=IU/cdzUqfeGxvfFTNL/M2rcmyaOccfuj4+fvZ9iKlII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGd+Im76hV0hhyDSWrhBpCwUrIFUImu6E620BjruAhJY1QnN0M8ceMGT+qhJSHBLiV0u+CSddJenfzKvU0ovTx7b738jId0h0tUXTpBEu4DPxYgPDsXK83AYXwqXAUXDk/rrmh9/7I52R5vHskuRipuQ32s88IqP52dgt3aTiJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fx1vILPK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JdXm1ApT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fx1vILPK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JdXm1ApT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645B6PWN3091479
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 14:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=F/2DXIW8O7JiMZgQ32rB3ikdUmEbQGqpgJc
	U1snQGfU=; b=Fx1vILPKD9TSFkF7w9iLgvDV+pDGdn7gTKHqTZoyGPN1zEp4JuL
	pMVeCErbZf2V5U2z9xp1E+74Rwyz3d6R9IVzCQNCkLTuDoOnrhyuCt5Iiv4kkUDc
	UgPFPPPukrgOOQlgy6HPmO3nzSi83YgSiXlEk0AOBro7s6DNSkf4BOG3Byh60G2I
	2QUkHgYh9X//xehHOGoK0uOq3bjAHHZ10+iHSlp6mf7uVE2dV8Dwukq98qnxteui
	EYxRbrhs1bKgmPhIGZavsGojQlYfpQyx41RKcNaSTSTa34vXZz3neUzcBAsEwqJe
	QBnYGpo5INMqp1tonT8JVQzKt9lt78l1hLw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyfct0srw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 14:45:00 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-62e66a6ee35so1521538137.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777992299; x=1778597099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/2DXIW8O7JiMZgQ32rB3ikdUmEbQGqpgJcU1snQGfU=;
        b=JdXm1ApT2s8L97MA0GO/tny8K4dAzikPqNR+UNKC+1e6E13AsHUsx2pQWti9xL4Xif
         9ren3PH1VvMUXIRNMfyg4TiW3PrEAWHSSG4E1IN/DQTYgV0DNQ1AB7e24JjukXvqH4gp
         J9NUVnBPtEn+UOrFqYtLHFM+Qh1ckAcihFDf0yQv+KiwNYC4Q9zm2eEyu4iutFTQdoOX
         tFiuHwV3GFTgClmjqJKACRwVKD94KEGwea//+AX0WaASWYgJHaHreiroTe5JK+4p1ZHE
         RqdbBFFcPhqqbb6MwpXyjjOXN/nPDuYj9rBhsPSgSdM5KwTmhwopsOSG3IxyWmdDqiqZ
         EcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777992299; x=1778597099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/2DXIW8O7JiMZgQ32rB3ikdUmEbQGqpgJcU1snQGfU=;
        b=GYhP9SHatmJr5V6iFSz01cQYwXm5OL+/yQv7Yd4ckgGnj3HJnl1x/DDiCmAlso4bHi
         jJAN7Nf8MoWUc2ym9KzwSEOuOb1ln5qvsk3cof0RZRppKa6PHuaOnLvsOjKUGXUcsrhZ
         yflmWNHhVzAMGo89KdeP9C862duxr+8q54Ru+8eVmc7spUEGF29zf8FjB9ALO6z8bLQp
         eoiazXOD7yX65E7MsHv73KrGksalpNKcBypbbRLfO/Qeq1/80kg9k+uXO0ZY3Fht8ECb
         67AVUJwiiXb+h3JLl9gn2TZVsXLVOtu3UXQEqi0noECcrsjckQp4R5s8tmbs1Ba8VahX
         eMIg==
X-Forwarded-Encrypted: i=1; AFNElJ9BWfO+Z18kWtfFXB93GjpxIMNtZDGA+sQGWFxPUfDPqERIZXCVrjrTz3NoC0gEToAEN/BUVLMFVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hXrYouLU0lLU3N7uK1JSzYvyJHcO8sHpG7sl5e0/tuQrnuzZ
	zwMAuIAMbMPu8nkjxd8d78zx9Q9x43yqDZZQ6GWS/zaUJKvOamGXqzc76NiYlC/vJrqoq3XrfPE
	Eo4MZWKRsHvuNnHZBldmUumU5f1o0HnHggA0ONY6yua3630pJBdPjN1ZHKoo2GQ==
X-Gm-Gg: AeBDiesi5Nj8aU1i3Ib89PqO1WEg5SoAehH+D1D+wDhJ8GFUHicEFImemRoNqdMre3X
	QcYfEOAdT+Jo0NehrrFDvEJe9a9tV1bt/7heCb+vKvQqqjVoP2/GBPeSF29gA6w/L8u9l0E5Ocq
	xCuyxbGAALpM/gcilX0VeN3CqZWLbEJJsSmWax5f51heBhqsmTMolbLU3LusbI9zVW6lefOyJk6
	1NqeRjgdrYC3rnsrNHgv/VE0lc91DB1oHvGHPOTf/xQQKfbXqwj9YvDWvNAB5bZ5rp61bcO5/mG
	U0i9fcdCsASg3ibce81QQUOTzKcxGebVyG5fNTrRcg5kG5uXxcDFxppbK7cWu4nTmNR1T9nGzrT
	w/Vkt/wPbxZ2IFFmtIuf8a0ZyzSCqFCjSy//oUGd1XKBmEz3z/GUzV1QEky0=
X-Received: by 2002:a05:6102:2b96:b0:609:4db5:de7c with SMTP id ada2fe7eead31-62d85ad9d4dmr6934918137.13.1777992299191;
        Tue, 05 May 2026 07:44:59 -0700 (PDT)
X-Received: by 2002:a05:6102:2b96:b0:609:4db5:de7c with SMTP id ada2fe7eead31-62d85ad9d4dmr6934903137.13.1777992298745;
        Tue, 05 May 2026 07:44:58 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960022sm5138984f8f.26.2026.05.05.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:44:58 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, daniel.lezcano@oss.qualcomm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/core: Split __thermal_cooling_device_register() into two functions
Date: Tue,  5 May 2026 16:44:47 +0200
Message-ID: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eH7Pf-G1w-EaUGT92Q5kq_vlHgokbhe1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MSBTYWx0ZWRfXwBaud1hF8Ebw
 /FkXywHlsxTLDA6LaP2RVz+vLJW+Dxa5fWTmB3JW85nlm77OkPVBTDJRBFiEdbGkYKENitcdgwT
 wOGMr96MNQwvOPj2Fe6KmxjVn5hTNsbbf6/SZaVZIh1/AvTG8H20p3STX4Gs3jrU9guIJaA/iGE
 PUEOdKDo7v/0hft7eRvO+77tNsh2kjrr3ZHWd5Zr8U6NKFWZry7/9WzOB01plrklNO54HjAQmer
 1XONx1LcUNnQVGqfps3KbiLKKATOEDn+44f2uB4nJikLJdqAFR8v9N36J1voJKFPRCH6j/lEbsz
 mzFcw39HMA4WWz9AdpQCWuSbYhzMRBS2tVXjsqECA7g5RdEpMFaVLUL0CSpyLnrpeli6ZSnqSFo
 rcm0Z4z9xOaguDMTS48nt1MtgnKRXKfB3gVIEsBX55pQ9w5EoB37baCasOdMIkK1QKFE9RvlzhD
 9Yxk9pY73q+JaJQ1JTA==
X-Proofpoint-ORIG-GUID: eH7Pf-G1w-EaUGT92Q5kq_vlHgokbhe1
X-Authority-Analysis: v=2.4 cv=NtXhtcdJ c=1 sm=1 tr=0 ts=69fa026c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=q-1SiEWiNDsYHmDIksMA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050141

In preparation for the upcoming changes separating OF and non-OF code,
split __thermal_cooling_device_register() into allocation and addition
phases.

This allows moving the device node assignment out of the core
initialization path.

This change is not a trivial split. The lifetime of the cooling device
is managed by the device core through put_device(), which triggers
thermal_release() to free all associated resources.

With the introduction of thermal_cooling_device_alloc(), the allocation
path must mirror what thermal_release() undoes. In contrast,
thermal_cooling_device_add() must not perform any rollback and relies
on put_device() for cleanup on error paths. This avoids both double
free and resource leaks.

As part of this rework, add the missing device_initialize() call when
allocating the cooling device.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/thermal_core.c | 117 ++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 664a4cc95199..fd4c61197d1e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1040,29 +1040,10 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
 		thermal_zone_cdev_bind(tz, cdev);
 }
 
-/**
- * __thermal_cooling_device_register() - register a new thermal cooling device
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
 static struct thermal_cooling_device *
-__thermal_cooling_device_register(struct device_node *np,
-				  const char *type, void *devdata,
-				  const struct thermal_cooling_device_ops *ops)
+thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
-	unsigned long current_state;
 	int ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
@@ -1076,6 +1057,8 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
+	cdev->ops = ops;
+
 	ret = ida_alloc(&thermal_cdev_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto out_kfree_cdev;
@@ -1087,17 +1070,36 @@ __thermal_cooling_device_register(struct device_node *np,
 		goto out_ida_remove;
 	}
 
+	return cdev;
+
+out_ida_remove:
+	ida_free(&thermal_cdev_ida, cdev->id);
+out_kfree_cdev:
+	kfree(cdev);
+	return ERR_PTR(ret);
+}
+
+static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata)
+{
+	unsigned long current_state;
+	int ret;
+
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
-	cdev->np = np;
-	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
+	device_initialize(&cdev->device);
 	cdev->devdata = devdata;
 
+	thermal_cooling_device_setup_sysfs(cdev);
+
+	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
+	if (ret)
+		goto out_put_device;
+
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
 	if (ret)
-		goto out_cdev_type;
+		goto out_put_device;
 
 	/*
 	 * The cooling device's current state is only needed for debug
@@ -1111,35 +1113,62 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (ret)
 		current_state = ULONG_MAX;
 
-	thermal_cooling_device_setup_sysfs(cdev);
-
-	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-	if (ret)
-		goto out_cooling_dev;
-
 	ret = device_register(&cdev->device);
-	if (ret) {
-		/* thermal_release() handles rest of the cleanup */
-		put_device(&cdev->device);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto out_put_device;
 
 	if (current_state <= cdev->max_state)
 		thermal_debug_cdev_add(cdev, current_state);
 
 	thermal_cooling_device_init_complete(cdev);
 
-	return cdev;
+	return 0;
 
-out_cooling_dev:
-	thermal_cooling_device_destroy_sysfs(cdev);
-out_cdev_type:
-	kfree_const(cdev->type);
-out_ida_remove:
-	ida_free(&thermal_cdev_ida, cdev->id);
-out_kfree_cdev:
-	kfree(cdev);
-	return ERR_PTR(ret);
+out_put_device:
+	/*
+	 * The device core will release the memory via
+	 * thermal_release() after put_device() is called in the error
+	 * path
+	 */
+	put_device(&cdev->device);
+	return ret;
+}
+
+/**
+ * __thermal_cooling_device_register() - register a new thermal cooling device
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
+static struct thermal_cooling_device *
+__thermal_cooling_device_register(struct device_node *np,
+				  const char *type, void *devdata,
+				  const struct thermal_cooling_device_ops *ops)
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
 }
 
 /**
-- 
2.43.0


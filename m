Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EF2F7EF6
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049422; cv=none; b=CuBxIkZFXbhgjBeCDoZd+khN0oLG4BFScori7ZNEPulaFHKmqbTGH3HOu1qXBGfD/szXVKHsPjAOUZ9pqJb1AeRyznK8Lb8GC6KmZrePh49MeCHATsc8dq7SjWvY1wn2J7Z9bQwc2Zt5aCS90DIRe8v51MrWWfVtXnz2fV/yLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049422; c=relaxed/simple;
	bh=/IxZw+rPFwV39zq+p6TpSHd4rD601RR4H9Jp0jIyzsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/L/+V+Z6A57UZmlt8muM6i4FmsL6CGCFOHVJPQsTPB5uH5/Jy65oPJrChT6VpnI+gaUCymD7NRP4trbnTvquTgftmgn/vE+6Y5FB+o4NqXZ+DNmubX5wTEFJ9VdJcdU+vqNSr66P1EEiqxJaxbZX+c01H3K/+V+2dWH//9IdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pQRQxA+/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gyfzShLk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pQRQxA+/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gyfzShLk"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6lkT1068091
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	icPHz4GNOy1/1gIz+yOBY3gb4ZMu3uYYLdHZrFuqdC8=; b=pQRQxA+/1t/wHLtp
	9bH7qrghD7GWtYyd9/rP0xceQn03HfHHxwiReLYufo6O1c6lp/JoD801sHtZ8N8M
	eCDc9vRoIJCAO8bGYEZLUzaNM8PSbpLYzjgZVomAHZeYv5VMH/Xt1b8WwPasbGDk
	yOWEjTUkG+IJ6+DxBPgjkVAbS0ArwGpcZRwy7+90saDzN6TA9yGHDZ1vfiKzFgu9
	jbiLv8Vw7LwANZ797B899Bh07TFr3HOT1lvxflM9YoNeuYx51zMUuYOeGc+Tv/x5
	Bvqsy2ssn87mR2JOQ6cSXHYvPg47uvT/pP8dSeHR1p+5K2Afo7cZHCbEN9GLPvY2
	iEgeeA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq1cxp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:16:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8485d853b08so11326216b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784049419; x=1784654219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icPHz4GNOy1/1gIz+yOBY3gb4ZMu3uYYLdHZrFuqdC8=;
        b=gyfzShLkt33ffA492CKvj/nHgcxx9a/tlkHMIYO2IzJ4y1bhNBZxPrcwcf+APy6VMJ
         Jrl8mE5R0AzXCucXmPyxMBIcyJQWi4LSw3zKv5QANzvVlwmkL6d9+QoUbHai/12yXx2J
         baTiBuat2vPCcln9VY8VjdG6ytTZrf2JKmzbe4uh2DP/p2/NPz2hiQu1q4/Cv2KTGt8q
         cBG/ilv2R+FMUwqyTOchFpmLSuyFV7a2MYihXnF8ou3w0Eal8ICTOdZsNubO/w8jVCuU
         V78+rEvZiq8F5ZvhtIkN1jrMAZH+RV5Xo+D6VqUI3Oq+QIn5rjVvzsubwKnzQLrfAA2E
         A4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049419; x=1784654219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icPHz4GNOy1/1gIz+yOBY3gb4ZMu3uYYLdHZrFuqdC8=;
        b=omT7u4n7OEJosUYu5IcqDFWlzUAXuxaONp9KmaJpAH/rzOux5cFVT5GlM2xdX1K+hU
         JHEg+0CQ9AvW8oOHnkfwWA1FC5cLGXXqRsyQsN4TnwSxL1rwRrpJyJNA9pOoHHs9CIYj
         UYwdwGix3lJ0xx9s2a3NTm+0q4vvMz/39AsG/B1NuksuMt6/RxiAJF7XoRVoRZziDsm7
         0OJhtOuyhrazD7i5lzqFZqxNeBhDmZclltyAB3zPBbXxFEoFTxlLVAXk4ehMT30G6+tW
         4sHCyM4AP1X5Zv6k4llbD1U9apY2L+VhA1axfFWKO2wbZjHe07b6mlrImUBXjLoKnwpa
         58mg==
X-Gm-Message-State: AOJu0Yy0BaorQ9Jvs+aZDQEh+8sCuXZREI2TQwbd6Y3YOq+8Ui6O5mtR
	vdGF0vU8pvhH0KA/zctq2UoUYS/+JJsDIS+jTpxIJ6De+CbGRE5lOScIK/SGKbJAmpvsH1y0y34
	AWzBq9UyOKL7fWh3eLk4267v0c83T/T+NAhHb7CTkYkybWV+r1vcOJjOIKnY78g==
X-Gm-Gg: AfdE7cm79LHOC6Tla0G8zuUIfAGUULrjuaKMQ6C30q9i3Eu5XLipuJuvIFs8aNHVnaT
	xsgQKIAcd7RuZi7cnu385N5Jfn2leonaw4l/AbizBWgJz1YMggk20Z45q8oSuAPC9x4bqlBdFgq
	Y5Cx3Kpy8aro4fIMJ7rtD6UD5NckQ0g3/tm6OZuRJAgeGloS/nPhSLJMa/+MTuAi+8ucwEM2Jiq
	EBPzu5wxiLKj5MTHTWq2Jcch0uFFdEYW6YiXuBCsm/UJxmivECs4YW5+46fcaPOFxBcm828GwV9
	nPVHlXjSsS8K5NeO4TJpLdS41z8SZDn8nVYsk5aTOhq83pOlikuyoYE+hirpJluLNKFxOPafJ1C
	iP3qcIGQjEipkm1ngOtO14ozGtGc/HvJaUooG1MZRoY0Pp5Q=
X-Received: by 2002:a05:6a00:b8d:b0:84a:2d58:15 with SMTP id d2e1a72fcca58-84a559b1b01mr3517998b3a.57.1784049418864;
        Tue, 14 Jul 2026 10:16:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:b8d:b0:84a:2d58:15 with SMTP id d2e1a72fcca58-84a559b1b01mr3517967b3a.57.1784049418391;
        Tue, 14 Jul 2026 10:16:58 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a5bfcc2e5sm731773b3a.56.2026.07.14.10.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:16:58 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:46:29 +0530
Subject: [PATCH v23 01/13] power: reset: reboot-mode: Remove devres based
 allocations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-arm-psci-system_reset2-vendor-reboots-v23-1-e7453c548c21@oss.qualcomm.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784049398; l=3945;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/IxZw+rPFwV39zq+p6TpSHd4rD601RR4H9Jp0jIyzsk=;
 b=FOkQfPXWoK1qKl0kI0Ie+LmI64jVoDcFZgWGS8EMP1eqQh+aDqSNIUpOAP/s/w438Ry6H1wC6
 tPpdm8vhetwDWabHr8DUbmoiap1etgE61m9idry1GmUboP18+EMoF3E
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a566f0b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=QIdouwm7mKRySFGJXRQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: 4ALKqUh6X2FkHZmcQw303HUC3m2Kk4qs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfXxoesVgszhpUh
 9F7imsmAei8ov8xHtsaYgXdrFl9qjf+MnIj4okFQ42COC8yELeLrCsmpGdmEBvApwmxJSrLcq0Z
 IHXuEKWYqiwoLR1PVTw3dL8Rs+s0nxb7RNlvQPPrbSO/DZt+V1pTe5W2YFOuGcvFhVXTZkzGGCC
 +5na6uYGDkKMzBcnQc8o+XcYwpt7wRqAJdr/RPTrVjEiuMLa4XuAH/8aFtA0t/3dl7fZncyxL6x
 /fwhQnB8krES0VRAtKlZMVGT8tFR2ZUMa2a2cHaoZtM4lT+0o4nQ6GfN/S9ri1vYPzodiydBI2J
 E7cIvlNdCPGDDJ76e9fwUJL3m35yAxhR7iT2ubFMNIct4O5BDL73iVFcBpQkbsUP8l2YBt1pQaY
 1PLqd3qILG+UHyHilZsTMopWrIEPd7fLrZEm9CPok1554/34xz/rPoKPAafrGXo2F0x9xk4Xykw
 s2DIfv+FTRdcMVoGWFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX1WCVcYL7Ut4d
 EEX9xRH4CDP0KQs5nQhIx/vXpE0d3CLe9D3dV9imA60Ejib54jgFSTROae0+rnBvvywob3b9u+M
 /uwSCHkYKkT+WWUpfLmm1dw1U8A4XE8=
X-Proofpoint-ORIG-GUID: 4ALKqUh6X2FkHZmcQw303HUC3m2Kk4qs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140178

Devres APIs are intended for use in drivers, where the managed lifetime
of resources is tied directly to the driver attach/detach cycle. In
shared subsystem code, there is no guarantee that the subsystem
functions will only be called after a driver has been attached, nor that
they will not be referenced after the managed resources have been
released during driver detach.

To ensure correct lifetime handling, avoid using devres-based
allocations in the reboot-mode and explicitly handle allocation and
cleanup of resources.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index d20e44db0532..7a74f72a8313 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#define pr_fmt(fmt)	"reboot-mode: " fmt
+
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -10,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
 #include <linux/slab.h>
@@ -168,10 +171,11 @@ static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
  */
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info;
+	struct mode_info *info = NULL;
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
+	u32 magic;
 	int ret;
 
 	INIT_LIST_HEAD(&reboot->head);
@@ -180,19 +184,18 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+		if (device_property_read_u32(reboot->dev, prop->name, &magic)) {
+			pr_debug("reboot mode %s without magic number\n", prop->name);
+			continue;
+		}
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			ret = -ENOMEM;
 			goto error;
 		}
 
-		if (of_property_read_u32(np, prop->name, &info->magic)) {
-			dev_err(reboot->dev, "reboot mode %s without magic number\n",
-				info->mode);
-			devm_kfree(reboot->dev, info);
-			continue;
-		}
-
+		info->magic = magic;
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
@@ -200,12 +203,12 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		} else if (info->mode[0] == '\0') {
 			kfree_const(info->mode);
 			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
+			pr_err("invalid mode name(%s): too short!\n", prop->name);
 			goto error;
 		}
 
 		list_add_tail(&info->list, &reboot->head);
+		info = NULL;
 	}
 
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
@@ -218,6 +221,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	return 0;
 
 error:
+	kfree(info);
 	reboot_mode_unregister(reboot);
 	return ret;
 }
@@ -261,12 +265,16 @@ static inline void reboot_mode_unregister_device(struct reboot_mode_driver *rebo
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 	reboot_mode_unregister_device(reboot);
 
-	list_for_each_entry(info, &reboot->head, list)
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
 
 	return 0;
 }

-- 
2.34.1


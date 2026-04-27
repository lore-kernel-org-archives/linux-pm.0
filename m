Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782673E51E3
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311326; cv=none; b=TtUA53Hyus7o3WKwnbtSjTHVqTX8KOq1eNYdW08DTHBPXTSvwvEkM59lW2hCc/ZQqajOYw0zhKXQrtDrdRrNizByDXiVM/xPYFzRROf6g6c0px7vLvu6cxwHp8uxzMYcQD9VTY/B/g0Zsd6lngAMY9r2jZEh4Z5382CdzyFP0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311326; c=relaxed/simple;
	bh=3TYOHMcToCIVpsVU2Bo6DmB6sqgmdebWzZn/F1m0e+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loEqdk7SOkP4D276nkNErM6vtbDAN3vX9GzyiuicGsj1QhVg+yP0QqQJNGkz9LnPG5e6wE51LV/c1n1mGjzQHSKelYLWRNvFqiQZ/2nJyvy/HIOv2fHm4lEpY9mbkME75mN4wBCCdYyplUbRfEYp5nUxMNv/kZ6AaOZ2Q3BNwqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lRZIIfxy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C7dOqJs3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lRZIIfxy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7dOqJs3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RCYRQ2429029
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLDNWZoJ4xbnRu6GNfsuL+e+3Ruoq1OnR+K2jzbSWN8=; b=lRZIIfxyLmSdHEI1
	2wK9QYlFisa7A3/TZfGTApXbHOkOhRixgMzzkZh0Xm2+PiAepXQeodVY/tFdNGyv
	7ll2LzC/ts5bywDNMKoUoYUWqjZYM2sBaXVxodQORlohMBntTinYX3OGr7W6thoW
	fd2Tag0MhgAJmHZa+R3MlEdBZHHpQ4yyDoPXzImzCeplEfE9JT94AQuoaGg40jji
	3lMrkzm8BdsNhzyymzjBZCTQKE0u9pDjG5ZrwUU/8B3UDUczpEDxkmFqbRiLElEt
	Qs701sG670k2PFWgODLGAbzf/6coazRSyiBv4s3Q4aSs0lxiguBLaT3xyWvhQz2M
	Es8/cQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7x3153d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4654f9bb6so109425245ad.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311323; x=1777916123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLDNWZoJ4xbnRu6GNfsuL+e+3Ruoq1OnR+K2jzbSWN8=;
        b=C7dOqJs3MkupgcmVrueCVsljEY4p/sL+3qgKvYCiWIhbX09lNr9DzTyrFzDA8s4//y
         uI4tVRYdzpfktoMQfR8M2nz+0dROL/AHr0KZilBxyycJgNAzOke1XlI+XlnDPlZ7wOwy
         4BTLNp8wpvE9k1bwmTQqmVBm4lvQ2w9rZ+qRqVgaMdaRheOGDW02ApcE6j7D4I6wn5u+
         8De3QBH3l5IQHXKoCTSZPkpz6I6KoPTAtbJzjbD09HgTeoijzewammHJi2ELEAaOBpfu
         lazX71ybw/RFyrUSEXo1Q5PVOXy1z5rSYrklc085nR7XuvbWZj1y9Wpwgi2TP/TRq7zr
         xsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311323; x=1777916123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLDNWZoJ4xbnRu6GNfsuL+e+3Ruoq1OnR+K2jzbSWN8=;
        b=ohnMlGe3nJ170DfYGs3JbRxCEXxSL29NGJrLexgkGrz5VwO59uJj65U52k4PfbZEmJ
         mr6TBnf6JWcCvW/HEle4q5HbKelToLKkToK8HSUe3sgsu9Hmq1Y/VGyi27pWHHSSwiMT
         n2FcsiJuao6k0KxGbHVoaWTWPYZCbJl/x/ujoFzvRVTQ5MVYBW7LXEp8t0ngEMf+7OZ3
         oF3Dhd0YqUa7FCS6JUDtu6+QiVLmv72ctxKegZbyUGJqagufflk66Gx23gKhXcEynTVc
         O7yDtxhAHGEKHnUPe/nmw2VLeveL7YDWmiuFomow7pP+oeN+iVIHEw4D9csZxtN6FT6u
         eHPA==
X-Gm-Message-State: AOJu0YyA8RBXYzwk5qEtJVwFyxJs9s2o2HXPoLRymU4xKcKZk2oPbi2y
	NYl9N3T3EMmwVhl2mXsefm31DjEgmj6qV3nzegUMfCJ6QVQIDahRSHVtHK1K9hgqZqwreYJUzfl
	OdvrFPIzyqeR8nSDr7iUQ4ocYpXvqTg8MYD7fQ62/u6u4XGBQLFESuXnrPsJNJA==
X-Gm-Gg: AeBDievoXnORTm9gBCdCmx8daLTCNnpruYspPjJ+5Xvbr/dxL/3qdlCYxIsNGsXxgBB
	uDts/rVPEl5uB18JAm9oZzBeeH8uFI5UKbGZ/scfDWQTgw2LBa26Xwsr8KCdRiemE2foQ5IQNBe
	cOvDZLa51lB9VvZQVz67BYMZihoKvaMnDkyGtFi55lMVLyI5SGaMFUhE5rtpp+0GwJMGSaZP0+2
	JEzIN1TzoarvHqDHBCi1FlqARX5OvAgdsFXGXDRNHZ1vyPjIwpCi+lbeVNE5YIBlGZDyNc9ocxw
	qBz9DwwwZVBQgMdG3TT8v680QtN2k8fBet7HnUVB49+OOpsnpJdN9sD4AFgk2YRRI6c74yhS5YB
	5NHW17dsn2yha0sTHF/gHL+tC5dslxp09JoBbACTGdCY492Rt4YjcVK+7jiotwe5MbtPA
X-Received: by 2002:a17:902:ab8b:b0:2b0:7e4d:f43f with SMTP id d9443c01a7336-2b97a97167bmr1110085ad.41.1777311323440;
        Mon, 27 Apr 2026 10:35:23 -0700 (PDT)
X-Received: by 2002:a17:902:ab8b:b0:2b0:7e4d:f43f with SMTP id d9443c01a7336-2b97a97167bmr1109465ad.41.1777311322756;
        Mon, 27 Apr 2026 10:35:22 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:35:22 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:41 +0530
Subject: [PATCH v21 01/13] power: reset: reboot-mode: Remove devres based
 allocations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-1-dcf937775e73@oss.qualcomm.com>
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=4001;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=3TYOHMcToCIVpsVU2Bo6DmB6sqgmdebWzZn/F1m0e+g=;
 b=32A+1VzoGWg9FSbHynSX81qbLupW/hUgrYzIQsaZuSIHuB+n0hQE8ta4k5laVXIaKpofnQnvs
 +fICXcpyJbnAy+fAxeBYskqTifNlGwo64pkQbTOArzTafR9aiuPkzPz
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NSBTYWx0ZWRfX8vEGmjW142jw
 24zEndTohJZd6sT9grGcgH8puYWp84WfisUYh7JeyPuHUHttz6gzXdqDvq6tcvS7SY1MwytdpoL
 +oIjd7tBhFFmGCRMM++Itusf2IIkIWkwCipTYlPxepGZU0YZjwnc6/2qxrzzKRVp1liq2XvzP+t
 5h5gsI2zJcktJVYFIyKDeSZQTUnupIX8KbAMvIrhuYC9IKClkPGtRVcVxavqAKSKknBQ33S+1AS
 LvShZi8C0FHF9sh4BNis5LiFEzVcUGuHibmtxVcv70uGWMxrRqh9Cq/ASZ6E7W9985OzTtLfxRC
 cheyazSvPvTKtBPVMVWI/P+jp9R6mJBgu24xUGh9OTi2rFD5B10oaUH75WRFJ53QUh0WMHXZv1j
 KHSxlZ7rGPrToFE6HoOLoitAYHWDo/CRmyjHetd5OPw7EsYQ1vQOBO9hbe9VNI9c+50KgPUsm6U
 +zQn7Gy8D9GEexQ9kdA==
X-Proofpoint-ORIG-GUID: abNPhJGj3sL3Z7YaUTzTXggrd2n_B049
X-Authority-Analysis: v=2.4 cv=AJEsYPsu c=1 sm=1 tr=0 ts=69ef9e5c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=QIdouwm7mKRySFGJXRQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: abNPhJGj3sL3Z7YaUTzTXggrd2n_B049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270185

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
index d20e44db053256d87ad8034ddab233e49d36072d..7a74f72a8313b73c3e0930a426ebcf7ef6eed99b 100644
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


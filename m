Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A2481256
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397976; cv=none; b=Cid82FsCeNqhZ8500oNga9323rtNTp6ycfFQ0grfPpd/5wqWthCrfQbmk/ntKA9nhh37bmJd1Xbo37WU9Uhz7H8RhGCZfEqARtuRTV8w9CR9/fvfNoTcvviJewVFxZodo8elSpA01hJwlIUWnYvOAZ3oOOqfF55abQgZvc2NHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397976; c=relaxed/simple;
	bh=3jZJCDBmdKair7R/qKaAWXxKmatvkMOd5u4ong8jp54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5FDoCBc8Np0IAk0c0gQ/gBBpFWgV3rB61d6FGqsSMA6PNO2zGAaEesrQAzl/3uRswwHAJ+gRnKvHhViCBwD1F8PU/a/YOIxcZj/8Y1JAtlTj/BV8myQ0ZqR4uIEoyMAmHiC0AunlQu/voOosMYwTSGNkIZJE8C8YPzffOpfK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+zPpzd0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V3+a+IeH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+zPpzd0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V3+a+IeH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0THN510941
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 14:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=; b=K+zPpzd03UkEsCJt
	LiqtWyAwkfM2Xrx++xrZE/ZNqHYbLFI4LvthAK0hpVCtaP6/K8S0sjkLPg91ljO4
	6cbzbO5sJsk1bS2F513JL2w//K8XrjF9aoMXe1hvDVPezR3y91wBfIWUn0JLIEdB
	c3BY+D/esbbtBsIkq/vuLeYhH8kZW9IeqXZQzivJav2NuydB/o7xxA+vxndTQQVo
	d2PlccpmAsVojFChgbnspw3sjkyILURvdKj6X09kr0Ftxq/YyGJHFKlTLrx629LK
	BjwrxTpWvkGbiyeKS2hX1/cVAjW0JY5P2Fn1sHZwM7Q8W2rLgpGAgpz8pqxzLGYr
	unEx8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvtgke2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 14:59:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dc92350888so56816855ad.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789397971; x=1790002771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=;
        b=V3+a+IeHSS0QQfIHEY0U4sbFjXSktQoo29fpYbXpm/irpFmjz1EaCxdcRtViRDJs+T
         yd0ytnn6gfkDuU7a8VjImVfkh8vJ3V5qBS/dLhvQ1AhZ6JUwRZ4pZ3I9P4npjvDgJyYg
         KWcFoBcyBGzw1o6opT/3cbBR23Qqn/brDfXTfalr/Apkr6LNqG33OyudGn4dIlxAI1sC
         EGhZnTKeMdQawYVwEI23X36g0QPo85vdRH5qwJ65pAv7DXyCRBXXxw5dEJUYMCAkTvMM
         WqXCxuTjGE/n96jTEA4aBf+zB1/aJpjYUnCKMzpNGHbiORTrruuiWQQJUI4TR4dY2uGM
         nHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789397971; x=1790002771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=;
        b=XJdC0gtOF30pxaEYwAal3SqoJ7E2RAPxaN3H3vzITJ/o4oBXy1M2TgU7sPGunke8Ak
         enZmODqivUJh2DCfHsklrxAgl4OhcD/UytTbB3eCtubBKXaWZaJhauMvHBJnN4y60zc+
         WODkRmtemUlUBuc2iV4iDNxcdmuWEnf5Ew/lUiukqDIANOHgB4W9BgxdfkrCkTUDcyoU
         UP97LwBUhILpwgsolbaqXHn2HXj7bWmD8B3RQOVcutLVhmykOxC03qITVCUOdlA9yxmc
         9wcL3jS9E6ea80t/U1D44qnaPDOTMImJXo2g/ru5BRKg8I5KiOfGEjNjEZj5lx82N1Zm
         /7zg==
X-Forwarded-Encrypted: i=1; AKwUvBzF1GyTFnF3ffSL9xPL/lMm4GJrxi0SpyvvSrKkRjQZrgr0pjvx3ncjgrnC6QkVF4uXuHOgZBkXyQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kyQNE1dqWTzqRipZSxm4EsYg+ynG+LaXZ9u8IscjTzeinH1ZGh
	A86NglGPNRQqTGEQkbscVBjZyEcyH7qwu3baWSnoYr2idWydEHTIqLheFWX9tIOT+JooprK4M2D
	l4qjVCOfsVJUtSNI93jUO1t+VQyHAEmTSiiYlw8n7+VejSKQpMJCNVPzJEOlCLw==
X-Gm-Gg: AYBFou3IBB1rTBGSgGKgXJGSMUkBFTDaGWlFVgYI0clbCNSNVov3tnmQuqDhsR8Fy9z
	Zh6crB60yJrgLBbw8woitWHPWVZuuxhhxWeRJGcCkn+TAuLCHiAUUlKrO/0DqiZoV7LyRsSOU5M
	xMjZ+rSyRULW0t+ioRZ57Mggi3hurbRMHgLdPmZdZLyde2hOXxqOJ6+ebKmVWJSsXLNLgs6npP5
	UqOOma5kDaiXo7CQ9lT+AJpz1CTZZyEtynvwjS73GykRqj0t3WbLmcbZx89SCjUYqnNIUIserxE
	gtH1/4dOo+yGTNUeFeZuhKDyB64xw7Vfm1FQJy2hduLTbUtnfuKD8AXinpWnxwrlvnHjuVKsiHB
	fw6OITaSPpguWdJC3MuVlhZOKQvmbjwCayndr
X-Received: by 2002:a17:902:e74b:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2dd6c6fd5e3mr56146925ad.18.1789397971012;
        Mon, 14 Sep 2026 07:59:31 -0700 (PDT)
X-Received: by 2002:a17:902:e74b:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2dd6c6fd5e3mr56146095ad.18.1789397970445;
        Mon, 14 Sep 2026 07:59:30 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4007bd4dsm42943345ad.4.2026.09.14.07.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:59:30 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 20:29:05 +0530
Subject: [PATCH v25 01/10] power: reset: reboot-mode: Support up to 3 magic
 values per mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-arm-psci-system_reset2-vendor-reboots-v25-1-4aaf5c09b5c2@oss.qualcomm.com>
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
In-Reply-To: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789397948; l=4572;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=3jZJCDBmdKair7R/qKaAWXxKmatvkMOd5u4ong8jp54=;
 b=7s+Gk1QNxVnLkzG+di2vJq+YQbfPHSTrr1QX/D/s21KZdIuvvOz1TUPD1brXp5hNyUSG3VZ/K
 movM2/29tT9Anf0uibgKIKF2jcDz0/Fu8ns4yO7NEmVxmJVZ8FXwY1P
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa80bd4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_usNffLPL2KliZ4tEdwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIxNCBTYWx0ZWRfXzkMq3/uckS+c
 MlebPYbsO8tbYw66fpkqIgvv/FXnSNOS7GrspDMYhZyKyifH6Aq3+gAVR82yIjqScE3xrZY5zFk
 kSlNd/UaaHxbbeeyqq0eR/AMm2u22JS2k0dqt/5XVMj89/G8NHTShKsRj2pgvHKrtcM0qyl4F+k
 bIS4EZF/uOuCUDALc62Rp+VIPos8X+kRRnFhxglVbhm/poavQeLATF5uMW50565FnKFlNqjthgi
 hMA56Pd2DIP10pe8o3a2++Sb7wdw7ZkcZfgqiOmy1CAIFvOCaKClxrdeS8moJgiCCKYYT8/mjGi
 RuTSCmRWBaLqCKBUS8HljkqkkWyJuo2iEmDlYyfqJRPmk2GTFbvGiPFOuO8htnkEfXPzxk+4oIJ
 670xPZl9y6G8/wN63mDiUSc58ZATARkvgbPsA3n/vL7NBR6uLj3grV7OjqVsJTHT23qsu8ofvJ/
 2SbC8eYxVtISGwoEnKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIxNCBTYWx0ZWRfXwuxmWwcMdiAt
 jXgeif6E1LovXoN0XpVLsC83lCjGNhx4+bPJblZvuqWiwzCG7r67ioFOOJJYRYIIYPUnulS/o6t
 vr3yWbUc7mzMliiSNiW7hg8Ojn6nlMc=
X-Proofpoint-ORIG-GUID: 6R11ou6XjnsRlV3RhqgvWLFXaZQzAd2X
X-Proofpoint-GUID: 6R11ou6XjnsRlV3RhqgvWLFXaZQzAd2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140214

ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
cookie as arguments. This cannot be implemented via the reboot-mode
framework, which supports a single 32-bit argument as magic value.

Extend the reboot-mode framework to support up to three 32-bit arguments
as magic, per reboot-mode.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 46 +++++++++++++++++++++++++++------------
 include/linux/reboot-mode.h       |  3 +++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 3611bed341e1..328fa37598df 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -20,7 +20,8 @@
 
 struct mode_info {
 	const char *mode;
-	u32 magic;
+	u32 magic[3];
+	u32 count;
 	struct list_head list;
 };
 
@@ -72,8 +73,7 @@ static const struct class reboot_mode_class = {
 	.dev_groups = reboot_mode_groups,
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static struct mode_info *get_reboot_mode_info(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -84,11 +84,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
 	list_for_each_entry(info, &reboot->head, list)
 		if (!strcmp(info->mode, cmd))
-			return info->magic;
+			return info;
 
 	/* try to match again, replacing characters impossible in DT */
 	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
-		return 0;
+		return NULL;
 
 	strreplace(cmd_, ' ', '-');
 	strreplace(cmd_, ',', '-');
@@ -96,21 +96,25 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
 	list_for_each_entry(info, &reboot->head, list)
 		if (!strcmp(info->mode, cmd_))
-			return info->magic;
+			return info;
 
-	return 0;
+	return NULL;
 }
 
 static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	struct mode_info *info;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
-	magic = get_reboot_mode_magic(reboot, cmd);
-	if (magic)
-		reboot->write(reboot, magic);
+	info = get_reboot_mode_info(reboot, cmd);
+	if (info && info->count) {
+		if (reboot->write_array)
+			reboot->write_array(reboot, info->magic, info->count);
+		else if (reboot->write && info->magic[0])
+			reboot->write(reboot, info->magic[0]);
+	}
 
 	return NOTIFY_DONE;
 }
@@ -173,16 +177,22 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
-	u32 magic;
+	u32 magic[3];
+	int count;
 	int ret;
 
 	INIT_LIST_HEAD(&reboot->head);
 
 	for_each_property_of_node(np, prop) {
+		memset(magic, 0, sizeof(magic));
+
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		if (device_property_read_u32(reboot->dev, prop->name, &magic)) {
+		count = device_property_count_u32(reboot->dev, prop->name);
+
+		if (count <= 0 || count > ARRAY_SIZE(magic) ||
+		    device_property_read_u32_array(reboot->dev, prop->name, magic, count)) {
 			dev_dbg(reboot->dev, "reboot mode %s without magic number\n",
 				prop->name);
 			continue;
@@ -194,7 +204,15 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 			goto error;
 		}
 
-		info->magic = magic;
+		if (!memchr_inv(magic, 0, count * sizeof(u32))) {
+			dev_dbg(reboot->dev, "reboot mode %s with zero magic values\n",
+				prop->name);
+			info->count = 0;
+		} else {
+			memcpy(info->magic, magic, count * sizeof(u32));
+			info->count = count;
+		}
+
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret = -ENOMEM;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d6..29ae39935d69 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,10 +2,13 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/types.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write_array)(struct reboot_mode_driver *reboot, const u32 *magic, int count);
 	struct notifier_block reboot_notifier;
 };
 

-- 
2.34.1


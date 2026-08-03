Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A185363096
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750298; cv=none; b=RRwXhMv5q7di4FzUETPuE3XF9OcoYaB5U1Fg5ZpWK+qK8wNRxUYKe5/bspH15R7ZQqMAOMSUpitZ79eoFG+S3k24yFX9ihHPHighH3KOMJJS1djmc7u0QtIeTNpeIR5O9dS+orGHC4t6Fuigzgp7QTjRGsMpNM4zm8QBu88pado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750298; c=relaxed/simple;
	bh=2/mMawez6NK626poMyU8T8NA9gdZ6S0XfZEN/N7KY1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sh4YO/VPQWKw5PyYYolj4xXnry9LRXlIrXseTG2H7nGPFSgZdJ115tDgD9EF/LwqpEX5m9mhcLUYECjuXb92LTgQR5auVQrzhtipxUbB7reXDtAuBmoceFTbH106xN3uQ9oYo86ngcaSDItbiRe/uwZJEG4GJ78QhmOORUZU4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ACMmb4Bu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cr1AsSsF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACMmb4Bu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cr1AsSsF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736SCkj250196
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 09:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r1TRODCDblm/9JLtIWphfOP7mJeC6V7GnV66A4jorCE=; b=ACMmb4Bur0R7+p9D
	1UUk86nNqNglPnh+L923LAcxwIYAeqPfq5yRZdbDH6fTy2cVwhMki1pskkztKJ1D
	eZyb3k8Vq3m5EuTewvYPjIDlcHBUocNgHHwMGDtalaumm/1gB4QKB/JrZTzayqzd
	+n1wlYPRRx/W2mqRzJ5otRnxb0gi3twSsX1fijYpisKpWwOdMm4K1kxIBCCv5BCr
	S9tmsx2U1XAyXZZtZcXdpIiTUikM/vDgIcPNAQ0C1Uvwtbw7cizKwGtMK9Welwi0
	pxZH/GEjKd43S9lip5fiJ5cGvL9JEegI7JoIXY+6+lo+XppbiCKmO0pKP037dFpH
	GvoxzA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrd8uwe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:44:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso3062450a91.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785750295; x=1786355095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1TRODCDblm/9JLtIWphfOP7mJeC6V7GnV66A4jorCE=;
        b=Cr1AsSsF8otfPUvX2hESk1tdFnK25Opq8X+/0ZkC1UI6RMOaXJFcPsWYyUTpRPhHo1
         UC/B2s7Tbdh2fJsz1keFNE+0McpqWXRlRxeI9SBn0gxFAPiehjlBGtSDN4eYEfsaKpKM
         s87CHN+mhLh3By8dW8ZZF3Wv22dQYHWmc8lhiOhn+Dq0inSEK8DKEyFFeSTLAtvkPGOL
         kAGcx6CSlfoyrUKPUHbM/l0eRYih3agNML5NypwFLv8zQ/vmrxsLzbWp7sSH9pOdm1tB
         +FnjE+u57TTveAxHEyePbbAxigPH1bcuzXspspfs3oa5BNCkAyDjB9y2Jeg3JXyURLQM
         7evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750295; x=1786355095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1TRODCDblm/9JLtIWphfOP7mJeC6V7GnV66A4jorCE=;
        b=k/nKSiFfJNt1HVtObtuzHRBPp2AGvIoD3LyGFa54KtXOS9izc++Ax4/tIEYoycN3N2
         DX+tKx4nxtjAf+Ky/7SO78xYAwGxglXW17O4E5jI5YPgj2cRR701Ki4/xP8vM2Y+ImMp
         xTwIxVJmVGYKtUFTjS8obuPR3XCe45GQuNMn9Ogx/xFoHW6IbPzdvyOqbVHqPnco3vvI
         3UTnkrhlEYpAA8VzoJkC3qoboqnqrQplszOL9jcHCbZm/0d+eurdNoz0xiSCzAbbWut5
         +uvJ+cA+7cNV9bsnB/iKCzLFntfy+ACPOJi4j/prrAoBHEi8I87QJu7PXx/NWfyBsQA1
         hLLA==
X-Forwarded-Encrypted: i=1; AHgh+Roo6EjA+6YNJiKSDNp4zMCvgcZNkYjG8hJ8LgZoBurYPXnS1lwbRbyRZZYa9jluiStwvMdddz0FDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLEYZn5qPEPmT98OMhJf51G7LbsC3DkmaHO5bH79gYvUb/v4Q
	ICG5Kn7zqIYO1Sg9nBS2l8LadoPMvAYTEnf2/mwAFFaFt83pt9iphmCqvBe9KRN2GiAolVrJgxc
	xjT2WrPeBZNQpv7mreavUTmc5c1zCUs1OxwvbGLYQC8pjvxtBA1JvjcKFWIZc4w==
X-Gm-Gg: AR+sD10+A29dPRDJCG/Mb9HBel7F5hRj0Cc5f06XVSjtkVhPWEMtE93bbWDm2W3hqTf
	YajyVtBpAy/YkQC1N4T0IMN5Rnide9RidEyBgQvQ50bEMYGmnXsgJQLTcgqcnP9fhA87pDZO9lp
	qRfjEqMwG4qJHtnymArIZZ41Hi2dZoUcxn3vEbqRJS70kWrdLYFxx8IuyGokrnCZHD5FRNMzTBm
	rmOqBDEthS9VhF34UfVfBO2GiGAFnmsnf34buUS+zq8s+wl1ddV/tdd1mql4a7S/hisoip3nVl4
	P6xySibcLQmHS7jrO/PT9IpV7Wyn7Cvkig+sDtt3lUHgq+zq5XQlxRQpF8cdqucV5Dx1Xs/uPNt
	d6cofs4ki5K72Iq+BZ2taIemiGyYrd7VBXDMB
X-Received: by 2002:a17:90b:57e6:b0:38f:23d6:b4ad with SMTP id 98e67ed59e1d1-38fbc3f7e43mr8156684a91.8.1785750294746;
        Mon, 03 Aug 2026 02:44:54 -0700 (PDT)
X-Received: by 2002:a17:90b:57e6:b0:38f:23d6:b4ad with SMTP id 98e67ed59e1d1-38fbc3f7e43mr8156650a91.8.1785750294303;
        Mon, 03 Aug 2026 02:44:54 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2be6c8csm3660671a91.13.2026.08.03.02.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:44:54 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:13:32 +0530
Subject: [PATCH v24 01/12] power: reset: reboot-mode: Support up to 3 magic
 values per mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-arm-psci-system_reset2-vendor-reboots-v24-1-889281373870@oss.qualcomm.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
In-Reply-To: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785750273; l=4572;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=2/mMawez6NK626poMyU8T8NA9gdZ6S0XfZEN/N7KY1I=;
 b=xvU9I4zZ2yqhSbHQ4Sj5d5q6B9I3PNsjrVLvkEbssORYCteXpmVFM3Ktc7dyL02b9gY1Ngg4+
 pgoUHjBjDIaCTlfsiQkfExsM7V7X88mmS3J73VfAddR6YEZZlU05T2X
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX/xswC01JGZCj
 aYvTp/mhCIkd3hRPrjcv0vIpoAbIs/RXlv64K/FjG/2iahHMBXW9y8mclxJrAX7OOCBPQMGErCZ
 +RoBH3pw9WqjDgKWhwayLdRPdcaHSjM=
X-Authority-Analysis: v=2.4 cv=f/94wuyM c=1 sm=1 tr=0 ts=6a706317 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_usNffLPL2KliZ4tEdwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ZaRfW5I-cHcLlA4y4UmbM8_QNd4kbrXz
X-Proofpoint-ORIG-GUID: ZaRfW5I-cHcLlA4y4UmbM8_QNd4kbrXz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfXwjHkEucAEPpV
 rVJ4dVIuN2TrUsSqUTfb/tIvN9kF+4rG5v+5OG4bunnLxhsUdM5R6FchhriFLfJeKsp+KTOEhBR
 dqtNMOIlRmQj4eubiUMob4UUGWBar/dghW14N+YidI5Uk0G85sQd22OAqDIYubHcNsZC9fkS3Eq
 pk50PyCOc9irfneT7YUIcFcJAGgqf0uLW3hDRgUgYs+uQIUnhMkBW7zTQAD4ZRLx5xnMPsXNG4n
 EkidIURf2qRMf0CyXrIGKBnQs1RRRHsxQdHfTyc677IuNrhe10S2WUQ+f/XuRkIFeY02jdVL4mf
 1r22hI/uKa398CE0S/H36N6wCy9ajAw6toZ1nacMkQnJf1afhBAHifjHtq8kBuNS4Pq0LySWjPQ
 gU63sJbvKOCRPxM0Ri4zRxNk5oak/ivFP582Lo827ptKlj82LhYEnChZ5CYbURo1z4JtuiW3QOO
 Iz01AdqjNyd1MwbEeQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030086

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
index af00c00eceee..c7e9285c64e9 100644
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


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85429992A
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049432; cv=none; b=PexlZ7UYCvBB+s88BjmqTAhqgLx1pSBCK0UpRoTQXjkyERk2BSY3kguPkVfR+rWFZmB+WWjaz/LnfEKbd5WQUQjGHP7JZ1hK7s8qVLCvfypYDDL2SaUPVxFRTvzS6cvezQfYsI5aKfctpXBn65ZkmHy5kyKWpOvle3kFMbJXcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049432; c=relaxed/simple;
	bh=RVaPOCf997VpffmwFz5T1csAYPCpvDfat+ouqwNAreI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtUikTMxWnEJjUuZs7z5byz9RfO7kbbh68yyoFRewC3PeYK/8XVyYxKvEd2N8y1mJkduY+kOz8LBeRXlXDyVP3DHddk0ykcfOxplv/X047zC6X6wyz1t45J1+eL8KIr4nLsLio/DhwigBXLsl7a7gXyOMnWcSURkikJWZse8er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jacd173B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d7Qa6nuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jacd173B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d7Qa6nuN"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EHAU1T1028386
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UjSyKzBP4WUNp0FLzrltMMh/GI3GE10855Ym1ouXjsw=; b=jacd173BaaVbPsqW
	Ai7TTzusn/WkK9YXA2ocjqh/vu3NQqJHzGqwS3TWUJ2bd6BT6OXFeU3o1XR3L4hM
	61u9ZwHNpv1rl7N2owTFRtK0XXoB9RD/565tALOJXKRT7ngcWnb/Fw9DS2kGH1vW
	GBJtKOUpliRKoi4WaLCwMsVeB9cbC0xtrTqi2M7BlFNvE7xU9ugedve+TbjvUnAO
	WdyfcQ9ZGNhZHl5yjhMHMcAvxgdQGTLocLSNI8Km23vOEUlXIeoi23daxbtYtfjj
	qID592WNfZJDrSfGhjyIHLnJDEL0fpO509QEWl+61SHpz2Jehw56EZouw+GcwKlv
	cmm5Ag==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9g00sk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:09 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84865f326efso5021803b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784049429; x=1784654229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UjSyKzBP4WUNp0FLzrltMMh/GI3GE10855Ym1ouXjsw=;
        b=d7Qa6nuNxGmvJO+YUAJKQMR8wpPVhQ+Gqs7Xzct/7PaprOZgxJ+dmjxlj8wBq8O+Kd
         PyHscwhozTeyieU1BZ/NCcPM0pOWy8g5cmcMi2VXjM9M2tEeLsWRObfTKA+nWEZ8atoW
         d4xvgfRiVykVLmafvNcuJHOl4LJyEyTkKro5HYPI3slFWT7i+MnU97qXpXw2B0Wj+uPU
         kyLsgqveLFvXgUmdOn+3NigxPgFDBnc5Nbi+cLnz4bcxRtU1IKv9j1Wmb6Eg7vhTc2G4
         6+EW+lgLic3LjuafDPmhl/ILBE9xr390/PwvuPQ0DohAxG4kQE+frfiyQASM5n944FTs
         vsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049429; x=1784654229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjSyKzBP4WUNp0FLzrltMMh/GI3GE10855Ym1ouXjsw=;
        b=sTvbg+6DaJ2uha2dAWOrTGrciNUaiFLlamjaqvYEwjNH5/aPiN4l/4tyoqbSK2XJqH
         N3/O8zwvdWUfFdJQN+IfRDJOQB5d9YYexGURkYePzJTWBie3ZV4+1/lKZ4SoWfve0vDk
         KihIZuK3clDJmKv6hM+TvhRAQ1+gxGJvoYSDRBmY8U18k3xAxrALFuzCGu2R8HP6g/q3
         NwfZBo+8I+IEzi1txhj59v6qBioThkgOmhxviAmZ7jasXWxtixLvJvy/hq0R6OGBcmaF
         hkyefQwwrtR5dQU2CGS/dYme1XVp9MTp3D+RIdzXKpNtdYw8u+5Nj3lNXRtELa/GGlQ7
         1UrA==
X-Gm-Message-State: AOJu0YwI+dp9k5OOXuNN0w5f28Vxgc1zeU7g9looSGBe7h+c6Hm+XVQu
	H7fN6HKQONyS5LDNG7esFegJnMadjtWkdx/oTv3ErGWt3BIlAHBEGc2Gbd0Nn+w1wRg7GNCE1yM
	2+5D/uoxX4aQnPIsTMIQDBjg7Il8OtgokJC4ASuIUdqzUlwzNb4CR1zOTWt7hrQ==
X-Gm-Gg: AfdE7cl5IT9/6OzziWVVdmlcO7GgLIp/lNuBXjao+h8DVERzgvFMkn55wGzlj9d9O8w
	cOVHewP5Mk4PHDuT4Fhytm1pK/3e2ZRlJQ3+hKvg+pH+BqdSFsyCvQKJYF8mZnATelk43hmRSJS
	W272C2fLcCvZuMtFIuoMJuT+AhgqWnQ0AItxJJq7h0z2dnZEwusMIiRB4ajO8e6FX/D1lfHVXC1
	4FqaaXhtngNOru22avb0s0jqHbvRA9PryaCBn3LmZPN2umcBtF5IDTdpMHW1puu3ZwtZoW6FBWo
	cVb1ODPkxhdVk7SSLEsXV4fWXNzJ+6FHhqyVY2VwXHqKt9Alc69kaf4KQ+QH4qM5Kru/kLd3Ome
	mSXo+J2mHa4H+jipa4cYXJfoWuTiHcT+XS6PKgyDiSra9etI=
X-Received: by 2002:a05:6a00:98c:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-84889633831mr13028880b3a.3.1784049428390;
        Tue, 14 Jul 2026 10:17:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:98c:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-84889633831mr13028832b3a.3.1784049427878;
        Tue, 14 Jul 2026 10:17:07 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a5bfcc2e5sm731773b3a.56.2026.07.14.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:17:07 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:46:30 +0530
Subject: [PATCH v23 02/13] power: reset: reboot-mode: Support up to 3 magic
 values per mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-arm-psci-system_reset2-vendor-reboots-v23-2-e7453c548c21@oss.qualcomm.com>
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
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784049398; l=7567;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=RVaPOCf997VpffmwFz5T1csAYPCpvDfat+ouqwNAreI=;
 b=rq4dDcAfNnVyv7NIzjQzhAv7vmit/5zydDQmKBy6uONRaNy+yzNahFgU9SxCoO3u+EjCayaGN
 XIlYzUBTfKtBFaO1xJPnn+6dynQAV0OeijYDKIJ17V21sDb4RsIfq1Q
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3NyBTYWx0ZWRfX3PsmZFiVjqVP
 Lx9/f21qmqdycb30BtncCu/Ce56Nv/H+smzR6R42IsyNPqmLN/7alk0T7/H7+vnTjoH4puhg6xn
 zjKlkgLcukZ/hTziz1KJkKYGecTF77A=
X-Proofpoint-ORIG-GUID: hOlrMEH_CeDy2e5c9IDPcmSYHXyshrZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3NyBTYWx0ZWRfX2jCBqxHMVHU+
 SOcukRg5lZlNIvvYjz0l5hOEdfvrIpHmL/3vCTc5z1JB1ebh0bpv981bYnrQ5kNT9Mx+J2ZM9Y0
 quEAaoYa3rfg/js/46wWJeknfRsansO6b2LhKP8jSyq5AD82oIZk+0s7JqIdNBiTfFuuxjomnd1
 rAhqmy5Sk6mN9WQRbiDgyfte+W+tQG7GbJCHy5jjT5wlxrHEPt7BF1AuGeHT2Ppn4VR2NMwBQK9
 0UclVpVPifoDz+z61Lcipqxn/MhhM8barzJjkygzZxR+KmtAqtR8MtYdaElApfMiIJW2rHTxX5J
 UjuVNxf3kKov9zlWT0GVNpk72Ff5A/eAj3UjXw+ZiFjDKlQoCoQQ57TgAf7KOVv8oeK1XbkRQCM
 0J/HHKt70avi6J8jPugiWzIWf8Gf+UvMYnrQIkHJmiRTDab1n//y2Iy6tOn4+pWKp7dNxa9IDNX
 drxKb/BvSdZ1HeT8SRQ==
X-Proofpoint-GUID: hOlrMEH_CeDy2e5c9IDPcmSYHXyshrZk
X-Authority-Analysis: v=2.4 cv=VoATxe2n c=1 sm=1 tr=0 ts=6a566f15 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0v6kfwnqDUnfvyonRkMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140177

ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
cookie as arguments. This cannot be implemented via the reboot-mode
framework, which supports a single 32-bit argument as magic value.

Extend the reboot-mode framework to support up to three 32-bit arguments
as magic, per reboot-mode.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  | 10 ++++----
 drivers/power/reset/qcom-pon.c           |  8 ++++---
 drivers/power/reset/reboot-mode.c        | 41 +++++++++++++++++++++-----------
 drivers/power/reset/syscon-reboot-mode.c |  8 ++++---
 include/linux/reboot-mode.h              |  4 +++-
 5 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index d260715fccf6..ac69b5f39fb4 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -17,14 +17,16 @@ struct nvmem_reboot_mode {
 	struct nvmem_cell *cell;
 };
 
-static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u32 *magic, int count)
 {
 	struct nvmem_reboot_mode *nvmem_rbm;
 	size_t buf_len;
 	void *buf;
 	int ret;
 
+	if (count != 1)
+		return -EINVAL;
+
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
 	buf = nvmem_cell_read(nvmem_rbm->cell, &buf_len);
@@ -32,10 +34,10 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 		return PTR_ERR(buf);
 	kfree(buf);
 
-	if (buf_len > sizeof(magic))
+	if (buf_len > sizeof(magic[0]))
 		return -EINVAL;
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, buf_len);
+	ret = nvmem_cell_write(nvmem_rbm->cell, &magic[0], buf_len);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582..a508ab26d03f 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -27,17 +27,19 @@ struct qcom_pon {
 	long reason_shift;
 };
 
-static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u32 *magic, int count)
 {
 	struct qcom_pon *pon = container_of
 			(reboot, struct qcom_pon, reboot_mode);
 	int ret;
 
+	if (count != 1)
+		return -EINVAL;
+
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
-				 magic << pon->reason_shift);
+				 magic[0] << pon->reason_shift);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 7a74f72a8313..db2129c72341 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -22,7 +22,8 @@
 
 struct mode_info {
 	const char *mode;
-	u32 magic;
+	u32 magic[3];
+	int count;
 	struct list_head list;
 };
 
@@ -74,8 +75,7 @@ static const struct class reboot_mode_class = {
 	.dev_groups = reboot_mode_groups,
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static struct mode_info *get_reboot_mode_info(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -86,11 +86,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
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
@@ -98,21 +98,21 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
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
+	if (info && info->count > 0)
+		reboot->write(reboot, info->magic, info->count);
 
 	return NOTIFY_DONE;
 }
@@ -175,16 +175,22 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
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
 			pr_debug("reboot mode %s without magic number\n", prop->name);
 			continue;
 		}
@@ -195,7 +201,14 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 			goto error;
 		}
 
-		info->magic = magic;
+		if (!memchr_inv(magic, 0, count * sizeof(u32))) {
+			pr_debug("reboot mode %s with zero magic values\n", prop->name);
+			info->count = -1;
+		} else {
+			memcpy(info->magic, magic, count * sizeof(u32));
+			info->count = count;
+		}
+
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7..983b1fbf614a 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -20,16 +20,18 @@ struct syscon_reboot_mode {
 	u32 mask;
 };
 
-static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u32 *magic, int count)
 {
 	struct syscon_reboot_mode *syscon_rbm;
 	int ret;
 
+	if (count != 1)
+		return -EINVAL;
+
 	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
 
 	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
-				 syscon_rbm->mask, magic);
+				 syscon_rbm->mask, magic[0]);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d6..34a81e4b4f95 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,10 +2,12 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/types.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
-	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write)(struct reboot_mode_driver *reboot, u32 *magic, int count);
 	struct notifier_block reboot_notifier;
 };
 

-- 
2.34.1


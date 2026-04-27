Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE713E5573
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311338; cv=none; b=BNeY7m6cGD4KCedToeXq+/KToBJ4xFEN4bvy/mm3bqgKlpl38eI9U9Owa7Cv5YMWU7kzCrvof13B7stQfA0kMfGCsmCPPZlHDJePO0LCMm6SR/9cmbOHUdfvcaIDTwFQrH/EigwazzAfpUsttQITuC68q/Wc+DTcZKFmZJBBMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311338; c=relaxed/simple;
	bh=epX38EKVbjs0anz2F6GQvKIGua6Av+7y1nPKAGgUGPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZhii9wYcWPhNRzCm6jqqIGhraMLG4HxnxIVzfJBK7KFuXvGw6/m+U1pY243KMpf4qzE9oJWsTsFgjtRn487EnjeLzR+k6C4AWfkkuVcMF0Uq5n+lnrIuhShtj3rmToQOsEH/tfnKIzhN2DdH7NmTLlCDQ3blhP0QJ3olHMX8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iv3tv+Br; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I7hqNLhS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iv3tv+Br";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I7hqNLhS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDtjGg241566
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yXsc+PIueYPSfML692Lroz6KSkf+okTIEVnmlIfO9iU=; b=iv3tv+BrP5qbp4hs
	Qqa2XXX9roh7EqIO5ex+vUtClHplWuGgIWAjnyz/kA5q3VhQnGGdZtePOGt+28KN
	q4+ivdTNT4jdK+hKf+bYdzebm+JEYqiBOA/Wx1w/RJLwc/rVjssI7bdk4vXT/ttY
	6OtPpwQSvqPQaaHWHilgeZ+N44J3Fa3qhQdmNy9JYSMA5A9stdc+vkkHYlnXB43h
	s2kNfAgRiJNVU+0NqKDMSpqOIz65zYTRiNOZux9ct7jYqOXGh/8rA33pGcTEP/8J
	ItZrggqptNUTmz9TQ+H7M1yYfolYt1951GO//AhwDXuIRFWRxDCWh37Er+NPeHsP
	SFlF+g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946rufu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adc527eaf5so80485025ad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311334; x=1777916134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXsc+PIueYPSfML692Lroz6KSkf+okTIEVnmlIfO9iU=;
        b=I7hqNLhSKzQKMZ3b0VwFEy5UMbrZanQtE+T1wnAnM6wrIa3SLm/wnw4hmGL3Hlr4R4
         Gbm/yXi2xGfa5sV3iKgRErSqvMVOlFxqwzIGyjGOJpHXWm1io8ylPiCZlvbQST9t7LBS
         IpQN7RwCC+2AE9JMSKrGOI8SUTVB52nWfBs9b6tp9S8W3tSpsFNXvE9UUNxXFLTIIang
         K1C9nLDJfvdYc4mQwLzxSL9has41RhAig4Ys1cMvEVuiuuaMndtiP4t9guQiAe+v+rSY
         oDDJFaMtB7ah0s43Bp6UJgUClKUHrzxyyGTNJK584G0sPh7w6XaJm4RxRp2g3PBhOR9w
         KsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311334; x=1777916134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yXsc+PIueYPSfML692Lroz6KSkf+okTIEVnmlIfO9iU=;
        b=IC9hUdvHw1MBXc0pnRRXfjeXX5wbyFuennIxo/gps5caPW9OkL1bJv+aiV9t0IOvDG
         /jmqQfA97up5YPCsqCK2ANiZ14jtgaZRSmHj+9a0RHlUJdwd/1A6QrdtbnrRxuD2OmeW
         uerudngjCafrXrVACYUtWfcs1tYN41FfmBbGJqI98xsJxfIxc/53duw7yBCCQF15dzl0
         xaGDlRAYPreLI5+I1jLYiCF9gHP/EfucBfEDFQAAnVULWGHtRz6MXu+UA4BFhSu5die0
         y/Nz2QHEGTtwG1AR8xbXsLsul2WB+IAIuOmmf10hbgu5lUinGF0bULpnN18IMXkjJRJM
         DAzQ==
X-Gm-Message-State: AOJu0Yzi1hMUe5xcY9Thx/U6tts0vg3/+O9gZK0pHUG5MDe1R7doY7yp
	GhXwFcOlo03hZZiUH+5LxEw/O3YX8lLpMzm3/uuc+JXVIGPfu61E05jNds9OEjZvakhI/b0ovsi
	Pogbfqq5mFLMr8azS7aaotBlNxzg14pW11FG422cR7vXppS+7X0DHfqEn7qYcJQ==
X-Gm-Gg: AeBDievSRSAqh1gmgcWvGi8/31gVmPYmZYcnrklg4W4WtPgi4pW1JO1QsloehwDnpjS
	GZOEiAEhkvwSVM5AuCzSLh4BtDaiO8JHNoe/+NT/Hutmk01VFx9o7WExsqo/22SFhGfgf5HHigS
	f7/txh+RsTtsmuqDdIpSvoqJQXh2MAauWMHTCo0mC5/5ZYMxeA7GoGfDluvoIctB9+Dfty0NXjt
	vsIIAYUX6hjPjcmZtfkIahfZmmY8cnZllQhNjqpNTF4lrw8eEycWnlvfmg1fCJ/w4jKZeTYj3X8
	oJb7AIC3cdqlWSWBpbxjkMdYsdZRBHrS/Du6B5oK3kzKnNanAWyuHqr26OBMzU/cs6Vu7YLd1yl
	lP5jXgwwkwGQR4v1Gehrl/rLEgq+MmQDNWs2O2mwL9sRkGIg6atpySBQtrSCVMvRZID67
X-Received: by 2002:a17:902:bd0a:b0:2b2:45b7:307f with SMTP id d9443c01a7336-2b97a9022f9mr1214555ad.9.1777311333765;
        Mon, 27 Apr 2026 10:35:33 -0700 (PDT)
X-Received: by 2002:a17:902:bd0a:b0:2b2:45b7:307f with SMTP id d9443c01a7336-2b97a9022f9mr1213985ad.9.1777311333091;
        Mon, 27 Apr 2026 10:35:33 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:35:32 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:42 +0530
Subject: [PATCH v21 02/13] power: reset: reboot-mode: Add support for 64
 bit magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-2-dcf937775e73@oss.qualcomm.com>
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
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=7590;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=epX38EKVbjs0anz2F6GQvKIGua6Av+7y1nPKAGgUGPE=;
 b=m5ZOeq6F78Xee5gkp4Cbx0Si2fuqN+exU1DnHk2VezQF9JDzcilSqh69m+FFLnMef6bdtd+03
 6K4VTfsER0PAkXLYFc5J8pgS1uhAuoKWV1djCl0OHiDSFc3B3oCvTSI
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69ef9e67 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=MO_J9Aa4ypbE8kPWTcIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: T6N26aKp9bpsWl_hpBswLMh8AnGIm9og
X-Proofpoint-ORIG-GUID: T6N26aKp9bpsWl_hpBswLMh8AnGIm9og
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NSBTYWx0ZWRfX2S1dy+QQ4JBt
 CpoJMP76qrSXN/evIfcgkCLutoGjOnpNoBHhkJiOsAkNtOfGbeG56lfEpQgG9Yf2Z1D4sn2jyc2
 NedRlDU3vN7s8cqN/vfpxpq1UWnHP9VXSYBVV0PmFBNZthJzIZFAiIugOjXv4wqMTJ8jyaERoqH
 o6nw5WIoKH3jr7XC4hIwHmXQSm+5Yq34bnnatmsWwjbWI/DNt9DvjyPSjh/fFyL0yvewgPIpC7N
 FnMpE3v7Zpz2B8jgPrYF2kFfxJDVgC7iA5+pfm2pPlvl+G8zZ2FgEXNAxC2Sa30TKOedXCxfZoO
 MSodhkX3eGZ0xAr0pboXSWU0PwDBG1RvHFpZaqFOfRx+S2ak0qDg2raFKhlNtmDLj82ZfAg+pY0
 P1B0IhoxfzodA33Fo0r6OzsiiuFqCnQso9jRjwlTQxr1PTFNZwmmG1H0mvEq+akIIu8hl6UmioC
 JHGzFNUS1dUyz3lVT0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270185

Current reboot-mode supports a single 32-bit argument for any
supported mode. Some reboot-mode based drivers may require
passing two independent 32-bit arguments during a reboot
sequence, for uses-cases, where a mode requires an additional
argument. Such drivers may not be able to use the reboot-mode
driver. For example, ARM PSCI vendor-specific resets, need two
arguments for its operation – reset_type and cookie, to complete
the reset operation. If a driver wants to implement this
firmware-based reset, it cannot use reboot-mode framework.

Introduce 64-bit magic values in reboot-mode driver to
accommodate up-to two 32-bit arguments in below format.
|    Higher 32 bit  |   Lower 32 bit    |
|	 arg2	    | 	    arg1	|

Update current reboot-mode drivers for 64-bit magic.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  |  8 ++++----
 drivers/power/reset/qcom-pon.c           |  6 +++---
 drivers/power/reset/reboot-mode.c        | 19 ++++++++++++-------
 drivers/power/reset/syscon-reboot-mode.c |  6 +++---
 include/linux/reboot-mode.h              | 15 ++++++++++++++-
 5 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index d260715fccf67f9f072bb56c5defbf885750650e..bd05d660490c686b43134f82f1eadd7665403d20 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -17,10 +17,10 @@ struct nvmem_reboot_mode {
 	struct nvmem_cell *cell;
 };
 
-static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct nvmem_reboot_mode *nvmem_rbm;
+	u32 magic_arg1 = REBOOT_MODE_ARG1(magic);
 	size_t buf_len;
 	void *buf;
 	int ret;
@@ -32,10 +32,10 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 		return PTR_ERR(buf);
 	kfree(buf);
 
-	if (buf_len > sizeof(magic))
+	if (buf_len > sizeof(magic_arg1))
 		return -EINVAL;
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, buf_len);
+	ret = nvmem_cell_write(nvmem_rbm->cell, &magic_arg1, buf_len);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582e8243c5c806bd4a793646b87189f..57b36e6186f80aff947fd7f5aae5ce280c65dc6b 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -27,17 +27,17 @@ struct qcom_pon {
 	long reason_shift;
 };
 
-static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct qcom_pon *pon = container_of
 			(reboot, struct qcom_pon, reboot_mode);
+	u32 magic_arg1 = REBOOT_MODE_ARG1(magic);
 	int ret;
 
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
-				 magic << pon->reason_shift);
+				 magic_arg1 << pon->reason_shift);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 7a74f72a8313b73c3e0930a426ebcf7ef6eed99b..f1372dc700e48043320812c3d3619ab1539e1854 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -22,7 +22,7 @@
 
 struct mode_info {
 	const char *mode;
-	u32 magic;
+	u64 magic;
 	struct list_head list;
 };
 
@@ -74,8 +74,7 @@ static const struct class reboot_mode_class = {
 	.dev_groups = reboot_mode_groups,
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -107,7 +106,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	u64 magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
 	magic = get_reboot_mode_magic(reboot, cmd);
@@ -175,16 +174,22 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
-	u32 magic;
+	size_t count;
+	u32 magic[2];
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
+		if (!count || count > ARRAY_SIZE(magic) ||
+		    device_property_read_u32_array(reboot->dev, prop->name, magic, count)) {
 			pr_debug("reboot mode %s without magic number\n", prop->name);
 			continue;
 		}
@@ -195,7 +200,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 			goto error;
 		}
 
-		info->magic = magic;
+		info->magic = REBOOT_MODE_MAGIC(magic[0], magic[1]);
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..9f4b18c5e46f6a8bf197773ceceb80b250f57541 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -20,16 +20,16 @@ struct syscon_reboot_mode {
 	u32 mask;
 };
 
-static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct syscon_reboot_mode *syscon_rbm;
+	u32 magic_arg1 = REBOOT_MODE_ARG1(magic);
 	int ret;
 
 	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
 
 	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
-				 syscon_rbm->mask, magic);
+				 syscon_rbm->mask, magic_arg1);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..2ce189fdfff4b396d7cc6f175b30016781ae4fe9 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,10 +2,23 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/* Construct 64-bit reboot magic: arg2 in upper 32 bits, arg1 in lower 32 */
+#define REBOOT_MODE_MAGIC(arg1, arg2) \
+	(FIELD_PREP(GENMASK_ULL(31, 0), (arg1)) | \
+	 FIELD_PREP(GENMASK_ULL(63, 32), (arg2)))
+/* Get 32 bit arg1 from 64 bit magic */
+#define REBOOT_MODE_ARG1(magic) FIELD_GET(GENMASK_ULL(31, 0), magic)
+/* Get 32 bit arg2 from 64 bit magic */
+#define REBOOT_MODE_ARG2(magic) FIELD_GET(GENMASK_ULL(63, 32), magic)
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
-	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
 };
 

-- 
2.34.1


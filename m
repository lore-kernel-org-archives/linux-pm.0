Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8923064A9
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049481; cv=none; b=eiQZg0TicMvY4YuASDJbA48lET9JBPBnozBcQst/6m560Y94T5MQ8TJCOI3WAbTBxNf4v/dv5rhD9dUcnup70Lbi8eMxx/z1TZVHrx1hw33mpd9D8gyILRR3LH4p3I0hSrEhq0qAKjliwNP6Ivy5PEEu3KZ7cRzvhFtZzPq3jMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049481; c=relaxed/simple;
	bh=2g/1r+tUGIrYD+Rpn7qaYdeF3w/p959uoI3764ZH9S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JySCNl2h2QWa3LyY6sgb5B4LpFOk3yONbA4auWy1/VGy0XgKMSrcJ+mcd+bdpaRUUnTRlctjVUUpDL5erdFKCkJlV/EJyuy9UcUgpIEqdUiAhfGGPfTpD649cUSI/LthEE26QTVcixYC6ZQP2DG0iEVhrumV4m+uJJY/wiJAUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=olQ+i3p5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=axDT57nn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="olQ+i3p5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axDT57nn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6uC7975506
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ja824+WEhomskfYCkM3rLk2MZr0em1PMkZk1CkEWLQ=; b=olQ+i3p51ODhRg2X
	0dXQ8vmRFQzbniW44oE8+jTuBdtnwuoauiYcPYGzI3xg2eohPZxsPYbPBHeiaZVR
	4vk/kp2oX9xy1uimqdzfN4z0ixDc1Hb8M/PbayfvX5vU4C3pv4HUsOREEuoUCh8V
	kw4EU2iwgqemCvbUl3blD0EUqSjed2l9iWces0GFO4GKI9ZHpP68e4pJwFpeM4u8
	+tQQ3S7F2y9lyNR+x++fOL2o2y8XwzemH4MCGqtiG3A60VkVkoxWo7XrrqDf7Tbu
	yxfZhRjWmQrMzSl93n9Tm8VISd5AwrAfKv4g0a2RjJyFSR0TQwjwMT7qkPNa43uY
	vWR9Pw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq2d8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848551b54f5so8790113b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784049476; x=1784654276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ja824+WEhomskfYCkM3rLk2MZr0em1PMkZk1CkEWLQ=;
        b=axDT57nn/EuP0qvB4p7BUM0SEz+IwK7gvSagKFzNSWu/R8PB/hyKO0WMMAoOgDoPLZ
         Ldadq4MmhVytxVDfgdbXOfox4XNEBnHb4NZpdy9m21ZV3TiFHly7vVc+36Wcy6TeCr8a
         u2UJCi28kI2HIwruwnItR0FOGKrMU/L3Pf5Rcn0bxsCI3rHlPD7lgALde8BhaQ3XTard
         YrQxizaVnC+sIRIux1aqArCb3zPJcWOWVR0bzE2dyN2brcibCDzcN97naJcUbfpfGxAf
         fFPQUv9HK/wTDxk0AP8rAvvhQ32MU1JQqX41cRxUt3eqK9sscC7gE5njjTvLgjahzcez
         Qfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049476; x=1784654276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ja824+WEhomskfYCkM3rLk2MZr0em1PMkZk1CkEWLQ=;
        b=PBtU462zSEPY+C+nb0hEJ97zNWAnroELOLE/qFz7V+U9/bTo0rdUcutPOcgzPpDz39
         L5uXTp+nzxHneb3gahMggHphOSYjBNPGmH7QvFKcbERjgDFVguiIRdmsbJ5Xb+IMFJrB
         ZDUVxeLbM6mz+bHb5yqRlqCIcVul5HOZHJk1CKHlwFhdKY6efI/vUmV+oAYdXNAYFRSr
         tMEYRTVe7Wc/VsmKZLWZqUSHB4VsvGxYMBY7x5tXjIZUlW/2H3vEjidZh5l8qIVxCzOV
         et/spF2M80tCfXCbtEHaK4mj0hNK1hqc+B9cKToYSJ6YP9dwf2bCCt71iNV2mV4c/dcF
         iVrQ==
X-Gm-Message-State: AOJu0YzOoNBrX6nev4xcLQhA2u/vAo0WQ/xELHi+PMxCRpW40etIhs4z
	F8sJz2lmyvRMwsgJgwWbYfl2yJ9+wWnzgvb1k7cWb2dwX0qJfbbjgRafDgoe2rT2Lh5J4sldP7y
	ZUeJ49ijh4F3iqsbA0np9AuNknf9fcvet4VvHZIGbN5dvWrQ35DnDFTScMyUzgQ==
X-Gm-Gg: AfdE7cnljl5wFD/t5EEmAYGjKlqAFPvIP016yESeok2tjMv7tbKSPtwARN6J/5cSaB9
	opyYDaB3icPv5bJAqcxHZ4u/hWfU7wSau1WqRBUjrEn6DoecMBJcnp3m0DUzzLqDJL6kiNRRAas
	LU74O5JMrpGYTTh0ifKYpO4P7kpVuoU5dMqf177AfyofgaXEjcOT2lFS+JWRnvXBFyBd+UybPqA
	C/TcNTD86jgHqAqRTyAw6VkhteKc/RgYdnOlHjEgFyJEnFVFuov2Nu4IiC12TY8hs9O/rKVIL0a
	29AyAsiwMr157j5ckiMKyJRiBJxwnNP2QxBedban81brvUqdYKysDHXihXl7hb8Yr6haKwfTvAK
	o2xQ0jsBMQxfELzHf48sRl2cxVm9FrFeJnZKUGfG7KbnMtiI=
X-Received: by 2002:a05:6a00:18a0:b0:847:8387:e32a with SMTP id d2e1a72fcca58-848896ddd25mr12586613b3a.46.1784049476108;
        Tue, 14 Jul 2026 10:17:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:18a0:b0:847:8387:e32a with SMTP id d2e1a72fcca58-848896ddd25mr12586579b3a.46.1784049475558;
        Tue, 14 Jul 2026 10:17:55 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a5bfcc2e5sm731773b3a.56.2026.07.14.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:17:55 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:46:35 +0530
Subject: [PATCH v23 07/13] power: reset: Add psci-reboot-mode driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-arm-psci-system_reset2-vendor-reboots-v23-7-e7453c548c21@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784049398; l=5437;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=2g/1r+tUGIrYD+Rpn7qaYdeF3w/p959uoI3764ZH9S4=;
 b=RmGqrG14uHOhF9BDsVH78VIuj42ggnKscphUOnOD+Gsmj+ocFk015pzZWMOf1ClDpSeh6qKxr
 o9Kk+eX4kGJC5I1S6kHDTRVsTWq5oA0b2e42D470B9lnOFzbRc1I0zn
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX4pU39504zSbI
 oOx9pxLQHlfn9XwIM8ui5mLEjvQ9nz/8ry3zkisqbWR2+d/TsCeAfduH2P8iEPZKJ4n2xF3CGuz
 Pt9OHVYyhZJTlGYlhU+uI8VZjoVcVfp8WjSIcAEXi0KZ9/N43w5IH62p9JYFk5YLaJyJO8oR+Cc
 Tiu3dFmT8jPgpUJJsxkhRuNZFK3DXH2EdVXdgmNSoIrsT8xH1AOPLyhWnBarkgYIbhvnMFSk+fA
 T5bSEIrQ/7zoe1T9flKUGlSGKr2FG2/RNG5rvTSVPC1lKjJLA3KPoq8zqnNHOtxBs3jUx5mD9x6
 YNxrGP/gS/ohRFoP6Yg623hNFCBPVxyh1Ntupn8+kxE+36icz1CzbMmW4kwk6juRA5yjO5A6/HU
 1G9/UzYNDL4PE4ogs65W4i5Qaf130CTg7Mir6JAHnWDKK3eeehHBFLtLmnuwvAU6F54TrQvhfjq
 DXLyyF5BOAcuwr2NM8w==
X-Proofpoint-GUID: F_G6cLQYFmKuh0WmrxTXrfPRpvdvO883
X-Proofpoint-ORIG-GUID: F_G6cLQYFmKuh0WmrxTXrfPRpvdvO883
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX6VKh6524JKeS
 BNX0kIc/mWH16sANMpD78JdqM7mP36qggZFyMBziqdxFgWIMrIUnwSwdHUoXILfBPdPpFUWoC/O
 WllJiBg4r6UJ89POdS4LmGuhFTwOpaM=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a566f45 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5CqnhzuZLWPXzHx0y-cA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140178

PSCI supports different types of resets like SYSTEM_RESET, SYSTEM_RESET2
ARCH WARM reset and SYSTEM_RESET2 vendor-specific resets. Currently
there is no common driver that handles all supported psci resets at one
place. Additionally, there is no common mechanism to issue the supported
psci resets from userspace.

Add a psci-reboot-mode driver, and define two types of PSCI resets,
predefined-resets and vendor-specific resets. Predefined-resets are
defined by psci driver and vendor-specific resets are defined by SoC
vendors, under the psci:reboot-mode node of SoC device tree.

Register the driver with the reboot-mode framework to interface these
resets to userspace. When userspace initiates a supported command, pass
the reset arguments to the PSCI driver to enable command-based reset.

This change allows userspace to issue supported PSCI reset commands
using the standard reboot system calls while enabling SoC vendors to
define their specific resets for PSCI.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 MAINTAINERS                            |  1 +
 drivers/power/reset/Kconfig            | 10 +++++
 drivers/power/reset/Makefile           |  1 +
 drivers/power/reset/psci-reboot-mode.c | 78 ++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1ed6abef62a..4910abafa170 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21576,6 +21576,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/psci.yaml
 F:	drivers/firmware/psci/
 F:	drivers/mfd/psci-mfd.c
+F:	drivers/power/reset/psci-reboot-mode.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 124afb99febe..93e4029d9506 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -348,6 +348,16 @@ config NVMEM_REBOOT_MODE
 	  then the bootloader can read it and take different
 	  action according to the mode.
 
+config PSCI_REBOOT_MODE
+	bool "PSCI reboot mode driver"
+	depends on OF && (ARM_PSCI_FW || COMPILE_TEST)
+	select REBOOT_MODE
+	help
+	  Say y here will enable PSCI reboot mode driver. This gets
+	  the PSCI reboot mode arguments and passes them to psci
+	  driver. psci driver uses these arguments for issuing
+	  device reset into different boot states.
+
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
 	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index d7ae97241a83..02948622fe3d 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -40,5 +40,6 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
+obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
 obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) += qemu-virt-ctrl.o
diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
new file mode 100644
index 000000000000..955ed68f1402
--- /dev/null
+++ b/drivers/power/reset/psci-reboot-mode.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/psci.h>
+#include <linux/reboot-mode.h>
+#include <linux/types.h>
+
+static const struct reboot_mode_entry psci_resets[] = {
+	{
+		.name  = "psci-system-reset",
+		.magic = { 0, PSCI_SYSTEM_RESET_COLD_RESET },
+		.count = 2,
+	},
+	{
+		.name  = "psci-system-reset2-arch-warm-reset",
+		.magic = { 0, PSCI_SYSTEM_RESET2_ARCH_WARM_RESET },
+		.count = 2,
+	},
+};
+
+static u64 psci_reboot_mode_get_cookie(const u32 *magic, int count)
+{
+	u64 cookie = 0;
+	int i;
+
+	/* Build cookie from arg2/arg3 cells in order: cookie_hi then cookie_lo. */
+	for (i = 1; i < count; i++)
+		cookie = (cookie << 32) | magic[i];
+
+	return cookie;
+}
+
+static int psci_reboot_mode_write(struct reboot_mode_driver *reboot,
+				  u32 *magic, int count)
+{
+	if (count < 1 || count > 3)
+		return -EINVAL;
+
+	return psci_set_reset_cmd(magic[0], psci_reboot_mode_get_cookie(magic, count));
+}
+
+static int psci_reboot_mode_probe(struct platform_device *pdev)
+{
+	struct reboot_mode_driver *reboot;
+	size_t count;
+	int ret;
+
+	reboot = devm_kzalloc(&pdev->dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	reboot_mode_driver_init(reboot, &pdev->dev, psci_reboot_mode_write);
+
+	/* Skip PSCI SYSTEM_RESET2 modes if unsupported */
+	count = psci_has_system_reset2_support() ? ARRAY_SIZE(psci_resets) : 1;
+	ret = reboot_mode_add_predefined_modes(reboot, psci_resets, count);
+	if (ret)
+		return ret;
+
+	return devm_reboot_mode_register(&pdev->dev, reboot);
+}
+
+static struct platform_driver psci_reboot_mode_driver = {
+	.probe  = psci_reboot_mode_probe,
+	.driver = {
+		.name	= "psci-reboot-mode",
+	},
+};
+module_platform_driver(psci_reboot_mode_driver);
+
+MODULE_DESCRIPTION("PSCI reboot mode driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56512E1DC
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575840; cv=none; b=jdaBzzeGsgy44oIrHwCwNIpB/m3n/DCXm1rqlPe43gvYR6ZSWKmZOrzw5LiorJU7v4k8LnjtKNEd+64S0GQwyIOQk/JsblOxnr2bOut/X1DQ6uvP1bA+6qVcA86wxAUWEfR4TnsAMgonMlsaKAEaZfft+DQT0VVV3KC7aIV07P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575840; c=relaxed/simple;
	bh=YqKBMwk1p8eRD80CtubSGjeU5I1v3dA71M7seUihtNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvwVsqARSnirsGibDcXoVhOaRJHYu22OZ47xJ1aZKoSDXM3WK7QT2VBzLpGP33ZLvlL9aCzBGoA7B+ZvM2fYuDS7vOqG2R8pHCHGDwUKuouiP2l3xEc9FbtS8wC67nF3gJN7YQwtReuv7pnzidH5CuziGhAHawJ9d6M0i6AVWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5BLxeAk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I3/aWapL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5BLxeAk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I3/aWapL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S59Erc1501115
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FkoT5PQ+I9v6WNTkSl/FYS9fxH1la1EBihgpFgTTI4U=; b=g5BLxeAk4J8SABaX
	0n3VdhzsikJhtR9+e/vzPgBZ7fojXZQzHX/vC9XDnqLed2I9Xo7XYujSNWtD3tO0
	dVOVw/Mlq7UMF009VgdU1Ed4AIAmPyPPQsLURMhBMzj1OIkh09t3M+2qVpaXoVhF
	oJI21fj5tYuPownj1lEt+8P/N5VSNdDqL+85AWS6bq0sX+h7vHD45AXlmT1lFIf6
	LNBK0DGTvy1ARKfgRurqnMny6G5dgCAXCNQsPpmnLvy/xWABDZxzo0gLjpyTiMWU
	FLLce4R+vza7tBxDpqV1B42uGHEtfcnN9TH3iZgl2d767w1rWuZ+YO1Fe05dI7VF
	rVgerA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubg5us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a0ad137e87so4302741a91.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790575836; x=1791180636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FkoT5PQ+I9v6WNTkSl/FYS9fxH1la1EBihgpFgTTI4U=;
        b=I3/aWapLGuNBev136ZXDoFsqFG3SkVLf6ZWxc0dqUAZvERY8KOsaFbU7+RUFoSXLv/
         L6l7ZjD457SHQIRwIV/H9c75dw+nqTP/5wZNMZ+D1Xbn/F093vhdhTMfCaAyeZyFUeRF
         urt3HI/p7vmln9yKrrBDKjcyMHUuOiGcHQJlabQTcGAxB2Rzh3ug9jTEmylc6LsSE/uU
         /hP0AhAs2vSJLOXC1J7Rz1wxvy10boPtT12UG7UstIHg2h7hFPmKVGjkHJf23AG4CMKO
         J94QIcp4IshgyMboyYXUG99gao7tmBH6sKfxgI6c7HpbQHkwQYc1HuCtKtIObTlmBTEo
         gqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575836; x=1791180636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkoT5PQ+I9v6WNTkSl/FYS9fxH1la1EBihgpFgTTI4U=;
        b=xp3uz+vmV22RmcEXbRQ0Zq0q/RyMG2JmoNSjUqjDCP2muH6NCrIxa7NblDoLXEGIBZ
         sb3UYyZR9RfhG/tbxf5MBq+s4Lxen4yk5KwDnfJshGqchx/tsRpufxYD/nddbh1yDPaq
         nmUxiBZjMGHsm9QqYQXdg8JgWJ3vVQJoGfkJWG/Y8D2cYHjvDS7rsBqtW5WdLVKgBBVc
         ZIEQnSPtSHbpn07vWRVM76c/KDvjsyuPEpOAc1xX3vLxElJd/0d/DeBk7nsF57FBCSTT
         3O0vSVD4H33eYQG9JLxv1OWEed2DZQJvG+X8GVeVc37pyYJTjSRhpXl+Vn/suYqNO5Et
         Gf+g==
X-Forwarded-Encrypted: i=1; AKwUvBxgUojMkYH38dBiqQlugr5hHhHJ9fWMYf180ODrgK1B2ITZirqUO6bzMQTu5Ka+8VJ53yi7M3HeFQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL5dqwaWyfoDDErpbF3PypVy/xyxggD6xSPP5h2rGQTivh/rlvp
	FS7JNGlB0V/0pC2kNahv5MG2pZAsU9ZbGQ5AGQThXaxFN5EjmizPIgM48ojhMVJzSmn1VroVSBk
	Kvi9HwQQmBixuANvAtBzxEEEjsEvzqJOzHfHGVr5KGjAhk7OX38/H3p+0OT5t3g==
X-Gm-Gg: AYBFou2rzyE6NeajsCxdkSmfu+H2HmW/8SxPt050ERzVNs9KZvoaAwE/UgFfObXwVqB
	kQSaBcDloDKzfiI+LZjlim8VmIBHIP9bMpgrCL4lp9NOHEr1OhG2BQXcbanXQ8Tu4FGvRw+I0c2
	JAjN7OqwumoOIFUKkQTvU3kyjpGl5tW24sssqNSYa0M0AG6aVeFuoDP4AomHjfY85fA/KLtV9CR
	G9QeI08WVV8E+f/yhIoEnB1rGLAIdcrFqhmqA0HL9iba5OUEj4lqbZvk4B9WKuFIQu/8EKLAGtQ
	x0eKQZVJiErwgX9gX7FcLKN0lpmLlhLslVTe8L5LGkx5mAmO1K129I58Uwms1aGFHRatISWNnnM
	3BDeqYZfyU0gydSsr2NuFGbCxaNZYdO6kR0N2
X-Received: by 2002:a17:90b:2b4b:b0:3a0:c276:1ec0 with SMTP id 98e67ed59e1d1-3a0c27622a2mr6367767a91.28.1790575836155;
        Sun, 27 Sep 2026 23:10:36 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4b:b0:3a0:c276:1ec0 with SMTP id 98e67ed59e1d1-3a0c27622a2mr6367746a91.28.1790575835684;
        Sun, 27 Sep 2026 23:10:35 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm20040846a91.1.2026.09.27.23.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:10:35 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:39:18 +0530
Subject: [PATCH v26 06/10] power: reset: Add psci-reboot-mode driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-arm-psci-system_reset2-vendor-reboots-v26-6-b24e2348e8e1@oss.qualcomm.com>
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790575761; l=7067;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=YqKBMwk1p8eRD80CtubSGjeU5I1v3dA71M7seUihtNE=;
 b=3E1YNxASd5gU46NBpiT33h9AugmPuh2nKUgUe4/iPqhotcRkO3ntGrVjMIs1tgN87ieIRFOBE
 gCX4lvZLL2MAkCFut8J+9kW57OU5oQmjt78jr/Gu0wfl82AvSJisdKe
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-GUID: mTBe4h3tv3GuKehRIsz-5U5lYzQPMe-O
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba04dc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=OTBdipT0aglEIzt2I9sA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: mTBe4h3tv3GuKehRIsz-5U5lYzQPMe-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX0D1SqmeeV56v
 Hq7JraLxaL6IUyxneQzGZSdggfGTyQ/4F9EAZuREX0BdyEt4mJjzQdSL//XZMxwUfZ03/4uInGu
 /kTjl5vZ4xnw1n7BjeQIN5qq1BwFf9yRnENNzZ2W0TurMbq4a4dABzmEVtgT0fLycy+H648tNsg
 Rh7Au2RuT0dZefXsMPqlH6dxZNJGHiSF+QMtF+bV1VqlW9Bpu70nqszMcAS0UcF2X6bG4hh+f/m
 1iTYIN7gJ4RWCvZBE47bmPRfqzW2PJqIGTYFn9kx/E6lLY88VdIjecCefDb34EM7eFMFvJON5or
 ihsRIFdw9Nb16xwPSg32mo3P8wuYhylimeEUkPnyd+AU0wqTfc7WVQvYZJ2/bABTfvpLpRuYHhu
 dYDv6VgXeHUm+4Jsj1Nc3HYnZHY8Hfgr505IOTnRkJBTGVWmCifWuYTtUu+M8faPCL9SJ7D4c2H
 QwKSfliTELte3or3D2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfXwIZ6CyOTjbrK
 /83UlyfjCuhLIGRDLcs70adf8OI3ycF9lK0gzYCBevQhv+HaK1Sf2RxjwRoB40hiU39VRy+TQ7c
 mLc+Qesb3lmHK/UKcJUQf4i8twjtv90=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280024

PSCI supports different types of resets like SYSTEM_RESET, SYSTEM_RESET2
ARCH WARM reset and SYSTEM_RESET2 vendor-specific resets. Currently
there is no common driver that handles all supported psci resets at one
place. Additionally, there is no common mechanism to issue the supported
psci resets from userspace.

Add psci-reboot-mode as an auxiliary device created by the psci-devices
driver. Define two types of PSCI resets, predefined-resets and
vendor-specific resets. Predefined-resets are defined by psci driver
and vendor-specific resets are defined by SoC vendors, under the
psci:reboot-mode node of SoC device tree.

Register the driver with the reboot-mode framework to interface these
resets to userspace. When userspace initiates a supported command, pass
the reset arguments to the PSCI driver to enable command-based reset.

This change allows userspace to issue supported PSCI reset commands
using the standard reboot system calls while enabling SoC vendors to
define their specific resets for PSCI.

Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Suggested-by: Lee Jones <lee@kernel.org>
Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 MAINTAINERS                            |   1 +
 drivers/firmware/psci/psci-devices.c   |   4 ++
 drivers/power/reset/Kconfig            |  11 ++++
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/psci-reboot-mode.c | 104 +++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70a11f2ff61d..1007d5cd2e13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22058,6 +22058,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/psci.yaml
 F:	drivers/firmware/psci/
+F:	drivers/power/reset/psci-reboot-mode.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
diff --git a/drivers/firmware/psci/psci-devices.c b/drivers/firmware/psci/psci-devices.c
index d23befc490ed..04f24b8d9943 100644
--- a/drivers/firmware/psci/psci-devices.c
+++ b/drivers/firmware/psci/psci-devices.c
@@ -20,6 +20,10 @@ static const struct arm_psci_device_info arm_psci_devices[] = {
 	{
 		.name = "psci-cpuidle-domain",
 	},
+	{
+		.name = "psci-reboot-mode",
+		.of_node_name = "reboot-mode",
+	},
 };
 
 static void arm_psci_auxiliary_device_release(struct device *dev)
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bce996bbef28..f165a41d40ed 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -360,6 +360,17 @@ config NVMEM_REBOOT_MODE
 	  then the bootloader can read it and take different
 	  action according to the mode.
 
+config PSCI_REBOOT_MODE
+	bool "PSCI reboot mode driver"
+	depends on ARM_PSCI_DEVICES
+	select AUXILIARY_BUS
+	select REBOOT_MODE
+	help
+	  Say y here to enable the PSCI reboot mode driver. The driver
+	  registers with the reboot-mode framework to configure PSCI
+	  reset commands, which are executed by the PSCI driver during
+	  psci_sys_reset().
+
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
 	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index e31cab4ba78e..45d8aaaffaa1 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -41,5 +41,6 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
+obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
 obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) += qemu-virt-ctrl.o
diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
new file mode 100644
index 000000000000..bf2dd6626feb
--- /dev/null
+++ b/drivers/power/reset/psci-reboot-mode.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kconfig.h>
+#include <linux/module.h>
+#include <linux/psci.h>
+#include <linux/reboot-mode.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/*
+ * Predefined modes use two arguments. arg1/magic[0] is always zero and
+ * arg2/magic[1] is one of the values defined by enum psci_standard_resets.
+ */
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
+	/*
+	 * For a 3-cell magic, arg2 is the high 32 bits and arg3 is the low 32 bits.
+	 * For a 2-cell magic, arg2 is the low 32 bits.
+	 */
+	for (i = 1; i < count; i++)
+		cookie = (cookie << 32) | magic[i];
+
+	return cookie;
+}
+
+static int psci_reboot_mode_write(struct reboot_mode_driver *reboot,
+				  const u32 *magic, u32 count)
+{
+	if (count < 2 || count > 3)
+		return -EINVAL;
+
+	/* Unexpected value at magic[1]/arg2 on a 32-bit system. */
+	if (!IS_ENABLED(CONFIG_64BIT) && count == 3 && magic[1])
+		return -EINVAL;
+
+	return psci_set_reset_cmd(magic[0],
+				  psci_reboot_mode_get_cookie(magic, count));
+}
+
+static int psci_reboot_mode_probe(struct auxiliary_device *auxdev,
+				  const struct auxiliary_device_id *id)
+{
+	struct reboot_mode_driver *reboot;
+	struct device *dev = &auxdev->dev;
+	size_t count;
+	int ret;
+
+	reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	/* Skip PSCI SYSTEM_RESET2 modes if unsupported. */
+	count = psci_has_system_reset2_support() ? ARRAY_SIZE(psci_resets) : 1;
+
+	ret = reboot_mode_driver_init(reboot, dev, NULL,
+				      psci_reboot_mode_write, psci_resets,
+				      count);
+	if (ret)
+		return ret;
+
+	return devm_reboot_mode_register(dev, reboot);
+}
+
+static const struct auxiliary_device_id psci_reboot_mode_id_table[] = {
+	{ .name = "arm-psci.psci-reboot-mode" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, psci_reboot_mode_id_table);
+
+static struct auxiliary_driver psci_reboot_mode_driver = {
+	.probe = psci_reboot_mode_probe,
+	.id_table = psci_reboot_mode_id_table,
+};
+
+static int __init psci_reboot_mode_init(void)
+{
+	return __auxiliary_driver_register(&psci_reboot_mode_driver, THIS_MODULE,
+					   "psci-reboot-mode");
+}
+subsys_initcall(psci_reboot_mode_init);

-- 
2.34.1


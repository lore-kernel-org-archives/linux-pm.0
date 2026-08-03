Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FA38886A
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750354; cv=none; b=axgViTpujL2V10NThCvgR2vKvve8A+aaMNTl3hwp9hj4CxoVyUUUl/0vZKUMBj0jBGQiSmnSNS1UOnJPNpBd5Vlc7DTSEbsbDfmYWdnu2cswyjFCGjt5CqwkSHjczYYnbw+SUt8iRjTMiTM1FPm/mqtqZPmy5yJXGlh2MLuvZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750354; c=relaxed/simple;
	bh=IqjZzKl7BNCcMxSaF/5GXH4dOI6iylxX8niIaIkSeSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2n3Ia4KRN+YMXvngxaodsf3Oj2k0ByUDtVsXk16SveXyZPqbize69Zdg06EkPBwd+gwFV2pHA6U4BcpWg0cEoPNBoLLboatVph8sT3+jMoMLdwObR9W4UuQkaadeNEv13j2YFcaAUgdTHn9akLtB2YeANQ17ByjQj9OV5cjUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U2+j8Yif; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NURdXliO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U2+j8Yif";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NURdXliO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736sQFT3790534
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 09:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P7gMpX23LaFBur5pPQaddvCHQnd9R+tRGpPVMI8EOpA=; b=U2+j8YifrLrGpHLf
	DagnOKH5YQVkmVgEsYiYdrTjJ44r+L1oIRaC9h0ICZlvQSQuX8tblcc2WzG9VizG
	JiHWhc2kLcnsJJiy6+MJsZCOkLWm3VHNBXZcj77hlZsncMPAZSEmuj6G5nrUJ7ng
	8HgjolqMvaZEnXkE2kDllhCaJxKL780lKiWoM3YEC8HcCPQ2XOZT+aBsMIowwbv2
	GggyiZo288eBc8OaIuTyk7ffxS5wNk4KrK7JciNCl4F354usc61ksDbWt8F41NRQ
	GFDSilfhagTNLJEshhgsFEqiOl9kzsNwZafxenYf4llM+u2be5ynk1c0hVqV4jub
	o87HfA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftp4r0sgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:45:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so4517428a91.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785750345; x=1786355145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7gMpX23LaFBur5pPQaddvCHQnd9R+tRGpPVMI8EOpA=;
        b=NURdXliO8fehWGFeqFJANlG9ph7vBzzglU9yWB42hjBcYiclf07snKsR5NfwqPf1k5
         w+gcE7mopkdlXagYBjKaRmvyqFWAXSqtjh1pt63fEMSRf2pc3q3aX7GkwGJUcy/nmoaK
         6XdCsZfnzMzpaBuBn0KKL9QS0IH+MsJSZwzFo4grZC9KKv+rwBAWDeTkSWB1R3RMUcmm
         GGTZPGrgHqH90ku4px0l23FRDQiHMz7rFdWLTgb+tCYOaVCx4hkoUUqdbO0YAColMGER
         sQtjUMRwV+KnlmEoxpJ24eu+by68XDuY4IvSv2WnJ9sktRr3E6r7TCCATESMlk6zBLh3
         w4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750345; x=1786355145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7gMpX23LaFBur5pPQaddvCHQnd9R+tRGpPVMI8EOpA=;
        b=nBjK2fFPd6fZtA4I/ahiq0mMWt7k039EtNLmRk0bk3xasG722OLoRkozbKy9ZTJKtt
         IucUzoizgoXrlSfePWiyAbDvcHtffx7yJfrjCVzEIay1yG4ATZu3XOuu+g8Mtt8y5POd
         2y4oLNzdMjnuZPe/xyagPaHtaoCTUhMg2PLhFdCblLP48vkjJHyumWOOmpgvExCIANPG
         K+AV4iiKOS3ulqd0xhRS7lTY8kYG4AxV6hX7d4kz1HhXWG9x9EiQGjBUKq8dff1VXAB/
         eWgggJ+rMHhdG8MM50rhl1g1/1QtNQcNAmxV4vRrRgC0EWxAz5WOz3m+jMWnAUIgKr/N
         70eg==
X-Forwarded-Encrypted: i=1; AHgh+RogrLK9TzObmB5Y0qAY1F8lpblS1wpebD4550gfnnyRbapCa5TchyKN/NguvqvJtloT9cZxBS50+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXwQ2FWptq2ntRZGwzI3nT7nU1vnuwMWZ062ywGqgWpxe/VDW
	0X2TPw/vlMaTgbRZu/O6z6PzyhyVMtkDOEIqNziorfsvG/AXbbnC+/9N684Ha0PziCwCKf92EBw
	CBST4mLXB5fFW6P5JdpON/EHVr/w8oq9WNSxO850ehJGcLVjaA5+ueSPitzEH7g==
X-Gm-Gg: AR+sD13VOftcOpL3WiKDw1eK7DMb55dcV3RRyglv0CMQeYhZWYPhPu2vo1ME35MahzA
	eXka1YIJX8YIQ+SNEjOmwE4V/cNH4ZYSh/q/gvxzTUnH3GI2BSo/1T+D4OfmZWhbhtPTSCGt06J
	eAw/gArkgzX1kGYKZ2Ic2xQ2Q2JeYDDshMf9XSFl65CUCh4Mt3Oz9JxUQeAfP86+e/IkaiJd/7R
	b1L64f6jGOUsx8UKBjxV6bF4RoJo36orzxe0HdDKSBOIaz6DEZA5R8FA4iaNkfLn/KQrYegskTp
	BkUbgqLTFD91qLrQACoFSThEsEUdmRBYCNLmB2TLbeZkiZUXk3R51SX9gVzey8TD6tnGIBKb8vk
	4FLDREfLY4YreTDXw8risepq/XA6O8PaALlJb
X-Received: by 2002:a17:90b:2d4c:b0:387:df8f:1401 with SMTP id 98e67ed59e1d1-38fbc598becmr9021668a91.34.1785750344756;
        Mon, 03 Aug 2026 02:45:44 -0700 (PDT)
X-Received: by 2002:a17:90b:2d4c:b0:387:df8f:1401 with SMTP id 98e67ed59e1d1-38fbc598becmr9021646a91.34.1785750344278;
        Mon, 03 Aug 2026 02:45:44 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2be6c8csm3660671a91.13.2026.08.03.02.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:45:43 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:13:37 +0530
Subject: [PATCH v24 06/12] power: reset: Add psci-reboot-mode driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-arm-psci-system_reset2-vendor-reboots-v24-6-889281373870@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785750274; l=5554;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=IqjZzKl7BNCcMxSaF/5GXH4dOI6iylxX8niIaIkSeSQ=;
 b=VvuvdMCCFfCnpfXMiifmJIg8ToW9mGWhz/YcyhcWBwYZyQ++L8G27zDMPlOvzPWKAgRM6T2dZ
 hAxw26BregDDZ4ndgGJJEgdlZIWzxDPFme60Q11ADtcSKqSRYEiKRjY
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=X9Ri7mTe c=1 sm=1 tr=0 ts=6a706349 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5CqnhzuZLWPXzHx0y-cA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: ByZoujkBIjwjrfClDbvqeuKRCGAPRwrf
X-Proofpoint-GUID: ByZoujkBIjwjrfClDbvqeuKRCGAPRwrf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX7P9Bkwigdg+r
 ke9pipIhJcW9fX1ejtvWESmAycPr+7bOJSP+1Vhow2OjeEAbN5/zkhvlN1oWVzrXm/XmDJifoUm
 iQmfGGjeRxrICkL61fmx8Fj4SkwgBZk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX8nyg4mt+ShRB
 kBboWZf44WHb/iuwFYfgDR6/Y4OBqUaOuRBi2+ECJqUpV6JPDfYst49TrWvugehqeRoeu6pD/U/
 lPmvxHaX85UbhQ/kK2yoiRMsogEguAXmSgfH6GA8DJdElkZnFN4FowHumNJoL5wk0QE9v6ZqO46
 5ri5PqvA7819SSrg6idcn9hm581OzY3NebJAxripQ3O9VbneakPsuwF0+cbUFqgWZFUSOfQ6KKd
 UARsRNLQE+UFl6ZawO2LCFOME3lbODAaaQU4Khsx9W/fxhf54BeGpq4lZ/aB29BqC1oCSHeCBYy
 3RaR0ODbuvOUmSziNACcFeeJqOhAoeSlXZmygYFoaUQOLQ57zwV5RphMjmZN/odLrqH0hqkFsPo
 i6bTOqU+11lENwZ53Z3rqNniEixtxYnSRKjV6CHmAFmZQW0IQuhk6tPFbKSrytQmhU0WExpOJQ9
 8VKrGl8QkCQYsTUz13Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030086

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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 MAINTAINERS                            |  1 +
 drivers/power/reset/Kconfig            | 10 +++++
 drivers/power/reset/Makefile           |  1 +
 drivers/power/reset/psci-reboot-mode.c | 82 ++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b6e4f89f319..a3339b98ba86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21672,6 +21672,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/psci.yaml
 F:	drivers/firmware/psci/
 F:	drivers/mfd/psci-mfd.c
+F:	drivers/power/reset/psci-reboot-mode.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bce996bbef28..143f3260f04a 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -360,6 +360,16 @@ config NVMEM_REBOOT_MODE
 	  then the bootloader can read it and take different
 	  action according to the mode.
 
+config PSCI_REBOOT_MODE
+	bool "PSCI reboot mode driver"
+	depends on ARM_PSCI_FW || COMPILE_TEST
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
index 000000000000..2f960fda8229
--- /dev/null
+++ b/drivers/power/reset/psci-reboot-mode.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/psci.h>
+#include <linux/reboot-mode.h>
+#include <linux/slab.h>
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
+				  const u32 *magic, u32 count)
+{
+	(void)reboot;
+
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
+	/* Skip PSCI SYSTEM_RESET2 modes if unsupported */
+	count = psci_has_system_reset2_support() ? ARRAY_SIZE(psci_resets) : 1;
+
+	ret = reboot_mode_driver_init(reboot, &pdev->dev, NULL,
+				      psci_reboot_mode_write, psci_resets, count);
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


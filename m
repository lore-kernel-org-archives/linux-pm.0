Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90833AB46F
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575818; cv=none; b=DENPLiImSLVl3C53laokvSsmVKOszDz9xyiO+AiM/4XM3IGL527eYeKaRZY82zAzPYd3NT3AiDHXIVsgpNw2hW6Sw2VUIF+CPvbY4sTCfBIlaGj7tWerQzwj1/mj4lZSEhCvNPxR/GGUORpM+nEae2QH9Gxts9wqzq8pJBU7nto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575818; c=relaxed/simple;
	bh=s+F2LpPjY225AXXtAlSq1y6fik/3LpswKtBmQ0eyHlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dzw/Dgoeq8YZS1yY/j2tf90PP562uccfRzDIzqop7lpSZ0lG8EdmIO4a6G5x6I2L3gK8femLKUNLSxLoxU686eARnMPDaTHxgFDyu5qkpv18i3w5vPUKD/o8uafaMuhGhlXB0GB1H/+nKwYDaXuopH1h6Z9R0MVJesTAj3/MzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgKJBeWA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PkoxUzDC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgKJBeWA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PkoxUzDC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RGmbM63167999
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t0DqDJ0pB/nmQ/l+KL+PFu1ALELoJnqz5KUly/ibpE8=; b=RgKJBeWA8ByTQm0H
	5E6sG1+B+mIiAT4iNnNff0xEQKGCgMw6CzNBA2UmW7/NqI/86hhd0a2hDC/12yh4
	6Ng9bvuLGlb22QBkidlLIBfew4ViCBzNWwWFkxpR4wl8dtIa5/2MVzApXZO1CNJR
	I0aAojh+Dooiy64dPsisLV9p4QOpUGrX5u40cwCkFI0SzBtn+oeiJaF2QbX9cUat
	zzOafjU9VDvVsJ3Sw2wqimJobHY+/Ihs5f8SaJ7PFylfnCLGugju05RpiPCpAiio
	LSzU2cYwmCyH6wqkrafUDAvQNj0CmaBE0P91Lm/xw/PPlI5AbWFDZBk9y0oiogHw
	ivcDhQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jvme8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso3033714a12.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 23:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790575815; x=1791180615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0DqDJ0pB/nmQ/l+KL+PFu1ALELoJnqz5KUly/ibpE8=;
        b=PkoxUzDCcw2QPfHFyBXJbNsev33skqNdphTJ+hBz9ou8sSHE0fhsg0SS+eYRIH/5QW
         8VS4rUttGcX/xZUKbz/OEf04KwxYwpHIrZUaGsvLMByBFTO/wCVCvlShtCtXco6iWZiM
         cBrOWsgX5g65/GbHPbmDUSTVxL8DJgdMN3G21TxR1IvZXD6N+Vtcd0i+KGg/1L4pDYOh
         4CxTFQZXvLqZNdNztCq+OCUCfJgVvCpxazioHSeWh82R8XCZ1t1754NJu3iK3NIkFFcw
         4TbZOLnVseH7jtku7SAZ+punkdccx8w81+7esLFhrSam5Jan78y46ZsZhvY8IcjrGHz+
         yFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575815; x=1791180615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t0DqDJ0pB/nmQ/l+KL+PFu1ALELoJnqz5KUly/ibpE8=;
        b=PxyRc6pPrM+0wHu2CdxtCymP3++nIWSsj2KyYiCq/Dd23Df9POS5b5UOYljfJNagmH
         WGAXGsAKB6hShKFb2VI8+dRcMto0e7FEmDsghd9llw4wmxnYrng06HUQ+2JGexrXwdOp
         I5vUytsQ8iZcXGCNLGt1I1AQzHbC0xHMdqSlWdkpFrsPUK1PELOMkdiBAhNea0r0FWHE
         GNTlwSzHQPqiCDKlr5JRKlB7OEBxStVHc2rJYml+roy7VWc8qQc3SZUfpzTe/YOHG/rr
         x7ZGpxMhktyRBGhkj+IebiVllv00cBtfBOjsrWLOAi7s4xWtRGDjB9Z5qFCxynpZIAjW
         +xjA==
X-Forwarded-Encrypted: i=1; AKwUvBymddiaXi3npAbIFcejY2hu+yAtICEf3s3V4R6Qd5PhTIIDduwxz8wdQ+OkXp/RIUEiwvRlQV3y7w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJTx6NcWHOnKl2D+c0PUXuBA9pvryqdaweRAewRBNTL4j90x3fa
	psJEjsUQIYUlxp5wBBgcdarizcTRi2dptKUOG5mYqUdd5gNEAUzhQzdQ5V44F+gHbfqga+/bCNZ
	JodLzjFslxlbUsHjTRzgLYnXSMvIQHsDGvUg4X4Hn8dH71nNKeinmvfAAY2sHoQ==
X-Gm-Gg: AYBFou1TqCLcyug7tm7htixpqdi4+3PxiwWkzHwMv6i9Z7C0EtaqHtW8afbZSRJOWDQ
	R93yqf/FZLU4GQUb37upiq38jQxTI2WR1oWVtTZ+aL+55GdlUz+LI7gDdRH8v/2AV8z4JW+g1x/
	AinaCMGNu1eSaxvg5gtZvZDhjZbCtsxni+nDITKyIuSjNF0oUrc7TmSCJjGM+SZ+eB4Eg4GgaES
	1MtvyUEYPbwsU6ibIIZU80bDAQWo4BuaWe0LlJqwyKd19uUtoesWbtS1I+QzF0CvSDd5RPY7hjh
	VVAvBiemzE9OnP6Yy1fIwM97sXTeUj0fOxdq97aYIErd+Rj3rleqW8tKfYIZOj6a1osU5O9XH+n
	GHP/COTvKaHHHpyXa6MFeSQIZgmjpzgkyi26E
X-Received: by 2002:a17:90b:3c12:b0:3a0:b210:643e with SMTP id 98e67ed59e1d1-3a0b21068bcmr8585826a91.22.1790575814940;
        Sun, 27 Sep 2026 23:10:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3c12:b0:3a0:b210:643e with SMTP id 98e67ed59e1d1-3a0b21068bcmr8585812a91.22.1790575814487;
        Sun, 27 Sep 2026 23:10:14 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm20040846a91.1.2026.09.27.23.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:10:14 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:39:16 +0530
Subject: [PATCH v26 04/10] firmware: psci: Add support for PSCI auxiliary
 devices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-arm-psci-system_reset2-vendor-reboots-v26-4-b24e2348e8e1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790575761; l=8065;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=s+F2LpPjY225AXXtAlSq1y6fik/3LpswKtBmQ0eyHlE=;
 b=gQbnNfJiFU/qICIAKpI98925/lty16Om6ynYaxb2H4Dv92rzs5I+2hPApuKWT9PwCNT0b+5MD
 r/XNuai+KN7DfduGXhi19L5aJX9FAm7fm4jzP1cEOdF5idS1rPqp6w7
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX63pncL3cU8iO
 QVf140/hXfLK8XVcmnCh56tFUKt89NpKWkQb0R6cKnu7Ow10vje4KplvAhQwzaojS/SVJKOO8VB
 h+fmal6x2k9fWGfF8sHB7TTtBBIiL/E=
X-Proofpoint-GUID: piGulURIvd3LIDt4k3W-m6KRhuaWFpF1
X-Proofpoint-ORIG-GUID: piGulURIvd3LIDt4k3W-m6KRhuaWFpF1
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6aba04c7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pkOq05zB4EqCiNOTdIkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX/P2MhCE/FhT8
 8AfO/f4pgCbj+F2OCX0lytNX5T6PGe+Y9WrbxicVMX4mCuhNhakd8cw86EEnnWhsKlo+BRXSQyP
 efCr5X2Pqco4SIsOVWT5qUndD8blX8ZTQ4BXntZBdnvrFnfL98KH7xuDAxh7hBnogmPKyArUGqt
 2Fh4FUJUEvn0ko4i0/UF2i3A/dDWVa1UEWhH+DdzYSUc8OPvGaxJ424VKl0gcRoYUnMQQIZClEk
 TG5nZ2eh1yAqDuwQj9HqQ4u09ZpsZig7b2eTlZkp158T0C/Oe0UmqQkhWqevqoqtpy/nfhBIDAs
 HvR65lROrlNwjJmKJ2bfhvgpur9ekZT3iV4QO2LD2BdgxzlvYRcmGDvBxxIJrD2/lo79gnXNFy9
 yCBB5jRh96pMIk+bDOkynhaBQZ8kgMTwK6s2uwEv40JKgqmI5IFmfS5dQXxwxvfdvP6639pdIRn
 96iolVQ6ak/WndHXjWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280024

PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
Currently, both the PSCI core driver and cpuidle-psci-domain bind
directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
introduced, would also need to bind in the same way, leading to multiple
drivers attached to a single device node.

Introduce a PSCI auxiliary-device provider that binds to "arm,psci-1.0"
and registers PSCI child devices on the auxiliary bus. As the first
user, register cpuidle-psci-domain as an auxiliary device.

Update cpuidle-psci-domain to probe as an auxiliary driver and use
the PSCI device node for power-domain traversal. Allow the probe to
succeed if at least one auxiliary device is created.

Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Suggested-by: Lee Jones <lee@kernel.org>
Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/cpuidle/Kconfig.arm           |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c |  33 ++++++----
 drivers/firmware/psci/Kconfig         |  14 ++++
 drivers/firmware/psci/Makefile        |   1 +
 drivers/firmware/psci/psci-devices.c  | 116 ++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index b88b01aa5829..f22e18b05053 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -36,6 +36,7 @@ config ARM_PSCI_CPUIDLE_DOMAIN
 	bool "PSCI CPU idle Domain"
 	depends on ARM_PSCI_CPUIDLE
 	depends on PM_GENERIC_DOMAINS_OF
+	depends on ARM_PSCI_DEVICES
 	select DT_IDLE_GENPD
 	default y
 	help
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 5722365b943e..199c1494c566 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -9,10 +9,11 @@
 
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
+#include <linux/auxiliary_bus.h>
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
+#include <linux/module.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/psci.h>
@@ -121,14 +122,10 @@ static void psci_pd_remove(void)
 	}
 }
 
-static const struct of_device_id psci_of_match[] = {
-	{ .compatible = "arm,psci-1.0" },
-	{}
-};
-
-static int psci_cpuidle_domain_probe(struct platform_device *pdev)
+static int psci_cpuidle_domain_probe(struct auxiliary_device *auxdev,
+				     const struct auxiliary_device_id *id)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = auxdev->dev.of_node;
 	bool use_osi = psci_has_osi_support();
 	int ret = 0, pd_count = 0;
 
@@ -176,16 +173,24 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver psci_cpuidle_domain_driver = {
-	.probe  = psci_cpuidle_domain_probe,
+static const struct auxiliary_device_id psci_cpuidle_domain_id_table[] = {
+	{ .name = "arm-psci.psci-cpuidle-domain" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, psci_cpuidle_domain_id_table);
+
+static struct auxiliary_driver psci_cpuidle_domain_driver = {
+	.probe = psci_cpuidle_domain_probe,
 	.driver = {
-		.name = "psci-cpuidle-domain",
-		.of_match_table = psci_of_match,
+		.suppress_bind_attrs = true,
 	},
+	.id_table = psci_cpuidle_domain_id_table,
 };
 
 static int __init psci_idle_init_domains(void)
 {
-	return platform_driver_register(&psci_cpuidle_domain_driver);
+	return __auxiliary_driver_register(&psci_cpuidle_domain_driver,
+					   THIS_MODULE,
+					   "psci-cpuidle-domain");
 }
-core_initcall(psci_idle_init_domains);
+arch_initcall(psci_idle_init_domains);
diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
index 97944168b5e6..68e381f1a618 100644
--- a/drivers/firmware/psci/Kconfig
+++ b/drivers/firmware/psci/Kconfig
@@ -2,6 +2,20 @@
 config ARM_PSCI_FW
 	bool
 
+config ARM_PSCI_DEVICES
+	bool "PSCI auxiliary device support"
+	depends on ARM_PSCI_FW
+	depends on OF
+	select AUXILIARY_BUS
+	default y
+	help
+	  Say Y here to enable auxiliary device support for PSCI.
+
+	  This creates auxiliary devices for PSCI functionality implemented
+	  outside the core PSCI firmware driver. These devices allow PSCI
+	  child drivers to bind through the auxiliary bus while sharing the
+	  PSCI firmware device as their parent.
+
 config ARM_PSCI_CHECKER
 	bool "ARM PSCI checker"
 	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
index 1956b882470f..8e75a0ed6f74 100644
--- a/drivers/firmware/psci/Makefile
+++ b/drivers/firmware/psci/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_PSCI_DEVICES)	+= psci-devices.o
 obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
diff --git a/drivers/firmware/psci/psci-devices.c b/drivers/firmware/psci/psci-devices.c
new file mode 100644
index 000000000000..d23befc490ed
--- /dev/null
+++ b/drivers/firmware/psci/psci-devices.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct arm_psci_device_info {
+	const char *name;
+	const char *of_node_name;
+};
+
+static const struct arm_psci_device_info arm_psci_devices[] = {
+	{
+		.name = "psci-cpuidle-domain",
+	},
+};
+
+static void arm_psci_auxiliary_device_release(struct device *dev)
+{
+	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
+
+	of_node_put(dev->of_node);
+	kfree(auxdev);
+}
+
+static int arm_psci_auxiliary_device_create(struct device *dev,
+					    const struct arm_psci_device_info *info)
+{
+	struct auxiliary_device *auxdev;
+	struct device_node *np;
+	int ret;
+
+	auxdev = kzalloc_obj(*auxdev);
+	if (!auxdev)
+		return -ENOMEM;
+
+	if (info->of_node_name)
+		np = of_get_child_by_name(dev->of_node, info->of_node_name);
+	else
+		np = dev->of_node;
+
+	auxdev->id = 0;
+	auxdev->name = info->name;
+	auxdev->dev.parent = dev;
+	auxdev->dev.release = arm_psci_auxiliary_device_release;
+
+	if (np)
+		device_set_node(&auxdev->dev, of_fwnode_handle(of_node_get(np)));
+
+	ret = auxiliary_device_init(auxdev);
+	if (ret) {
+		of_node_put(auxdev->dev.of_node);
+		kfree(auxdev);
+		goto out_put_node;
+	}
+
+	ret = __auxiliary_device_add(auxdev, "arm-psci");
+	if (ret) {
+		auxiliary_device_uninit(auxdev);
+		goto out_put_node;
+	}
+
+	ret = devm_add_action_or_reset(dev, auxiliary_device_destroy, auxdev);
+
+out_put_node:
+	if (info->of_node_name)
+		of_node_put(np);
+
+	return ret;
+}
+
+static int arm_psci_probe(struct platform_device *pdev)
+{
+	const struct arm_psci_device_info *info;
+	int auxdev_count = 0;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(arm_psci_devices); i++) {
+		info = &arm_psci_devices[i];
+		ret = arm_psci_auxiliary_device_create(&pdev->dev, info);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to create %s aux device: %d\n",
+				 info->name, ret);
+		else
+			auxdev_count++;
+	}
+
+	return auxdev_count ? 0 : -ENODEV;
+}
+
+static const struct of_device_id arm_psci_of_match[] = {
+	{ .compatible = "arm,psci-1.0" },
+	{ }
+};
+
+static struct platform_driver arm_psci_driver = {
+	.probe = arm_psci_probe,
+	.driver = {
+		.name = "arm-psci",
+		.of_match_table = arm_psci_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init arm_psci_init(void)
+{
+	return platform_driver_register(&arm_psci_driver);
+}
+arch_initcall(arm_psci_init);

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0CD39CD03
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049460; cv=none; b=R8aLkMapOx6acRMFiLKRkWG1xTRHx6mh9oUoClUYn6KJl91GcinfuawfvMifPHHvt52IuP7QHAB55USc1baQU5oHyTyZlPNEmTZIFFWeFEE8fFCTgOUYRXXeDDg7P72amjWgGsqfFmdeZWUOJIeZ7lU5jDXKwM8nuoUFjAyzuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049460; c=relaxed/simple;
	bh=WwBfb2ZvreUMO78WFLpkZieBbDtffp1obNxsGq+C7tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+uqytN23VJvX08H0tREUDyqjY07F+Jp8d5s4wIjjMZUYH5bcSolwH0qccgw17jz6AheXNBGNO74zlrrf/vR+4jQIjGEeMTuljHtvVOpmAXwjYm0kR0X555zQf/lUJ/MZeyVyOFN+NELKsFhD/ZJPSLgCvMGGM20loKYERB1Ze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XIpxSKZz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gOrAFxJH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIpxSKZz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gOrAFxJH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6w1h852643
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kCPxF6uGGYpLkRljUCIn74j0oFDyhw53Efw/4CN1qbA=; b=XIpxSKZzSXAIx5nx
	dtyL7UV4jeEyKghqFFtLH3t5mpBl07+HTmnAKBLfP9lEyClC7K2tFozz+8w0k4Kn
	Gayt6A6bXKY3wBDjW4omOdKzETpNcs8GaZWHborsUYjqdkqUx0fwdLPEaG68Jcef
	gmwAyj2/e84tKuEX27QBum421jnCugUcfhXG9dbEDLoCC/tO2ay7Yrx+W/T17S1Z
	XD5h7cyoKqLjuspwgpQS91h193NVxA0UhAiUAKuqVq1oh2ZfpOyB+B++M0cTy8XW
	KStsZ+MJYFlezyol2ypXVvXMHR9670IrvbilNOqinDAG6OFUaI56PZHz/5SZqMbv
	JDou+w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmkk1dph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:17:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84870e7f498so5352506b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784049457; x=1784654257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kCPxF6uGGYpLkRljUCIn74j0oFDyhw53Efw/4CN1qbA=;
        b=gOrAFxJH5T81kbQh1CZNdcvUmL1IKUaAKc6bHFleCyL5PjBkScABY++JRYcHqxUIQX
         +ZKBgGblkr08yWAVZA4jILmkqriwVLBMaNIcxBW9tMDChk1RKftyBTUiZqazh3WNadxy
         wklXT+d+V4yTiwLdNbS2E01fYJ9rePbkDfl7QvCxhSP6aO5a/YrcVpliU6xsYQuohM/A
         /tACAJjTp2J5n3gjtNbwVIP2PkNWASCPI1aYfvtYoe4T+6EfrE/dOvUQ2BQe1rNUzDuW
         xYbmmjkXTXMgn/nMfUaFsf43rnZPLf1JzBvbGoG00KWG9fxaxIJ1S7rSLb52UQwDcM8n
         +XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049457; x=1784654257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kCPxF6uGGYpLkRljUCIn74j0oFDyhw53Efw/4CN1qbA=;
        b=htYuKVBKkSSCK7NjOB7F7qzv0XwQWAR5+zSAjRmKH8iLLAqsLc38O6L6VFHI1mseZj
         9qxakwe4JZhafbESDcw38y/zXX6nr3strOrcB9p24RcYW9fjWUdyZRu9Tt1N0cEHCa7w
         Z19jakBeOIS5je9O7ixBLhRFlUTpxHHTlzOHTy4Ur81PB94k9dyixMytw4Hu5FqxlDF3
         88579p3068nWjes8JAsGL9L7lk2kuRMG9Hz3koOMbq8FMX43QsQgQFL/0QCuBin50DaU
         aTGKU9erPIKtsjeM64PBzbSNjOh3K3e//19TfjpdyCb7NIOrcOFWWkydTPr8tAsI5jIn
         V4Uw==
X-Gm-Message-State: AOJu0YydOwvlGA1WiU+bSaOX29N2iQ7lKNkZoMhNAiXZpPFHRW0KP7Us
	q7UeN+eYGI+fxu89VGIRXoiV5INWd2zoie/xKUe1rOwA/ZdKnl1CYuv8yralyZxBtqHLJMRZUjX
	vIhEYd1zPq/wbisXNjFay0LpGDyFkuqfAYVZpCCqcvK8NJf499sJEejvqQbH6Yw==
X-Gm-Gg: AfdE7cmMYjbCA/VmzNb+yr0kI85GF/7tdkP/AMWLpiVMHgbsYPFj/IT7JgZC6s0o5Xn
	5GOe4/C7PRrj9LOauIHl9GWSPK5AKRRjaEPRkEqTLQvIgCjXyugPb1lC7yJ08lhIardKrvRJDXk
	zmERf/9D9udDpFjsVbqovSWNe0v1iCTC30/+Q+eJ3GWNABQViKucbF4LWqub3oMHaYHPnyibCxu
	w7YEp6GuLHvNUCLHj2JcQf1Fkh48prsrkp8zvWxcVTKt4D40Vv28OX+XozNTp9NFB+0ZUKF60oV
	9jioYHfrNV0A/5k53275dF/yi2ml//R+trnkXIKdZLUr3PQC4z8Ta5g+Cc9mPdvSzDgQR4KIXcu
	n+9coLdPAt9HK8EfY/XYCUzHdcZYb7FEnE1Xlfx2gxb/F4g0=
X-Received: by 2002:a05:6a00:1f06:b0:846:8b22:4933 with SMTP id d2e1a72fcca58-848896612c6mr12636118b3a.17.1784049457289;
        Tue, 14 Jul 2026 10:17:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f06:b0:846:8b22:4933 with SMTP id d2e1a72fcca58-848896612c6mr12636064b3a.17.1784049456631;
        Tue, 14 Jul 2026 10:17:36 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a5bfcc2e5sm731773b3a.56.2026.07.14.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:17:36 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:46:33 +0530
Subject: [PATCH v23 05/13] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-arm-psci-system_reset2-vendor-reboots-v23-5-e7453c548c21@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784049398; l=5547;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=WwBfb2ZvreUMO78WFLpkZieBbDtffp1obNxsGq+C7tA=;
 b=WEdIWqidYL4gyeVT9/byS7p/mXPDZVnitOfzgIAtnnqC5h6RRMdVeDn5ckn8JBbNV5EfrHuSs
 BVz4nGfXAeXApyajcnFqdc8bYpM+ClQFd6+S+1kCDr/2nmCXDqDEKl8
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: GAVucTOzz6z2mFg7h3ABt74QmKTg3vfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX32lNcPTizUcW
 zqzEJMxmkz5fXYoAiUeeJhsHSdJClw6MDkhShTIanx1novCtleW1bbza2ADzyl6eFlMl6gfQJ8C
 juYhnd9uFg+TzqtjTrQPDlsez5+GXVAVy2Ab2v13cLlr5tkiP6+DiFAOdOCZVIejGX8XdQFFaDh
 oV4eL/O63sN7dNHu00OuSAhKK2gbdm5yjSfUpju9tdq54KN9ItFOCztncg1IiR8RVIs2Q4z6767
 LUuuft7ejShThJwhR8Ox9rA5dEABfmq9zOzLmAsCUi6EL3UVw8ZmYy/HXQCCeOhPjJ5SEvoiV2E
 KqcAsHJvOCnc/WLcFu5Zi1QEM/tUGDK7clHE0vEem2L1KbzZEuTTuKU2joR3f2zlm+wCEKgC9fY
 577sAJFQsieNy0Us9/9QHAUH4hMolbcSw5LkViKujXIn1sCVXM/eYfymOcdvTxuikrC7HuMwtv2
 coyDSILKx+RURJPba/w==
X-Authority-Analysis: v=2.4 cv=NszhtcdJ c=1 sm=1 tr=0 ts=6a566f32 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=wfThnEy5_2w5d1iZ5YkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: GAVucTOzz6z2mFg7h3ABt74QmKTg3vfv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3OCBTYWx0ZWRfX/M0z6o/OCrit
 0JYhv08Bc4LO/90OP9WERWgvns6/FzMg3HVPz3dQfQxDL7NZtcXV5WAmsagCCFzJJ0sgUf9dyRH
 YOHzcJWgqLWwqGHQFyZ/mP8fr2yzI2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140178

PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
Currently, both the PSCI core driver and cpuidle-psci-domain bind
directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
introduced, would also need to bind in the same way, leading to several
drivers attached to a single device node.

Introduce a PSCI MFD driver that binds to "arm,psci-1.0" and registers
PSCI child cells. As the first user, register cpuidle-psci-domain as a
child cell.

Update cpuidle-psci-domain to probe as an MFD child and use the parent
PSCI node for power-domain traversal.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 MAINTAINERS                           |  1 +
 drivers/cpuidle/Kconfig.arm           |  1 +
 drivers/cpuidle/cpuidle-psci-domain.c |  9 +-------
 drivers/mfd/Kconfig                   | 12 ++++++++++
 drivers/mfd/Makefile                  |  2 ++
 drivers/mfd/psci-mfd.c                | 43 +++++++++++++++++++++++++++++++++++
 6 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcffe9fc54f6..e1ed6abef62a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21575,6 +21575,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/psci.yaml
 F:	drivers/firmware/psci/
+F:	drivers/mfd/psci-mfd.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index b88b01aa5829..c5ecca0d7397 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -36,6 +36,7 @@ config ARM_PSCI_CPUIDLE_DOMAIN
 	bool "PSCI CPU idle Domain"
 	depends on ARM_PSCI_CPUIDLE
 	depends on PM_GENERIC_DOMAINS_OF
+	depends on MFD_PSCI
 	select DT_IDLE_GENPD
 	default y
 	help
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b9e4ad7d43a3..a2d01810f295 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -17,7 +17,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/psci.h>
 #include <linux/slab.h>
-#include <linux/string.h>
 
 #include "cpuidle-psci.h"
 #include "dt_idle_genpd.h"
@@ -122,14 +121,9 @@ static void psci_pd_remove(void)
 	}
 }
 
-static const struct of_device_id psci_of_match[] = {
-	{ .compatible = "arm,psci-1.0" },
-	{}
-};
-
 static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.parent->of_node;
 	bool use_osi = psci_has_osi_support();
 	int ret = 0, pd_count = 0;
 
@@ -181,7 +175,6 @@ static struct platform_driver psci_cpuidle_domain_driver = {
 	.probe  = psci_cpuidle_domain_probe,
 	.driver = {
 		.name = "psci-cpuidle-domain",
-		.of_match_table = psci_of_match,
 	},
 };
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 35f6e9b76d05..8b7fae5d3f5c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2368,6 +2368,18 @@ config MFD_KHADAS_MCU
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_PSCI
+	bool "PSCI MFD for psci child cells"
+	depends on ARM_PSCI_FW
+	depends on OF
+	select MFD_CORE
+	default y
+	help
+	  PSCI MFD registers PSCI child cells and exposes them as
+	  platform devices. Child drivers are probed only if enabled in the
+	  kernel configuration. Select this option whenever a supported PSCI
+	  child driver is selected.
+
 config MFD_ACER_A500_EC
 	tristate "Support for Acer Iconia Tab A500 Embedded Controller"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index dd4bb7e77c33..7fa0112ec309 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -24,6 +24,8 @@ obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
 obj-$(CONFIG_MFD_MACSMC)	+= macsmc.o
 
+obj-$(CONFIG_MFD_PSCI)		+= psci-mfd.o
+
 obj-$(CONFIG_MFD_TI_LP873X)	+= lp873x.o
 obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
 obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+= ti_am335x_tscadc.o
diff --git a/drivers/mfd/psci-mfd.c b/drivers/mfd/psci-mfd.c
new file mode 100644
index 000000000000..7affd6bb09dd
--- /dev/null
+++ b/drivers/mfd/psci-mfd.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static const struct mfd_cell psci_cells[] = {
+	{
+		.name = "psci-cpuidle-domain",
+	},
+};
+
+static int psci_mfd_probe(struct platform_device *pdev)
+{
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
+				   ARRAY_SIZE(psci_cells), NULL, 0, NULL);
+}
+
+static const struct of_device_id psci_mfd_of_match[] = {
+	{ .compatible = "arm,psci-1.0" },
+	{ }
+};
+
+static struct platform_driver psci_mfd_driver = {
+	.probe = psci_mfd_probe,
+	.driver = {
+		.name = "psci-mfd",
+		.of_match_table = psci_mfd_of_match,
+	},
+};
+
+static int __init psci_mfd_init(void)
+{
+	return platform_driver_register(&psci_mfd_driver);
+}
+
+core_initcall(psci_mfd_init);
+
+MODULE_LICENSE("GPL");

-- 
2.34.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED837A836
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750330; cv=none; b=uJg8FP/ym1otNVT5nfGhI6ySJ1hJ2Ijd+EvuPLlglFpCZZpA72l9Z+a0iqQnKObmF67a+u1YlIcK9F9ofYWJ0nXSsBMRy0YTbhu7WUGfizQ5mI8xyD5ZM8d+m8+tzM+lSJqvxHWxnA8KjT2ZgZPU9Kk9FB8YW7I++SL1JUhGJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750330; c=relaxed/simple;
	bh=14Wda5kuxCa3ilXVAoY0TfVZfkEE9VqcOuvoOICdoVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMDDMnVSU7Qj9ou61u+fQkb+bsLLk59N51P2VvaKe0m6q+L28BiEC09c2MyC8GxoLFRd1A69M+kIyrgKMkazQ+Wq7gFJGcA2MkxYwJNXsGKXLAtv/L7eNXeV59EoZidgOjZ/01UvhlaQaTkeoXDDAqlZlc/aclaN8JTIN419Bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S9Y4Ke9f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WlFpFPCN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S9Y4Ke9f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WlFpFPCN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736TJAu4015800
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 09:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4D+pGGbNl/vhgsCUDZ0lT7ihke5qeqjPnm8lr8lBIY=; b=S9Y4Ke9fetdzZCLQ
	d6W0xPF+376FSs+qGvUboSD902GzFzpnyvsGxO+QG4vh6MigY7lcE7cFRPNNgMb3
	82v5VS+bd018/IzcLxFUZ/0k6evixIgnNGWYdz8B+L+OmdmaXudkHvxyWnw5p0i9
	+srfy5PEgYEsqxVVUzQu1bUj/Eu0XGuxE5Tn0jVpF1JCZCcbjjPVgHJ51jm0F324
	h/b7k08U0iffJFFVXCr1ED0LGDeqQAFXP1FwVzBkfHtMYvFsuuQvZdxtkF3W3Efy
	I4Xt80jwBCoOW1frLsbbaRVXzbAIXeVV3M4Nr+a5m9Eeqda1N7g3srwOpLpt5i/z
	Krk/7Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrt8v4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:45:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso3408415a91.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785750325; x=1786355125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4D+pGGbNl/vhgsCUDZ0lT7ihke5qeqjPnm8lr8lBIY=;
        b=WlFpFPCNR7JhWyKWz458/FnwxI7kqWgC6a+LGdzrouonWNZwbeHts5InyvpSI/AqeA
         ELA1dfCyqR6RZmz9jz/Psjie0zlRq5Bpj+diXF8l9/Ee9XJC5o+z8hPMJdOM+9pdqxZH
         kXnoXmk/yA38i68QmObwGuzVnN0/NBxe27m+ashgLFwFhGzFuJvqwGodQ/nhGD519Nj+
         mDXTDc2AQeK4j1RsdVK8+UVbuk9265Bk7GYo+yuINVSInuuUKxH9JWhBYSoX15jAzse0
         le8BzUISD3TIYPak2bwCNGTHeUEkcuIefub4HoDQ8UW6cltHUwueZIRcgkfIKcjkL8xu
         4i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750325; x=1786355125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4D+pGGbNl/vhgsCUDZ0lT7ihke5qeqjPnm8lr8lBIY=;
        b=lA+Ld0TmY7FuJaZjHzLJ+/pFbYcCT9a0EyEz788jIk0dAEO5j3iotMocvZ6PM8enZx
         6uoszTIk8p6DxzJzyLTd2pnYurs4sv4EJHUOGmlDRFfm/ZC43VZSX0gE9l69JIdKHy6S
         1a/+1YxAauZGft/Pa5fAWcjc1HwCvA0yrcCJrzw8xqLkmSFdNEKCLxewPk45uIsqnV9t
         8vQBFLR60M8lH3hcVm91yrpb3FJ1sNQhFdHlKaXFNx+tlSVN/15Ak0U7wCk9SILREgce
         20rVfTX8PCAtSETcPKHISrNbL18L0RC75ERGT9BNSCAZqVUQ194Z3u5Bf0M1hDP5HG8D
         n2oA==
X-Forwarded-Encrypted: i=1; AHgh+RpXcw2NynXvnWbLdyq4pYmwb1tCVYWJ5m/SaFCo+ugZL9Xp1XfnvSvK8Um2iEK6zO11xl6/sH4z1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hX6dlwbju6qVcNgxuu/2l/4RYpNDLJd2mhEDouz4yisdY0sB
	JtBdR+6Wjg1JNPKxDN/kCaDcZHIB6zIe/i++8xqEaZLB8uBGZT5/HHpycKrq5T2rqbBWtKWXCl3
	Yqdw21KGfaXLMUxz2gIcRRB0kDG/a81pkvXBCyE3vs0+4jVSHl0odHQY1WUcm5A==
X-Gm-Gg: AR+sD130qtScmgkoltjGu+Aw9VSMjx12gn4/Pgw0FW7LDaDqWQQ1v4vRAFMeVotbCF5
	fiNJpsY+0Ixl/erx22iwgkbH+O6JYVw5u07WJQdnZVxova2Ng5Swr2Y4vdGZD4UUECdjG7lkBrI
	Y8zvwThpWOQKB81hH/S9CnaPUJrx6srMGWA+FLpgtKNjYIh3YePaXi2FpVp1XM1f4dFh58zk7DH
	vN0X5RiHhqAlPIdF3QzDXbbhZmMFlBteF82jUdMOI47NgIvZjsjl66rdEM+J14H+t/S/b6i6N0q
	iQLaLywRt3GseUotaybVxQ+DcCdQxEsJjmoEfALsCkyreRh2eAAkERVgomcBxsSdOaDaiEHKQEC
	lmK6o6IBIWPu6DF6pAvfqVYuabPDuD9RvUKoo
X-Received: by 2002:a17:90b:2ccf:b0:38f:57f0:1f4b with SMTP id 98e67ed59e1d1-38fbc576496mr7546531a91.35.1785750325058;
        Mon, 03 Aug 2026 02:45:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccf:b0:38f:57f0:1f4b with SMTP id 98e67ed59e1d1-38fbc576496mr7546477a91.35.1785750324313;
        Mon, 03 Aug 2026 02:45:24 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2be6c8csm3660671a91.13.2026.08.03.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:45:24 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:13:35 +0530
Subject: [PATCH v24 04/12] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-arm-psci-system_reset2-vendor-reboots-v24-4-889281373870@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785750274; l=5547;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=14Wda5kuxCa3ilXVAoY0TfVZfkEE9VqcOuvoOICdoVs=;
 b=9IqK9YQfeGIBQH2lyLywWk9vUay4MYLXLPwLUwHLrLKBYO/8Fz8A7JrYANArZU5BL46C/TEgs
 twT/hme0T3ZCsPgPRUMBhJv6UlJYhfMCWuJUcw8p0DoR+YHJ9GsV42P
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfXywhRMhzYEjj/
 vnmBQ8zZTWM1MMZI7DD6NArJ2CzzTAFUFui1SZpwYRQkNhshUPD3Vc5ApyH9+tk1TMfIucYHwVd
 ajU03rKVutNafZDwUYnHmn1vFwFRQr4+5Ir0LB9ksbfhZrcvCD57HzYPmfrkCyJ51ot3KCAOhZ3
 7tYlQqHIJjSE0IIJYBeaBLn/sJAw9DuvaD+rT3ngaYUNVSmyJ6p0D9PJfzRi2s0FgiZ/TLxOHNi
 zvAX89g94pJQLLE22qDL860BDr9qU+x2+WblVxBsaNbsTUPAxjszR+lapLexwazLMZdZJG64Wdq
 yQ31KteJQuQ1k2J24yo+TpRJ9dejPUgQDQPtrNW/YT1QkMnviNkwTMlMU6qUX8YRP53U+35ZM1d
 72qUkGvCjxsV1d3cFSplY/H3q9Wk2lSwiCET77AkQ9IACJmdTCWKddDm8++2tbpnLweBN0BIUKd
 2jqvfNuv5D8SFBrcIRA==
X-Proofpoint-GUID: -2Nl7i8Y8dWO0jfV3e4vD7sW14ivtbwX
X-Proofpoint-ORIG-GUID: -2Nl7i8Y8dWO0jfV3e4vD7sW14ivtbwX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX/D5bzn1pZMYw
 rtvpwIcrZdMssiCTMcLF3KEWblf36T+X0Mg4Qyup2h7DBM/l1hvaua6OF/5kD4TiUM5Prpq3IGR
 vEan98B8Q86gvX49cB0vV6jcNMnI8Go=
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=6a706336 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=wfThnEy5_2w5d1iZ5YkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030086

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
index fe67f7bfa44c..0b6e4f89f319 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21671,6 +21671,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
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
index e4fd4572472f..d18655d76172 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2374,6 +2374,18 @@ config MFD_KHADAS_MCU
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
index 72d3944b0ad8..f3edfad702ff 100644
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


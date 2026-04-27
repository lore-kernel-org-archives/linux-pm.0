Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382C3E314B
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311368; cv=none; b=GanKmTgFLkGUHp9jtG/Zuf3lGLW7AI57lbyxSDLyVvKIykIrSOJizyOc8ObYnKMf4lJeshCakdJRWw3Vcn6YBwGOBW0xcfT5pP3+liCv6N+OULVYhEcN0yu9wNTF/o9NDrhUl+GIiR0oz9DOIH/UEPqvVP+580CKBOCXiDueXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311368; c=relaxed/simple;
	bh=lzropSLLuEUOTlXB3lVSMDCK1IZ7W79RN88MySMJil8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+zp9Wg13Qoa4RnFBmKdpr4SZ/VoztZN5weSyXMaUPdb4Q55BXYPEsk6gBHxKnWH2D+/gwOvDTW+S7oKJWH+6cBld4pGhD6vNIuCWvA3XiCTDKaZyTO0/wP+uTe1afdb2JkJGFrSwPY+g9QhSYUZQON7QsOCjveWyc17RbaJaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BswXOTsk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kxOGN/C0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BswXOTsk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kxOGN/C0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RE7VFA2913817
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GCiNA24JLGnW+ALPlEr94KdNN1Dg8+VWxK2km+y6x2o=; b=BswXOTskG+3prOc4
	FTddRVN2lV4PCYS8uOSTVqn5NxfgTYMz0v5f1fcQefm7AjKbL01cOo57B7+DMJrz
	TofHv/LRT2uPdMsgdYap+BiXQkTRAWofVxb13DDLUx+gj+FOR5lyGvbkOXphd9KJ
	q8wGlIVErkHWUKIVsBPDsZyYIDIomm+8y/Jvv5D9QXIjH8lNr3CcIIiujiBG8pW6
	eRaB5xfihyzp/4AlUK6Lhfjs0hMi4YAezUOasbKKJfI0HCEWFP2+X96AhYlktmvx
	JJsT73MLpTzNEZtCWCTx56k8b5jRxIfsxYn8vGVuB+XKvWwop0NB117Egu7h5h7+
	y/7yNQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xjmk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e06219cbso128158475ad.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311364; x=1777916164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCiNA24JLGnW+ALPlEr94KdNN1Dg8+VWxK2km+y6x2o=;
        b=kxOGN/C0hM2IHgggZ9CZDY2JY0dw58E0Vf9P5vrUM/O2u8dtPdYzWBt9Muh7gObHd8
         +V1vovKsab3+f2kK1AOwq/H0onKI+aJVC+UgGtEbojKuqNfRT+xTko5vScpnEF7/EfzZ
         rCM9MyoK19fHyVbTyKHuMsRcWYvKPLN5LJlb3RJJNV7wG2mCaKWbxYjjg+jg15TYN1HV
         KHg1F2eIjlTs0YAZEQWnZtm/nnJGZvd2Pn74TA3zg6y2Rj+XN4K1yHreC8tRqgbwTwlo
         RWcl3/SJN8GYLzE6jO6gXBJ4tvxuiJXjud6Utb8dOMidhPSEGWXkzx/YsTwWKNZn2aVZ
         2BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311364; x=1777916164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GCiNA24JLGnW+ALPlEr94KdNN1Dg8+VWxK2km+y6x2o=;
        b=h3uXoURD9gdapXz42b4YRGl9lF/AUOVWRJ0zN6t/UjAwjozG4y45oQMvz7zqyCALa5
         Rrm3d+I36uZJ33b7K6p46zbT9odoYTebTZ218J8ecpxFwZbIEz1DHn7aDtG5exBAj/Kk
         3QuFwpTdSairU4BkkpxbA5s3dY40ycmMa5Ol4kZ868PDZjCqCTCnh4z+1q8fCnakSbV1
         fzWxsf/nfqeJ3N5wc+wSnMz6iB2/PN+tvifkdGv0664c+ePZ8zVyN4nbuDlVjIvc6Rj1
         jvBVgc12FhyepoRjw/vCLrKPZP0A2TU2JjRb1BXGJcRETkhp34gdftzIh5rKtM7cDwS7
         nJTA==
X-Gm-Message-State: AOJu0YwskKENQGxqyoadLE+Ch0h1XK6+JEuTHHRjeZglF0F9l5iX4yT2
	4BYluKrB7xtvR0l+18EMiOPTKTTSOp9Ml0ZIn7zMEiErAdUjO/mSQP82+397QDCDDl7+xtqIiwN
	6AC8KtVbnCP7EZtN5q+fvSwDYrpMDu+V63fGb+EohV4j3ErxOcghJH+NlXRVy5w==
X-Gm-Gg: AeBDieul0/BRcB0KTKk5YuzPX+g0dkTCbVWl3QAB+TkUJIR7ez5u53o1ieLseIX+JCc
	HR700/WetXPgo7unJ6xQoYECN+6F3lqMWmPwuW4G0zVtuyS3iSKq92xJkoY+khbzaHZwbVEvylH
	oXibgf7n4/17iwO8Zo83omD8VZOEa4n9ASYYPYjdflfDkM+92SdaNggJRz43AP7vMWcUJsCdwuM
	glhN9ATOP4mkdcRDJLv4M448u3CDyRRRvWlHJe0MMsOkCejh6uZF/diQ4huplEINTJK2Wgnuslf
	QFiClzf09qsekZXWtwQpMkTYnLgCXfbX5GY+whkzJMEiexTk6aCDfA8Dr2uxc0p2pfRQ1sRCb+M
	yk1b4YlmQvSlUoM3qhUEyA3sJsw1se28lnJYz+NedfvPfcPMOKDUO/V+xtZ/gCgUDE64O
X-Received: by 2002:a17:903:3503:b0:2b2:4ffc:a7c4 with SMTP id d9443c01a7336-2b97a9661cbmr1763695ad.24.1777311364016;
        Mon, 27 Apr 2026 10:36:04 -0700 (PDT)
X-Received: by 2002:a17:903:3503:b0:2b2:4ffc:a7c4 with SMTP id d9443c01a7336-2b97a9661cbmr1763215ad.24.1777311363460;
        Mon, 27 Apr 2026 10:36:03 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:36:03 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:45 +0530
Subject: [PATCH v21 05/13] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-5-dcf937775e73@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=5704;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=lzropSLLuEUOTlXB3lVSMDCK1IZ7W79RN88MySMJil8=;
 b=Yax9prFDQv171HwJK8GhB9i1LBifVuZuKjaRqdRPhgOa/XGkco6ROfooGv8bt0WStsk62OajJ
 3ndcItGxp8SC2hfvo1UlvIJlnuM8CXU8VJPMMcPr5ymXTPII1gaX4s+
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: SsYj6wHpw1N-nr7Z7yCn1Ptl3D7CMH3a
X-Proofpoint-ORIG-GUID: SsYj6wHpw1N-nr7Z7yCn1Ptl3D7CMH3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NyBTYWx0ZWRfXyX4jTsfQ+Y6j
 Vh1dddcINvHFAvU2qs0OlUITDZMuNsmG3oC7qtXNmfPKk8u2v7N8Y8aj+iWjNRLP6SIPR+uBI9w
 efJPlQ6CXp51G/WNF/mT6VY1HJyl9yq4slt7uVR5CE01XeFk6/TqeAtcMMHMb59IcPXh8v+Zjvu
 jTfmumA9Pxtj9fzZ4OP5ywi+EAwfZoF6xgBQC7UUNEc5qx8CdGg1F/yhxdacitJY5ZjwdCplEWS
 JFVwwMU1vO68BK1+2EXOofWlFPrHUOQjsK+xu3KlnPJ3Vj0KGUsCnDuHsJ/XKu2B6BaHtYEnPq7
 iO9LlQwKOXNoNooBioLI86z3uTjeYL/0TXho+53hvrGdayupdGwxZqLCHur3PX2wLBxdJ90rWDJ
 PfeAg3WqNtVyfk+rpLKu3MeqRXJnuxuYC84W3iFl6aRufy1uydRcHPDPPCviQGxZgPBcFUFBN2c
 ws5CNNv6RrZXu+JIq8Q==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef9e85 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=_6Fr27BeRXDgthG3VUMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270187

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

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 MAINTAINERS                           |  1 +
 drivers/cpuidle/Kconfig.arm           |  1 +
 drivers/cpuidle/cpuidle-psci-domain.c |  9 +-------
 drivers/mfd/Kconfig                   | 10 ++++++++
 drivers/mfd/Makefile                  |  2 ++
 drivers/mfd/psci-mfd.c                | 43 +++++++++++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c871acf2179ce16c80b404027e6b969c7787a6bb..333b01fa00b8fbd15e6f31a6b9af47600411624e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21239,6 +21239,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/psci.yaml
 F:	drivers/firmware/psci/
+F:	drivers/mfd/psci-mfd.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index a1ee475d180dacab245510674514811aec337ad3..1a1316d11e0a2e4f61801586229f5104e2435865 100644
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
index b9e4ad7d43a3310a76ce62018dff0af1488e33d2..a2d01810f2957abdfa52ae66503dc0cbb205f163 100644
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
index 7192c9d1d268e93d1557ca6519ac96056e37e221..75ea5b47315cedfd1153899eef28614a165a14f5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2376,6 +2376,16 @@ config MFD_KHADAS_MCU
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_PSCI
+	bool "PSCI MFD for psci child cells"
+	depends on ARM_PSCI_FW
+	select MFD_CORE
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
index e75e8045c28afae975ac61d282b3b85af5440119..36e872b11b995135a04ca24c33fd3a4d08e4f49a 100644
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
index 0000000000000000000000000000000000000000..7affd6bb09dd83452664edeccb09290fe4f43186
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


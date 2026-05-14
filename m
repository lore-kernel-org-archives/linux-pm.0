Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29D3FA5C0
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768913; cv=none; b=TFUCSc12XCBQKOH0fALseFQ8mdO7wga3lBhh6DYnuM4gIfLNY6xZBzPYIwhhs1dPtzVX8ccHTEfS69i+dgGIlmBEqzFqA3QhSSB+QgE2AN1zOeh9F2svDXMEmMWz7OnvbBmppQkDJUDuZSXc5GXZgSV3AD9PED7wP1Oo0tYcF8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768913; c=relaxed/simple;
	bh=qY5ZcIM5rzFihKNnoujQTEksmxgJGl5ic/lCFibX6G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y34EvrqLWJqYXnLn3UH/WvU5tEiFccGtjH1Jy4mL3tHLaUd0MKDBaVlpNbx0s/vKP+3ZPYUf/poo+HyHPYQ8aDkOeg/L+41h4/daAMr/yeo7UcTke+pkHUaZixlEvkl8V7wddZy5WCZIb9I7jGBeGtrJMmmfDlJ8T1wvim1//8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hFaeiy8z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZAgjo+sR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hFaeiy8z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZAgjo+sR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBerSN2239471
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oWKxom21haWgZdoOhFhN3R9zZKeJdr2nkwKtgHCCEbY=; b=hFaeiy8zlR5ONugv
	1yPO1AkOPlVK1PSqAn6ZLWegn7vvi0LDcPXk4qyjoohpMiPJk6sh0vokz/1dhUWc
	NpKYv9F0SEo/lJDeP9xIefhisryqZoJlcYZIiJroaZGPy5l6MVtRTtvm7A+hfIFK
	4I2s82PHoqFxC5fmy+n6p7zdb98YBeD39VqWeQ1uV46PDd2myJc7+t7YFCbL/F/S
	vBVEJ8TOFX4DkUpPsiu/SPYRIaS8f2r/Dh5EeGRlrzjYtfZzwo+RXv4BVQRXRzmH
	AZ7Ulka+e+QYjD2gxqcfwHlIde88BozUDHCWRUoXoZ5dex1HEZeBgOCxEfBX9E6P
	zJf5Sg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e566bj684-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba268cb5e6so71817765ad.1
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778768910; x=1779373710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWKxom21haWgZdoOhFhN3R9zZKeJdr2nkwKtgHCCEbY=;
        b=ZAgjo+sR3H8ibtbzZ0vhmwDzdt7vVmW3q6ZraZYfNHlUgXtLuAQ46kYSYeE7BEFISl
         gUQoAJovk+iYxpZ1a2uAiwro4fGVzdk0xfGmKGNpYQ/06cBAo1Ruzw0AfmdWiE7e6f0E
         DfWMnoKeWFe2hgw6gZ5sRjcxNxH1p+Odq0yCFuomSnOha2RPw6JbqHjcsOpELEVrSGEb
         dZaxSdQQWr4huFGfyFyETkkFPwdiLJfScICzyBoDUCkcNBOGzDQGbDgSqybIEK1SNk7K
         YwOYYed0BEZLe6WxequlamvC/3m+suXWnVbvaTVQjrl253skuuXgJWdk+eWTsUlFmVAs
         Shzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768910; x=1779373710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oWKxom21haWgZdoOhFhN3R9zZKeJdr2nkwKtgHCCEbY=;
        b=bvxH4qxSaNWY+fS+cjfQoTkfB4wN11vPoDJ+PkRg7B+D/4ULsPlFhcPd64f+k/iD76
         ut23VxqTbLcLqJ+4PKJ/qKpWVXxg2p85c8sGgygeiRrayCKFeur2kwRFK9MeTXc4vTug
         3c2Vhi4IrXCPK8iYfiBCox9MmGIX63l2nfsEXZ1N8wQI5s/wd7ZPjb0g3K9U6J8fhxJC
         KA10jmn5ByFAQ60UT0MdzKyFTIAzgrxgTHXYTkdkB008Xh71VJJAeYf+dEIApL9qi4LF
         u3BGgsHcHMYQg3Hn61bad6S/Dw0wFZLENok32Hr5MK8GTmAgiTigOBSR7EwAaPGI/OxJ
         aL9w==
X-Gm-Message-State: AOJu0Yzxqi2Jy/bl1DprS8Su9CyVC2QcpPGSXRTT2DLeqmC6n9P59Oka
	+IQIbxx6FhB/tZEnElFh8Yruy3nxdB4AhL4YCR1bXCKxumhZs19glG74F/fRZ/B5BaBaxwke/0I
	xrtHsjq6kWTp0NcGVG8WvoUtyvWL3YvH27ypTMXSjiVwlvyh5Df+1J3BuGAYDDA==
X-Gm-Gg: Acq92OHGdLrAPDpCP8wHtZ6c73CdP1UhO0JnFVzmQ7/7hzE1rlnBl6hliFmUBlZ04hV
	AGsE4ckKp/AuljTqxZf+v67l1TG3GHmq32GPVK6V5NaiOOyhp37ha1byue5D+S717IMIi/DQjZX
	S+lrDg4mppAB4uNH5w9M+zwZF0yNH981VYzRGfYTHOqYPMsNGE8V7hEtJVIMshMHorkwGPaCzyn
	TTYmEhwsA3jTujDbxWvEulGSpFHL6Q/TTC9inXKI2N1I1PtPxIK8tWqD+/oIQymO2utXkk7CvZh
	udFMEPmMS0o64lO3qnNF1oYaHMCiiNMf+gDwzkudtExIyVmsIxqYpSm03u96NRoxMbKWanSTGo7
	r/6G9yHA+UscRbAaYNzlP/Oev1hgt1NrNeqU4Y8z3DfgErbFtsy7IIsJ9og==
X-Received: by 2002:a17:903:198c:b0:2b2:57df:264d with SMTP id d9443c01a7336-2bd276d9763mr89889505ad.33.1778768909596;
        Thu, 14 May 2026 07:28:29 -0700 (PDT)
X-Received: by 2002:a17:903:198c:b0:2b2:57df:264d with SMTP id d9443c01a7336-2bd276d9763mr89888915ad.33.1778768908917;
        Thu, 14 May 2026 07:28:28 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ffbesm28566485ad.27.2026.05.14.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:28:28 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 14 May 2026 19:55:50 +0530
Subject: [PATCH v22 09/13] mfd: psci-mfd: Add psci-reboot-mode child cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-arm-psci-system_reset2-vendor-reboots-v22-9-28a5bde07483@oss.qualcomm.com>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
In-Reply-To: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778768806; l=2150;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=qY5ZcIM5rzFihKNnoujQTEksmxgJGl5ic/lCFibX6G4=;
 b=AsfuP37SwpufjnSF40KcN6LpuME+xnY+R0MQ14SYIMGvMHlu2Pwe3lLn3lm1X4iWvkci3GH2i
 IRF/AV0XpY3D8SsYxoOayVLFsJWfiPo4qH0uHWQ5tiisSVrbhHY/E5V
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: IY3WcKy-UDcWk_OFvH695YJFb6xaXlkr
X-Authority-Analysis: v=2.4 cv=WsMb99fv c=1 sm=1 tr=0 ts=6a05dc0e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=wFQm1DtpZAjkPzv8fpkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0NiBTYWx0ZWRfX+Y0YtN1Ik7nU
 k7M8zcy06IbIzReKH3e/TfHWtr81zrEPUbu0UzcoB/FJYh1lpXaZd6Zc6Wgc87fMGGlf8ZmARAR
 uGWI2Dij/W98bgtbemeP9Dlaro1QVphuQVZSDfhBoJvTZ4xzeyhhnjbYxWZCzxZc4U7X+sj2IQ/
 ZiY1KgZTwntUtisZFtMbuiW85fhWLel4s/2pZ1R+IOI9cOyQ7i03cGcJU8qJQLQW1HRpsIN7TnJ
 VBxnlbab3dJhXdlEKggpWzQ3/vrNlYZSy3vweHK4jskDpWLda3xwdJ4buG34rWbRkFcrpkdC4Vb
 mgZnRNKdlcBoP8hAWT7vu6BGcZbj/H9affoNrkQSSCebDba9MVBAx3PMBOvREf6Gv2AWyfbIEpC
 6F73Eu6e9ldmQG5iXxCn79LcMyhV/HViy/HOR4uzV+4sTtnEV1LGWf0Jyze9Kyx/T7avvEKx6t8
 hOQIxb9bVejrgZAHksg==
X-Proofpoint-GUID: IY3WcKy-UDcWk_OFvH695YJFb6xaXlkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140146

The PSCI "reboot-mode" node does not define a compatible because it is a
configuration of boot-states provided by the underlying firmware. With
the new firmware-node based cells in mfd-core, this node can now be
exposed as a proper child cell.

Add the psci-reboot-mode child cell to the psci-mfd driver and associate
the reboot-mode node as its firmware-node.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/mfd/psci-mfd.c      | 18 ++++++++++++++++++
 drivers/power/reset/Kconfig |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/psci-mfd.c b/drivers/mfd/psci-mfd.c
index 7affd6bb09dd83452664edeccb09290fe4f43186..852d8e294a438d4ee6789c556d16a83739af2013 100644
--- a/drivers/mfd/psci-mfd.c
+++ b/drivers/mfd/psci-mfd.c
@@ -7,11 +7,29 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
+
+static struct fwnode_handle *psci_reboot_mode_get_child_fwnode(struct device *parent)
+{
+	struct fwnode_handle *fwnode;
+
+	fwnode = fwnode_get_named_child_node(dev_fwnode(parent), "reboot-mode");
+	if (!fwnode_device_is_available(fwnode)) {
+		fwnode_handle_put(fwnode);
+		fwnode = NULL;
+	}
+
+	return fwnode;
+}
 
 static const struct mfd_cell psci_cells[] = {
 	{
 		.name = "psci-cpuidle-domain",
 	},
+	{
+		.name = "psci-reboot-mode",
+		.get_child_fwnode = psci_reboot_mode_get_child_fwnode,
+	},
 };
 
 static int psci_mfd_probe(struct platform_device *pdev)
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index d9d1f768b8691abc3b32f2675519f2ddbaf19b84..79559206d5852ae5eae4c8eb2c390901cea7531c 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -350,7 +350,7 @@ config NVMEM_REBOOT_MODE
 
 config PSCI_REBOOT_MODE
 	bool "PSCI reboot mode driver"
-	depends on OF && ARM_PSCI_FW
+	depends on OF && ARM_PSCI_FW && MFD_PSCI
 	select REBOOT_MODE
 	help
 	  Say y here will enable PSCI reboot mode driver. This gets

-- 
2.34.1


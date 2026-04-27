Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F6369970
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311407; cv=none; b=rXlnRQhpsC8tm3CqpLHBARfjzLFF6EtRvemar+woYUfq2HJ9GbLmDNcJ87VjLg/lEYuJW1lSREal/oTa4Js7F8pM5DOaIZ1nEwgl0ViAebs9xgpeR2AUrRVyZtnMjOEf/0Rkao21rlJYZil1uq+IQIEtTh/50utyP+qPEz5cSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311407; c=relaxed/simple;
	bh=5h0sjs2AZBoFyTJm/Doy48a/B0F/c/N7jdCV3GRQDUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0mTQikVLSNj/sjfK/bP061JSYiq5P3EYbKgLHzLR9q4E8PPaAxgvzPKcZS+aLXOFwbWW00Yd+BNYf8VS/w4tZh7hZwq0JDwhMsv7hEexRh82rwpgaPJ4VSYe0qk9uZtOIzzke3Vq8wz6aayfWgdcMO05SmfNbKrOcEhpNvc4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ft0GGhE+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DDTKXKG5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ft0GGhE+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DDTKXKG5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RC62no2007380
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1rRdDX/+Ei5K81nWEVyfEKN/cB2TrHg+BZ3igx5GLKU=; b=ft0GGhE+1wbfjrdu
	3UjvbIr8PduzRljaiMay81Vl1zPBrBHl2MUbHVJybpCx+zzNnfuvrdosPj/umQBh
	KH70qUsgOv77c+6mLhBQNTtzEXsjusarX3To7O7lowp9puR/ZEoePpO8efJiCBk4
	YNTaR6gYakUMoU5fwEo6ydW/0oGKch5VcOvjSzHn/iFiCeuuzDjVeFgO9JFpXbmA
	RRoZSBeosb3UMRWi8F21MhbWc05fpP9h3pROU79uxevHNZeEPxMWF/IcEXKQ2rmV
	lfagU1dmn+nL1fOtmhoFLTdRx1RaFzohsi9cCk8elCs8aRHtFrA8mHOPRQdJDSl7
	lZOu1A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkh8ej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24a00d12cso106652275ad.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311404; x=1777916204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rRdDX/+Ei5K81nWEVyfEKN/cB2TrHg+BZ3igx5GLKU=;
        b=DDTKXKG58apamrbBUecf6WGrV0ayeZVcBEfD3qHqmLZMsLaKEIfPR9FF57JjvqwP0Q
         fFCmVzY+q99Gqy7vsyWw0BOGQwfN0U0z4fhRPD9Bmi2ZiZCulghRR8WjpIMoR29j7OeP
         ZK4u2Y6twCTqQioEZ6Yb44HdSzj9K9tJRUv9IOOStNoke0zKCTW9jYOXRdEDUBQaXQ/w
         x1fHnEJYnXgnG68jBDU7Z7lihQzCylBasHeXwDAqXIAecU6sUf56AwGZb5AwysmljSAW
         fXcwQEWCujU0oqlGehMC5s8TEQgsG7Fus8oPvxhsYrc7CcEVFAgkrIG+qhjkheuvCR/6
         Wvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311404; x=1777916204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1rRdDX/+Ei5K81nWEVyfEKN/cB2TrHg+BZ3igx5GLKU=;
        b=B6ne20WujkBhrcLSDBb/0rSdsd7r80iAT3GOsOC1/tfYAzdXeUPBUyIH9RUFY0QxsB
         VbzeBJn/ZORuNxFc+0gJxAvqeCNNEoSHc35gYOu1QifplJ7TOyZGyzNVYZZHBV+fi2jj
         OLZqhtXLMfOoB6fuQ1/9G+BFNBUgQ4CWBdgr+OwWwuCD2Iyvv/+XZGRt3x063GaBa5lJ
         4pYQjuG8mjXyf9vBldzQ06PMtkkHJyfigoHRL6vjFfp8/987f6IjEJhPi75uFUrkqrzf
         fMB90nECEcFg+aU9BL/Vi6nFHKcFWIR310AahR7xki0WiL367P5yoMqScsl8WoBV0OvR
         RdQw==
X-Gm-Message-State: AOJu0YwJ53eeKDvrwZe7vzP7lEmADaKBWzD1S9xw/xJ8+rET8OZ2Qxaa
	gPju5EFGu1T6WGFPRyx6cH4P9vrs8i9rNNqzzc1hz7LEC+TeJBPI2I0g94WK0aCnibkQTYJlUJR
	+UDU7DWuleh06M3LiQQNDUrvlrX7J09lEoR7fIssiJQg20A55lL0ba4yirLyjgA==
X-Gm-Gg: AeBDiev/EIVT60lwfMKqR5IsV4h0U52EsfVke9N1PtuEjPc2DhstXkQBikm9hsTrOum
	g24y7QZYllZXI3XU/DCzFabkAXbJmCqlB0m6PB7SEbL5bokPwoVD2J528OVU3C4HM6Vl/5Rko52
	6MCQx1s/ix2qZ1iKQwOtMiyZSesf9U+arUfCk6ddCrv9970NXE08NaSWkzMHQQr2VRsM83n59GO
	FpZar47hIDJuT42KbfZU9hSfofGQXaydKfiW7fqxmspEGlme0wv6VEtIoiZMawwa3WLj+EYqBHd
	EJZJfocHu9o1FcM5y7Q99by18OYla3A0bnIWupKthpZUjC6WLFi0/1x4iEdaZ4IHlgOfKktPnwF
	lxe0lrs2pFJpeaYNkrMB1SmE2tK9rQ5SGwOpc/XalCq4cwm69pSV0LGzL2P8biG2ekqIH
X-Received: by 2002:a17:902:c40a:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2b97a951600mr1711455ad.35.1777311404430;
        Mon, 27 Apr 2026 10:36:44 -0700 (PDT)
X-Received: by 2002:a17:902:c40a:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2b97a951600mr1711145ad.35.1777311403899;
        Mon, 27 Apr 2026 10:36:43 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:36:43 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:49 +0530
Subject: [PATCH v21 09/13] mfd: psci-mfd: Add psci-reboot-mode child cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-9-dcf937775e73@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=2384;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=5h0sjs2AZBoFyTJm/Doy48a/B0F/c/N7jdCV3GRQDUw=;
 b=Qqi4nd9Oe7ndBnF8ZRdQ3G26kUFOzIzSxH9DDzNSNYCgqcDhJbsJtVvuTk/fVa0pziIz8yF/2
 8/c9Fcztj1LBvM1CFWuC/OpeCF2cn5Yk6nAidAkkX+114fRCTDwy15I
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: dSbRcL7PTbWp54HikQSbdf5xh6rCFg9p
X-Proofpoint-ORIG-GUID: dSbRcL7PTbWp54HikQSbdf5xh6rCFg9p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NyBTYWx0ZWRfXzAV6co+D94X7
 IPFAN0H5SM53NmpY/yLZw3AKhgRcdmw3+E/bJPVqRdnAQPhwkgHypek4jecLLuzXXeV1RoFBQpb
 RyaNPh3+PzvgwAgZEF5LLRKSS5Gpuim8mfzLobNfTHJGDYMMo+cHWb/ceqs5VetK4vO+Rd7BW9X
 5hFKvilorMFFmpIXwYoj+jcgq+RvxLbyiTst2zRlnDFBBng3ybFQwkIbILbc/W7yeGbv33ezKY/
 YYJlZ5mF6cYTvxuuRcQMYy1FpgV7rF22J/yKaRLEhmL8Gti0bVJ/8tC0D4ZZgTOj/y8M576xfkQ
 G3jksYfqgVc+2xtn5sZ/4NbdcHnA9Radfcc9cHCoYEjQlg0ZFJe5jFybxPnqP2FafCnkk2SYLqP
 cLOpvYTBsGfJPpXdCG9CBkXbPaBS2qFzWIAH/ke2MVfIUYM76sp2OAeA+o9P5XdNPn7qRBWysEO
 ZLQXWnsFQs11dV+VFvQ==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69ef9ead cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tQ_U0J7R6L3XYHxJwYQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270187

The PSCI "reboot-mode" node does not define a compatible because it is a
configuration of boot-states provided by the underlying firmware. With
the new firmware-node based cells in mfd-core, this node can now be
exposed as a proper child cell.

Add the psci-reboot-mode child cell to the psci-mfd driver and associate
the reboot-mode node as its firmware-node.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/mfd/psci-mfd.c      | 23 +++++++++++++++++++++--
 drivers/power/reset/Kconfig |  2 +-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/psci-mfd.c b/drivers/mfd/psci-mfd.c
index 7affd6bb09dd83452664edeccb09290fe4f43186..dbb7c23b57d89765996ac887beda24fec76e8373 100644
--- a/drivers/mfd/psci-mfd.c
+++ b/drivers/mfd/psci-mfd.c
@@ -7,17 +7,36 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/string.h>
+
+#define PSCI_REBOOT_MODE_CELL_IDX 1
 
 static const struct mfd_cell psci_cells[] = {
 	{
 		.name = "psci-cpuidle-domain",
 	},
+	{
+		.name = "psci-reboot-mode",
+	},
 };
 
 static int psci_mfd_probe(struct platform_device *pdev)
 {
-	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
-				   ARRAY_SIZE(psci_cells), NULL, 0, NULL);
+	struct mfd_cell cells[ARRAY_SIZE(psci_cells)];
+	struct device_node *np = NULL;
+	int ret;
+
+	memcpy(cells, psci_cells, sizeof(cells));
+
+	if (pdev->dev.of_node)
+		np = of_get_child_by_name(pdev->dev.of_node, "reboot-mode");
+	cells[PSCI_REBOOT_MODE_CELL_IDX].fwnode = of_fwnode_handle(np);
+
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, cells,
+				   ARRAY_SIZE(cells), NULL, 0, NULL);
+	of_node_put(np);
+
+	return ret;
 }
 
 static const struct of_device_id psci_mfd_of_match[] = {
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


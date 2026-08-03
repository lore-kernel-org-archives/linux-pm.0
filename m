Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C259371068
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750368; cv=none; b=EOrnJKXHO2I6JlydaGPhubyDxKnjefhzUPFoQ80kbgFl0NCAzoYr46v3ulejNJB/U4f4xaj8j0pfX10AB38xAj2DjWbJ+PSFLiO0/k/EVzfYVmqFaqrcWfkLdZKb52DSykeCUu8+t2EWrNTKt23QcAvsMm2Ph6YTZm982ojn4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750368; c=relaxed/simple;
	bh=a4fxcZei+1h97cnUB4Koj6aUmwrxpdQsIsCANK7Zphs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=taiYU1Uyj7CGVbdlSQvj0cc8t7MEx8uFPxeC0tRr/xnIkS5B90f2xXgEMF9Jg/uAc/yjoDM4OBlH6mdMEJHbb0xpbsuurrclOne8bkGrGAiSnWZ1Gyh45FPqjOJBKP4jLfWg1QEqHVnK9uwfxCXSoF1eUyVWlGS31MrmMufJvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a93+VRjp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DYS7ovgm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a93+VRjp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DYS7ovgm"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736EvbU005475
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 09:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	miyN33yZIoWSSdkcC3toNxzlqXgaA/C5AXSlDcD42bA=; b=a93+VRjpDeAHhX87
	3lzQVhB0l2nMDdMKZfqsukZ2ADuleCH9oXvv4hc7jeo3QfbkmrkwoH58rGCYt0pk
	2xzWeP+aoKi1oCsjiHwrjfRx3wUigHt55EtszBCzOhEsURVYcPYvKajmJWcaTCrr
	CXsMxqWoV5a103PnVnIazeg5ssbYe4w5V7Pr8IGNR8G/G7lD9PUWxqhKH+vBA+Vg
	AFMCGqXnpXAtYMZJuS9om4czlVlRSpvpSgTBooF7ZqFy/MlvOkBq7KlYDcBFbfWV
	IckEDfEB5OT1BWI9hHeMkqfpOd+iK2GrTjhfaOZ5G9e7AVB+kDwiCx77AiHXpzMI
	V+iIJw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnj78vvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 09:46:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so3712884a91.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785750365; x=1786355165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miyN33yZIoWSSdkcC3toNxzlqXgaA/C5AXSlDcD42bA=;
        b=DYS7ovgma82sSaNv1udGP+aNo9QESD6efmRlO/0wDWs4BdDcf/vFxqxR1VRiXhlVM3
         CGXmtHkVOEfplqWoC9dvpvr6Y2xHF8FZ0uwgVBvPWfoO+3IUc0CpQWdPNPao1qaVtJtG
         IqEx/pad63T23smZisGTI6acoPXuNfLV3x58ftl/cxFEDua1mymp7RWfk3DBdxxqRBoM
         NOhK2zM0gUefrrkOiAlZ7NxyQQ/CINJLPD56PAq0R3AtXvn29r/vG7Dp7JptE+kfGhfm
         cbZNsbpE0HIccaiBW5uO34Fgfm0U15KS1FTPy0vJNAl00I8MvhIaeY7j9OcJFHPCOjd0
         XT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750365; x=1786355165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miyN33yZIoWSSdkcC3toNxzlqXgaA/C5AXSlDcD42bA=;
        b=RpN6ayxlBbCTM3HSQHFaQ6w7weJyRLBCdKK2E9BYt9pgTd90G+yX3OkS7IwWSYt9h6
         58XKCmeJ5WmfSqTnNXF2aUxDmvUCQs3ivdwjLWyUdWc2tcp1VwyxAKkHc5pb/MX3hvQ7
         LUKGoo4IFaPMe9bgJBKgZTsHE2968DpNZN05IBZydSGQ0tKJzVzMltRAUJOtdCce+Z2h
         WVcLGyVOifN72wqByhV8vof26ObGcOpWZk65oBy5WicERwJNbi/lUGJe+TTr54+ofuDG
         ZJiQo82YIJNwYUeSKZGSHeKiv8fdiPQoInK/T1/tVn/2gHIvu87Wuo9sVU0YnK2DRgQm
         5GBg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2qGshJy+N7Gu8Uu06RrGf6PqWpWkV03MtJB7RuspMrvvsYjr4qGV2jWjvdSt8xVVy/eHCfdPkRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9q2KgcPBu82KwsuH1sbHvhAI3HE7IjFSKKP6SyGSTZovvbDj
	tAXDuyTGZX1HrCCmsR9qo3OEzZX6Jr3pd4lOWWCwwgHp7dHSUCtPh6+JLW80TMQmuPACEMN4ZNV
	KdLLCZOHM1lQ5DviAPcS1cNBpKAx0vTln3gKf6jtlj1Kb4aNJ8gG4cY+LE/v+NQ==
X-Gm-Gg: AR+sD11oUvmNEo00+7G96IBMYWZAiXkYNm4oMNarn1d7otNpv0fajLTW51BVExTpFZX
	NKsoG7Jnw0wxTbSUCfrz0FW5y4/6LSgDhMkXlrciBQ3IfAXf7RCFDbCTzM86SenSvHiaiD9sK8W
	Y1dp8w5SD/dsUCI8dR5Rx4AGr4kaCKOeCyFaHtkvUt84wivI04vG9uGRToYmxR9j4CVB7lU/Yea
	IUYfvOdeMgfE7pWT8EwU19/xTGkmKpb3L2b+QY3iyKZ71vLzrA3eHVVB5D68p5OpHTP+kiUHa3l
	8Xsv+rhl1HYB/fgCVtC10Bnk3D+5kPXJce5ON9Nn8zUGO4N4ErvxolmZxzq8EpNGVICrZSDQT6U
	9Kj0DKgTooO0zc4yVE0ty/eQRdudzIV0OAjk/
X-Received: by 2002:a17:90b:1dc3:b0:387:e0db:bc28 with SMTP id 98e67ed59e1d1-38fbc554637mr8271601a91.40.1785750365002;
        Mon, 03 Aug 2026 02:46:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc3:b0:387:e0db:bc28 with SMTP id 98e67ed59e1d1-38fbc554637mr8271557a91.40.1785750364566;
        Mon, 03 Aug 2026 02:46:04 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2be6c8csm3660671a91.13.2026.08.03.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:46:04 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:13:39 +0530
Subject: [PATCH v24 08/12] mfd: psci-mfd: Add psci-reboot-mode child cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-arm-psci-system_reset2-vendor-reboots-v24-8-889281373870@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785750274; l=2310;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=a4fxcZei+1h97cnUB4Koj6aUmwrxpdQsIsCANK7Zphs=;
 b=6PUWyqdZoXA1QuaysA36vs/XHvAO2olSJrRMhPgZHp0LLLjlf15a6Ar5oPcErXR2QVPoPKJKw
 fm10+Fms55SCR80ZbNJ6JxxIvTiBOyaIWQ6cBXZoRzudw1S6emdYjg+
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: rzmu2oOBO45aNLUiZxNcdM3esXYZi4Vr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfX/bWmBmya9JBq
 YQkXye856ci8+2Yd4C2LYd5Yd61yf4JPA6MBWCst1r+3ykkZSLmIi/vRY33Ip/WXqCmBZL+mAMU
 CQBAEp+kZ37p8NNyGH83LrmYRcGG4Eud9K3eiZa82+pu5DJLyNx2/ohlI3RmR1ofFXIiEqMANL7
 6XgtvpWHgl3tW6bqehmrkTxigCyUDuPsYWFjcuDF01gOWjOwYn7utU2cPEwbqQj3sK6FImvnz+m
 Yt8JAeLc3+XJnIdh4Iro7/X1HATfuy3uWqSjBxHJf8of2gRkFWnQ6MKQd5LvdTGPr/lWTRgSHqK
 GVyqE4LhaOMabrz09SUjnyytUw83We8oAs/b26RQ3/e4Msy5z324nbbDipx6dS1NqmV/O4QgTMJ
 a/un+9Kq/IhyS6lR7UA5zhKBnYd9FhjbS6pzeWJ6ySgGoN5Vrl6yh6zhOm1dltHGkDlWr/dl9MX
 jm2vEAkOFpwAEabSYYw==
X-Proofpoint-GUID: rzmu2oOBO45aNLUiZxNcdM3esXYZi4Vr
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a70635e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=qQQu7YRYY0fa_xNKXW0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NiBTYWx0ZWRfXzHmVIIyqx865
 wJJitLgZTtwmQ4XUY+kJ4Uoj0/9wRu8nQatz/0g01acsx3irBsUNy+GfkuCxy1B+t9nsuAvPDTZ
 +1h48kovI6ZBjzHMEJ59teIVRl3cgz4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030086

The PSCI "reboot-mode" node does not define a compatible because it is a
configuration of boot-states provided by the underlying firmware. With
the new firmware-node based cells in mfd-core, this node can now be
exposed as a proper child cell.

Add the psci-reboot-mode child cell to the psci-mfd driver with a
named_fwnode. Add psci-cpuidle-domain cell first to isolate it from
reboot-mode failures.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/mfd/psci-mfd.c      | 27 ++++++++++++++++++++++++++-
 drivers/power/reset/Kconfig |  2 +-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/psci-mfd.c b/drivers/mfd/psci-mfd.c
index 7affd6bb09dd..7befc4fa86f5 100644
--- a/drivers/mfd/psci-mfd.c
+++ b/drivers/mfd/psci-mfd.c
@@ -14,10 +14,35 @@ static const struct mfd_cell psci_cells[] = {
 	},
 };
 
+static const struct mfd_cell psci_reboot_mode_cell[] = {
+	{
+		.name = "psci-reboot-mode",
+		.named_fwnode = "reboot-mode",
+	},
+};
+
 static int psci_mfd_probe(struct platform_device *pdev)
 {
-	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
+	int ret;
+
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
 				   ARRAY_SIZE(psci_cells), NULL, 0, NULL);
+	if (ret)
+		goto out;
+
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+				   psci_reboot_mode_cell,
+				   ARRAY_SIZE(psci_reboot_mode_cell),
+				   NULL, 0, NULL);
+	if (ret) {
+		if (ret == -ENOMEM)
+			goto out;
+		dev_warn(&pdev->dev, "reboot-mode child cell failed to add: %d\n", ret);
+		ret = 0;
+	}
+
+out:
+	return ret;
 }
 
 static const struct of_device_id psci_mfd_of_match[] = {
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 143f3260f04a..1810482d52e6 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -362,7 +362,7 @@ config NVMEM_REBOOT_MODE
 
 config PSCI_REBOOT_MODE
 	bool "PSCI reboot mode driver"
-	depends on ARM_PSCI_FW || COMPILE_TEST
+	depends on (ARM_PSCI_FW && MFD_PSCI) || COMPILE_TEST
 	select REBOOT_MODE
 	help
 	  Say y here will enable PSCI reboot mode driver. This gets

-- 
2.34.1


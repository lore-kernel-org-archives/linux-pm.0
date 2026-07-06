Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFAE3E3D8B
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341935; cv=none; b=loZx8ny8uMeJIIGONytd/8SQoOULBHwvm2yKwfwPAlFG4B5P3cipxVQVcuH7iBKQ78gzo5CvLA68FNZi0KWTPO3en3mwQMVdmA6Av6HqvIDE8rpiDXByeTcDXlMXpJGhW9B8xJ/ozoYFI2sYNUPQnjtr65zrKojA0GexmlKnGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341935; c=relaxed/simple;
	bh=zNlCSBzaa8h9eLrFPJ4Rsk88by0DY6qHl2V8PSoqi0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcXXvYj4bllCN35WkhhtT9kCCw+drNlrO/7i6JezeDQd7Oa3HiHGSSMM2rLrMGzwIlIuMsKIoEJgKTYqHbIGleiZeK6ERKGUgfXYvpwfsnSu7APEQ53b6os36/nGdG831SF7axc84KOoncWyVOcU8gJHnefc6miJIbAmYfjslO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ebOZdHAw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YVi8zHTU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebOZdHAw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YVi8zHTU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxG3l369006
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 12:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=; b=ebOZdHAw+6pvz8U5
	guxfBlryTpeglXytQIMDf3qb70gs8OqD+lwFTn+TG66rcgy2RCviTEWtn/ydL5zH
	0LGJgBOBodFF1ycxr4uJ9xW/IQPIkl/yCJQb2iZGsHVpG8AmRZ81E+/eHhWqc1OV
	1HwR4fjhtQkotKRlcShLfUG9IqvbsF/ryqc1sesHzvoZx/JZL/x5Gn/9mRbf5+29
	hitgZGkTaIO/Fvo6JuKOHb89bpnOvrPgF9j7YL6C8VxFb9Id0iA9jcsSgdLMlxVo
	bcDiq1L7xnn3E/Z7cJ3JFI9rteqpICWlCsAbGItPxIo0ZrHZcqb3kqSxbDlCgqHf
	4ZP8xA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h99369-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 12:45:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e52306621so213617185a.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341916; x=1783946716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=;
        b=YVi8zHTUKneCNXs9NmvDZ4w+spQ28KWPP7ttANPIftWdR12lnMavwsBvTQxOy3CAwO
         gTq3Xlcfr4aaWqE+yd3wFHs1koNlskvEXj0MdJJQYlDSeOVVNMJFP3Lx/oWsAwpEm2hC
         DeosKAQsFhk4+Y6D678msfZlUh4txrMwT6syICa/CQzwArQabR0mtY5k2ZCf8dKa53H9
         KYBypfoLgQtUcFaLRyNoAIPR7hFFrJBX4UMW9MQU/IcMHXC+IrhnSlUl9g/JdnlV+B43
         oRjRNLk3Rk6Ai7l7/wbW5iJYixDSJ8l9EvrP9qqo0+Kmjt0JU+wYINdGIiN1ww1aWjAL
         OfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341916; x=1783946716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=;
        b=na7smsXutDv1DxJ9MFbDlIo0MV8nPPDAVH+fPm8Dhyqj0G0Zb5ayHFSlrHmbDBA1jH
         i0WV4BEP17MVHU2NVyovfp6kca7/gsEISJob320lYHdKJa6lo7fVVYvCCsSGLJ4M4VJ2
         3qFcIZruBOt2X/Y4Yn2dMrvPxiA1Lr0JxBoZAoCXV2be6f3DrZ1BUE90erj2BJ3eB4Wc
         Q6V7afKiZxv4YwQlpeeFBCwnn5geVVB8Yr/VPvZ4EUkOPVU4abrDEsgXLxaIAkI9RQNl
         p19o4l2YCh6PFkPMYD8VWHvb1+15wLDVwMU7fNlJbyiyGEIamebEVWRMlCpReEjsyWaV
         kbKg==
X-Forwarded-Encrypted: i=1; AHgh+RpSpiMV3g4eLqP9+k6JgIYTjtY8FudeTcoLJn2DaU+IUi6tNipg1DYfOTVAREZgPgb5c5vrE0pvkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgeHXKuwWp3ogqeJ0gKs4+2pnVMTobyL1zlta0S9df2cb910K
	iI1XMwizUawqziOY66+QoG4js+3us4sxPau1s7qyEI6TR4URi6hPhO/TjXtaNfLaq7Au0u1rrE5
	0Pr8E3KLbx+l/C3WnWmyB68FfMcuN+FrZpW6AtuEm70Wt580h20v4hd/tdeV22g==
X-Gm-Gg: AfdE7cl18Ld+Qkn3AeasmoCC9jG7XXnDU6eG32Cn60dPtOX/Il5r5PSqjb2I1OR15Lh
	ZnIJzt9Hi/nR0PmQqhn3rPyYegYaet8DSOYknq2W0gVukrdGuPeUvYTzGrerzXxiBt2IaeW/dQn
	AqAqPh8LqGFkglYoRtjInhd+AN0EmhwZ9utOKL3/m/J7o7O9Gs44ybuF63UZhvD1hlKLDjQ2rHW
	6QQxh6Ww90mlwv2ecGZk6x9NOUPwEQoKWnVYwSG1yUYEEAYRNOKqBBtXLlx2AaoA0tacB1CZYJC
	gEp4b1Lke7XCQOqvAAE5rDda2BBNKoNDaqvgq5EHNExeVBUst/qxiopXiZkpqa5afFt93NCaqmv
	E8MJqOFHUcAYR95AUXGSnWX5ky5SjkPUX4I4uFORs
X-Received: by 2002:a05:620a:2911:b0:92e:61f1:6b72 with SMTP id af79cd13be357-92ebb49ac6fmr50864385a.13.1783341915000;
        Mon, 06 Jul 2026 05:45:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2911:b0:92e:61f1:6b72 with SMTP id af79cd13be357-92ebb49ac6fmr50855685a.13.1783341914299;
        Mon, 06 Jul 2026 05:45:14 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:13 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:20 +0200
Subject: [PATCH v3 08/20] i2c: pxa-pci: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-8-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zNlCSBzaa8h9eLrFPJ4Rsk88by0DY6qHl2V8PSoqi0Y=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M26fTgmFzEcwV6TgLmONhrXHSg1JSo5rARQ
 cIEm8brQ2iJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujNgAKCRAFnS7L/zaE
 w4FQD/4xlrZKVrDsxMxMDylskkXcnlp/TO8AFqhtcIAfJPLix//8WtkgYU8BoNMp1g9Xn0gqxcf
 Mqf4MoSZUM/9N4F6rrhsUS/fyZ8JjetftBgldbi42hSBBzlfigoXf7c7XsBd9RGYeEc6bF6Tvuk
 BeJBj7nTA7F/4P00u7JX8G1/EeAtOw+bRQp/bw49wlB2BMUcu7ymW7ZraPoAKhBLVQ3rfni2ggd
 v7fQ91AkgPqnXxlC03UumTZYRoodacvcu3K2/OHWjJ0tNZDijDmUhbLuEo5YxD2+r6fe9V7u6S0
 1AIHBEWJKLNycrCiocP2fSza0iVf1XHu6s3E0WBNJBpHEngK+P+XhEETCzEVV5hM/s+NO28XuUL
 BwdgBkheFv01xR0OIIv2htjsf/BOvFDkVUAE4mRwAAeBbUIlO3d1Gc/xIBw3P5sIyC/K1IP6Mpa
 29UAXyfBBm/QY0Eka/LOQnWf1rHBt/qWrcr+P5wHlLfPBPVvN7hFRXyJSSRrT3ZERQqDvupO8Qj
 ptCFfm9nvHLamnlGUxzUrLNpAP0Oxg4KP9I1Ee5OxwE6+tf7mtUlBPB89eKW+UNWpBN9GIYK0ZA
 yeTbyImJwaYxdcjvOhmsd7QN3u8NfTNp2Q6n3JTwHbo5apELLjJoObnNQc0x01jWKh0+xRyswe/
 xFrtfFeb09kS2tg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: -6suz0mB_WvXSh2mcceYAB6g5Vszq_kY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXzbFlgHJxV9aw
 ndOnSBhVH8fBcI04EUGLZJoODpdWwRe7aJyQ2nG9FssvZqCuw8x0N64GDgj94zPt/QUq8TiG7pY
 ImkJUWELegSxr52vJOBIYNrD4+L66EA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX5NgMugJzOrO+
 RobiM6HXueh60xMyOhdOG5vQgpKS/nN8vPmeU/QlMq0tR43ARY36nLuk1VRYAwOvadPaSu0fBOk
 fuy/3nqgE7B8muniyNwdgGzsQ23I9p8DUccRzebfiOdYl45RrQyEP6yHrmzM4SEodc9RoinZOoe
 fU6c/kZC3DpLBZz0c7yQ/GE3oKuzBJmgSsF/pP0fjzIVhJfxVVkk63e6Fyao898DQ/is9QTwhd6
 GIRwX1OoXPKKuPilF+4m7j8jx5d+/CsRNTgMf1q4SAf5zoCmktJZ9KLOLSVpgTloiY/Qf7X2+4m
 Vr3mBcLPhXM5FECt32Iwaj3uCUTM2uRlAw7EftoTxKh8oH354GgZnQCtqCTaanJOK4Wbb7thvkg
 yPVbG6rKYWSrnxGXEgu7sVoKkLoktDmSjZXnrTeChfJh8gheRv5QA9M648css9UvRsFh5gyh0gM
 KL1RmMgAEkhx9vjBRdg==
X-Proofpoint-GUID: -6suz0mB_WvXSh2mcceYAB6g5Vszq_kY
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4ba35c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=LDBv8-xUAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=OZ2e4d8rXakbCkRG61MA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for I2C
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-pxa-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index dbd542300f80043c6bc65a69fa27ca7b3d5fe787..92a0647f08c69f841ca99caca757c1728b3f6fce 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -76,7 +76,8 @@ static struct platform_device *add_i2c_device(struct pci_dev *dev, int bar)
 		goto out;
 	}
 	pdev->dev.parent = &dev->dev;
-	pdev->dev.of_node = child;
+
+	platform_device_set_of_node(pdev, child);
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret)

-- 
2.47.3


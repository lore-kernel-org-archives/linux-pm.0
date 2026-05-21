Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863813C37A6
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352684; cv=none; b=rBzJaRVxujhQp4cJiJRQB43MlJbDvgNndfxgIekcVkepVQEzUQk0/U+Fc+Bry0BJze6hvn0qSL12F5QiO6ZpaSUMNOGAWl1Z5YUjv5qZqzlgcpE++2WDY3oY38Ib0Z7v3nNPmsG5wuLDYEJywcxRkwAeC7AQVz4nxRTwxfUU3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352684; c=relaxed/simple;
	bh=rhXX0+hyT0zDUTxSmyLBrqK6ajNjs9sZyKq4hbamtnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfR8c75kYsAxi7OVC0fCMKex++FZcoHhvn0icMkj87iGGflDo1bpWuWaK+0fl3VETVd6DTZfjS6AwXFrjwZjw69ajtM9Zf//UJqkSPFedN1yjoHn6y9ErL3l2VicMNig1gRj2Vri6KoIy9cYPHQAIDNsSrcc8czjlMW2GAHI8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pIhnv42c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VlfCDwoa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pIhnv42c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VlfCDwoa"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6hbuN1797760
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mItV7Us/JDJyeyXy2sVeXYfFBIriRxRMQ4skromGLeg=; b=pIhnv42cOOFiln8f
	kFw5jgHplGSpeAAJ0Cytn19IGKTikvaWlORb9ffXZ6Vu6Y9WimKHPGfsQlVUvOm3
	r4bvDYEaQ7O74cObcz7CYi4FCYaj1OrTAX3I102sgO8EkTnptUE1trvlPgXB2Wal
	H2i/4ZxWOWoAg17n8cO+twTraCfWmhHQh+oBtnyRiWhM3IdmAkuoLJ0vRZIZr69W
	Lf4XjW/ergPahswxd07+8tfRyYNu3cb0lD2jGfnZBtXLLaNAoj9GIOgXJ4pPo6cs
	8MtRrVZRkF5qCWDZ/y5hUWaZx07ef9B6dQUzvEQcK3vS1xjBbTEf+07U1Yhl6f48
	qpxkOg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu422w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:37:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514a182b90dso81880361cf.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352672; x=1779957472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mItV7Us/JDJyeyXy2sVeXYfFBIriRxRMQ4skromGLeg=;
        b=VlfCDwoanZUyoN/aiPxyGeG1Vri+4FIWQtsnw24J1FeXxUziQvqrZqw5eCQAxyBknf
         HLU2tKmJubUdQ3wyXTKwxcsU9cKNu8DJUC0xHG0HNyuMxIDJQ2NuyGFvjnI2C/auNqix
         Rjjv+wbaKDMWDAxyL4Qv6CpXauUEAN2WfiF3CHhG4na0pLbeXVFtSQMSR9BkY+f4p1NF
         T58KXlDRkw1S0KgBl26f8QhVy2rLqGN3Wu/8ui56Cf0JwD+4kdUvbSZ06VuKjt4TI3IT
         IP2UdF+rucUSn89uy5+3d4tCuyYyv8Q7c1FCEjowcjlhj+5ensbL9zN9wB9UfLu4n9Pi
         6sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352672; x=1779957472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mItV7Us/JDJyeyXy2sVeXYfFBIriRxRMQ4skromGLeg=;
        b=XLOd2clanwuFI8mkEVq151bK/DgKdy7XA8m0KW/IOL9bdHK2lbehtdOTJgkRQ4JZ+G
         KcOki/NcMpXfeKh24z8Br7nHiNNZy7Le87drV1TEVOcZNdk7CwGC3+T1rKk//puFC0Gh
         f9IvFZSw/DlCVF/vTZqaJHspZI5iMLY9+ulEs8jWzdBesjcuvYUFEYjQsyPQrxJZ0SR3
         sON3z0k4S/qJoOBll3pkxG0IEbuZLDpJGmLN00/5/UiKA/VtRYGZxc7qEjZjsO0IEq2Y
         YbVxylsFTDgh38oohpLQAM7Cg0AIltCwrBnpYFGxNZ7Vlr5+5Asl/4zXAn6nkl2vw3LK
         WB1A==
X-Forwarded-Encrypted: i=1; AFNElJ/ER45mYzsOuwoPHyIpcj9kx13iSGYloPYApypHRZdhEFhDHTv0wEIw3TNynOyDmFLFu4LR5r67WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDtLWbvE9KFT0CUdgaqp6LIDF7dsY8QW3NmjF0zmgADuDwbCw
	gXn11nfBcC52NXUDbQuicDgRP2UzHooUGJm2XOsy++ZUaBfqrzbMdhEEvUKR8BWUrsdMoCcufLf
	bg0Mmf6TK0MjpEwvAMeiLd0l2Oj9+JGKtNrObByf4c/ucHEkEuh9+Km7rey0Tyg==
X-Gm-Gg: Acq92OFsdiQytDTRct3X8694LHW9Mu8GlI0GMbX73K4pUa9aS6RWKa3sT//jIUT2Eu4
	2FM4eSQyNNGD/aQapzn4ufXrIOYyBemQ/L/6F6ZNLfYquG3lYEGhCqJ5U7+tffTQqS1ab8okF/a
	In0yYfFq8kZ/wtIZ8McHpGxv7bKpt+eG4mZ3CW2sRdvqCF5gmXbQtBykNAislj+B5oWWDR5NnvV
	hwlOtce/dvsvBV8SlsvAhEOCX65hQD9H0hWirDpmdfTz5dXJzKm06IsgDMlKrUz74Te7gQhLGWf
	5H6r6U4MrUtKCvFBfzfVn4+k1Q5OHhMzvJBDQ7Wdcf5b686e9XFeH3h/Ame+w8JWmVhufoeiPDo
	lPekhoS6ljk9OB/p8oFS52p1IPH5yLuZIqZTXvoy2nhZewzY7TR0=
X-Received: by 2002:a05:622a:4cc5:b0:512:e813:7ceb with SMTP id d75a77b69052e-516c55d2560mr24462261cf.46.1779352672379;
        Thu, 21 May 2026 01:37:52 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc5:b0:512:e813:7ceb with SMTP id d75a77b69052e-516c55d2560mr24461621cf.46.1779352671784;
        Thu, 21 May 2026 01:37:51 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:38 +0200
Subject: [PATCH 15/23] mfd: tps6586: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-15-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=921;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rhXX0+hyT0zDUTxSmyLBrqK6ajNjs9sZyKq4hbamtnE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQqDmHIVs4kdm5DllgC1wieRn0dTfi40w5+0
 YZj3nANwgiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKgAKCRAFnS7L/zaE
 w81CEACP1pUKe1vdi5szoShgJ7SlWvqPeODf0sDK2lq5ecuRIcOXCXNzZANxrv7nwAPSjjaTXDf
 Ww3svzj8ZcTYKA6TPCVub0Oa5ol6XfGL66UF49JUULJIk5xWhEuKXb/yZNVWElkqXaxDfQYcDxu
 SB3Eox4L5eO7dUyanLTruaUo6Yi5irnV8OexBKV7aFuTkSxuwwYuM/tOHsLq3X/GIomwiJfS6TO
 tEfOkkat1q020En6KN1pwOWL1Q1bpgj+0gYD8ycJOmEeuM8h8xLAq6M14A/c9jqQwNlGUuGn3WT
 8JoCR4r/5354fbl6mLc3BZV3VRO+FQMyQ//h2nMuWisORPsmjDieTsEMSHiB4ewpHGCP/Eo9xK3
 wvD/6hoCy+868y0ZzjuNXghfJvpA2XGMVCZ/NOM5+IqDHYySNcAN3WH24riQ+zmTlh4GEFACNYF
 Usy9BXy2VVrpSbYL8ZrFf6HYadDdgUT+Z6+3AnKzX+hs37Gx48+YYdSJgdIifqc8JU2QKqeUHk6
 cWN8RMlX1URpAS9729ac6Xia16DdH/M5dwauw1mEDiDsx6TadFqnvQqbHwklcUEuewuVBqmstNv
 dHs16McDSCRVSViWlOG4sDYHx8HJ7rXWN6iSalNq6n+mFMdL2s3xB8SS9TRiBXxSAoTA+op5dA4
 PTIIcqPqF9OzQfg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX/Kr3ln9S6aS/
 pdRZtHrHgsZlJ40JFtWWRFwIC29DMnZGzBGQkzwSmHKITCd6BmSWBpr1ST+UpZM/MsWjk/GUyt+
 jsq/CJfF/zeB+LHXX0wdLScY+3tCXnwC0M+UoxWnGnKGEPf//FdeQ4TALNqS4lj2/ua4ao+97us
 BEzx/SYAV8LydmED7vumc9Rj0oqGAmu39OUidKIV2/UM19CZY5oyaM3uxx1Ou2/EPGyTRFKpQ2R
 +Crj7ZOqta0qwKNSCF1sFmKD3EpYUBhwzuusnA3ZCf2eTcWW48Exqp+yEExuNlGOrEH6jUwi4xt
 HNlsg9COT0MKCBL1A8A1sE7Bjuf5lVHDKGzTBvVTmTVzYUnl9pvFLAUbHdEJ5F0wqnDaCboJcGe
 Y+fczpGVKA4tn/4wjIJabJOCwN8K2tc67uX2t8jvFfmC5lYbdrQP5Z7dgMUmc7ty0u3dBMfEzas
 pdIe3FvC6o211F4wZFQ==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0ec461 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ESSmVKC5p6WdXJfq0SwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 9KRFJx5KM4sQkQISBoTASdjRvzdT9dgv
X-Proofpoint-ORIG-GUID: 9KRFJx5KM4sQkQISBoTASdjRvzdT9dgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index f5f805446603315ba76ce1fc501c908f1cec0d16..3cfd2f02b62f3cc370e0d970ec2643b638fd0fec 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		pdev->dev.of_node = of_node_get(subdev->of_node);
+		platform_device_set_of_node(pdev, subdev->of_node);
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3


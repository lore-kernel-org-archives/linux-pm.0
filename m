Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59722401A26
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724411; cv=none; b=ud63T7v/R94Y6IhCWFzbnbR4en1qmhmv5bzpiKG65Z13FOyups8FaU2i+3HUTxn5ZeUmNKzyfH9FXAAKqVbjXQqrPCBsuxuLUjgFK2C3T9nFkVCoAiq+HHWQs+/iaW+/pQDBSHVKvJNBeyOvhzcmhdeAp6F5O+KojbvfKfPIaGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724411; c=relaxed/simple;
	bh=6OXt4TN+oyzNJeMucuDRbXfo0ddns7kCLrcZYoYbhVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1RpKnsmT1jR1VGEq2yZl0on89iB5iJk5Kl+wUiqnrc1ys+Di+6O90CQrvPmCiv6/RxL0pdAKAg4+UxAx/YS0x7H43mXDwdGrcY+VP+Z40GfhylG1YOln62dxORqBL4+5EIY1h1EZ3mBx49DHNao9cRBU7NJLhJF0xPiIC/1MiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IxATTOPD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D8Pua8h+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IxATTOPD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D8Pua8h+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T91Nx32400847
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=; b=IxATTOPDsNWfM1w5
	9Lm2bZKmIqww2ual7Bo/WyUgK8HyaoF2qRAFIIopreJj2AvB/0rKOsvctFyIzuAW
	9JgB9/LsEBbIHOzfl+qNj5Q4p/TQObb/sILpwFHUfFDmeWKzRtQaMeCxrullAV9v
	RCAxZix9ZCKbdU/Zo5xq3OS6SQHSMXAb7Kq7xRAfzwNcskEBWXWtwsGxKF3OJHWZ
	wkGCy7pdqhNt/zo3AeqZeknkyQ0XliC3BX/ne5a9fH9EmaBoCLSIY6MUqqCS/XQs
	pLLcqWrmMpggVrZcksC0P/pR9TxyRlxaYj2xxnXRYVHQrrSwEKT5u3tTFnw/3s9u
	WmCNnA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq881qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e45453c94so341422485a.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724407; x=1783329207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
        b=D8Pua8h+ItLuqg3qpjGaLvY6ScQMqEskUhy8P+YAY55QM+DzmmLH6ddpc1vfTIal9v
         8SVG2+X4lACvkCPjHwewV8blTNiKPaX+Gwv3XajJy/l25esSz0YsiLBo60MwPv1wJ9UM
         9lKEkGMDV6SvmMg5p5DNxfE+yn1TF3JPgdrXYv4P09ROKX5HEaKuGKpOxTCHdKHhGSjT
         zTYcQo/46/WxwEQJx+o3+rGk3l8yNva2UjEsRxAwLx5TvJf0gsLCkcX3zwDYGQFJw9I/
         DlZmeVr4oOr6UD22b6fXKvMFvPsbhDZcvgwEijfo6R8fR1ufZz8EIxgAjN6tsKWYwFhU
         2OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724407; x=1783329207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
        b=PFtYXhTRi6FiAP+ydWPPo0Zkpd4HNhIZMKpT0AcCTvi1iNcvUtFI2p7uU6wlcdWtbl
         gGl0tLFZ6fPDUp15ePNqKMvVY/d7hWSIzNxMOWfFEfaQgSQ3fS2NuVzQGYGkWHo6bzeL
         6xG2BNjJ1JxtEgLzUgaRVqA0yNCt0dZCyqTh++I4I6+q/MVJ6+saNNKPM6orRmCWXNBN
         39MEoytnygMRjlIUO6QLGonMANisTZRT7pH4VcjF4MC1cwAg+psXerye6AxXwu3cNXCX
         Z2CyDOzZOydVZc3ptiYV/cJkHCLjkLMloimCWKzhC/JIlNrquPzx/YTfpPgl6ttIGYkp
         exMA==
X-Forwarded-Encrypted: i=1; AFNElJ+pY4u/dI0A/7T7c+dBmG17lbJRHXCJwU4qCyTCBNpSGTZQvlLI8P96JuA5u9cNdHF3jm+aXaBJyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/ilcxAhSRRKxZz8lN9M8DZeFJ9j7Ol7vWfwuNqRFAjZnCtQh
	WtXHwllZ4JKF1F55nzR3UHo7oa8/hjFOpeapCBKwSBll3aO9jQjTgqce4nk+VIyTd5iP0jkhT+9
	cU+re0N4eB9IWn55QmaY+zTGpp01y1hXL4ixPFscPMt6reeRUTmMtwKBxWTjw9g==
X-Gm-Gg: AfdE7ckMHIUE6KaJnPH0VGKhoqrMSw6ric9ojhJbldslH354kq/TBxSwR++6k07CU77
	d4jnZbhXP0BkMKUtIbKYkfqG6qJ6R5fWxCEVvMuDW9W3O2Z+8JuWJrqCPNAJa3KFZzvecVIuwrP
	6T0y86OW7Sjq3n/ZeKm+YS9+qYXZAGNK9QImn+g8N85zfiP3BUnMsDfghn4xcuWnEWyVNWUlrNt
	ez2SaaB7DnbyfLTIdyWS3aNgBNXgOVxBv6SKcSXIZQx2FKbyGqoai+JyDvPzjCP09IdES/Ivzfy
	beFc+fGWJ4Aeufsdc5mtBFe70+hFQ4eYUXy8RsYq2wrXYZcJc/dwO0uM7eVSxdmSclcKr8kxAIo
	pYYS+5/TB9avbqKlI9Dk8NXNVt71IIWXUyynGegu7
X-Received: by 2002:a05:620a:2611:b0:92e:5554:a80e with SMTP id af79cd13be357-92e5554ade6mr210125085a.39.1782724406634;
        Mon, 29 Jun 2026 02:13:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2611:b0:92e:5554:a80e with SMTP id af79cd13be357-92e5554ade6mr210119985a.39.1782724406150;
        Mon, 29 Jun 2026 02:13:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:25 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:32 +0200
Subject: [PATCH v2 09/19] net: bcmgenet: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-9-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6OXt4TN+oyzNJeMucuDRbXfo0ddns7kCLrcZYoYbhVE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcPi8u6RDiDExgcO0jHLU6ko4GFAYWUMb1Ut
 WtM6/fX5P6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3DwAKCRAFnS7L/zaE
 w8RYD/46lV+0Hzns8J26Syo44iocOUu05qY2fPdPuC8prnE4zfS92GVnMhoqtkvlPY7sGH4KNn2
 Ibwj6Wg321rdUn2dZZp+d/zO13w+cxd32X+8z1xhJxQz1rivungGh1GEp1C5cIj2eRVIaov7cHQ
 ARah2+b1gMOmlOdtTcfyxsW5CRYQ0K7CC05tKmKkXOWKyi2BALmIDUCOc2podn/5LvSK9U8Ck3t
 E9yxSgLb9H78kRhhHSpbziUPZrrIjXQG9mAlBfePXv7ljvsmx/5Bjv/iUxHVCr53QEgzZdgeWrM
 TO6EOWGZGNiUNEUOD311a6wk2XDVzjQSCKiWxUw3xWaOu23XEQzRxKL5HcAVNzLKSFgEAqMGYQF
 1i+FFtc1SkiUv8YwoBDU351b54WTSo/ucPjrfje0V1mwfBZtcXOptbgCUCpGVXdq4YrWfrJthpE
 KiRDcixBoTXo7SKLrwrdWCwY3KaAl++WrP2zbz2WQIgtBc2o8fhnGclCRFQyH7syB0WoVe9UnGp
 EGMD49EykyK4KeeIj+XL8GllWKEK/O2hHpu6vRE8GgU6foQhj0vXB/4ROIlnFsoFmIm6sWqxh1P
 TIaPvgSRlrbXNW9J6k3tMiQKv6DOZeCtH31ELMaXpJZlXaw1Ks+u1Gh35Qb/Hay8l3nvD+fpVaq
 rNfTpzNjv7R/6Aw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 2NmEbOqXxdUvBd89Qis4riQWl_erveAd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXwjysGZVFLv/t
 Atl4jhc7RtjBISByjhp/qUTr12fKCEPjUp1vDfeS2Oi2ga0roPwKurXNltLtJZ5HSXJdusCIWRt
 Hx5s/7q0Efy0Fy0veRY4AbNVKpzxb3I=
X-Proofpoint-ORIG-GUID: 2NmEbOqXxdUvBd89Qis4riQWl_erveAd
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a423737 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=_l4veLwUkFW-k-pZneUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXyZqr6w9ABCU9
 vGcPaR/rGKUwGN/FMMFTvhnRpUYj+cHvsPSOFXO5pL8XLpvjbPxA+APqxmCMK0jXEzuliPS10vb
 8G7d4oZtZTOugjuCyhYVLuuBW2bhicv5J5QbKB7JO8N/gaopnc7AoXK96b/kihTxY95L1zsFnWs
 9gfWB0CcXhRkPuS6/Sz6ECDIG5FFtClprVIsYTnMFfp2jX1GMk5swQxXy3f5z4UBWu5erxRQ/iz
 C/Zv6FE4FMiO8rkXFS3/+l4uBne/LEQWwZHtMbsYqP16vdpEj0b0PYUjSg3yi4G96k+inBiYaGN
 c3vq09bdJWnLeu7IKtzDPtbzdvUfgb9f0b+jm04R8ttaWAzF+CUJhQcDLt1KesvqoNIsSt1WPyK
 aMR31+3D1JuYOvw1XtVwYgHTBwdwW6Wr2GgjhZU/ltoBj+/mF1ZfagqLVSEAxNa/AcundDW1xR7
 q+E2lbh9S/IwEWt5TNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index a4e0d5a682687533a1b034ccf56cdb363d6b7786..451b23a039cebb777f356f64924838230052dc45 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -490,10 +490,14 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	/* Retain this platform_device pointer for later cleanup */
 	priv->mii_pdev = ppdev;
 	ppdev->dev.parent = &pdev->dev;
-	if (dn)
-		ppdev->dev.of_node = bcmgenet_mii_of_find_mdio(priv);
-	else
+
+	if (dn) {
+		struct device_node *np __free(device_node) = bcmgenet_mii_of_find_mdio(priv);
+
+		platform_device_set_of_node(ppdev, np);
+	} else {
 		ppd.phy_mask = ~0;
+	}
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3


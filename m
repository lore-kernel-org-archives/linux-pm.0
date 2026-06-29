Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF9404BC4
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724422; cv=none; b=HxUrh8fIpKS7keWyaRF+Wr56BUElhZhHLI93hqJKgvMEPhzQ1jeyZJEKgF5bFq3yomu54W2DUuCYSwygnk10ADzoodVUp1gOjjnFxRnjHl5tTO6DCZzeszbuDw2PWGXqBXvII92WrtCCcu4l2aLRCrDmpAEUbUhpkOOQK4ByWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724422; c=relaxed/simple;
	bh=+Q36/R3+axSk26qNg0RKgcggtmrfBcF0QjetixEKu48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpjS3i4tEme+P2uPl7OwFwza4GCyqqPMH/ER1QJ7TaOUK7BI87RQA7XSyitthQ4+cZg2jtzVLu68S8eCIRCyJwZqOazXQbMMIkTjo9kb80F5mvMPydDd6nKZxhI7z08xeOhJKngwKVnkzb9vEyI0bwEYJB7zYYVZOmg8JQn34i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TJV4dgAM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gdbZfPdM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TJV4dgAM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gdbZfPdM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8wVwE2391251
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=; b=TJV4dgAMWU/+8Fge
	LhekPmtkirGo2G1WGvWAssawORz+6M0mrlwHcIibOxpoZCVMq+2L7WT6vrJ9+1et
	EP8eV2W8OJx5qateDGni14/OqBOYH7A86vpDd5IN6J3SRx9H1H2Ka4oiJotKHAPq
	UHeT1r9ZDTLYFb8KRJjvJEQ3OOpHEJF4nQGXqoQ/kB6S4SqDPjL79pjN778T4gLz
	s2qvP9JtSlDZ/h4hSLUHXvMk1gOmOOrn5XCfm5kFQ5zhYJx8JhGoEVAAupN+uhcK
	xk6Zt9kFHNw+DCE5JAV4bCQIY3aH7alIM6f4eZ45FgXVRRBjfW08arsQJIKjxk5l
	5HftKA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw8271-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ad11e2197so578901885a.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724419; x=1783329219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
        b=gdbZfPdMeps33PY/wDMck43+E1LHfivdHcazhYE/pAGhYPo9UTT3g+ct1cFQf9Xj65
         tfxvtypkyG4rPZbnQyQvabF7HEdKKBxVTnq0BcxlWHnk7CpJUhy9D0l4y+5HRS12eFDz
         XUNpcIxEL6DSfNNm0bf7xGWTv2XMbpDeE+yZi7h9ubia48YWH1KZNKFCJV1hFOdr4Ci6
         i4iFU5RU+/49o8rwXw9XcekWSWsnGJL4F2YbHTycShq0gaondMC65VEsIQYNe8JMbNNa
         WH3j21fKbaNwXI+hgcXnqysOeGib3FLbo4q0eFSYdLPkmdNyG7M6irchylWsGveB68v9
         tTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724419; x=1783329219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EbIXrTuuG3XY7IQyzDipBNefbhJbG5vwiEUXw5AorV0=;
        b=CQdqE5kbmfB/r/wLicDD6i/FwgSrmPrZrlufcjdaHqK7NnmfvNUimo1ad0SMt5bF/a
         BTksu/KiUTL7vxeQ2uY7+bNCcgRJXfNDD8BgPpyieBWvX5EDHq9TgDfqXzpuppr03Nae
         +SnS+dc/aJRpig7l7VAstIFT/w9Ve2+6bnUTDvI72CXjlLWdcy5khwPeKU7TwNvDdgtG
         Onp7TiCfs6wRy9vbFIPuA+zqbZs7UthjT51o3DZXYb3QJLHDolg5PyOa8bIz0UyhYPDj
         hSi6C7L6XWNm7uBrlWdB/26D+vmeUNLhggADBzs5mpn5CpaMpsS/o8jsGUt0d4Efy8ta
         gLXg==
X-Forwarded-Encrypted: i=1; AFNElJ+T1SxyDl/s5szIfTe03s8MX0A84a/83Wyfu5wJJ2ThamXnwsZFXTB6+1TIDbXtNQB8qLW2UXtbiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9E4F8XJVz0FpJ3eOtosPQOu0cm89SjjLJCrjYLPZ66liOPfO
	9cOACkEPbMsMCBDwiuCPESYA9tqY4ytzGsLPfAq1xUE/T1CY+QfnbSElbjSu66MTkpc2iqp3AxF
	VrdvetgkWijJkPJCWlb6i4A9ABVrid/ayaVhuY38ssmFTimT5YzO66NYrLQvPBA==
X-Gm-Gg: AfdE7ckpv/WCTu5LZWSYflMPpZ28CzC+/1cJJmk7Lo/G6sFeRveJaCHM7xEQGgeHjrR
	+AvyfbXIqikcYcwnWq49FtJlrlJLDrdwZeMgeeO7XpXr/LnexIqcGattqowWBP9IU8A1i8T0Xga
	q7lN6oPF60aFATQP806602mJuLjtWAJbRwup+v/Zn6SNTmRoveXecxKGc7LVnStsrwiIK1qFFpF
	p8QkLKc2NckEavRCwmXNCt5yNs4oTgDi1In3JzkclPxO1IrsqeA7+TY51Vc1uLw6cSNMIdDccNb
	LVg8biMJTa/tdAXiBaajQWF625FyxVhmPclUD+2Mnqpz7XuWGP4ljholRs7hBrO6drWBoSrelWY
	nr88GAKWx7prMt1DPApT/ENdDpaKThcVIs0pdg0F+
X-Received: by 2002:a05:620a:880c:b0:92e:5444:9274 with SMTP id af79cd13be357-92e54449803mr246448285a.30.1782724419481;
        Mon, 29 Jun 2026 02:13:39 -0700 (PDT)
X-Received: by 2002:a05:620a:880c:b0:92e:5444:9274 with SMTP id af79cd13be357-92e54449803mr246436685a.30.1782724418509;
        Mon, 29 Jun 2026 02:13:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:37 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:36 +0200
Subject: [PATCH v2 13/19] net: mv643xx: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-13-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+Q36/R3+axSk26qNg0RKgcggtmrfBcF0QjetixEKu48=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcS4h2j1YriB7udV3KPdGB1WgZYJtyXF3EwY
 kWYyj6tBQOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EgAKCRAFnS7L/zaE
 w4OMEACpb+VV0xnCo9JBstslWcFSexsJONNn93JsC45mbPVtpAmKkjbrIEiewVFro99EPr3WYy1
 qgyQx0sGC5N8MjJ416HOMzRJxcjEIzd1oDsayga3Hm5jHr3aPET6ovOL2D8pPxKjEWcqcAVrZvK
 sxr4xUzdhk0cBmeaI05gXB2y/pbRlPvE8rcWRYyss8ohjJPNNnVQcjxZUSorQq16LSOFp5CGHPu
 EYwMXOaY7DoYklLTUUSFnqS46yyTgmmlNf7GYefxWF76TS2QcYDOcONjbhH+cs33Alsh6WdkAhI
 1K5Et3oS4k+uV8IeF/MJP+031ZUNWKaS0LSCqyXyYU8d9D6pA1XfEJMd+MrHJalMen+AoRuciDO
 JodmffqqSe8Ht3GT2UM1iwvhKz4qrca+6jtr7gVmieZA9R4w8XoFLLCHP8A1JagcJovYVca3af6
 hJWsCx4YQCUOk15HJeq1vMOPGj1iTQE7ynFI9+KPaPZiW54aTa7nl2ImLTSZGW4d3BWeU7MoWnH
 Qn0jHvQeWz9yhbmxxL7RbsInTMhP0hCO4CsGeuoX+JXUEshiZbxUWBo4YK/bz49AfsewLMLFERh
 N6DyGeSUtUzgNCVW6knWh/9+tzdIqic3hzgHEIXxCBODPiU/grBsnpnpOqfS4ToKqOS91Tkjrms
 2/CqPYQ9mTIKGDw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX5aOjoS+yvEnT
 e11f+/VdxjD/coWnbIUWQFBtx3r0kScjvyNEb2Y3k+gNS09V4w2Zq9y3n7x+psrFhAdVftD9rzw
 wX6EOPGV4DRinUtF0UYtDDqPVWLvYvs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXwA1LD3XtTO8l
 B5rSJrn5WaOU6xyRmnWAq/Coi2Ncpc4fPha9HFrxn0EVsvzl/tFy6bAIe/b3AEsUMeO4KmCLYO3
 3mZCPOIT9d/CVDJFiem6LQyIc9pRibmxzetuAHIFZHLPzdPXE4w4cdeeK9GdVetok+hazSc7QY/
 G8st5IRcnOisB05HY/jtJIrs7NnGcthFnR5oIc+phbudmgny4p3GlYX6GWUhhhDi1EaZVzqLmKM
 V3oqrlso9v6rWyiMPRxgwSCXApY7SmvyT7UiOGlUOetRS9iXmqPPXSXF3YyEzqqgei5bBF1jCrv
 1xx6w++CkYr/9KHGC7/pEev5h03vP7jFRMJmCp5KvtSJN1WkDqHEqHDyfyZDyI5qWchcu43F9Hw
 tdgioJ1Ud0FoUQQ1+s1pnZy7y9vkhQgk2CD1+p+f+EcDFSydxqYoFjcxbuAZwEcKMFmfwk3ZMCS
 iWgxn2maue4DHzhccUQ==
X-Proofpoint-GUID: GtmKhRMU9vQTSsbakPkdFB23X-r7co4Z
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a423744 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=deS-VIKRvcGxR6069T0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: GtmKhRMU9vQTSsbakPkdFB23X-r7co4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 1881583be5ce2e972fceb14c2b8348280c49ad1d..9caa1e47c174c9d7a161b7f2e2ee12a829b813d4 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = of_node_get(pnp);
+	platform_device_set_of_node(ppdev, pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8F38423B
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352634; cv=none; b=nKZyN7wos4LRkj9Sm+gRN3zOvr39bsZAac6A8f7PjvBUkP9kYpcR+Bwd8yqIMXmdtl1jEGunnejgEbnzVbjOcGIYWCVXFbJaKgH8UzClg9/oRx05Z/zhThU0NzCsgU1D33gUK0cr9zgNZ3Y21ynw5eT9ZBS1KV6uqeVogEEA7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352634; c=relaxed/simple;
	bh=/aRY/vb3/hIBTIMJYLxhoggrOSD5XZpzRvD5IEGaQ84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=om2zky5hT+IzfIYWOrw2QTv15B0ntv26rsxZhIt1LZeJj3rMpXZ11+a4o6UIb0TLO3G8dIYuwkdRQdoDqiC71hoITONxt5ElBMLsH9MA7WjeMn0uKyILaGXpoitel8h8CjKaFRvq7vivlGJFV1PjXX/Bour1Pr1e5DXSztiaoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHrTiXeE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ult06zW4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHrTiXeE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ult06zW4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2SwhH3815908
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=; b=oHrTiXeEYw0WRHRT
	0JryuBJBVPGqSxjyOTxM5WpWR6iIX+t5Ehvvw7Ijy/GBhhIDg6CRp4j3QlEKLHrd
	+T96al+7FsYIjjP2jU6FOexSof2OZMQ8rNPgA0pbm1sVXGeUZU2LmQlLaiX36fx3
	MG+nBBELBSvdKBlncwtRnvz10SEQ3fEi44Jsy2GFv/ny2/9kv77+p55hQ3FGnrzQ
	IKaYfJHP4+j/gv2GVgK5+Euq6Esk471OF7JFruDCfx2cLtA7CQELRBGCRGfJBFlZ
	KngEWPif/BD7w3A+cd5xrKALQ79BP1Zurh4FsssoVkSxxz+bgCaXm7XUBHfW97zx
	+2sblA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa19ha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:37:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514551d5f2aso231314131cf.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352630; x=1779957430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=;
        b=Ult06zW4HVLp8XwVxMFM/dMUx+/NdTDIB/xJQ96L4q5ETDlTIujP5d7zTOwu0Vo8mQ
         wlOXujXvYcixyGI2AvY1qCbPPlsbcUbdBMS2wHUFRlQ4u+fdKJIxqHjEJGpBN7lcTHUz
         +QubifqY8VLV8xvuq45rDlWQD6FlzZUs1JIXs2B0m0BD9kMm09vA6S9ddxpXoCUxhxTK
         NbZciLIzp9O3ypns4X6lzJ0oRrKsPj/S7eHTjVk5jRTDf5zZRRpSA+Rq4iQhfZsffEHM
         WDwA4nm8YdE+pbHwydll6kKMxJzgx0n2uet/eFPBic+dzkvxXnLbxGzZc3Z9O++L293X
         BqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352630; x=1779957430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=;
        b=enw2TDs7vnIqiOkIAWiPCymFBSUFvUKKhBlXoke1UPsToPKpLMufMMn8LcDpugZPHk
         p2IJrCQ0KO/bFl2t4JSfhv1KDMxdkDhyL6inueGD9gMzRsJdLlUjOS2G2b4GfiR4p0jE
         eRL0eOPugr5zoziMEafSV7B022lhYlVNPW4Qw0m8oTJ1FpL+2FpLMo/eukjLdyyxVBiu
         +Q+6XuTv4i6cM6j5AAUvVhw+jFbk7KGdN9a+cIPjmXGikmPu9oBzlYO+EKPwea0eZEls
         v7vYOmsDsd4A83W6WvFMmoH931IAK3OVwUg7XW8pDO0/dwJz75NTyfuIQmrrju+WoKG/
         d1AQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hMJbH+PrGCppThy3xHN4Ld4vCX9EZZldoxNhJQMlcCLMzBLHKJadO7d3BSV/TiEn40EITU67prg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XNpVVnnyq1+403nvKm7ShC/tbTl86zRxXLTn/C6uq/sAFMKA
	GqqxHlRH7VvQv0kXgCpjXYpxie69a+zJwQnms8BnOUwz24mq8m+XKRpTiE0lqUMaVMw6Si0yQhG
	M+/VTbONFTiykLcbV4dsYGqchslBv0DlulpxlYLGPlAyDypRbH/hQ9MSw7fsSrA==
X-Gm-Gg: Acq92OE+hIrEs7zWHkaWSX78Y+MBLMgRXU34tpeeBRMxJMYpYMDOCgsn/xZkwnjFTlQ
	beDKZZVBgY5VQqYQ9VXctsJB2TO2cgeiLRy/S2efjl6y66M1xp1bTIwJAsuvnD2FLPiVKDgQZRF
	kkg+9gY/7B2XTe2QHM3JvnsX/aNJVXMfGUdCGfi6X4o67qKFYmELADJyHytGBEq4RkPw5jw3CWX
	SVyu7LCgAzkhfupK4Z5iXrQ+6HY9tQ7vlHbOfvhUxUoda0/5qb8TdsTYSudzrN9j2gRAhCeGsAb
	H7nOK1wNKwa5aO/PmbxmtfdNFbqo1i0ucZU/vp4il4AKZwgMSMyBgormE9mvGhc0T0oTV4a2asY
	eyawapZYQsqaaaE0IKeRX12gaZvKkU/Go6oempDYio7v7xTBzhyo=
X-Received: by 2002:ac8:5f47:0:b0:50f:bcfe:e8e0 with SMTP id d75a77b69052e-516c5477e17mr25148461cf.13.1779352630398;
        Thu, 21 May 2026 01:37:10 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:50f:bcfe:e8e0 with SMTP id d75a77b69052e-516c5477e17mr25147771cf.13.1779352629775;
        Thu, 21 May 2026 01:37:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:24 +0200
Subject: [PATCH 01/23] mfd: tps6586x: fix OF node refcount
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-1-88c324a1b8d2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/aRY/vb3/hIBTIMJYLxhoggrOSD5XZpzRvD5IEGaQ84=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQdlJ6Gw9yankDCBt9FSOgN2Xq2huOUHVWq2
 3Mrh55a7QuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EHQAKCRAFnS7L/zaE
 w8nQD/4loqIyi5npUB0pcQ0If2+y1OYKJ5I3fRWNoD+DI2qAw7RvRg8s8P8r3CAXndoCmybnGcM
 5m1IEHBWc6qOHq0mh/OkumNuSy1hZr2x107TEzMLDEBT9H1M+UZPMvVEe/aPC79WmowHUUF9TuQ
 GP5vrZ4LpMcgS4O084BJEASA5nzY7uelq72L6TarvzcMxyS5TjdWC6urxNMBWCi8R8jZzxGqvRA
 QLmH/AE/4+uNzpnvf0hKdeOVPd6gbvE0i6b80v+PHjuoXIi/p1jUehPLgdPjIZdjebdM2TlVbq/
 P+9OrZKLw4SE+WRjUcN+UTnJ9tUAy0e3et+WqqPo3jUL89kKacqheQ1e2WkNXwGyi4uVuDNHzDN
 EvguWALMcMSEtupOOdXvE7nDWlVjqiY+3PMQILeq7NqMN/sFl6eCYnlTfomjSu+m/Em7L8Wq1ZD
 tFuwrfOg2BDxS7mr/FYdjg8+gBUNSZIL7MNlfzoXNWRl0rfwXF4Z8tdBbpD/g0zNTdhf5OZgAls
 IYx3BCJ1rkEwyphre8P9P953xIKshhJ4v9FpWul23QHiCYgcx00qs38wMQFaQ+tcpndPkewXAjf
 F/6YGVrg7Nc4nlGb9xf9H82vk+Y3HR5kALW1hO/kymu1NlKKvAubzUwld/OTrCD9MzeUjTa2CC3
 KvJGbKuQmkv3QvA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX3e9hPVHwHgAL
 uflcZPvozrXDeUjq/SHEBYD3dBUcLZs+xctZ849Ywzd7m1hN+RbOfp2aF2mlEg7a6bC9beve+XK
 dSwamgzEHlyrvEmbTBH5ETyN7bl6pheIHHGt9OKuh4xeEbbe9Yea1fFlhZ/QnXlSQtP0zoXwuoV
 xbKhxeOE7vzTZtwzDa2I4xXqX9OCUWWEbVJ8i/nP2HAQ5Rifimo+GwCriG4eHOPeYTnSVQWRhp7
 n9GLEuJbKfQj0zX17KrV0AX1Ry2xz8A1/wqkTmnepJfvM/ieAUo80pMkCWmhK2c5BAcIwo+gLML
 OkrICUIa47Kh8vbjCQlaUInDvoksBLiDSkkMILGt2Xwwi51NX68LPS8YcQ97ki1dplxXwKTGry6
 9X5+WqYQ/acyhkdZ59GyTdu+QgPpQ0FAMH5Q/TuPH27mz3PXoa2xJOA0OHlsgltcp2lRXM0ru/6
 doDpn0VnCyFI6H5ikZw==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec437 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4gvjGX-radYMG0rQGxsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 6cUItTviUKilcGZXWckHxgGpc13xxanm
X-Proofpoint-GUID: 6cUItTviUKilcGZXWckHxgGpc13xxanm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 62f6b0879304 ("tps6586x: Add device tree support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 8d5fe2b60bfa550d0aad30acd0820fac354028ac..f5f805446603315ba76ce1fc501c908f1cec0d16 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		pdev->dev.of_node = subdev->of_node;
+		pdev->dev.of_node = of_node_get(subdev->of_node);
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3


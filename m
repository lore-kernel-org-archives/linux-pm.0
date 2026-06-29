Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3F406813
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724432; cv=none; b=lgHcyJ2+HdAcQJbHJZnxpuZJkqFHhVcGh1zMNCEzPsaMv+qkN4E4WbbS4eenbvmkpcaJLurY7MHr+dauq1Dx7i7lGKHpRHwywyz/ulgUYmGvPaZ27ZlYxraVpx28mNOYpkz6g+KYFKfRpsciMVRGqG8X5VS9aKXMqXe9t56ctMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724432; c=relaxed/simple;
	bh=Gc7zjQ8K3UGxrQUEA3l/ojyEpHz6CDAO+1N6mZySJcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2k30rR7yrlLn+GHe8Fhw96C2u0GydGYJhhD2BlAqlUv38BnazHcYO0hJyqLztnZMHA2g0DINQ1b++Yn5PloCvHXwB2OaIz925DMoyP3ocnKlN/RAMCRscW38UN+5+m660gapkF4KxoodPDpABff+z0ArMSbe1EA40BxwnlfZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILn3fVqP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ds/k0YYN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILn3fVqP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ds/k0YYN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8xguJ2431938
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WnFQ8s5FzTKwx99wZfiqcLQumGzbQMJ1Gb38TtDDzAY=; b=ILn3fVqPEftBrxbf
	hbNT1B+TKhtWUm4n09Np/mVZdX52QNbGzOkOo+0eCuwdMafnDDhXzksj3f78cul0
	/JY36CRdvCq7DG8+9RI4dY9xyaa0bHXKzOgr+J+EDeDNDbDeGF7ma1rd/EAdl1GD
	OGT7STFj1i6QUYlMe/S3UwMCCFfDRYDPAp9cAOjeTL2/eOng6YUxiYoz3Nj7nZWT
	FPeA7LGVmWsvDV9iwwmLYsN/JCob39gjGui/sLO/5Z7qsiYyIwcjcuDvF1IFzOOH
	DQSH2TmfU1TTjGR7LTzqSp2gGB2K6W+8y1hBWlI7lZl1knIzdIH6EN3AVKScHjPm
	JpOLIA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper289-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92b380149c4so247778885a.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724429; x=1783329229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnFQ8s5FzTKwx99wZfiqcLQumGzbQMJ1Gb38TtDDzAY=;
        b=ds/k0YYN8AgCsM7D0vJ5y8gt9WUEFE8exx3ABZwbfKJpVpm5cpxvV4rjPeloJaEhvH
         +htAz9LQVNBPjt2Z3R4jq9dZhVUCCQ5M8kqJ3z92PJkiQFZ5jA7pI+xttdYmm3YnovT4
         AW5cVC+Aa3BgIs30AWYiwFFpGXO1QoLF4yVrDnf/7MZYAaxz3mbnP6xWC03nefl1yIz+
         bnCAWwVTJlPFH8CXWKIvEeQn9V8KmvFhmaZ7KuxLdhj6r8sV4jw4cxKVnWHRU29huP4W
         BvKzolmXuE1dVnZAoJSQxfswQWpf7kEIB45AQG5UZB9Wf3T4dsS+g6E55cp+egZnT/v3
         XirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724429; x=1783329229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WnFQ8s5FzTKwx99wZfiqcLQumGzbQMJ1Gb38TtDDzAY=;
        b=hoKD3JVoS0HFt+D9enMipMcsApyL/xEJ7lZ/5bNvcAKM8a5B2OxIlmvsuK9L2ZXTxr
         geyn/CGEe/n40jlpTehxiqSsErXdoLvxx3knxlUZHWnldOb11tH3Bae5n4NsSbYRomMT
         9RVh52xrFrutuMDa9acUQjFnk7yrwF2hYqulhwpLA5Tm24PEv3pj9NI42Gc28LVvdTL+
         DKlOhd+TeTYspO03WxuJqIAVJ/oVfCES9RQTzvZzRHGUdmh1Imi26U68QLnFiY4KIi8d
         LOdkq+fI/8llu/unPYKWxAOIjjNY47xK/Y9ZR2o4MOxzANZ+uMjR2L+SP8qLHynnZcPE
         XsKw==
X-Forwarded-Encrypted: i=1; AFNElJ+gFN0V8GUHSo4ug+190ZIu7byiEU2e0w0QyOuX0bS1XHlHg84U9eo4QRt9QvDCi6T4gLEQZHfS3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSMn9GOY6LhN/ncrtRXwIUTL6JVMiwY711XMBShhv8uR2SSKG
	/WQHoWI92i+qDJL27cdmLUx2ez4k4qWT0V26iiMZMzDhA4swoRLiuUZnuKyZWHnqXn3XStePIxz
	RZVQIeZChCO5uxB2EL31GMBaSixjQfoCfXJO2EXvNv4mhpYm4kJ/2QywpCgxwuA==
X-Gm-Gg: AfdE7cl9dlT8FOvfsx7AjHBFS/MAV41q8DsmZoR2trFNvuoMpGIMsV2/bX6fWrlbFd/
	StJPqhKJTTkUXmyHt4D1vDXNFNwAIQf+loFd4ALRXy4vtZIK+in5k55MQbAy8niRXGK7/a9M9MC
	C3lT0HNpkEifkWq7u3JN15oyXOFsKXZn3deUS2+lTNRteGNXQz+ReLuDMXoV0m6bqd99KSc8RXM
	BghV0hEas/iYI13iowqqlsJ4FPxrl93xFTND4N0Ddct7eEBeCxpXjj1BnsIvYxnyHWxCT9IuC1+
	OoZVg2Tr8zbFh3ofpjj9ndMdnMjp8y+SZoE+ejZ8fg9Dnj3kRCsN9JwuIJXHc0iOc2b3mFjsdtI
	csEsAL/TZ5e2jICECMLTzHCsufPiDqE5xLNLCrqpD
X-Received: by 2002:a05:620a:4706:b0:92b:e0de:f193 with SMTP id af79cd13be357-92be0def3bemr1192762485a.67.1782724428083;
        Mon, 29 Jun 2026 02:13:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4706:b0:92b:e0de:f193 with SMTP id af79cd13be357-92be0def3bemr1192756185a.67.1782724427424;
        Mon, 29 Jun 2026 02:13:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:39 +0200
Subject: [PATCH v2 16/19] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-16-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Gc7zjQ8K3UGxrQUEA3l/ojyEpHz6CDAO+1N6mZySJcQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcUYFPkmtYlqYBD6pOfruG0HB4agBQdjermW
 D2CaNY48aGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3FAAKCRAFnS7L/zaE
 w/FjD/0eAzv7lZsLEu+8uN0Gf3x0hmYmNZU+OfT/4weEInEM7TeSQbiN3pgMmvlj80CdY5Q1REQ
 Ex6iSujlHMMD9tcNl3V1BIGs++Pz9dpmj9n+5Fo6INo9YQJfeP3ZfbkkBda+3M0CX+RGmcKChG8
 npDT3s5jcIu0Be9TRlphsuhpjCXJsDBvuxhc7eqwWardj4eSth/HNLkbKfY+ju7Y4qsoHepyAeA
 p5m2K9399ZE5HTJlwCOfwYlVlQo4sJnEl0Afhqsr7b7DkrqCZrOpi6NGsFj6JDD9aokHMeUDntu
 c/1zSjRLx2hKPgU5Q96bRQysWGped1vtY1grnPhifgdnp/jvqRcbEXVYhxZPj5FACP8Gr1ReNWv
 BpTxLfHoW/M79AyNPhdGX+jVcNrzPaGm5sVhrOGIPEpAo42H+MVA3DDdBup4FrH+i3sUIEPEYps
 GV0P5A9CKpLx5K3dIcWMsBn9ZrBorNi/XqU3JgfGBbpcv9xeJvBGCy38l/PMAS4/9u9zgVTV//y
 yQGP8iFBOxoQxugRDNREkWEdHcUi+LdcjWnXvBgZnXMSiqiK1AwLZjKp8YOnvUwQkbEcuCaAePv
 C4sElo1miGCgWPCtW3XInxjubqn+p2OX/c89FWORM3XSJYRsDCJH3OXSvb1aktZuC3a6q7x0S2z
 I06GT6zphKjJr7A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX5eFKpXLxI3DH
 /kaDjrnLpqODN5uhzGCWCyY3vsI6H9CcZ9y//rUZIUQKvzkIgrnNS1dMAi+oATWHdi9tgxTL7ma
 Lnb7wBzI04YVSYs4dRZ43rhxnQUzvMSSTdjSe/Xd4fINN1ubYC2f+spEMD+Ih+PwyP1luvGQVrm
 pGMoM2I3d9urHpnGiGvyYbkDXiL3NUarXNIF6+rHde4HLK+cbiz6pI4T4OpLm1T6h+YsMYAlz7a
 v+c0X4swrgZivfCgZavqIDYDeM52DVUqWCjTIFSh+NwtqHqlecUUfWW+T88uwzO+lDVdbh3+XTT
 70c9TxmoVXuN5Gwb9rbsJ+RSVtzjASJHZvzvp4qUZxL6cqd6e2Hd67jkHxLBt5akt4H5fiwAPGg
 TvrJjVqcVJBNP1Hrv+hm+OsrfdQkIrUHMqAzQmzheQh2ZhOxmBRgr8thIX5xNlfFlOSFSUgX2rX
 xXh5ptt60hOrMecCOQQ==
X-Proofpoint-ORIG-GUID: wQzQiTsqlEA4cVs0hrgNy0FDpKpvV-Zl
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a42374e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX3AgOv7ajWVuu
 cd6s9Jqn6rWwJVxFnVttMGWA0/+5JTxx5FC3OGo8IJ0Ho1EFD7UBxObmDxWSP74sYbc9O0Aacxl
 LY4mU95gyvmF7SdpMnPbiilf2ztRHHE=
X-Proofpoint-GUID: wQzQiTsqlEA4cVs0hrgNy0FDpKpvV-Zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20211215225646.1997946-1-robh@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 07563be0013f4d28ed6318a0751670ccef01d0a5..7edc512cc37dc24551efe5fca172777a0a4b0766 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -879,7 +879,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
-	device_set_of_node_from_dev(&pdev->dev, dev);
+	platform_device_set_of_node_from_dev(pdev, dev);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)

-- 
2.47.3


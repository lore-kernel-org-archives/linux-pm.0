Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B494071CC
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724435; cv=none; b=b5G+1Nr+tPstfHxHnGJa09Ju8xY13A1SsgKiVl5z/Xv33HkRUHPovWOYPTlZXCsKYvoB2wFFEI/jFiQIAb0AbIroPkJrXm4rNXGw7dkZCy1Qk9QV/okny/D3gj/PIlBt4Zh6pnPuTjvLuz8t4zcy3zO70KIKxM3yr2kndfOWMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724435; c=relaxed/simple;
	bh=4q74vFm5uja4ZnWq1lcGzJHIM1G0GMuR0uWtoVmzh3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+XJEXeth0xf700FejtLlt3G1isqqBtwlpIWgvPfteVDOJE+bwYlm2SWpUmEhnYOEpNH/soceNobE5R99V6trVmiWt5MTS7jvQmHlxV8lEhg0S43CWuJNCjio9z2T5pSV3mZ7eoytJg9sEe2HHz6t5K9RFYDWNirrhAT6c/4V9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBiLrL/h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BmF5C9GV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBiLrL/h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BmF5C9GV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T91OEp2400911
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	69XgShsEeNDkbLdefBHgY7gGgfsPixaRaQOC3zvYX9Y=; b=pBiLrL/hYuKQO+rU
	ePrxQHLapFiYpVVJMeqqlJrCUakgS5j3y6au7ou9qpQAXazZMU6J9Up//h0r6mQP
	1351AZAcaFoIu0eoYC3KHExgEMiQ5kpzn7EAR0/LhZoAKFkZySvHRZMMBybkaEs9
	MidW3MKMX47N92sSvR80tS322/UVX4E13iabdO19NYxBhkXtPraCSbEnJSNVsklQ
	Ya4TR3ZKNEviFJi/w08TeHKgefV2q8CJk65DJdADQ+UewHHqye8koX6ffg93U2Mg
	Jm6NgNFPuCDsF5+1UYyvOtipjmo79mlydHqwd4L4/WiketDb+f+2o3JhCYYERY/F
	/gy4Vw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq881ux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e45453c94so341487585a.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724432; x=1783329232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69XgShsEeNDkbLdefBHgY7gGgfsPixaRaQOC3zvYX9Y=;
        b=BmF5C9GV2NnuirZ+55DOQQIBcW17hw8L2q1RDc8FsX9fR9GJpeVnls9DpQNF3HxEz2
         tnKkcQojJ2p0yNXsz1XkVy6YCdfGPPWbCWuh+ppZ2I9B5w18D31/xSzjl1ejDcjgwNCd
         4HtdUACRLKsRb0R8Is7grzRknbcX0sZUWy3GhJMDpuhc9Yxg5Q5pn3J5NMms+7fyr6CE
         sWuSJ2M9rFzWMWy4nym6j/H7RHFYW+huKvOUlgAn2QkpjVfJ95to1AowmPA+Fy/1dVfJ
         F7ri+c7eegNOFbGsRsPwZxuTx6IA6l5v+3Ql7+syExZcEaYGdxjBjUKVku47MTQHmrrS
         yEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724432; x=1783329232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=69XgShsEeNDkbLdefBHgY7gGgfsPixaRaQOC3zvYX9Y=;
        b=T9GAG6/bZX+bVvRPwoRfL5C8kqJGoUQZi4L03PMCMkAX7awVE8GZHxUfajCsdoTA64
         rwDWnuUVRyiv9aPBK0PrNAiqWS+nnF1HN0YzfdFzzD87DSxsvECFpatyrzZnzCwBWO+R
         5GdtUP41gI9Uki00n3JRExV9M/CQTU0whiNPOCNEcoh266IGRngexEGaxQ7IdVWrY84X
         9K2iwzw2m0v9B301Gr7VApTtsTtSLiO+eyCBe2Mo+7+lAFQEwV9JHpHn62ECBmDIajEX
         SiqEyR6WKJtpoR6ohCJ0l52TaP7lUvKrWyRvKDsx1fkzq3fmPWKPZC4mNB/9pbQuawb/
         hEDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QbKOlSI9VvaksJhWbbOLuoiUlaZqN1dMjf5Cq+EsT7cV+UfI9cuIRIPrYT8y+x92cu7ZMoRvpVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySk/NvSutGsqIbtGY/tv4OR2bE4slDSjuHb6iBBH3p5PYTDHK1
	b6H7szq46oD5SIby9YmACuGZWoA8sQNeTgdS5PV8wdtVoEEdP8vlE/wzeBmR+ytZ/1E6nkHx4Ef
	OO7DICEKcwRk7nDunn1/fBGNszVyxCYOdKfDNyNw2gIwbK0vtfPU2l47Aad9kIA==
X-Gm-Gg: AfdE7cmpThkqZbAGhg+XKNZgtXZzV8bjMKo8KAeu/o5FtqflZprWwtBixFZur0BeJ3x
	E2Qr5IyZTnBxhZCxmsAQZuONxqPG20pgi8RwCbA+LNPRgtJ5wFmMbYfyoaltmLzfVVJnNahM7oL
	0DBVUTvm14Em82VyYn01tARAqykkNafvfRqVeImlypYrBrgKwyGcjLNbNx1XfRL5nktkQJsawd7
	JeE1KhfYQ58gudAX3LUKUzUS8CCcGtOWDecBxUmM+YNIAw8KGLV9mIbBIVdHEMugXbG6VLts4Yx
	d2P28Hcci6vkpbqwFOhrhELYQZ9B3gxE/yijNBbe0FfaNqbTl50VjPRmmoRhOZjdb/nUrDLFaUc
	mGb3/oYlIQid7gDQqqa1pDPqMbbKbRrjC2PhzqKPr
X-Received: by 2002:a05:620a:a0c4:20b0:92b:32d4:4ae8 with SMTP id af79cd13be357-92b32d464a9mr987664585a.8.1782724432135;
        Mon, 29 Jun 2026 02:13:52 -0700 (PDT)
X-Received: by 2002:a05:620a:a0c4:20b0:92b:32d4:4ae8 with SMTP id af79cd13be357-92b32d464a9mr987651185a.8.1782724430435;
        Mon, 29 Jun 2026 02:13:50 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:40 +0200
Subject: [PATCH v2 17/19] usb: musb: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-17-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=976;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4q74vFm5uja4ZnWq1lcGzJHIM1G0GMuR0uWtoVmzh3w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcUaoEAQ+rGtNym4mdXn6H+wSR5jovuUo4Xe
 W9yGwBaFkuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3FAAKCRAFnS7L/zaE
 w+6hD/9LyiWIfVxtqm4ndMyDneBYNN60hwgm4cXHCq1XpEjqnjcyEIHTyKq0I49Mp8FU9xpXN5k
 gQnaVVJJIxMCT3XeyUAxsXAhXnTNImA1TC2sZ/cTz3ryUteIURQPE8qc3VgF4KyMNH7LrlhVvH6
 mVXhZnUgvbwb1393J/lNIVJlB7A4PPUCoILoaFbJEZ3I2Lu2fKgtFcT5kmyU3LLpAsDbK0GCz/s
 xsHPglMoY9iIOvWGke5+knNUDHTadqb62yylQ7xFD9LCHeYhM+7ccdwrZBa/9p25vgwxULJN2n3
 zqM1MgrGYYkih87L7JCf3nBpW4gWnMnL1NfURb0Zlto5Vz62R/8UTrhMuS/w84x0/t31HCBVErk
 oHJibHcDBVb0IbGbPfGpf2qJITOS1rRiLSn40TuksrjJG1QAVul8rE7AD66q/ZlTmSP1QW9yMBF
 yGMvvd6BlGHB2wWyuiUWSffSIMvy0pvl9TXEfin18wKuOG2OFVpCk6HA1Lci6A6MQH+RmAavl5D
 tlxWgLoIWF9Zwwo5YAQpX5pEacDY2k7YkNdg87Msyp6ati7upxnfA16Kau8oVAKHJOmxITIxXIN
 2qvAYYTH1oq1ReTzfFHxdVibxbCpDOG1ddeqkDEwFV3rHpCaT95BOfXx8yhP1afAGlDp6fXzGx2
 pD/9VIfSZmKjbFA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: tcrbTY8-Jh5wJ4XXG8XgbZDQI-yCA3Wv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXw2H73MhZMtwI
 NgJ/gcfJJcS1udXhu1lNtquz+36wYs6whQNWe3NP6Frwytpc92JQq+qfVxMM1vtpWs8RpskKJHK
 S9XYk0yhEFSjo6WtEwF2240kSGnNlaY=
X-Proofpoint-ORIG-GUID: tcrbTY8-Jh5wJ4XXG8XgbZDQI-yCA3Wv
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a423751 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=-E7rG7sKBpYtUKygALQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX37A+22yo7B9u
 PRB5pLgP07gmhrV1fEr420CnVPs3Td/edc4HdYDZzbtlaVgLTjEWIzTS8gMH0T8ManOY9wEt+ul
 NcK9pw1Bf65xdvtQpqTb/ruYBe6blWrFT42EtZ3UlYIeOJdqoR9sZlX51KA96rLq/3BFFGp6WLo
 FqvFhIxwvgjwV14WzMGgv9fHxqSjzfffjRd7B0IxC0Tm2bWiHPWvIKmrUPcHtk5oTqgOHOrgJN1
 eOUtfaamotGJiZLPiaDx86BzaYpvTcFds99WLvupwGME3zzpaccNAK5AVREA0qmciYIn36DhJ25
 fUqL83qLfbKmaJSNSzyo9Nj4zPjbE1YcJwcfqi2mga2F1X+oKq+//VOQHCnjwXphyMfyB4JKlx/
 bJaQpC8bRFEEzd1cRoZMSMK1Wf8Fr69pSsZCD9xF7tNReE53hwzBx2CNB/mR37ni7Hv5wOGq5na
 GcSsy0xyZPCPD1Pup2w==
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
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/musb/jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index df56c972986f7c4f5174a227f35c7e1ac9afa7ca..c770ba576f05b6b672836753cd9b696b752d017a 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -273,7 +273,7 @@ static int jz4740_probe(struct platform_device *pdev)
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
-	device_set_of_node_from_dev(&musb->dev, dev);
+	platform_device_set_of_node_from_dev(musb, dev);
 
 	glue->pdev			= musb;
 	glue->clk			= clk;

-- 
2.47.3


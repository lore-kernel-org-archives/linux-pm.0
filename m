Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716674D90C2
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341943; cv=none; b=k0/v6nEyu/AL1t4rvfe6grWwImcccGsIzXKecxcHhnFM1f1km5GfVap8eAP/PLh9pdEL5y4ClbzUelr8+0DNLbTpmmvYAJDLAyG942dUjo55iE/gp1LUWtXtUvJ0upVqeiIvk87/N9EIwWIW3jGSQL+gRAHDypVKIQJUU8dARxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341943; c=relaxed/simple;
	bh=hK6KuPL0Fkp2tcUxylzP/EXq5M4YtzoXDw8O6icggM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aallcbcuZu9nKi46SaCbjmSRtAqih3r9PojRZdgOiJQxNHFJKrIwWRkQuqwI2XCDnvHJGtWfWs8sqZzTg8Qtt5u7Rjn07bkIRXBwOikGzBGA0PmmteJLkTVC7d2ds2ydJfUGsSHsRMVWM9Ps1ze+zFXOquwV55/nMDQabv39GSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iwyNy+Ih; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NXl+5xw5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwyNy+Ih";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXl+5xw5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxMED387498
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 12:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cXUi3uXAyC4OxWqNWLbh5atOLaQPfv1B39yCRWJbLQA=; b=iwyNy+IhGsX+O0T3
	2kGvU6ImOgg8EjDd1o5sbToLqJ+h+J42bWw11oOKHn2iza+sGFzhlFcYywkcJUBy
	HeSBI+6jTPzl0z0WmeufrDDA3k5b/geFNZabQnp2CL+Ab9ynYk2AcTRksJQ/+rYe
	E8Hctc/S4ThFCUuD1dnULxTglMrmx1+pljFRLfA8vCQppBG+3/6+TAL73/TG4DsL
	cBQEsCgQEGltOsP0Mr8x83YCo0df0mU0GDYCtse3AL0b0s8CO2JFE81P1yUgB4qM
	HoK/QkxTOUS1TNlrlhR8hFCSBgrY6afF2PMam+drQNByb/XsozJ0CPCVjg7gkHjq
	5vYUhw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0mmf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 12:45:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92d1cae5740so342819585a.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341927; x=1783946727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXUi3uXAyC4OxWqNWLbh5atOLaQPfv1B39yCRWJbLQA=;
        b=NXl+5xw5clf0ND9iT1tSCJ8IgUs58gchv8WQ0JN87Rdt5vyda3MDc0PIzO7sDxlNQy
         Z/u2L+kNG4U4KySsie5d7k6XTd1vLGa0jQCNQV7LuBb7Fdx7QNr8rb2ip273EVaVNLVj
         LqGJKWzAK4dtMhIbyFEs+ntW0am70qM9heHFxaCdi3JQg/qYoY2uYSJQv3WiwDrQViOD
         jjQ3qJRf2AZLGiyCc22IF0x6TQZCxHaJwdIQ0dDkqOCDmOW2+Jd+sKcSyfEgIq/P8vaS
         ibonzR8JygMaNpwGgHxU/hDb0eDpW0sbxv9vzKHU8My/3WG4ZEWKnugAK5dRGKnKDpS4
         GGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341927; x=1783946727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cXUi3uXAyC4OxWqNWLbh5atOLaQPfv1B39yCRWJbLQA=;
        b=cNMPVxvdPI2G18n/HRVcpnSvHqO4I4gAImrXBcct8xePtFYu7HHogY4lHt2IfKirTw
         IBVntjiVGY9D0avxpDtnQMmH49TLOOUt4vW0qUeAc9DH9CB3o0nrKHmjtaSOaAv9wcfe
         UZ+zRh2tpRPZQunhR7hLe/jqqqpyoWS8nZuTQOoaa7v7XyQXw57+cLkU//zUe35x2ekh
         H7xIDyMxYQWOyjD2bYFoYbNJysAuoZK8xjlO/tuCDnOb04oq5FTFEo2gFrL3RvtJNMgK
         TfVhFv2LQMl8sG6enus2WK9cN4xkbwtMpBcc+nTQ2pzVKrns5718ulm7nQemYdWR9e8/
         4PSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjoEin0vxEq1chlOf2DTvQb4Il5Ic6BxwpRmP4ju4b6uoVqTqU/6hv3kVk3oJWLg930Cjgh+Bpig==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1uKVOLTCj/BIUE2OwpYtJiYWVqiKk6wUVLDPFds10GpMTNqI
	xJxSmxkWgw7VmcaN1HhS4H0va7mKI5eQX6W3IMb+7BkbQWQ0GReivxmW1xrmbyAduEfT+mHo2/X
	xOk/GkCbQvcnZ+OQ+IL9cPCdWQXdjR0e3zHMELN65DTjPkE8DL2MsucSznfd76Q==
X-Gm-Gg: AfdE7ck/KC4sR8Lm74nbgqiZWbKHStvvKgKIZba6Jsl+/HbLimixTlZxia1RX9Gzr9A
	SvxvpT++QOvBiq+Tuo59LN+9fd73it1dg00oYrh8SnY99hOp0SdBltzgg/FKHIVWIeNFYejNAZV
	SWR4YwXA5NbF4Nfe3vrtF6PTTx2QBRVAGKINow87fC9ocOw91MmGcShCVvqdx+7kcvFIBvRHd3A
	pTmDaxve6X786Y+Fp09RSH1fCbu5jbPDCbMWUemevGR+cp9OVIWor0cDn6pTXNeYds+Fnqfq6T8
	42c3cdik/QO/FQxYmNkM+YxMoBv4+r4foatfL6ak6xfv9TQGFZI0v84tTUWNxkp2DhAAVY6M6S6
	gMNfWAlXExSIFrqu+n6C/D1F814s2ATs9rV5JSJQz
X-Received: by 2002:a05:620a:45a5:b0:92e:6a8d:38aa with SMTP id af79cd13be357-92ebb715eedmr45292585a.63.1783341922401;
        Mon, 06 Jul 2026 05:45:22 -0700 (PDT)
X-Received: by 2002:a05:620a:45a5:b0:92e:6a8d:38aa with SMTP id af79cd13be357-92ebb715eedmr45258885a.63.1783341920254;
        Mon, 06 Jul 2026 05:45:20 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:22 +0200
Subject: [PATCH v3 10/20] net: bcmgenet: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-10-1ff028e33779@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hK6KuPL0Fkp2tcUxylzP/EXq5M4YtzoXDw8O6icggM0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M3t0pRyIvWtZ3y9/kmYZJtWQnTZ1JwDAy//
 CsWsDHHr0OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujNwAKCRAFnS7L/zaE
 w63wEACOGysngK2nm0QicOyzdn1brppnkLrfHtIsrAcQ6K/s6NderUhLDryX4rcF0Rlw6HmXmNg
 epZ48Mx4J3UnU+PRjfDrDnU7GawDhxMjlqB61QqqSdtHlPaKbywufH/xrDNwSFspkipSNtateGL
 pbsRAUIsu1IhDvDMuRPtomMEHwKt3wvaMhy0QEkDyZF4RLJS1NjqlqECOHe0BRxBAP+OmuzQTpa
 oMxis5dLIqamCrsgjaweckAFttguLVhpVoRa35V3tgqh6G8gMSA3vYFajE3vVwlk9P5ts3bhHFz
 tSISSzP80joTF3QF3/3hyxGvP1lF2NUBgNAJ5TISmI2kZoyGmzcZ2XDRgjMtgfxjq6xpnwDjRIG
 9nKCfeqppxo660tr7LATQCxUco2jllbHz+6ma7aeybYxfpCvOfBoanPl0fme6v2jXuG0kA7S0cg
 Qig0wTZq3jZ+0WRSOK769hUG8E8M+56X+vajU1q/woTmsvsIhotoZ/IPu3Q7pTh9TZMfRHz5tYg
 JfQANXNXaMH/V5XUAU4mzYNu7cq102DojDBd6q+pQQOUvFmIsFFHwxAPS2aUMGWPa1Cb/FdACap
 rNKF8e6iN/oRaSKbqvIh7KwkYlPtsbqdUYAP4dxlBT7SznOUKolCzhD9ioxnchcLdrjasucBuUZ
 iHW2JM94Uq8jnbw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX38biokfth8iX
 aBbBMBdr768h8v2i7Sb2MKg5lVRPoEgMCr0R3UOShcKtfx4ufRGq9NrBKNvDPb2HLCrib581eWp
 qLqaWufvKWd4TAZhx1y0e6LG5mb6abcSyZDXm/swG+eg754VhzIUVqtlsG1gi5ASfSUtsH/gnzY
 AiyjE06oVgnxf0/6c5bBBF/NXQMoo2anrIibBJBPMby23DVtSEgp83zp7tmxac4Oyo/86ze7Khw
 vOLq0e8+VtkM8i4owXw215X4Czi0ejk4/P/sFkTZnRLMxxxKqmrbndCM8knYld6W4LLpdakjNMf
 D2vFpFRLao2qO8RNfN3242hx6TrD492goCT6CwwfWcPYEw3WuWFzN250oxNnergex0cAVsEmXJY
 Hq+7to0nuuJuamlkFSNYVAD+GtCl0qfhkw9HBGkYb057uvXEQSTr5lzeOfy/FlAst1v/AUF+CdU
 8h2mBH1fcmFUpFklMYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX2lAvteHjdmER
 yxrM/YsifbqPsAaqtSjIqpt4u+ajdWTwJvetNVZWtHcxjtiHIVINOiEk1aEboUjpZDug0fu9MF+
 8542LFYSVm3QvUOFlW5LvGOXg9A20WU=
X-Proofpoint-GUID: 323rMYtSXO273kMjAP0NOEjLsqwEQ215
X-Proofpoint-ORIG-GUID: 323rMYtSXO273kMjAP0NOEjLsqwEQ215
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4ba367 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=S253l8tU-mt40G6jxkYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index a4e0d5a682687533a1b034ccf56cdb363d6b7786..0f0dbabfaabbce3469de79af91d7731b8476709f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -490,8 +490,9 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	/* Retain this platform_device pointer for later cleanup */
 	priv->mii_pdev = ppdev;
 	ppdev->dev.parent = &pdev->dev;
+
 	if (dn)
-		ppdev->dev.of_node = bcmgenet_mii_of_find_mdio(priv);
+		platform_device_set_of_node(ppdev, bcmgenet_mii_of_find_mdio(priv));
 	else
 		ppd.phy_mask = ~0;
 

-- 
2.47.3


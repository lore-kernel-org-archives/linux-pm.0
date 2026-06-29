Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929B4071FA
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724438; cv=none; b=J8eIOiZXaK3HiRIw2IHf22x3tVIjhe2xW+0v1pQ82kBrVmwHrDu+mn/Pky4/06exCCCxeC1WpYnyUorFrsaWY24pYysNNtjiyCdoMLd6wQFq/2fjMgTQOiXUxkAYmiAvTszpmspBH3Cn9W45YLgxj7c2wLsyheteEj0o4EUl9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724438; c=relaxed/simple;
	bh=uU1Fr9CywAvFxzuC6Bl5zMISX54D90vnS0rD7BYCHEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psi5vA6UNdv1JNICURXuVQ/18Fe4itde6d+ce5j7ybfxzXY93Q+5ymIXvOJPjfEocwBN2H0nc5RMu8vHpMv8J4qHd08C8Qsqr3L0v/LoOHHrFEYCYTVTDTFALHVg7Uz4JY+F/ZQR9eJafuecOvlff0CKPj2JiBs/+iytAUd0Ogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O3a63/+I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bGyBOeDt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3a63/+I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bGyBOeDt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T91OcV2400916
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsri2EPN9pY5QDvkjI4fd8dHK5CB1Dy3Xc4grAMl3dk=; b=O3a63/+IxA+EjaKg
	JhczbaptnwlswGKlVyWvfV79oZ0KgKi0bTGFNJk/kxCyF7mjkMbxf+IRd+r55AZi
	GXomEMUi1DqoikHCTXPAjdrqb5Ame8D8+M1BTcrlnoGZNfrToyafFbjNRPQ2zwaO
	4KfhKoM+KaWUEcpS8ywRhbLGES/ncPAMK0oyJZDgf5lyYxGU7SSiPqxveHceEdKx
	yJ3pc9q4r02Gw8jMiTN2QMkH6NuZHGf+hk/uKmGbuIXR8ABH+pgRX/a19EIS9WLM
	6fVCVyrgt9sr3cUfuSRwMDTtyQbTS2qrFv72TDwNRNFbPtkn46a3Ggi4Go1D0EVz
	NGg4Ow==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq881v8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e97889ac8aso52934656d6.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724435; x=1783329235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsri2EPN9pY5QDvkjI4fd8dHK5CB1Dy3Xc4grAMl3dk=;
        b=bGyBOeDtfjySCWYmACrjTE6OgmiaVmZrDr1K/vUrAdZghkMbRZznBPIT6ze7xmGSVV
         6+3rSQW3C87gaeXSyA+QXEPs071Q1tYy6CYXgug+YwnDwhGf+9OwGRiWtA6JRwoU9QQu
         VgXOJTkyCL+HGH927ORlD5BBAxCu46FJuCGKAi/KBFh5Pv+AFNC6KlGaZWHX1PU676WO
         6Q0VSjB9m/A2BYBwp/gSkeDeN2drLeHKC6AxhWCORqgZe2Ko3Flf0JSsNEhrT0t2ZT1i
         u4qBjBnmeFZ5ufIbW2J6pdE1Ad0T3F9noJrtl4QkZuISeVDtwjDfxqgJkK7wRN+YTW01
         jg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724435; x=1783329235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jsri2EPN9pY5QDvkjI4fd8dHK5CB1Dy3Xc4grAMl3dk=;
        b=Hw3PGYXs5vP2T0bzRVVYKXBeijnuM3V2ytrrbW/jTzWRqev0gieXVOAVYj0YRBDmmo
         ylyUVvKGNSIBUpTUwCQSMvuS0OJDXkWeV3avMvFxYgJAula3wf0Cg9ZAwQwRSsEZB2jt
         l4QtWpE37aLx65zWaAIeOdpbjRslnatzvOoNP8hpwUs5qMN2rXYbWALCwOLFOUoPAHaf
         sdWXy+zgBn6QSTY9RG9dWI7MmanLo9xKjPPAcB9jtmVFN0yocdRZOCLjxtsPShExMb4K
         MgM/Y1v6rXGgZDMi+K3FovGsL8VDqvvZbz8LBZM6NN8hlHDTZE7FoCmr+zsLzvNN5tVw
         fSXA==
X-Forwarded-Encrypted: i=1; AFNElJ+7/rK/uZUq5thkkLMhA/tevHefsThMEa9DJTUnu+8U3fg/PdFfmzHm6PAwg7fR9LARbbvwJRqLKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJzTbB/wWRVMv1JboAJko0CdCWjDYimUKUT2aLURljT0BwChW
	nOdnvEu3TOL1VJLHxEy2YTrlQhIfi/zfMwG1u4O0Tqp/CtZp+3xGfLnWmJIi2KksmI3B9gXycSh
	U6hiAfhc4ocr/e955ord69Dtt15NXltOZmw8hu/LOOPza7MaDJy0SU0QKKi7jDg==
X-Gm-Gg: AfdE7clW1CkOEG05dXfDhThKn1aVLxTN/xOTi+kKD1MBmcTyOBFk6RFsWl0O8Q34isx
	xa3VK6qT0UIkUTRHP8cF6oLrXnMLhWY4euWKZNUu21KiF+cycU3tFwedkdSj+b43lsMdv50nEHN
	WfGkEdgmmvNIicrD9Y8bGVANaYumYnlIUDzi5tQ5gHNeQ1qvxAbH0mP1VXvswaMNp6QmeNAjcKz
	Mp6y6tZ6+JqsFgl5AVzB1d+JP6ceQMsGlGsuGa9es7X0xvfPFUmmdEiFADelCqzt9TSRHXFJEDC
	RFBLxEqT8YhwGsFSHvBl7sdQOejMR3SWBucWn81jg8ghQvphSRGzwCYp9S3ESgZx8OUkJpoVGVv
	X0qjJAzbRx+eDPj8o/ttZlw0VD0Xe+6JnBpe3oYDU
X-Received: by 2002:a05:622a:a50e:b0:51c:868:899d with SMTP id d75a77b69052e-51c08688d46mr5705211cf.15.1782724434195;
        Mon, 29 Jun 2026 02:13:54 -0700 (PDT)
X-Received: by 2002:a05:622a:a50e:b0:51c:868:899d with SMTP id d75a77b69052e-51c08688d46mr5704721cf.15.1782724433603;
        Mon, 29 Jun 2026 02:13:53 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:41 +0200
Subject: [PATCH v2 18/19] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-18-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uU1Fr9CywAvFxzuC6Bl5zMISX54D90vnS0rD7BYCHEo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcVVV4ntsBNkEfJYpWCbBlNwGjTzWXksVf6a
 B7aYJ8a6BWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3FQAKCRAFnS7L/zaE
 w4lZD/9Z00RoirT9cBP1O1TRPSZsV/i898PwA1y+V390LSkU0nBecvgm7et96y3iAHLoAbhwMId
 fCniVeDmYthH6LI2ZiS9IIqGiBvDjXeEAhdyEvMhzBuiPGFdp8mFz108HQYBgy2lUI7+XDx7Af1
 rMkRf1MMt6X27j78EZPbKvJxROug2ur0kEKUiFIfs/I/zk7D2EvBDMygGK4m2zrcyre6SfLQxaK
 8I4dqrMScYY8SOluQf/60QUYHV/hnhOpo04JNaLAyIvaMYd2Qe7n9BJjsaHXDQbL4S6iWyJMT0w
 BqfC+KJWDZDMP4dmiJ4zbtlsbfN5GUKj8+ZiDylkn/8gD9sz81zDrsSjahp6yn5UQoBGWd42Ndm
 pt7oPQmw6Vk69Bw55koR2LRDdmote7WmzKfDN7d9l415NKsy5TKIx+djbJyZOmNCVzd0UgtIB82
 zeZHJ5d3OfaC/hM/UMDugPFDzimkz8aB3O73Y5VGjZhxNSsYmkmWn1HMPcgS9UEtb2YcsJk2gWk
 m6fAyae3Lps827xqLL5DFo/eAY61/9bJ2bKTNQyB9JP9FCqUoc1quDYM7MzqjaYJPn4AIr3mbvN
 SJ+j1qcgCh78X6wsSW5E7LlwrU8gDhIQbjdeGn1HzcP8Z7PDSraWAf2hXpcezPNeVEgjZ+BHkGk
 q8nixFMcHJHjozw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: K1qqz3EBLIQmQ8PnLEYjUiu_vSC2ZIFv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX0BrqEsg4co/B
 PTSBCmSM0+kr7xsQ+ACNYtFgjOgmmWFZzaImqdJLtRf5eDNNSvQhmSZOzhrznQoH9HDGk0tEkAi
 6Oxe93Z7R+LRdJrMJYrKEccJV5eN+F0=
X-Proofpoint-ORIG-GUID: K1qqz3EBLIQmQ8PnLEYjUiu_vSC2ZIFv
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a423753 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX5v4toFKql4Ot
 HGUdQRfDxqx9kDkWZEHgEGFvIY14uPx8xKzgSRlcMj1sPuqQlxEN5M4mqtINiZeHOez7ZRJ+gDp
 Urh0mJI7m9TdrZu0hkv5N3JVVgNS7/ubO6XbStqALEs820aKfnBnTQ41viWktpK4QIAbuzEWWGG
 uH+joKwJJdCLLTszbEK66/PdAUJ3lFX+IoARj3FMl8DEB15jErlJnKRUDtYBPQ5K4e8BM+srzPd
 1SO/5eEz2sX6gj+pyY+UZWuSUWPWEOlCPXrZIgUHCPySU2DLuxkHLFjGyfus2N3VZoXFa97Srq0
 TuJbwV55Aw6e8pXkbikUmi/JzPSkROMVuWeM5o+lPBX6VWMzBqETGNIFnAOqansUeI9irfYBBnA
 1ssK+2qgRJTCMa2bCrsWgRDKdnLd4HnCzBuGHskkobeQOEX+PZ6RBkJrG0Y4Gyk02qzZChj5QI9
 faqatX2fMDdQaiRZNig==
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

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index fd75d9601a3bfde7b7e3f6db287ec8c5c45a20ab..f003b360629c90bb37ed0ade7a675b5b0f28fa7e 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -249,7 +249,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	vdev->dev.parent = dev;
 	priv->vdev = vdev;
 
-	device_set_of_node_from_dev(&vdev->dev, dev);
+	platform_device_set_of_node_from_dev(vdev, dev);
 	error = platform_device_add(vdev);
 	if (error)
 		goto err_device_put;

-- 
2.47.3


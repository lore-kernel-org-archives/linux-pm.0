Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B93F9278
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724392; cv=none; b=qEpBnLjULNVA5Kt1bICKBcaCayvim1p6U+WQzNKdDq2P7ys/pI/GbwHSizrcLtbIeYpR6u8YMqQ06fivafK5MgcR00zTITgr02JKzvwxDJCOL8O0I1LkMRbn0Iy2oc4GCXWgVqSNeGElyUUwMO6UwmZ6T0ROLD+7uxL7PaSl0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724392; c=relaxed/simple;
	bh=rUG0oEwArOQI4stC68CYhz65UwovfxaACRw43q5Ey5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3H01WMBZDsLVNXWkwQrLtQ8EkYtWWQUHEMOFKhG8S1mUCRVPSdmqpc3Feoo6xQjUxF3uM2CFJpNbcXntAzEth6c+4qEtEtgC0jv+x/5Dz0CFPKEcPGj45exvVuU06bZEX02z6YNwlJh44udIAV4noM37BaWVCFdpcyaSFTjLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gYI/y+G9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kJgj1DCV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gYI/y+G9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kJgj1DCV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T91Ou92400899
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NMPTZOeccy6sNIaJUkTJ6IS2ml8UYa40KAi/6XzhKnI=; b=gYI/y+G95VumA8SD
	/R59cVJHGOIt5pSimIFypsAqavIeXQaZcfb3WjkwbUJYNFoo8aH/QBp7uGVD3eas
	Lr0atSwt6c7aq+ikROGmESkAzTzl0B1g4uTb77HhpcqieTQm0wPBXwPKilg4xTkY
	jKJbM3mLi+mkc48JWb30vOO10hxR9PhSkbP+KDz4UwMdvnwcUOEjVvKfwoAQYkgl
	gPMxOE/72VwvH8eXJKtTUPAapgu/txpGKnhD2UhCN+tCgnfm44W6g9Vf1hZWU5DW
	GhGs2PAeNFj88H/XEA9LXtyNYAR7ScpzMO05COuPAUZcc0NULXwA7b1clvWReCcn
	LCXaKQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq881kk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92b380149c4so247644585a.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724389; x=1783329189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMPTZOeccy6sNIaJUkTJ6IS2ml8UYa40KAi/6XzhKnI=;
        b=kJgj1DCVVbmPCqP4LMcZ0rdDgADrBibxUxDHbCYBJ0LppWZHmEmXMKZ/hr3YzMLya/
         W97HfisiwTq3+RcRIFWNpIUSopGaIx9A/YdzonzqXFlvL8+7oKisfMQaBrNUHIgkBq8S
         y25afi/Rd2lJPxmCBPeW0y1Htn0va8lhvApefSufqvhLkjt+dhwakGIaK3Wh0dWEE2QZ
         h5FsDtoUa5jyQ5XCZy7bStZiF/7gWtQyIAzYyF+YoBV0lkDL0o1R4Jq1y2yRKt3MTGy+
         Np3PBHztV+xzMIr8B0Z+arzA0UgCtnG1pK9uwhe5KWPXgPwj+R6cKXqcEgc5mJg7jnYq
         7/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724389; x=1783329189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NMPTZOeccy6sNIaJUkTJ6IS2ml8UYa40KAi/6XzhKnI=;
        b=ipUFD8SFTO7NQmXcqO1pwihYCTy3qgjGLJjzT0hSCVTS/sbHAWIkdp09rQHMCgd9tC
         IcTLFfqRIXA76wtAZA2uAmyaXfsDbHOEJW6OMFk4a6hgAJGl6qWbfVR4JTnYc81Y0WTn
         K2MF6rUVPhAq5junpsUOrLBhGcaQ1p1KH0a46ZB7fi+hSe+kRTAlBJEtIH5n015SM4Ue
         JJmSE0XaONWNmLcwIPwux8X1tYRie/P6l0DalAHBM9EfBoXEiQO2XrqD9DQHN+STEBVS
         e3cIgknMr+CXS+kEQDCf6yxM2/FprTJGfXS4Mj6nXgHbiOqs+i8RLEiQwxozPtiVFta1
         BhTw==
X-Forwarded-Encrypted: i=1; AFNElJ8ks89IOQbJmiw331CTKGyzpWdsIAhxPKKoYxodVWhLtlugOK6icB+AxXgd3HjvnwYk23nYCUE09A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzarV9m8fxCbm6fQO5z7/9Eo5Kxd20I41kfH0HgkvwIjo5pkEjH
	bRssvO5LlDhzH+IF9A5C/JbtIpPHvdeLHVW4/5A2u9Vhl0gpcIFBWXAT0HXTlNwzwnSn8rUjRLh
	jPsFvbE0D5FleJZfAgTmoWce3EK+M0GVFVWI5QPWgJChgjUwiuQoN1NQ0IlHY3g==
X-Gm-Gg: AfdE7cmp3Ikx/1piBm4JQ8lSMFccvdp//6szCTduFSeSEUybrdDn/M38EHUYlf0DIVB
	oYWn5fAKlY1MULG4CTw9H5LqvQPFudi79WwqPMyhwDOKc8fMs9TdGqppXTNB7Fq67dYk+sUe5K9
	t3raV4FzUXHcOz5zmRMAWBameQvtNAIfuRIII98m/ko+vmzi/oYW/HEy9b3D4IZ479EJhdax4pX
	G7zpnVnnclQKfkhl2fDw4Uf/XpyzCJ+nyv1W1zYMUJ8s8n/tRxLYsXABcrTQZNs9h7t1sF5gfnU
	xCYtx18ZFYTCa/n0gT3brcGLUw/6YJHIoVI3TFY45Mmnn+WxNDevFWl4NAYcyrBzcBIYmVuMRGz
	NIJC/JUvh7yt8x+PqvBrMZp576Y9A8p76sIIofs8Y
X-Received: by 2002:a05:620a:17a0:b0:921:9d7a:ea38 with SMTP id af79cd13be357-92b3e46fe04mr1387197685a.45.1782724388607;
        Mon, 29 Jun 2026 02:13:08 -0700 (PDT)
X-Received: by 2002:a05:620a:17a0:b0:921:9d7a:ea38 with SMTP id af79cd13be357-92b3e46fe04mr1387179685a.45.1782724386772;
        Mon, 29 Jun 2026 02:13:06 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:26 +0200
Subject: [PATCH v2 03/19] driver core: platform: provide
 platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-3-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rUG0oEwArOQI4stC68CYhz65UwovfxaACRw43q5Ey5U=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcJjPh5mDVUknauSD999iEJoQhOldHh2+5sY
 Ww2SlGyFmmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3CQAKCRAFnS7L/zaE
 w+y1D/9MES2KbtS+PRc7JBKv67xJ1ZbKe/n9QDkmQW3Fo3GeBTca3T3dkyrF9AKSM24U+GvjZou
 /krTxMLjjLMEIK62SRmS1xLxWyc/DISbLyTE4c8AUYfVuqTPy48X8A8meGPg7hfWc/Ytl7U/+ZF
 4Bmcnc+qhSS0WdcwRcXJ5r+5q2BohvzW2Hg4yNk44DxQSqgd6xy7d4TlVAG3fUIp+2zCbPXx8ed
 G++O4czOLSbEsEPM2pI/bGPJJkM9C+gjbqN1NdLtds8PfL+Ltr3Mo5cyRY5wmITnuQKrzc2SB6Y
 eXCHjkdukHWRc47AD5Jtd4Bo5YH0p/lHVPY+Y4L6wu7fGGpE9s7k6g02v0N/ZSjgRV2Dwy/YFwv
 8ptXzAdQR1sRag8biXf8XwCe2qpjEt32eLjWBFS/NhEBaIexc2Vlko8t+s/nKh//af4WWWzIK6f
 hBhFvGPMc2xX6Hfhm8xtpnkklUakjwvXa/hHr2ZS2XT9JKTn/uggmbE5kAKCV737iom/G6SvIQ+
 mHSlz08g8XpkXmumGsmvIS5r1YW/yZ7Nr3Jjnz1TpKl/Xw9ZtYTjk8gnDfkRCTryOZiSqWELkGs
 h31XwoK+zijgOwVnaDmYXxrSzbtnAJQxBHMA+AwMll8KTyhe4jcz9NiWNumn+m6m1nP4HPGAhgo
 7evHEDzQbm0hLcg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: NNCQMe48V0Li3Nv-v1DPgBSQD9RFp723
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX4IkfTtxixO0Y
 siOigiSeCKUzCDRbS8qvnjC23J7V+wTLDXpkRdCKJbm0CCzfSNLlKc0HiP3Hm8+rqHMYZhJYzl7
 4+oJsfVAKtSwpJbvviOAYwa4xiC6s8E=
X-Proofpoint-ORIG-GUID: NNCQMe48V0Li3Nv-v1DPgBSQD9RFp723
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a423725 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=7s1i5lxVbzGmBzMXG7QA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX/d7uP0U/ZozE
 90QpzCJM2ASGKzaCO62EXIdkoSscRnXF9PubcZfK9EsKpuGYrdLqrs+tF2amsUDNsEPGx4ymtzY
 UGZqadgytmhuJGKUBJE+Fj9IPm5/TDe456hryGO4TWEZLSDUI0YIpYsZ/Dqqbk6a5eawN5uPxiK
 ZBMjD+n7p4BRF/dVUZxpQMrP1GPNq+DRIvW+kaaQMrNxHOOnhM6dOCibhKyqztKa4rSaBWXqryp
 X+PLMkGSnRA7ihTES7VUkE8iItLZYaCBKyf65zTkjxoH/iQ/ViIHbeCGVGEHZRfzYnZxCbxyM8Z
 SxBfLuaBFn11UR4NcVnPQL/jm6Qfk6t6JmlTCxPNaz+8OCtcC985hBs2v3geG4kxPmrUoJ9cF68
 kd2OrM1pJjRFHMs1R2WKQUi66ywmw7W/b8ySeUN7nj9LkRhZy/xiMtcAuHYjxJQ9tVq7TPoFQIl
 iBiWFbyT1MXS4DkCzEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074

Provide a helper function encapsulating the logic of assigning firmware
nodes to platform devices created with platform_device_alloc(). Make the
kerneldoc state that this is the proper interface for assigning firmware
nodes to dynamically allocated platform devices. This will allow us to
switch to counting the references of the device's firmware nodes in the
future, not only the OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 19 +++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3188d5aba5f90622f821c695049cacda030204fb..6520b70cf3052d683a2ecb1a0dd7227575546ba0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -711,6 +711,25 @@ void platform_device_set_of_node(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 
+/**
+ * platform_device_set_fwnode - assign a firmware node to device
+ * @pdev: platform device to set the node for
+ * @fwnode: new firmware node
+ *
+ * Assign a firmware node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		platform_device_set_of_node(pdev, to_of_node(fwnode));
+	else
+		pdev->dev.fwnode = fwnode;
+}
+EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 870d168aeff8558749eae71723e657ab150ce0be..c463d46b7b9ab6b891df1ca9f0c98608d2bb140f 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -20,6 +20,7 @@ struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
 struct device_node;
+struct fwnode_handle;
 
 struct platform_device {
 	const char	*name;
@@ -265,6 +266,8 @@ extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
+void platform_device_set_fwnode(struct platform_device *pdev,
+				struct fwnode_handle *fwnode);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EFD43846D
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342374; cv=none; b=Jf4c+5kzHDcmMT38EXanbKjzpMJUva5beFLbB37VcDbKbHZk31YZgm7IGyS7lKdL5ISHCMnMo6L0BcSAmxNA0DDOsCnPzMWNuu2senW3T4Xehw7HcylcMYLYhWOoLt2qNgpkWS8cljKvBk6HmYSFFggCA33WhBLA+Dkihb3ElBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342374; c=relaxed/simple;
	bh=NdHbJPjvsu2u7F3hdYrPvFRlBpPy98KniXg8xIhSKCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxmB3tl2gXUEh9Gzzc+3/F8J1/yFgjQvpxUFpgqUc0vI2wDsCA6BHBKtwhBCD3Yygotj88E/9iPSjwBdYQexbHswgOb6okG/+iiV4vPPEzrH3s+bZlds9lQJ0sNNS6+UJauzM8YBtz0HSma9swAr4AFcfzAzpuyZUF4+Ex6o9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUx5BzmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/xxKhTt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUx5BzmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/xxKhTt"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxFnu387079
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 12:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=; b=GUx5BzmGdeI3Evy4
	TAdA/IjbYevjVSOOVEM/jHBANLO/MzvCLIDPyIiN9HGOV3lzrtsxDYh2CWy24aEK
	e5pwxDyUvASqAikj67tpYkJEHSqpVZx3/eXDlvj8KZ4YJmq04TuS4yBAg4Qm/eRM
	ZEODUiB8+by0n15kbnlqjOE9269w5Ym9DK32zJnFCj0bqmMBm70riK2KGmEZoCu8
	JkOkwNLn1fuC88jPUs0mvgPD+1NSV/SEeU+G8k2TrSp+bpuv33JoNGSTFOPm26k0
	myU/VmbL6eCNFjIuinle8aMsQaDP1VEBKYV0quH0XkvrWv1IekNPOEs/A387VrsR
	n2AyQg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0mp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 12:45:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e63df032bso328951885a.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341933; x=1783946733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=;
        b=W/xxKhTtQrNrmSVK8gPzwLzTHOiTtjTkQq01dH1LjU3+tAB2N2sKjqpienwhBepvqf
         rgljMNHFobpfTwrVn0OvpdIuCTupp+MoRMuafPTgGOdii/THENeSNlslXXvpt87P+9/y
         zeeZyrwUuUDBPAX4XjZxHzXSDL13CFg0By6Ts/u17xnxxZcW2vAPZnuoHq5uYmu1NEnm
         ADGJLR6ACphQdCqwU7RXp9NRH1T4SO0zgmkdDmr96UYHm4R7yn88P9Bc/U/361FIZXKi
         cxDKgNlWuWTTnF69SeTRUOFryW7fVCi0URnEBBo3DWWRQEh6xcTQc1ifmcUG8etXd/RJ
         ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341933; x=1783946733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=;
        b=Xb14Prl9H6hoXgN23CCvvC08BzE/ISfU6Jm6PEKEk9/B7lEEjEq8KNZJk+n1wiXaBT
         hKfNvm9N5OPZXJH+aDGlOq30sMxmqnsrVrolXklXmSr1bS126MqQMrlghrmjsZJwIpp2
         4865MlnpQ+3Qlt08eeQVSTVrgtzvwbB4mkkXi7uw1uzVehUhwbz1uqlqc2mthbMR40t8
         xlHDzusilCgqItMo4VeWoROMPDA4pPnpbVlgY7ld4HroT0A0bwt7O54nFHkgnSUR+WMS
         epzFx+XJel1SH0LezFWHfwScL7ZYa/NPPjDd+R3q5ihlVc6Qc2JQj6hhpR/iqI6h5ZUe
         IbvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIpuZ5QB3vmPztcEMJgDhIqEiLGanW3KEEg8yUQDndtYdyP8UN7/FVxN9YpN6hHpxATnb0ldes2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YylvpSggLtusO7NFIv0euQiUrD3+ooiKoQGsvTS6XKjzOFHrvXt
	6S9wZ0R4kpycG1aE3/XD/PkUELvD/sWwNTu3eEOkWYKFkhtTwSQIbM4U0lE4E6gl5qmRNilmtfH
	2judQ00bks6hUJdGL+h9vPu164uPR9InNb0JfJjdDnBJaGoOt4/eqwHWMaitiKg==
X-Gm-Gg: AfdE7cmoFMSb+z6R8GaYOIVOxYXcyYwp2gaAIWOIICcRVXtccNKPtwMOf0XYwUPfZrA
	9xuCfRA58YVyGOgHv6ErOH3BxX87la/tgELxrKHLQcZ20q2lMyuv2LGElv4YXjXYSyMDvsF/3r1
	MZBEUW6Mp7qdRdWoD8cOqXYpuOrAjJHKOwQc2S9ihDupqloRzgiYQSjWSs9o1lZwItX5qn5lVur
	cBqJ9dqSyNLV9vhM82zQMPwPut34I7LK3HIbqLtrg+2nQ8i1Pj4uN9wXpUG0o0Bvtfv2E7+0eM3
	Se+3sSJ2tUVQgyo6kqoPV4/AFc5hDch/GrEbMGmeSxKZD9sXxAduGa26SjIwSqodyiFfLt6Ow7E
	1lsFD3ZPPl67e97j8jGFHKX5fZ8svrtSe2AiKg4Ah
X-Received: by 2002:a05:620a:630a:20b0:915:9eb1:f08a with SMTP id af79cd13be357-92e9c9bae7bmr762473085a.18.1783341933211;
        Mon, 06 Jul 2026 05:45:33 -0700 (PDT)
X-Received: by 2002:a05:620a:630a:20b0:915:9eb1:f08a with SMTP id af79cd13be357-92e9c9bae7bmr762466885a.18.1783341932688;
        Mon, 06 Jul 2026 05:45:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:26 +0200
Subject: [PATCH v3 14/20] net: mv643xx: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-14-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NdHbJPjvsu2u7F3hdYrPvFRlBpPy98KniXg8xIhSKCg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M6kp8yOiB9vvJ5zjdHbWe6Po7/EnS4ga+ev
 hCyTVpoxO+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOgAKCRAFnS7L/zaE
 ww7dD/0amg46FTyYgYW8LYZgcSVagN2XNs/hYCpCDsj0WIQWByz3JPvcwF61FhdVtvUFuUYV+eg
 X7P9kb9yoTHoN1zMJCWDP0kdPaf12F5JdaMy+qsgjzl2P2MgGwuqQQML8cdGlCndeIvBfZzo7nO
 9qijrM7bVX71vT/EpqOJHbzX5gMZmLrDW9GuxO5m4CIjxHImLkOcRCikfjxnV8hepAxrK1AMx6R
 Mc6flJ2X5DdAi7Cru+Q+uLRr4o4JKNA7AxDT5X6V7Ns88ytfrTL5oV6D2eulc/QkqAYGEtknJw6
 chwScCFvjEXtvO9lO7ahl3qlNLbLc+YlVO1T4bKSi285G+axZpIEKet3oauOfTFCM/saAVEif4M
 KuvsN9jfwcJ0xXMRvreW//zyuhY8LNwY3Qn55M1FVhdMhR15xLP9t3gOyKyxu8id1cdmortkJpD
 qrpspj/OgEujquTmIu1nsViAjjB0bI1BWn7odOKePTyRWnujpCUPRgGD9GE6y5D1J3d2h2us/s3
 C+UML2ty3Ar0TmOdfF8nD81xCWgHBwz96BBI0ipfe0fz1VLXXim6Z24Z8Tpg6aFGf6ilHkampD5
 kfVoicCCwzU+89dyn7GdpnULRhUez+rKMA82vKy1zopgY/6h3TvBwUmDbFlk6k9PYM2h/XaSG9p
 jy0y60D4DWCJRkg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX0Dx/dO0dsUU+
 SYP2VZtNN6IBznAJOUVAYXRADK407HvoG1HbVzMO20hZtIMgoyTy46EmuTGzBMBM5LWFvOXuSXn
 rSVFza2xId2H5794Gp5apyw/LPwQ4JnY+LwGV6PJ5lR7dChlVfiGQrp/wnGJaV4yE7G+M42/4jN
 v85F/XFSakhjH4YLZOnCZxjZrmP9iDmv2lXEuI4TLaw/TQXMYycXpsfsYdaWsrmPw7SAIXmYPAK
 UmTxDfauJrxqgvWPKp47eKPX/ELpV0DR4F1uCcWr1gqaPRI26nwyI9jUfySFE0AhxpqKvTvW0LZ
 q5JHItAv2XqqXJ4n/vXpZsVUwg616kmqv8j1+ZC8M3R75AKrZHHLLatdZtieIqvvAzx349iaygm
 nSGSTHioXQFNUbNL4uOIeesI3X1fW+c1c2FKYSTxvnbnL4aEErIQEYI1Lh+czjwea6jHLY4/ChB
 8uOD7pcL0h8PXgpoWiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXyoAGh+zMsLHz
 ZcE759Exxm2tk/x2cNoxf+iruNKdPMh/Jr6pbw9L1ijN1m3vgFUVl/jkykXRWL7HEqcAaBofPrv
 qiyhF+Pr2M/OCFOwBb8AtJKNltgmt7I=
X-Proofpoint-GUID: hzUWz-6P18sMM6QgOdj0hqEPIWZeLu1B
X-Proofpoint-ORIG-GUID: hzUWz-6P18sMM6QgOdj0hqEPIWZeLu1B
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4ba36e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=KA_NOx0aAURzDPfFvPsA:9 a=QEXdDO2ut3YA:10
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

Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


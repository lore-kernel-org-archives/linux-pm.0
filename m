Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074503D16E4
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352699; cv=none; b=DZiUo9EZjMPQS9JURXAxEfI0i4nL0Vv0zlZXrj8HMWA1Uarw/7CROMSBjG0EuXxAX1sUn5oUQdEnK9tnXIG8CmqA40bI2yNdC7VMIwM3Gyss+mxARr5SjCYLUNF7p2w2depAzWoO5P6pWimXmQPmfVIBxO0sXhPzEMU4SRQJzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352699; c=relaxed/simple;
	bh=BQp3BJQMi/G+gQE50h68jsUUyT+B8hxHS7036l8NXls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTKzG8PSBM3u2b8QWlccXa9HwfLdU3jm5kYpGbJPKE740pyMiEASk+tElYgl3X5DnH54+8guTVCLh4HRqHDMlQ7k5CMtSjSJCmoDjszwOhFokVz/xp+pgdBffdhVKe+4YBD8vRkllJ7L8HtxFY4qQPVvDR/Oos7dzizLAe3R4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETMv0UEz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Otkh8bus; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETMv0UEz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Otkh8bus"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6FMAS2157616
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jQm8FjEEV1MO6cIIhFWA2fcDzddol+KMBCUaCkXjjmU=; b=ETMv0UEzGin18yIO
	zOHyP7x8iY+OlWlx9nKmm444bzrPOPxKwh3b2E+AZUBPwvrz34RnxbQiemMT1XNT
	Nzaw5W04hcIM3aShKSaFmTXczPUAy1RwkVkuZEhrNUeN0B0utS61B7jMcxDL1MYi
	dgZ7uJC6QGv2JrzBWVq0ThUYemMcLrNROllJ0Td/q1IjYV23CRsACtchry7AwdpC
	99JE9KQ7duYxULEWMIr5Sw76zn4qf+i8X/kH6sFyOLBk49gRvkPlBf9UP1qGCU2a
	QEyls5Pg9lt1s+gyw3fKGWsm6VpskmbS+g6c7huGknaUwlmF4lft0+EyxIMpScFp
	7tiZLA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma4292b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:38:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51650041428so128127371cf.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352687; x=1779957487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQm8FjEEV1MO6cIIhFWA2fcDzddol+KMBCUaCkXjjmU=;
        b=Otkh8buszhLUi4Y4tevtGlI8dYdHpOpe2GwRzAwngpsouynbea3UAef4NoMB3DVpXV
         QmOMmnAVwgOcsYnynd4pVsNy7GWDp4GjWUswTnovmggfvvFLW0i2l10B4yn625Ers8tB
         0WIImoJYIe+3cbTPQfzecCX9bQGdjdVG7fVYBVI5RA6sMFhNfkvYJNz/j5h6FEc/teN4
         h4h94V9UUhMKh6P1jc5i4z9lBye+0jgF9p1ZYEsUkmpzdD2riVRZcxUUE22M11cuaLHd
         jkth4y7+ygn9ER66cQAuHn+n975iEJmsGG9sNPHliT3tExoujSt9JK4TLSHaG/351Sn+
         cQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352687; x=1779957487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jQm8FjEEV1MO6cIIhFWA2fcDzddol+KMBCUaCkXjjmU=;
        b=gWTmk3RqLluLtv1BzlvucljhTJFL4L1Vgz+RZYzmW8Cd7RntYyIH4grdF8/U48gDbP
         7JZadJL1+8XZM0L3WiOt9lU8dm+RV53ed2GCVIq5kDSRQfUe2xjMdDYWpCXvgMGoCQ2N
         heI3Wlw1JM/4PIuvJ/evaIO6pCVVoJLizEWGuWsQW0I1qJbSAf4WyXUo5Yq377ZUg71z
         7NDgP6xDrIR5r4VgbbAzKrM7CWFSma27tqI+9C5KYlafDPAd0DpKxbRsow8jRP0qsdgJ
         1h5LQ7CYY6+kKiHN/UePhlpD5wA5c+xl9GsHP6n2Xx0UDkbtxQXGkhdwC9n6cd9yX/80
         LRrA==
X-Forwarded-Encrypted: i=1; AFNElJ/zsl+8qsDavR6gA4cp0AimOTDvgrf1WkU+wV6US0e7NlNIeZQ4yE2R8sbC/8K95gU1IUIq7qmUQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VDmkMZeYLRypURWS629t6UqpLn+KEbxB8Q5RI3a+zXoWN5On
	g9r8temyJS4JHmivA8ncnC2KgaEVea3DQz9FZMT3u/0WM64iPpNDIkXdoaZyGHW3LVEsnYw+1ym
	usjz/6OJ4pnf5e7HLGrLZ8xB7uBiYNPQocD67q3mCyRnbXpHOtZ6R1/iU78XWxQ==
X-Gm-Gg: Acq92OH/nfWnl5EzrNUGR8A5pPF/uNinalBlxDEVMj9v/CKztBOvj08uGNmQ3PiUdTy
	7WoT54ezNIFOt+tfw4MiE+tG0j0kdL6jPKV0zBI1DawNSVm0A3MJ9wN1VpdgV3ykySxV4vbxhhG
	j92zo7k6D3hA7/agSmF0hNAh+1gM30mcJYFex9k/j3FIZmGTsL6W9ZfGUoqh419vqPQ9jHsEVS6
	CwKXqhZZjamoqUubimdTOgIX259FanVB/VuwksHZ1DGStmwMvnm5wh55GSOwhIcCzMU4OKqhKlR
	BPz12RoDTQK3jBjIjIbYyr8nLW4/rlPdn3THcVgJXrTACFvq+VC6fycAqsx7vDvrr8hgowWuRkK
	eZ7gdZLTFabD/Di3yvQjYrYIOmEueQfYwaA0EGcwTz3dXdlbDwd0=
X-Received: by 2002:a05:622a:5986:b0:50f:be4f:465b with SMTP id d75a77b69052e-516c55a0cb2mr25069581cf.33.1779352686684;
        Thu, 21 May 2026 01:38:06 -0700 (PDT)
X-Received: by 2002:a05:622a:5986:b0:50f:be4f:465b with SMTP id d75a77b69052e-516c55a0cb2mr25068921cf.33.1779352686206;
        Thu, 21 May 2026 01:38:06 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:38:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:43 +0200
Subject: [PATCH 20/23] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=919;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=BQp3BJQMi/G+gQE50h68jsUUyT+B8hxHS7036l8NXls=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQtJH8QMbFPV1dWqzeHalCAZ+RpZK0MKHRiJ
 e2Dnj28kPiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7ELQAKCRAFnS7L/zaE
 w4sFD/43Yx1hMHGpbYfxWKnFqlN/WdgLuFdPU6cY8Np++YZo2rYf3uPGYaOPteE7Q4cL5RynKN9
 tR0Q5pOUhbL/jLv9XdF/FeTDp2Wtb+TtYWM4RNYXfZiLtOcIW1O1RcscMBMDg4SKDXrB9nTsFlJ
 Ets8a398cI+pUsB6ZfjOT2KSJcdnUmMi+G9PftPgIVhNrFawhhoQeIPbZjqlS5xIYc7aoup8q/F
 cHF+pVR8vRKDG1fnQKF7uZujTEhgvA55j3FSZTVCZkxCsBX0/njfg8jh+9GfGikqXOJtpFtrqIB
 YRP/K01aDpXYz4urERxYGVxMrwzGzHwEGh2xWQFo4GyeVir0TahMIMPZogHAdeXd2fwtP0+Lurc
 oF92WGf2yxlTJfSUv88Hf+XvE8g1GANQ6YH6zrRxwkbaYi1lAW7i6pVPyAZsYPHERSHgjP+9t/+
 UJeBVAVjRDPH5bZtRjJSdOzNtuBlEvMbQhzXOo91V7kuzqQjqauwM0s6wHQTd/P0JuKRyXzkBbZ
 2WgOWEzaNqEGJyVsjDv9LxSCs8TCSw1CnD1brSHk6LTZZWG6G7GUcE6KkvtVssqWUr1hner+mI+
 /oFzTOsTFEXIwdUHSm5mfY+fzKnlCN4a0GHwdRITxW8thNpsdc6uikexiFWnwMcZhAW6Q1lW8wp
 aEsUt3Z9Z/xE1VA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ec46f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: n2NN7OkPCCrDAfeYJd36y2VoUJo5msvZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX0MTyy4mZIzNZ
 0lQXLCzPrC31PiXa5A8tG6bovqd0SDBq7VFkH5jLri/c2rXHkVCDkr+lNZ1MNmklliRcJgyNtd3
 1WTlYaojGCglMpVqaPd2xtFEXuVfz/FSY3TPQ+qlPvtlMfa5/sw+wcI+1NLBAdGVwEX2v4md28S
 3T8hkjo/dVc/wqaGU/JGakTAc03+MVm5M6/PnXvkrP7m+fGE8+fAUAwyK5HqDbXfRYe/3/amC3e
 AM1oa6LJ+rpcPC9Aaj+us4/ROi5t1fkrkugZnTXEx+06MuzDQgxdeFXoe0DVp5KBZQAWhtQdgy4
 jCZZ8vt412Ha5t9R2Rf4jzrr5dQE4NL95YpsHvLpeaxWHDDPtIQO8HgmbXjjlLddFLylHjp0txQ
 LBeMJ6aJC8zLXR3OSHILvgNuMh5EJGmcjDAD5XOL2qoQOdfu7i91+numv+ROJQbQ+3W/rePWRgt
 irpOmpbUuOVZH7wRYDg==
X-Proofpoint-ORIG-GUID: n2NN7OkPCCrDAfeYJd36y2VoUJo5msvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 7cfabb04a4fb80c6db56ccb430d290dbac61b716..5dd415f42fe0dd026e8a1cc162357e42ba8ceaec 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -888,7 +888,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
-	device_set_of_node_from_dev(&pdev->dev, dev);
+	platform_device_set_of_node_from_dev(pdev, dev);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)

-- 
2.47.3


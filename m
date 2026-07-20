Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAF43D4127
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539536; cv=none; b=UAb4+OSf3W7tHyj7ypTkHZP8Xg75K3yRldvxgT7Bp4uhR8pV/UKFsVlYn5PJXir5FrzS7C7NMyLV3GhDxdmci0AM514YabcF8K1Z3XIRktp4Y3gXr4mCnv56iRqUxqBDAUCr6XZJGzzPrsbjbqekU4vDsw+kGQ67RPOuUqw2yEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539536; c=relaxed/simple;
	bh=ZrUS/NnenvYCjb5pfCsn//onD0rmCvG2RI/jvr1V/hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FO9HKhxVUaMUYogP12jx9VMfiYGlCtHYyibRTC0l9SQLzS4qnrP0YFfQ3eQRznptpxy6AqFY34cvchV4QTQfrE2ovDSiKkUwaBjlPphQiy7CPkj32Oq3lZudbWYl9r3vzoqv+ceKDBdjg2McyVEVAR2nHS2aNNhl2sW6Wl/lxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XmLYFkPG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HvZOVx7p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XmLYFkPG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HvZOVx7p"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7rfSk2979946
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=; b=XmLYFkPGPsf1JkR3
	tHbXt/iv/+pOUgfX70ac9uIwEItjtd1LHmJy7mC1eSZFKYGF3Cq9fTHXUnzeGBmz
	/VpnGG8HVXTgFzokDnuIWnp/4QgY+Lym7qVOeGkqccLklVlAvdxRSc186WX967Os
	nQv3ErHC2dMMJv5Y18ebao6fJZe7c/O4EuVhqxjviEx1Y+Zv/YXuatd4CKMqt2MQ
	waHnfeTeuRLbF+uuzNmLuxLdE/BMUGw0uGWEbTBv/Tz1bdFMXvKyLy6gLTnuGrFx
	ua8/ok2FwFRPlkBqSWKOQDF82DjrDoF3J/6KMDzmBtC9ZBbMNao9J8UuO5FITvZw
	mJTiwg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg0enr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c110a3b6aso105723661cf.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539531; x=1785144331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=;
        b=HvZOVx7pes9UMuDypSL94vKLOcifMT7PRRfgJzGml6/Gb42nLfkCXAhbBNeILRP8hB
         9GBVNjAh2YbnXtLSH0Sq5u2LZabDDbvtjwfeHc1mmKdkI/wmLi5sGHqEb0yzOcSyaJLp
         V+pQjPymdf4Qjj3cRKlt4gHya2bxIo9IHLJC6ouZ5LZpeKwPLCBANHAGDhVG6eHbPzvn
         8PxuaW+X1Mr4wrTE+vRwlvTymglpsF+vQHyKR2Bsr0YjDn8cUQ+K1QzwLLWLDy6us8Uk
         8p24HjAkjcdT+sXgfAP9nIiA1yCeT2xUNr/NvdpQPxiBLfmZJYTJUgq62hfiyZZvcirX
         gRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539531; x=1785144331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=;
        b=eA4s+tAEUmKvZKLSia3prMbjsFRC1zOc94kBmdb0oqLIO0g2dyP631lSd43pFzK+y7
         7hfAC5IDZfJIkGUDU115pZ4WOK79+HQGBWsm+0QbM952UpYy+uurTIRmLDFeLtgUBdNu
         of9AkgV7wqSpg0bL6yK3JymbjFO2I2ngqrBdRk5k3yrFHWUOANZQOHQUYLiimdwZm5eX
         px+0jMUK8ewJyf5hzTWbW7KFaiczU1gcd8tMfArlZLgntOewtqX6YVsAzRMjgZcaahjY
         vfbACpSV8BROt8Aj2rEX6XsstpXXerEUoWhqS65ONj8wmIR2+kpbT4QDKp0lzeZRwjFL
         OuVA==
X-Forwarded-Encrypted: i=1; AHgh+RqgiDCPf7afLWMgnO16TRTXfW8qNL3c65fIUTy3OhNNtow+WK8Uy8B5Mon1mLr7tlYEuYMXjoa9Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUO/bheqgK2UZc7nWZUZcGvmCJKqZWRkfMzf7kX9yO6qvRlES
	/dsFAiOlt5gZtftLl0SWnUCcghH9Yrx/6q4cmjRwuO8AAiS4ItFxHtPYUl1OOnC2HKE7//+UARy
	Mkbbcje6lXfIVKi0Ieqx0ZneIXpEt18ibFjlw3OwwVgOxOPUAfyH98+0F/ffcfA==
X-Gm-Gg: AfdE7ck6R7Sz4JDFLDFqkJaTReTP1fPkTUeFM6c7qzd0v3y2rJ4SuwV6yU4BWCkZcrz
	MuM9sFDkLoTZ9c7lPSBKvXbQ3+bNUlOuKcALOnUn//jqn8F76G2GF+p8qaCcmeDEjq2sLn3Zykc
	Rl8wgHrsEQmdhrp92Twy/Sr0KfVA7wRREmgfdVmv1+UxVMK/huh5FtSBpHXI3YHKYTA28UJdbba
	wV9Mc/ySVd04E6XbgIMXRETat9ZeOpJqevS+yEloguBP4qVnhiUHK65mXsecWsHgOTk6Tbk3Kmy
	lKMuGmFt4q74GrLnaCvodVzHMoDeNuEHqzPPgS0daTuEqovlydUlnlGwA04T68p6NrpR02NyuNN
	oTvzRYgvZS0HEUNNlcEaedazOYRYUjQ==
X-Received: by 2002:a05:622a:13:b0:51c:12c3:efe1 with SMTP id d75a77b69052e-5213f66b7bamr122491441cf.42.1784539531254;
        Mon, 20 Jul 2026 02:25:31 -0700 (PDT)
X-Received: by 2002:a05:622a:13:b0:51c:12c3:efe1 with SMTP id d75a77b69052e-5213f66b7bamr122491051cf.42.1784539530849;
        Mon, 20 Jul 2026 02:25:30 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:29 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:49 +0200
Subject: [PATCH 2/8] i2c: pxa-pci: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZrUS/NnenvYCjb5pfCsn//onD0rmCvG2RI/jvr1V/hI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel5RRr6FDYHe7Jyyb5uYqdruVF1jkNXdGz9x
 /SmPjU62fiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3peQAKCRAFnS7L/zaE
 w4UfD/4hGqcnN4YJaIbxls3DUyM4NsWC4IFRTcQ2thdYEI/wUb4fhVe+TyZ7PrPWrKx17P3wNAc
 maYIRBGRspgJFSLrKzyw/l5OMrFyyVo5Z/pJ7Dk0uXIabGxiELqzVXgd1WoxDuuTW4tgZJQQsNz
 aya2utaREZyKIpaxj3Roa5oFmv65+HJQAYnFL4K5NgfQAiEczNPuLe2ohktx4SzYNC2lv9sJmm/
 DHA4nfXFpGMYRwQ535aVbihSHmr1VdH2kZH3C+G/WUXDG2zcXQbEDRHBEOhpmLhdbvqSBENsqcX
 fC6rJWBiX+4Se5NDr4QwWa19rVDA7zPjcdlpN9JcNkqhFi9xrmkRXzjDUdQKm8EIVdHu3coyLeE
 dfcxPzHCmIAHb1itlp1OLHnZ9DJj87OFgfHqY29oOKKtNW95J+QJtOCwUlVFNwHyuCYraWwRy+a
 812PKPLgPzRsVfXkL/L7lzI/tunY/GnBcfOwpqKIihhVnA7CJuOZOAOJf3NLzzZPf5XVTB5OJ1y
 Sm73dsM4snyIEvT5gwzRjiYfEdW9H3342ztO571XE3VibNZU1J0bAZ7SEJoJH5prDBaV/jdLz+3
 RWkWUsdJASZAhP7p9ua3RxQqAYNsUMW6PQtT0H5gB8zcpf6TwgWLDgOPI+3GVCrq/4qo8tigfGI
 atX2+rRaKYcbS+Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXzTNcS1dJ3SUz
 5yEaswbFdEIc8YdWExOQ2koy2Gtf89+A4mH4kz7Xpxgkclt+hHvnehGeU+Jmy+Ej/jmw04iH9P7
 38CwSjUMUjU84vj5yDx1ZmMCiip3aIs=
X-Proofpoint-GUID: xRnFus6G0ACUWeopDxem_EjQ_FdPEit3
X-Proofpoint-ORIG-GUID: xRnFus6G0ACUWeopDxem_EjQ_FdPEit3
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5de98c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Dy7njVIJoQnLZkscNskA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXx9FK8kRSvoNM
 9W9FmVz73UEDBQQq8HAfoK7EFs/piv/VztW4JMkwmi5Q62pSZhhGiucc5LVK9He37X0oLD4+pxO
 5FM6+ndCD1T2Q41YC+b6elBWVK2u4Ud9jbfHnYdWMlXUI4gSCmstY8O5wjimKhHdZy6MLBnDzco
 LJhikw+gqOHH12W34gr/UtuCd6Zi9uPldSqx8NWnV7RcLbd4PuKH1EHp3BijNVcBPNxwF7UDwlb
 BwraOzgCRtprI87ymLOMOmfzGfp1OfCbuev9OKqjV6xBwDzP1r9FiHxPqj1JSCcOQM6MfuCHOlJ
 /axXBxoqAKF+Ex2nCvLbESdB1iuk4r2xoYFBOWiM9Fjam/46TQyL38QaeCUyrZE+ZfSjeDTZxUa
 aKt0FTcA7yD4LvB53dLcA+EFKDlvdwJ2pufl/Eb4TdFDVntor0msqcTO0CGWIu815o/z0Q2uE/h
 2v2PMnSgCQZGWwhwRxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-pxa-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 92a0647f08c69f841ca99caca757c1728b3f6fce..58532cf9f06d43a0f2173b962eb498c9e4bb81d0 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -77,7 +77,7 @@ static struct platform_device *add_i2c_device(struct pci_dev *dev, int bar)
 	}
 	pdev->dev.parent = &dev->dev;
 
-	platform_device_set_of_node(pdev, child);
+	platform_device_set_fwnode(pdev, of_fwnode_handle(child));
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret)

-- 
2.47.3


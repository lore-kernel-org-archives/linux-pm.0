Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA03BD64A
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539529; cv=none; b=t+lKOVDGDkuEU4OYQ45f0DD4d/cB6ltYyuDnbVZxUi3NQTimx52/7xvWXbN+/PhF5p20IA2G8eYeCRWA/yGsM0IhzFXRr0oDV5UW19r3pTlc6bKeV9KfYHY0yHfvx1kFFmiVh6oDlzW+GjUFePMv7ytL8HnbWwZ6vW1fO8V96/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539529; c=relaxed/simple;
	bh=y+3A5/VLvAorU5dstuzQ20g0vs1cTbJrLg8xUVeJe9k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FCEUrOOgl0qHXx77lL+hrzQXzxbqPlr/Dbzrg8fIc98vNssKkRv2arNfLdfDFuKkCgTmHRRG3xkGnxZoiN772CFkRXy+GG/0uqBdPH6mFYYPdA7kQg0MJEnZM8DiiGS7Pc2+8IOQnS0qZhXC7khonH6GqBkdVO+/gltk6iB2XdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhycOz9Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XI8iLpoD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhycOz9Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XI8iLpoD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7Yhbh2045267
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LemIgIdjk5eM3AXQKute2f
	Wvk4y9PhORePmOHO5weFo=; b=RhycOz9ZM0sBTG+JXF14kS7s/iqaTNli8PXQKJ
	C72kD/luWZS45Go3+a4DbMmI4SDf2il2GgK4FwpqIcWEAz55lViHRkySGBPuPOsY
	IUxnfqfr12rU5+egoIxWfhubYRyJ/AMPdL2Lz70pptI5AwygrnUPRzfl50jRkev+
	lOhWY1hAqSk8fhT3+/pogMIioSoDehy8uDJTmwuGXFf9Pu/cJ6a8gZpATQETlZL+
	z5xtt8+URVfsZWGAdcCwZmV491HqQxz1dKgxV5ERPyXQCO5Vtdz6uxI7zUwgPL+5
	y57TYAujaast9gunXtb+8OzA0tHevb0p1pH9eJ1FO99Kbnwg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcggr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso204897811cf.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539525; x=1785144325; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LemIgIdjk5eM3AXQKute2fWvk4y9PhORePmOHO5weFo=;
        b=XI8iLpoDmnkTWQu/7NE42t9Lx2Va4KmDmk0ZKfn8aCGkJIgNL6QhK9/hgeC/oFJVSH
         b4kIGSdSW+3NFKhqbjEcmJCjoaC9yHsq2MXXXoPfhS/wP8w05TiD90Um4H64h0M8Q/S+
         n++mGXKWGAbHoNzigg1IjYDhi2f3MXHZAaA82IhGXn1DBlvW6jJodZs/WquxYsT7ajE/
         lEaseweS8M13ZlTG72WuBiPcgSV+sk6WSJLHPdImlA6KpVtPNPYV9gvv5vY16Osk/SJ7
         maqry4H9G+AnV6+Sy29M+a/psWIcobZ0/HnRyRwugQA3DnMRRkFtNeMfvWitTP10iHcs
         6TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539525; x=1785144325;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LemIgIdjk5eM3AXQKute2fWvk4y9PhORePmOHO5weFo=;
        b=j5GcFnFZTk0lqBNmlTvtnTGQC3/9cWajeiMv7XEG66t8tZH1Lv8D8Jm10ZWZVuvg4O
         A783z4I+IYvQJn2CXwh+zeUfaHOIcIfLO7pKLNQ4n2ugAtJfEm1RXJi8u5wYk49WctDU
         RiBzbpgJU9ykQRK4DJVgLMIQGd1u2cAoqf9rjRvzhmbfH+braztIBMcqivv6io0ToKhA
         jjn0iM9hkQH+MsL+Syn5K/nbanTzzi4gpnXHdIwHlj/V5vqdmKxCcqI7HH8OBGGuuBFa
         0TrTjbl2r5c3uiz46bsjzLm+ZrGGiXL8t853fLboXwmEoS/SBGeN8cTWQDdet1q1u2ra
         96rw==
X-Forwarded-Encrypted: i=1; AHgh+RrQUWgYhBxK8i5MkbryMMjpuU3hQyVRf/aQffZvCGnaPr+RctyLRzjiauFwCxVdzMzIYgr3m13k1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwixqKa7Gjhh+53+o+YJ9jczEXMlAGXq4rFcEmj8mTXVPbaF8Wo
	ia3PpiuHzIQvtXQZBLydHTwc4fkeELB9F+8V5MOHAMovhfqFJozlKdP0N4tYivD+qtVqGhu9bdV
	fuPxtVmxDnD6EZMNiUrtib+rXytFgmr0Li9alf75P1iusj/xi8q9iE8LytDdY5Q==
X-Gm-Gg: AfdE7ck0Su4/KU+OKkM/kaRjE6AiKMfgjxNW5Xtmq9hFl+a5UprMYW+zkNwb4XR7VGv
	gSKFSkKOqNB/sf9UZGA5OPQJmCnYO5nWOyHy44CJ6tRbtQhuvTZuYYxBXq/00BBhUk/X+im7TF3
	7sMEwdr80hulCtaCMpdHC22l47HQKH5RWeh7QeiqXIN5RjeNBi1LhI7BIzJYINYu1/5Q4UrW1Nh
	zGuu0fY2zD5TFFX7JWUfi/9dxowvjcHBAbqXiKeQGberRuZVVv4SjbktSE6d63O3eQ5RVTFDrUR
	sak6D073dort2XRn/x4j4XdiSwfQP3T2tscF4QsbDyS9fD1bF1yyo/Dw0TD54YOtQmxyoLGLxm4
	7dP1qnNMRcPU3krQonvUfwjtin2lviA==
X-Received: by 2002:ac8:7f8f:0:b0:517:8011:3a4b with SMTP id d75a77b69052e-5213c7e50cdmr116346881cf.21.1784539524938;
        Mon, 20 Jul 2026 02:25:24 -0700 (PDT)
X-Received: by 2002:ac8:7f8f:0:b0:517:8011:3a4b with SMTP id d75a77b69052e-5213c7e50cdmr116346691cf.21.1784539524509;
        Mon, 20 Jul 2026 02:25:24 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/8] driver core: prefer platform_device_set_fwnode()
Date: Mon, 20 Jul 2026 11:24:47 +0200
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF/pXWoC/x2NwQqDMBBEf0X23IUYaVP9leJBzKTdSyJZUUH8d
 9PAXN48mDlJkQVKQ3NSxiYqKRZoHw3Nvyl+weILkzX2ZZw1vHhsrFg57DH5oqOumDyn8E+t8O4
 wo3Pt0/RUhpaMIEc9+YzXdQP5bB3HdAAAAA==
X-Change-ID: 20260720-pdev-set-fwnode-instead-of-of-node-e83ece371509
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=y+3A5/VLvAorU5dstuzQ20g0vs1cTbJrLg8xUVeJe9k=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXelzKWZE6870gD3WWYpCRNtH/x/7TnWJA+MWI
 +18iI+ok1yJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pcwAKCRAFnS7L/zaE
 wwVFEAC39JKLu5OuBinyDLYXI20Qwbj5iJgddspKDBrIHwzbE8GYvwxR4tbccRRa382Fmzdct8y
 EzujI9HvhuEvuRGbzYN7nXKISM2Di8/vbjW+fYvgUH0d61sNqxWxNpyhA+RjY+bO2ovYCYgitp4
 KAuedXV8aifMRqUntG8OUyDK7/pRU/OYeBjdQqP86+KfJROziANbRE6R13AsREnvOsOpXp5rxyf
 Nt6Hq0D2M1mUJWKYKcqaBHXnY9HMNXXOzc+1UK6ohzMTFcE+JjZXbkZpOBfkNqimGJXIfXglvMO
 vQyEV1EzrURqAEx+qx4RAqS1LAMEjW6NWVmfKZwViSO4RFnifrncA74OhKxw4imku2YwssQ1ZAT
 X1fkgdX8b5xMz70t2a3rvbGmwvSksfSCz2RzAbhkD2CbvxkaN6/J7yDasBLy/iYvfmCsDWt0g+o
 lQe7N4WegbVPHnOq3qaCeCE1A7AeqAPWEDnzj01qMuNcvv6BsYMBI5+5nWHFw2X5pFbGQntKtIE
 y2IHrZix8Z8c+8zw1ZC6CCaW/8PZ/bZt8nHiPN97ndbD6joCGFMKOo1R/yAr0eychf3fUsa34MQ
 543Wud8L0J+bI8TjoQFUK8AhP4uQe4aVi0URHHakNa+jsR5rhwd9SKHNKnMG95SngYBbKD8g+Vf
 pAe3KSxbxKULFDg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: UEQ0TypK0fef48QNPhyupXAQQV_w-E6_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX1j4ADfTXUEN9
 8P5rN1OiH34W1VBm/eNdReKUUVn9SL+WB+FO0w5r9j+vUXRSs+jv7RhYYERZycgw9ziPaJfA3OZ
 IsqcFz9qdFE2TipgH7lYwNU4BdvWej3zVtgH2EvxW9V2yCIuiJHMrv4S/nnVVbnkRp6e62CG7uj
 Sjy+D5nWTS2zf8QIsZE+ghKkDPc+zDcdQDOSNdp5DpMuKgN+O5iBy+Ku5rSSlOZWkR/dUqGuP82
 lJMdCVlCsUdzaKhZd/Ms6zBc+KyXqEbp1SHhK4o3dmOu9UERllJ90cbohWw1IB6VM02xAjMdehU
 jq7WM6kngiYY1t1Da3zLjbDMOY2MxiOnmFuOZZz3ImU3oXy+7X+hSWK4dZaMjhxedewuIcbzNSg
 PSMEVaEXRg9zw4KSSMRwPSEC2q4gthNlVpZ8GiwFuWYkOqKOl9s137FgWVHxOBPzUxokFRJUpD7
 r37A7dyNAAobQEGCIOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXx2Q8fZoD5+71
 Iw40riAqXDHJ/3WMm7qVZnIz6lA7aZH7IvMomOg1wVK1OFs0jFHVrVqPKydCz6cmc/m6gdbCvZz
 4o6+5WcdX1FyYpl6b0BDMxU6kvYQY5I=
X-Proofpoint-GUID: UEQ0TypK0fef48QNPhyupXAQQV_w-E6_
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5de986 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=dfxIzRrD6tu8yhXxuZUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

With the final platform device and software node rework changes having
been queued in the driver core tree, Danilo pointed out that
platform_device_set_fwnode() is no longer used and should be removed. I
argued that instead we should prefer it over the OF-specific
platform_device_set_of_node().

This series converts drivers using platform_device_set_of_node() to
platform_device_set_fwnode() and does not intend any functional change
as the semantics of:

  platform_device_set_of_node(pdev, np);

should be equal to those of:

  platform_device_set_fwnode(pdev, of_fwnode_handle(np));

The prerequisite changes are currently in the driver core tree so this
entire series should follow them as well with Acks from maintainers. If
it doesn't make v7.3 for some reason, then I will resend these next
cycle separately targetting individual trees.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (8):
      powerpc/powermac: use platform_device_set_fwnode()
      i2c: pxa-pci: use platform_device_set_fwnode()
      iommu/fsl: use platform_device_set_fwnode()
      net: bcmgenet: use platform_device_set_fwnode()
      pmdomain: imx: use platform_device_set_fwnode()
      mfd: tps6586: use platform_device_set_fwnode()
      net: mv643xx: use platform_device_set_fwnode()
      slimbus: qcom-ngd-ctrl: use platform_device_set_fwnode()

 arch/powerpc/platforms/powermac/low_i2c.c    | 2 +-
 drivers/i2c/busses/i2c-pxa-pci.c             | 2 +-
 drivers/iommu/fsl_pamu.c                     | 2 +-
 drivers/mfd/tps6586x.c                       | 2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 3 ++-
 drivers/net/ethernet/marvell/mv643xx_eth.c   | 2 +-
 drivers/pmdomain/imx/gpc.c                   | 2 +-
 drivers/slimbus/qcom-ngd-ctrl.c              | 2 +-
 8 files changed, 9 insertions(+), 8 deletions(-)
---
base-commit: 27edebd505791748a77703e311d76f0f55a8d7ec
change-id: 20260720-pdev-set-fwnode-instead-of-of-node-e83ece371509

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


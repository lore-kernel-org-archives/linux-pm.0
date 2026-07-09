Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FA3E022C
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582201; cv=none; b=eXwZVV0YahlvzAUrvjo9/9eQRwEswBZOqvk6uIjNvMmDtrZnu/B7vaYTwDefhBsMugkBN9OXwK4eSHqJ8lNS97VNQm2iv2M2c2KK7aGBSNr5L6mczcTWGDnlY9wF4tY/x+Sr3/v0aPxIo3u56ztnyWRFuckshQt5033gU5JO0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582201; c=relaxed/simple;
	bh=CQuF6r98MUyoHzeESCnsTSPvCQtraJDtOi9/MqYC/aQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cI0pcrODfVfZfGJBX+kHSoXTzEPZK/yYyAkKEUK4sbVVxhLtsUENAzCDMdFXjBaDc1BR12nZHhir5n2/Q8zDLqaUFn1+DGb4+rbP4CQrVFVtgjxor9fewSvvTXlFgEsilAn/1aU9bTDB+ou5yrru5APHZZ/kg0xJThWxNs5IelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NU8u7XOq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CK3Bd+48; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NU8u7XOq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CK3Bd+48"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6695xxfU710966
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 07:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+5XJP2Be7eav9Tuhpcp9P69piQCiwgmJ1NEddpNBnxk=; b=NU8u7XOqoLnceupP
	5biCqB18flB9yeri51HNrvfJXfCfRDC8/GLbdYrN+S0VlJIxjemOTVeQvDHm8uir
	Ae1uLE6AQI6pHMTcoN4PB1hlGnnjip25U//FOMSJhhZ+l/t4DCBumflcYEcQGGbx
	MXMa8S6o77P/KkNmX65/ZNFeiAtvVN2fvb97GY8iXwt8pG+OM0Z5hIVlCuv2lmWC
	nvWUSn2aoCkphQOLci5olvSForDwyCRHWAeRVsnYjr9LJrz23VQ9fO+CnMLlGGsw
	BdfJAhsCRWiIemiXRmbk4tVbAdJCcVvJV8iP9AdjiNmu2Lu1BIlCtenAJEhxolCb
	DRawgg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vghjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:29:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-846bc8a0d12so442730b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783582198; x=1784186998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5XJP2Be7eav9Tuhpcp9P69piQCiwgmJ1NEddpNBnxk=;
        b=CK3Bd+48tWjPBQGpIpMMlqxtLaqqTq5C/XD/iCa+ZwQ758W/WzX5/IymNrhRM0IXJm
         kirrqM9hdef/RsBJcmdW3z9zPpPu/06C7vQqyoGx8676P22/jn8DwMVHMgmzMT7IeR77
         yXgsMGoyd9cHJcUEMNS+Q/8xxwjXBIqeMNzxHGtBWkzMhLw+TNu3kY4NLSLnFJim2S2Z
         qeXaUtf1ZbXp1Lb9EydEI9cdkJCjl7X2Wd3DcWpyl5zryvVW+f6wRzy1o4y3LmyftmNI
         Lv46piz03N++1X+WFKooevU1TEU16A29msRD8tIJ0qKRqQMYo1018/Y2oNJMgaNlbivZ
         MmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582198; x=1784186998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5XJP2Be7eav9Tuhpcp9P69piQCiwgmJ1NEddpNBnxk=;
        b=AjQMsXvMcKNpU29Rh9sDFThyMhGvqVLsYyQZu+6VSaWQiBz3PuvNnow3ZiefDhtss6
         daeOzi21HTnTZtNJsjF4YW2nG644iXM0e7By7GJc26T4j3XW9ZgjfpCTuasPv5lQqO9h
         lGZ0E6gOVYaVzXCKiGVFcFIQCWtjbuuBjzdTLjBpSWLB8Q4gVdsvAM8tFIxiB1VyqzSL
         UIqny6jaM/DO6JMpWIAp47rBe3c5fg0eojO2Y5G24wcfr6f8JY+ai+BmyOmGrb8P1BQ7
         msnHSXk1K9LPlkfgsZBworN2d7V8LImcT8/TaYucFS2SQwO5NLxEhbjkwu3bzdMRukQM
         2feA==
X-Forwarded-Encrypted: i=1; AHgh+RqbVjiMZ8/BSS83sAU9eeXJCs1+ygaCGMvnI1j20j9y1ov7em3JJUkFCcwqhc/lVn2SR10Ec4dY5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9netvr7xYbkQ55sjlznWbqwu9F84JPdOpo5G3HacLyokShgY
	HgHvE2xjTdE25lNhqkFnctF4PkPrRMAARfVNcTIdN3aKxotfNAADWXpI7xMPJ4q/5+k48g1S5gv
	eacXYqvRn5VQ87U+QMOZSI6VbJHTLYtwaV4TFqMtkbno4Mpq6i4d0YZV0R4MUzg==
X-Gm-Gg: AfdE7cmkrQa/PhlYa+7fHx/BcC7uerkFO9QFoPfIb+EPmRvyigf+uZcKW4AF8HGWizJ
	ZsOa4HTGTnwL4bC9S42n+JPMebhGA6JzC/4fsx03Z7chDUzoey3WT1Gf3cHfmVxnqSL4TYYqc0U
	A4Soq3u5QyymZDETuNoF7bbeBflq/qZm6Qbp4D+3gaHdq/t2JDbA7OSYZFHYnohtyvyW/lEhE/4
	7cllj8h70JiyiNd38N5dULIqrc3n6sXoP1M7fetFyqQ5N1sTspdKdzXZIiRiRnf4wic/s5mHH8w
	BX5dxzbuF1l4Mp1uSI55MmZCrojop9M0OuoGhnt2FLPNBLI1+5cxGyaAQq6oa7zRGvIe54sO6uu
	HqQfuHh3808XhdPQDQpSfUwkGz0isioaSBCRit3RiG2x0GLQpoZu1hPaeknvvRA==
X-Received: by 2002:a05:6a00:b8f:b0:845:328c:1ed3 with SMTP id d2e1a72fcca58-848560608e8mr2014127b3a.7.1783582198280;
        Thu, 09 Jul 2026 00:29:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:b8f:b0:845:328c:1ed3 with SMTP id d2e1a72fcca58-848560608e8mr2014092b3a.7.1783582197789;
        Thu, 09 Jul 2026 00:29:57 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d44d53sm8167222b3a.38.2026.07.09.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:29:57 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 12:59:42 +0530
Subject: [PATCH 3/3] power: sequencing: pcie-m2: Deassert W_DISABLE2# when
 no UART serdev is created
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fix-hamoa-m2-w-disable2-v1-3-5e725091266a@oss.qualcomm.com>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        mengshi.wu@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfX2HNUV45m9s2u
 sXW5kV/0atMq25eB06/obVNBaXxlWLKW8tOSljuK/LDnlaJhLmDp2pqcUMEPkbwUMfQWlNOAq7D
 yXNzDZCcJkGF3aZOPl3TBrLvE7d8uct3LkWvVCJgBjeWEaGGYloNR+jblR8TY23XKXYOcRymXso
 B05/zRjnSr5j33ZhL0SZq+mbWRYn4DoEvX9QC14e0O6N+ZUReKhtvMp+3G6q7WSZdB1ZecRO6Xj
 yEPOt1pSSURTJalpUtmIC5f5V0ZzFRdEX6NAFpGdshDgoD/HkuuifJl4645Eppz+e1cG2dU1O53
 aXYnXCP/Agc0CG2+it/gVOvkng6c5Kn0lWTnFdDCSslcd7xsFcuzCZBX2s0c0LGIayRK27bep1u
 AG0USv/KKQ+MXgQ7nROiE9NA5zvenFJGBRk6UvCoNvzU7KbJ5JXwxywAFDzy+sfPu0K3R7PouTm
 Poi3D9h5QoCzAiIPYgg==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f4df6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Rd_Q6lwWc_OclDomn9YA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfXxgKFBYYTTu5W
 qn5rXoVbJvxqAmxYCRrFg4MbvKkJmFTfscFI7xrg1UBWUF9zxqQ4so46GUIGLMP8XdfvS+hXWvG
 MjYrz0nrR6MqF7NDUliDLjxggV1JxSk=
X-Proofpoint-ORIG-GUID: js1gZR3vR0MkZay2qqfKyZ5dOdHpt7Gy
X-Proofpoint-GUID: js1gZR3vR0MkZay2qqfKyZ5dOdHpt7Gy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090069

The pwrseq_m2_pci_ids[] table lists PCIe BT devices that use UART as the
BT transport and need a UART serdev created by the driver. When a PCIe
device under the M.2 connector does not match any entry in this table,
no UART serdev is created.

However, the BT subsystem of such a device may still require W_DISABLE2#
to be deasserted to power up. Rather than adding every possible non-UART
BT device ID to the table, add an else branch that deasserts W_DISABLE2#
whenever a PCIe device is detected under the connector but does not match
a UART BT entry. This allows any BT interface on the card (USB or other)
to enumerate without requiring explicit knowledge of its device ID.

The primary use case is USB BT variants of combo chips that share the
same PCIe device ID as their UART counterpart (e.g. WCN7851 NCM865 USB,
sub 0x3378, vs NCM865A UART, sub 0x337c): no UART serdev is needed, but
W_DISABLE2# must be deasserted so the USB BT device can enumerate.

Reassert W_DISABLE2# symmetrically when the PCIe device is removed.

Validated on Hamoa EVK (IQ-X7181-EVK) with WCN7851 NCM865 USB card
(sub 0x3378): without this change GPIO116 (W_DISABLE2#) stays low and
no BT interface appears; with this change GPIO116 is driven high and the
USB BT device enumerates and comes up via btusb.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 33 +++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index cf51122d54fd..06eb5eb0676b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -401,11 +401,23 @@ static int pwrseq_pcie_m2_notify(struct notifier_block *nb, unsigned long action
 			ret = pwrseq_pcie_m2_create_serdev_one(ctx, pdev);
 			if (ret)
 				return notifier_from_errno(ret);
+		} else if (ctx->w_disable2_gpio) {
+			/*
+			 * PCIe device not in the UART BT table. This covers
+			 * USB BT variants of the same combo chip (same PCIe
+			 * device ID, different sub-system ID, BT exposed over
+			 * USB instead of UART). No UART serdev is needed, but
+			 * W_DISABLE2# must be deasserted to enable the BT
+			 * subsystem so the USB BT interface can enumerate.
+			 */
+			gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
 		}
 		break;
 	case BUS_NOTIFY_REMOVED_DEVICE:
 		if (pci_match_id(pwrseq_m2_pci_ids, pdev))
 			pwrseq_pcie_m2_remove_serdev(ctx, pdev);
+		else if (ctx->w_disable2_gpio)
+			gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 
 		break;
 	}
@@ -469,16 +481,17 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx)
 		if (!pdev->dev.parent || pci_parent != pdev->dev.parent->of_node)
 			continue;
 
-		if (!pci_match_id(pwrseq_m2_pci_ids, pdev))
-			continue;
-
-		ret = pwrseq_pcie_m2_create_serdev_one(ctx, pdev);
-		if (ret) {
-			dev_err_probe(ctx->dev, ret,
-				      "Failed to create serdev for PCI device (%s)\n",
-				      pci_name(pdev));
-			pci_dev_put(pdev);
-			goto err_remove_serdev;
+		if (pci_match_id(pwrseq_m2_pci_ids, pdev)) {
+			ret = pwrseq_pcie_m2_create_serdev_one(ctx, pdev);
+			if (ret) {
+				dev_err_probe(ctx->dev, ret,
+					      "Failed to create serdev for PCI device (%s)\n",
+					      pci_name(pdev));
+				pci_dev_put(pdev);
+				goto err_remove_serdev;
+			}
+		} else if (ctx->w_disable2_gpio) {
+			gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
 		}
 	}
 

-- 
2.34.1


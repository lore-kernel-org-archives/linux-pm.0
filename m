Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590699;
	b=saejZrr7/6ygcyOx8a/ErIKDBVxmCG1SPXfwgukjO2ZKqetaJLqtPTvACZ7+2dZ/PqRJ
	 Ya4mUz3rwQ6rkor/HNEgCnI4UF/CRRO4kBAMKkWRTpoEgAC5UNFp1FXTxBVjNFn4AEFeA
	 iCdHtRSZma+20OxPjr2Hv4vlGlwo0C+3tmqFoYXzWh1zy2nxan6inDG46Lw0Nc1gJxs2Z
	 tgRiPDGngOk4raqhsPU9zNn/v+kwFUds0xFD3RD782m6E+a80HLjA6NZRmLYj8c2Y1B+Q
	 LNWHze+YjKGOxbzGPCM7WuDZ82XIQPUppP922cuFLio5/3c/QqKAgY2+S36Vbzd153w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590699;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6ic9YLfgNTNC8LbkgAOfvr1E7rxhwKyo7fVG4O6cpK8=;
	b=XZQrjvJfvN9vTO7I2mvWPLC2mWn01f7hvxOqR8+Qo6c71d7122aQ8zE+sl5QNHXwDyUC
	 SBqs2FBPChbU/DkTFGaagbr9gZx+LhAIgK+Ofn27GtjLQ1S9+KKOYiHwCnbs7X19m7CE4
	 4LCQ3rKrxcPzuznSPp5vAXs/8kU3NUtlKQ2X98mgKAhRwIbQWXhNNv5uH06FrPnTBLXsL
	 dhwOoGi1UFyw/RJWGDeGZVnvXb15X58G/RaZCXuflFEkYMt7bEsCCDb32V1krTaVX2vA4
	 VK6QCFkzxKr4PuVKIHk4T0jvAf43c5+xKcFMuwEAPzBbB1VjsumPfll1QuxlRxdkRSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xkws2U00;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UNEfIIJs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DE606A329
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4DE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xkws2U00;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UNEfIIJs
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LDHOf34038126
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6ic9YLfgNTNC8LbkgAOfvr
	1E7rxhwKyo7fVG4O6cpK8=; b=Xkws2U00vMsA1S3OJf+Kw6noOrg8AI/CvYPANc
	Sg666KXvUcVP+7qkx5tMz1s7O5nH052OysjUeUuAZJaa2bC+aSOEnTEvn12XVcXB
	HBw3mrJQLkStrg9YO4fjzdphRMJ+ZmJ7+XzOTeU4sb1I/yHZ1Oj76rE6gnXj5D5u
	P5FsgZTvzzDXBHu3mmah2LBznuvNXLGPGiWfA64eY9NiP+LzBpLEj2R2v4qErKgm
	R18rFPtJLX95IPycmcNBo5UFDutfxwBTn8GnLNlwH6elY5Ys9HExEpl3m9Dk6Z9P
	t4FRo/q3uzReAdm85y9F5MqH+MPdosxVOkbCvelxBDoNxmgw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5884qt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36696c9f55bso819912eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590692; x=1793195492; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ic9YLfgNTNC8LbkgAOfvr1E7rxhwKyo7fVG4O6cpK8=;
        b=UNEfIIJs4Ycd3woFQgfVGa04dQ1czRhid+p7gU531tuGOXSSe9JJ+72UaqU1ncr1YS
         J/CN3CCTvRHsN6VFhFrNDzM74VXnTjNyTiKYekuD06TKqMSfEzlec7kXwEFofpp80FCW
         rPK5ybdPVIaR9xJEwTFCFc1YdyBbDnm4YBRmBCDzagT6+vYGHcCGwpHMTefaHAmf0R7p
         8JYYfmEHkNAwD2OZChpoWylEQlnN4EHPqsp5zeP3mnkxvPnciR/r1jRkXDP3GGp5ljao
         1oxyO3r/a4R9nyZ6TanC7BzTvxfhG1DmTX8HjXKudDv6/YA/c6QjNpyjNO6dRF1N2r3J
         HWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590692; x=1793195492;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ic9YLfgNTNC8LbkgAOfvr1E7rxhwKyo7fVG4O6cpK8=;
        b=kBpT7b3brhGojK4fDqMxiD5EKYNIiw6iz6Ke23PKqYljyDz67j7Yjh12vCgRnHRLPA
         NjZYMOiwnu8fJsMaPlrIl4KxEQGIWPq/iBXYihASS0OrA5MjVTOPlCHXh8l2TLFmq4Ck
         p0SRX8WFPGRX+uIhnH30S5J9qo2zeI+vWhXyGCedQ35hYDJJOCLodWumYETl7UkgAmGH
         xbKxeR8H39s+T920KZjuBqVuE122VVQdZl6BzxF0Zy0bI1DyvoRMszMJnY5gB8uDDe9V
         YQ1OWTl2sKyrRLYWhRG6uyleynV4sX0rYwJH71J870u2uwncEu7/kw7HuFUEk6kMyvIj
         O9Mg==
X-Forwarded-Encrypted: i=1; AKwUvBxgKjpTQHCz/fN4DZKQMaWSn69lZftUCVqCgAdc99o6D2jDH9nlR7bFVNQEc5hVME8HeTp2HQqnVQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL2APwIMKnOACPwH/rF36vUhrO4DT5wuOZ3G3rUXU8teRem38uK
	7rC+qlrDnjQxcv/TNhtNzcOdgFo+on6U7tn/Wzi4STUAPvBqNAV5B+KgyZB0T0EonJ+fmYxHqwc
	sGlaRI9Qwzk5BhY8r/z17VoS6pyXYRKhyppKDxcLjLbN/uf8h7Vi6H8SRt8TrtQ==
X-Gm-Gg: AYBFou1KgO2iq3ZySTLyex23lLOJ18ugPx3q5EVaydjI0ZLnKMI0MarMdSVbfPxmQF5
	zfmjgfZedGg3eGi0wEBlvH1Wpi2fqAdecn72MBGOHk+WngwlT/7J1xar5rEVs/FMY8VBYhu8Ojz
	pfm3SuRnxYeu5v2F6du4fGfMfcIoue4LdhMmVKVc9UwTvtCZGzLCmgf0cv/zlUwZxN6eg/3/ZFu
	GCcCIutxq3JITqJwdkBgJXeORcXvOhLpdfk+OAjTiBEb4m6wUurLSEwQwLeEo0UeFET0ZHFD+XU
	94nQgnzi0Vo7mHivp7uQZutQ/PpMtvsAzd4/wbTrR5k4pi4U+X3s8gD/5ASamlPQJ/dS3qCK9JD
	0LTcNa7hH3Hbxay1VPZfyEGJRA4Lya3hxFA==
X-Received: by 2002:a05:693c:864e:10b0:361:8d0:6c7a with SMTP id 5a478bee46e88-365fbf86502mr7227534eec.26.1792590692116;
        Wed, 21 Oct 2026 06:51:32 -0700 (PDT)
X-Received: by 2002:a05:693c:864e:10b0:361:8d0:6c7a with SMTP id 5a478bee46e88-365fbf86502mr7227503eec.26.1792590691495;
        Wed, 21 Oct 2026 06:51:31 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm7534332eec.13.2026.10.21.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:51:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/3] power: sequencing: pcie-m2: Add PCIe M.2 Key B
 connector support
Date: Wed, 21 Oct 2026 19:21:21 +0530
Message-Id: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnD2GoC/yXMQQqAIBCF4avErBPSwqSrRETaWNPCQisC6e5ZL
 b/H448Q0BMGaLIIHk8KtLoEnmdg5sFNyGhMBlEIyQvB2WYIZW/pYsZKaSutdKlqSP/NY5q/Vtv
 9Dode0OxvAO77Aa7YGxJtAAAA
X-Change-ID: 20261021-pcie6_fix-cf66f4b8b387
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792590686; l=1492;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=D/UvRdvBDBS/Rq/ST/CUi0Wd5LwynsMiqdDmEgI5bRI=;
 b=GA0GHTLmE/SalAfNw5rnP12qL+JshQsAM+buh9CGhLL9xvLCTlyCtqkJr/0RW7F1Si1RVcTQ0
 hf/aDeNqM2qA4j+XzATTEYLZePe/7mYoVq2kN6qI9GE4Y3mgCNdcKLS
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX7Q8czXdK9Gah
 g6p0CGx3fh4SaE4KT7kkNKaMtV0hsoM6A5AkmcAwGKv6sCp9Uks2ea0qzcP8uLE/9bLvnKXXlqc
 HbT631BiVTZ8LeFMpsC27ZdL7LfUw+k=
X-Proofpoint-GUID: Qc3RWpCxXIcBhrA3FVhKYyNN94pMeGc-
X-Proofpoint-ORIG-GUID: Qc3RWpCxXIcBhrA3FVhKYyNN94pMeGc-
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8c364 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX24GzNdpx3SDY
 Xdgay8LUfrNUE2A7lvGBG9J9u05+0D2b6wnydTUHokw6V/xD5PG9lkPjfHHlqOTRuEAbxjodBDl
 HpBscaDDOgWWhtun1sSKDFI1Rsidrx58hzI4IWyWtXux6U9cb87tpe2AkaDOxKjaYlnYCiFOuIS
 bP2a8ZwoOyR8++ybPlgwx5phdM98UNl0nTX8xNL6Qi3/QiJpqZMgJ/p7j+MAP/qsr/Yp23gchZk
 6q57NGhKq71xrlZWLgbqBszIUUhppOndFHJXd3lT/68513NoyIF/dfJHDLdk4vB27oPsoB+Gget
 TiWEp5Jg01r8EbVug82tkbywVaa366+R5wDS1p2c3Z4xCOn2hldw1PQk0e8d0Cg8vkvr4rY2/OP
 TvlPZmjA9x5himBz9mjbOtQ/x0bgX/NR52CDyif+sVifNmovr33OtTyPe7hCyauuZVBEezBRB49
 31+Ve3qE4y1fgQSFsMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210055

Add support for PCIe M.2 Mechanical Key B connectors, commonly used for
WWAN adapters.

The series introduces a DT binding for the M.2 Key B connector and
extends the PCIe M.2 power sequencing driver to handle the 3.3V/VBAT
supply and the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1#/2# signals.

Finally, describe the WWAN M.2 Key B connector on the Glymur CRD and
move the WWAN supply from the PCIe6 controller to the connector. This
allows the PCI pwrctrl framework to manage the slot supply according to
PCI device power-management requirements instead of having the supply
follow the PCIe controller power state.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (3):
      dt-bindings: connector: Add PCIe M.2 Mechanical Key B connector
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key B connectors
      arm64: dts: qcom: glymur-crd: Describe the PCIe M.2 Key B connector

 .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi           |  29 +++-
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  82 ++++++++++++
 4 files changed, 256 insertions(+), 2 deletions(-)
---
base-commit: 2c455ddca7827ad8fa3a64fdbf5a60efb928b46a
change-id: 20261021-pcie6_fix-cf66f4b8b387

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


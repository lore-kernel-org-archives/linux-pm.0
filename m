Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397C3C76A2
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583197; cv=none; b=fZV69ZYsh7LcoaqfWFRDjB0tJHumWSjmJ9Sv2/C07DjVqqB09uxaNUcCDy0zqi/3yquMQAvDaPwo6rVwLbx7nYmiGvs+GN+eDGdbRv9hKZObkRlJ8ETDGfJAgep0Nd4oo31vCiDhbmfSGCg4g63VkzF3TAIRZR/a8RPWnAHFLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583197; c=relaxed/simple;
	bh=3yc+oFEDiae/9wo1xuCH+yHzREyAlh7cr8qgkE8f9go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzcCsoBEcLbEexgkcQxYkz0+jT1iGJeV7G1f45wPvINLa1dszilDJRzcHsWwCiO3SHihgQyb/mmeY/+Sdv8z5lO+eO91nvZolgmMbJ11ZQOuxZoBpuLLsW7hV/jqKuT7KxeDNumRzTtROz1njs450gMiu1+1JXkeeeljnNAptXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mIPcs8C1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O2NXVYrw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mIPcs8C1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2NXVYrw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960EFX931889
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 07:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	odZ3ve7vJ1rCrLXsB23lnwMfJKW7+qyBv7jEFL5Qyvc=; b=mIPcs8C147vjOBL0
	vOJhjHVmk6xoIEltH8bOkJCIy3LlG3sF+FucCI2Y5TYNHQ01MnTbUU3c3ymxz8Of
	IEMnBrgGZRxF38XJvLKlN0XeNgPE06/xvpzn9VsRJT9mrsZSGa0DOHTrXplcSnLf
	wa80tOrg84F2Y0jYvSjROXgrX+Me7zIQevm5IYi2cFLk9BWkwCpropRy+vhKEZpb
	QqX0V6/sFM+bLCeJUjC2Re1sHUnEisRbaqqQ0keyYG1EmQzzxzsSXsfMWJEoDPFY
	b+MegDojerEa/GfjS3o1XiXHVTFOWgl2ERvjVByfxtc23v9IW1nb4NOpzlH1zZd0
	Tl95WA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqsb0w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:46:32 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-739451feb61so743240137.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783583191; x=1784187991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=odZ3ve7vJ1rCrLXsB23lnwMfJKW7+qyBv7jEFL5Qyvc=;
        b=O2NXVYrwRYm+gmizIBvafaFaVgo5LRxcsH9BS56282sbce6lKAZrT4nU95PF3XFQvy
         R16vzp7A6Mi6fZB2VaBvqRCaa3eD+reVhJh241K628GZHPeYRt7JPpfCSO7AXrVwmuCx
         NEiO8jtPJZ2YQ7ceG2CznbN8ZnTdJcsvzvRJ6QO2gJ3mwWS8A1LFui1RaTvsx8Vqc9l1
         QY69nT+6r24W5CRc9HRCs0Jpqwq5BjoM/nQYilcV/7Vk6JgrXQkOaeaRHedOe3+OxPNj
         E8FrMpRkc2PB6GOXWeFR6rZuL0hgXDptLsk8FwlSRLcf8G9fLMlVGVoqKLARi8AVViM6
         kBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583191; x=1784187991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=odZ3ve7vJ1rCrLXsB23lnwMfJKW7+qyBv7jEFL5Qyvc=;
        b=sIpFjmBOdCVQ0iQzCuxb7VpXJMo4TNf0BSEo0WPoQGnWrfhgfILp6xCLDdw/Mvx+qn
         i+moNzwTRSxdlv0UYoQgPsoO2hwNHAyI86IpBQdaFMUCFfGtdisQLJLkjXatqRqH1mXO
         bKvOundZiJ6PdmoFArBtRyrICQb7fyBlVyBc+HF2NaYYrHIt6kil4YrfbRN6AS8uWsDp
         VuUhpXUZDhhinf5xrotnaRPnL9PHMbolzAU3Ew6Opn0WbVXx7Yt9TdwMV2G3fZ2OBiX7
         jLnNWdB5dMcyZxkLzf3l7PzK0fHB6u/j4yMMR2m2ClHhCXHoleEgCJ0jDZPIHQOopM/2
         xskw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0qd26krmWDTiQVmPB6+EyDW6Pc/wEgHpTZ4SVibHbS6ItzLPPqr/vuVk0ENetFIVQOKkw1/4IPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BlnY+KPc0Tzz0toB2TF53a04NbFtFwXumhHFMbdsgTa81ZAQ
	IYHChHY+2sTnBpju2sBWFqQDlD9hiVd4H7akSRaOyx9Uk/z5Sn/seUNwTpeNtg59SL3hFJjeMKB
	hnOQL/3xE8rrb7HEUzuDhAOXlronQTjpu15NpS/4X0Fww3stahnfdDDlgtYFcnQ==
X-Gm-Gg: AfdE7clzfWHwmKpX0clxYaBFvxKBM7Xc3uzBLrIpcMFmUYFj+BBHbGgqX5KBkCS07lI
	yQ2U+0nwqrPS/ngNg0WFxPmbcDJxRqZ5xixZ6yzpYyn+AaSDaukWibVoirpnvkIg5Ob9BreBKcT
	QIXZE8IzZyarqTHC5KilXU/E9u8xKnYrOG7eCNmw6+zRck3Vmb81SWbJACTom8ie+HRibCWqGlW
	1WwdEP4pT/OX6aBIBpW9oNLVLu9q/gSFl7OTJrNks+1VVPiMo8WHanZj+wl7JHq2PhJgMhkXUZQ
	L4h0gpNMgYEJ8Tqe2fprds5//M4xQGsxRBKwTm35wAo7JqzCrF/hrQl1CEZ9dL/IYeEuQ4v6lT3
	v7v1vTV31sZES0TDvdwwfAufuyCIEX62gkDdQBfUV0joMIzu4v3DerJ9J+vDypyUZ/GaU0vD9/k
	limvcxw3LrgA/JKr9/zLOcNuo2
X-Received: by 2002:a05:6102:3910:b0:631:2624:e5ec with SMTP id ada2fe7eead31-744e00118c8mr3853632137.16.1783583191367;
        Thu, 09 Jul 2026 00:46:31 -0700 (PDT)
X-Received: by 2002:a05:6102:3910:b0:631:2624:e5ec with SMTP id ada2fe7eead31-744e00118c8mr3853615137.16.1783583190922;
        Thu, 09 Jul 2026 00:46:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb768sm5112907e87.52.2026.07.09.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:46:29 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:46:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 0/3] power: sequencing: pcie-m2: Enable USB/UART BT
 coexistence on Hamoa EVK
Message-ID: <drwgkj27gdstulk47cev2nxs6icienfa6vb3tu2uc2gqkbeedh@duj252fcm3bz>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MiBTYWx0ZWRfX0CrXzHEy1khD
 wZoScVccvSG8wmm1X+DlIGNckYQNlnMcFYKyKA9JwQW5pGbQmVRXwq5vLNg4dSeh35C7JXvIwNk
 znegBhi0MbfikyW7ho7bQep6H/ipS0M=
X-Proofpoint-GUID: E-1rnI-D-T5sevmNBM0Bkhd3AGB5R28y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MiBTYWx0ZWRfX6ePaRrTGqxBc
 kj0GsNHhzme1DbYe4Vy+6G+H2BjdCN8Z8Hf+BHqwHhfNpGVfoDgouKGqH/dru2FhFVVlVAhRULD
 Nd5HPkvdkB7z1gDogb2sdslOwbLk1Ohmtu02csfmxu/6zV7LePBVOSye9if/tuhlyEnskbfHlg6
 Br++wh6jyDZTefeaM72lwKp3D3M9O4lwHewhD9paXILxDCmrjsZzuUOmap3PZzPV5XwSWPsNN6P
 78dqC5cQiHWlpVe2a0htHLann2iXD2cG+iktLYxkAS4RFxNB9E5MwDIIctbWCo0Lh0BSNKZqj7+
 vjzA3EfMVj51Jo5+TNcBbam7P+ASp9rGgHXRJdOm/Fic2dWpyemSVJKC+15NEZjH4TT2tPopyJk
 dczigLKZIZs/xIN2SiRIng7HtrOdwJGmOEc7vlWLdq7PLSNFXbKA3vts+obvr/c6tBGOH3udaYl
 68QZiPoh4AhxVRWkTPg==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f51d8 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=s4KJf74AQj_XUxSBtgUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: E-1rnI-D-T5sevmNBM0Bkhd3AGB5R28y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090072

On Thu, Jul 09, 2026 at 12:59:39PM +0530, Wei Deng wrote:
> M.2 combo chips expose Wi-Fi over PCIe and Bluetooth over either UART
> or USB, depending on the card variant. Both variants share the same PCIe
> device ID but use different sub-system IDs. The current driver uses bare
> PCI_DEVICE() matches that cover all sub-system IDs, so both variants
> trigger UART serdev creation — wrong for USB-only BT cards.
> 
> This series fixes USB/UART BT coexistence by:
> 
> 1. Narrowing WCN6855 and WCN7851 table entries to UART-only sub-system
>    IDs so USB variants no longer trigger UART serdev creation.
> 
> 2. Deasserting W_DISABLE2# for any PCIe device detected under the
>    connector that does not match a UART BT entry, allowing the BT
>    subsystem to power up and the USB BT interface to enumerate.
> 
> 3. Describing the PCIe M.2 Key E connector on the Hamoa IoT EVK,
>    adding w-disable2-gpios for software control of W_DISABLE2#.
> 
> Validated on Hamoa IoT EVK (IQ-X7181-EVK) with multiple M.2 cards:
> UART BT (WCN6855, WCN7851, QCC2072) and USB BT (WCN6855, WCN7851)
> all work correctly.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
> Wei Deng (3):
>       arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
>       power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
>       power: sequencing: pcie-m2: Deassert W_DISABLE2# when no UART serdev is created

What are the dependencies between patches?

> 
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 129 ++++++++++-------------------
>  arch/arm64/boot/dts/qcom/hamoa.dtsi        |   1 +
>  drivers/power/sequencing/pwrseq-pcie-m2.c  |  39 ++++++---
>  3 files changed, 74 insertions(+), 95 deletions(-)
> ---
> base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
> change-id: 20260709-fix-hamoa-m2-w-disable2-0fe775072c74
> 
> Best regards,
> -- 
> Wei Deng <wei.deng@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

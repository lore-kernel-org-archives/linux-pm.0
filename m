Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB63D7D82
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280448; cv=none; b=aIJ5OW/WBzljRfkTxeor+2jYUxCqY0GmG2jcN8Y41raTQ5TCGZk6DIAZXN5LXt4XE8RjUkyQV6hnvQ4s07mnlTkUEUeUUuBlCzJVzkiuu8lOSPqVNH904AedEvZbU8e7iwriA+Da/8yrBytB7mJuEwUs/xFukQa4+usBGpx+BDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280448; c=relaxed/simple;
	bh=FaiYDWv5ktpOfI7FbTjcTMjQgLuV8H8NQfFgpojEVP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrruPbCWTEkiASH1PbljKlVghHd24VpuMK7N04pnl4ZTeSmVx24+GYYAcOi2Tob3GRY3Ny3xeMfN6Cjyrc0ceTmGo1UmNx2Lh8POSsAIbGcltVKSiDgUby/iHnOrfoGFjiBNP34xNdmlYef6PiX3zxUmnCI8yCwOIsnj7hyq2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTA9WPbK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BY4CKkUr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTA9WPbK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BY4CKkUr"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7ApEG2984433
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sWlv1f+/kOxg4LIib9PaORtM
	K1pM/yQ62L4lr83A1ew=; b=pTA9WPbKFHaJ3i5vjoo097EkuO7KP9Oh+yMGs95k
	Yj6c2GeGk2jdInRXdfIk1M1pUTzFVfWSY9TH0JdwXh7FXM3Xy5TMUyJVF9AZj3X4
	yfm8H9/bg7Y6BgfQHTlNuIVWx5YkoVccRHLCj6gwk1p6G6e2x745Soeyo9/wOw0G
	fiWmYTwat2dhHEhxf1Pu58zLbcha+qDThXU3gZYw2HtGTq5O0rXvFxKXikZMJSZ+
	TLqM+AyVDhPR379c1B+QfdIzfghf/DxAFo9qzjSgMx3ZJCGlSVMUFd/M80NCZCDN
	qd+BY7HB7F3JbcU5TSSTdPsVmLAcHVM+1bHpsuWrFpwaZQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t4syq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:34:06 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-95d25cc8f5bso7842084241.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779280445; x=1779885245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWlv1f+/kOxg4LIib9PaORtMK1pM/yQ62L4lr83A1ew=;
        b=BY4CKkUrUk1+WxrjlrDjTavjur4DNg4Cgwy1eXyzdDiVK2KcKuLtLRxlh3nf3AietZ
         X7q5x4fKHDU1TJdKxS3ynw5QiTX2LzqgKDeyf1ma+0kK+2b+m8GfjbajLcGSd1It58iX
         iWsZ0cSncfVa1jYy4ACHXOkDPjx7pNWr/sgPI0rH9KFZRN0t5knzYXbs+XGTuz90qTx7
         SQ7DfdxXUfITRrAn2RZBLvnklAGMlN20MYwZ/32OOhY4QvNVugd5ZKdxD023jdAkuyZc
         Z0sjKSEVWdY7HIUWK7B1IExF8qon44CGOzF5vOwKC+ZRF9vyhAHMkqkqUYwCQ7fdTaoh
         FAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280445; x=1779885245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWlv1f+/kOxg4LIib9PaORtMK1pM/yQ62L4lr83A1ew=;
        b=fMj2ZAe/ryE6uFmjTzKyCGSvBushcC91pUXqI0bSDO7S7+OQCj/TKAmC31lw6+bSs9
         vt20yDIu/Gd7BTG5gMinRKmzAwTQpYrHfch3Wu5KA5QpmyU44fsXOvV3vv/9OOoEREwF
         sFkjUhvV35d57ZiTJYVZ3RQz3jH8yyR/RdYgvqAe7lLz71aNFllcgTqnybR1eH25sp2g
         kFWrdRuptY6pcGjAcPsummV4It2hVuUAMSfMoiTPsIPvSTIij98eb8oFFoW+8Umhw40b
         wuNHU9Cq6YgBNI3jT//fvNvAYWdrYNBVyNwBywd1SV1XrToSuVfE8GMF4xBMoYvmA3tr
         3B4g==
X-Forwarded-Encrypted: i=1; AFNElJ87SugB6+93fSwiQ720Qr6I9OeAncfRENc0cAE1B6kpQeJjrVXi1x/t94ThlMrHgEIFGBLbLRKKrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VJX9281VrHJKxYqBMgZCR8E8emZAJngqrqICV05GQ6IwhqqZ
	kfr9RAmrXLUwbt6LO12W3QH26flnbfWMmH73/nU5MSrXyaI6e69KKce6Nu2mrMF5ncolgLMk/NN
	Rd+R7nZzymtwn5YLojqVmamXAdb0Sk1X2hWVtIrYbr2HXM39kFTkbxDcr95gESQ==
X-Gm-Gg: Acq92OFKSro1yabnnx/lPF4A/Nprk0viMv9ljtPv6uWHLLlClfmdFIu2pKo7fsgNTKo
	tiV/tFf+u9nv0o+4w+CZBoK8trYhuiCVAuZEms1s073IAEPTXr1G6jHgyhizPjJeJIRgnMTx2CI
	FzW0taVehbK7tNb1CdPgnuvRFYwFaQkhsUzjYRSFTEGjaok+6cm0XOmxhcXXz/eShkZRGKPd+yL
	sWjW2v+Wj/T2Ue7JSMNwYBYdIp/ruXNRh65cJIXUVrD0YLP07cYATHcM1Z3r5lVf+bDzUfY7Io5
	S7ORNbeCa1dUetiXLjL9pIm6FH0vs8kg2aC9QDElQCExRtHcob1/PaTzC92h6EWPIu5A/TwoBnq
	Q/b6m0EDNtdxMif8EiLNvjCO8s82sJZq04GnzzwgTYw20aEk61o9yTBGeM51LbrksQkdIh44wmd
	Rl6Hmk4M6rUXY+R35yJFMKVlmDebiaGnksC1k=
X-Received: by 2002:a05:6102:50a9:b0:631:2624:e5ec with SMTP id ada2fe7eead31-63a3eb8bb94mr12999008137.16.1779280445416;
        Wed, 20 May 2026 05:34:05 -0700 (PDT)
X-Received: by 2002:a05:6102:50a9:b0:631:2624:e5ec with SMTP id ada2fe7eead31-63a3eb8bb94mr12998977137.16.1779280444859;
        Wed, 20 May 2026 05:34:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c4fasm4905823e87.5.2026.05.20.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:34:03 -0700 (PDT)
Date: Wed, 20 May 2026 15:34:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Message-ID: <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BOCDalQG c=1 sm=1 tr=0 ts=6a0daa3e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=STQ2a8oQ04ts6E9hehUA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: h2YXGPf6AXBjREvkGviSrUuiTFaxDcOr
X-Proofpoint-GUID: h2YXGPf6AXBjREvkGviSrUuiTFaxDcOr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMSBTYWx0ZWRfXwXXsHtC7Z48U
 0SPz5gyvr8OBPw8ssZHDlCriiSDrlUE0T0jR2sj65IKIheSGYi9+Yf8zQ+Q5Nzio+oMUhoD2m41
 t9eER2y7NwaDy+U2pJSRPKYp/AIc7YhTHgcblA9zRxmr8HVd1KEYRRfFNprMlv8bZeF+oGqcntH
 8UnugT75FRxw4era0cUcL4aICMSyfJLchq55Cp0ziOIgx2CChdQ+2va/avAV/hwydnyoKEMOmb/
 BH0gG3ZuZY4sss/odcRTPxx0VKzKTeStaSyYhXcxf4X52aoVJKMqEXJ2hu3JOmwH8H1iIprKMGc
 Cgo6/BbZj4v6y1cH59mswpVNfHkVMVE4N2DR6SMFkinWsl4lLZPTypu789EtaE+AjVEpGL7O6Eo
 +K7egDsXrrJDVVV1yaKV1/D/BcyUYPuV6gMU8oUACnQMvMVzqSwIsO2oVuGIU1A18+D7H6SsIg+
 5enX82QESG+WqCWohIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200121

On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> Arduino VENTUNO Q board. The module is interfaced via LGA and is
> compatible with the M.2 Key E.
> 
> Add wireless-lga-connector node using pcie-m2-e-connector binding,
> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> the Bluetooth interface.
> 
> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> the pci-pwrctrl driver can acquire the power sequencer and enable
> the M.2 slot before PCIe enumeration.
> 
> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> (gpio56/gpio55) used by the power sequencer.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
>  		enable-active-high;
>  		startup-delay-us = <20000>;
>  	};
> +
> +	wireless-lga-connector {
> +		compatible = "pcie-m2-e-connector";

I think it was discussed that LGA can't be an actual M.2 E-key
connector.

> +		vpcie3v3-supply = <&vdc_3v3>;
> +		vpcie1v8-supply = <&vdc_1v8>;
> +		w-disable1-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&nfa725b_default_state>;
> +		pinctrl-names = "default";
> +

-- 
With best wishes
Dmitry

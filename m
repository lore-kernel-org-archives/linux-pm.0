Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB923D7CE
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691453; cv=none; b=M11rlI89Bq/8zk3JLyZj/R07wN3wTp2v3MmkDBhY8oHBLeHmDJLf1ygowdQMagU0999c0rPqLrNxgrH5I05ciI0pvHM4OPzfuesDZJsVFlgALBatiGyT8oDJVStlpvVtLrfdbrZmRmW8Oi7YqKlrYd4q6Vay/GsgWgdG7fR2bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691453; c=relaxed/simple;
	bh=xH1xh39y8K/9voN/rwyDLcQiZ84Qo7t4SMNVdhnEKJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7Y1UYNktf48eFr8B8TBAImZVckJ44vn8eLtw4ayovEdWtgsxM/bzoOAfPvnr8ETGZQNMcOxXwG5Y9oBobtpigLfy7p0QZpuwvJfBmSOJ3RL8YAYhlM66eVTntHOVTe5H4bqpvDBr5EF5mK4YeZLdddKphXgxGbrhUeoDdDmXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMh3ys41; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hWfgvpZa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMh3ys41";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hWfgvpZa"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD5xu9969181
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 13:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6AIQxvcRx21RioxQhZDbiYJ1VNsBCw2h40lSC03Og18=; b=TMh3ys41KU3gbhm/
	vr+T7ySZQJvD7YOYzs+Bb5Sz9GUZPEo6JmxpQc09aLvo0+qi/kg6wgGHizmkStZM
	W6e7R2Mw7Vkd459x9ll99zW1qxDLZu3sXYRPJXV7XBz/uvMQ3nnZBRmS0D+e+I2u
	Mi72rS3Psl4VGTAC7/Qvpv6/J5B974DSuVlxrejFr2uvVc89wKUq+sbDkmYJTAqW
	iTxwITLqCQFRbmIhUgK9l1eGyQnH4Z3l9KGCpX4ZM5fzGDxQmekXg3nw6iNOSDL7
	rB/risaTQu8Tsq3e0KRAwqlKCEhFWeE42QrRk+REEL8aKlUxjYnV0/RuWIkISFyK
	GI5PwA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3mqvm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 13:50:51 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-737ddaf8c57so26255137.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783691450; x=1784296250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AIQxvcRx21RioxQhZDbiYJ1VNsBCw2h40lSC03Og18=;
        b=hWfgvpZaEwcd2gJE3dTYwt/dcDxQXGE/8ras/yVAkvnQaEYCuQsKDfiFEQmIzczytL
         mMGfZZp1wGZc1RZcQ8fFE6bDcvVB42phVH+9QTzEvMSxGzq0HJ34k4bCQrDXxGb2k7ca
         J43AhOMVeYd3xXIsJwo395EDzXI8/HOllIE9Mymzd0MjDhqxv/L6Y/x73U2u3Wh6aL2t
         TTb9fjM2Noh7sw2fFzfvFS5Q1sjW8Ae+9yRggI3bo7cwKdodGjXZI9OkWbcqyo3NTDlZ
         M+Bb490mFfqH/StILY6Tfbit0z4LUdfUF1l6B9azMBup2P7cAqV3X/BSKG6K/5nd+Y07
         qmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691450; x=1784296250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AIQxvcRx21RioxQhZDbiYJ1VNsBCw2h40lSC03Og18=;
        b=cKF9nYX+D1MXg5xt6b9nPUd936ongKkb0e5kYcsTDIGv4soVL00MxmaAMXn84NLE/1
         ybNbD2dTYVP+WTSbzw1CBCFL3AuJUkacv7OGmMalrLv9Dt7Yp/EMO88Yx4kE75+XpAfq
         zJJBvn68Q5aCmbbTeyEjuNAQcjK5RvbxSJhZSn7aBPwguMhnI7Y5RL1NXpfN7BttnXJ5
         oeWpDiV2gg2DHaOuzYbmoWr7XLFA+2KAaHuFwpuw9MJ61Bnz3ikrOYkLODAV8w2zjyPs
         FDDY1Q2vA2ktSTbh6vKRchlaXjQvMe1rLDiPeyTCmSwpkh70hnhCCIApmzVioLkAtgQS
         mKEA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7AdFUJXWN2ZtfobLpFaMmOn6AKSOo7tyAmK5GNsZY7hhKirP4KCY9uJ0NBLcL6dzIUlfr0gQcBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx96MTth5NO6+jHRePCwfX1u2XwlK8moqkxPo6QgKH05KTiguS0
	Vwgudb575bKp3KO6W4fvh54AiQnyIj2yeOuGmpAQslNkDTV//5rqDMw01ZFGXuks+VUvYBrM/Dq
	fhvztL1MZ7K74YCyx7wocTWsNXc6Pf3aJXX4CVl0c4iByFOpC66J/S9Fj1wbYEg==
X-Gm-Gg: AfdE7cmIDfqum1ihsWteYuXq7DoWqFjImEpejCDQQ0H9V+gL05YImG2rcFDyfrKL/yf
	/VZcMhHtykZUxj4nAf79MGJYLmpYhAkt/BLQVljugLY3k4xFsGjf5TGAh4uGUhhgjSm6txkto20
	ib4eGe/TVOn/7YgMp8OXIqd2bMjJYw5S50MVWLCHAJj+a/fFrCfuBXzcy4JyO+6FWZL6wlLnmzc
	8/i2zxPxDcuIwp7nCCxg1gUsdtRUziv9daY3+bR6+dTJBPzskip2Ev7UPU1fAiE18mrGegVpZjQ
	S99/JyD7HKiJWvptDG5HkDffbfohx93P+4BQ/okEeRu3uCXNC61WmLUN95e/1NIqlSIUDZadbHu
	lAuWxx8G5YuhUnSdkZx7sIciwOH0eqqJC1xI=
X-Received: by 2002:a05:6102:a4f:b0:73a:322d:1bb3 with SMTP id ada2fe7eead31-744f0ab5277mr2225549137.3.1783691445241;
        Fri, 10 Jul 2026 06:50:45 -0700 (PDT)
X-Received: by 2002:a05:6102:a4f:b0:73a:322d:1bb3 with SMTP id ada2fe7eead31-744f0ab5277mr2225535137.3.1783691444637;
        Fri, 10 Jul 2026 06:50:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca54e25sm615052e87.30.2026.07.10.06.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 06:50:43 -0700 (PDT)
Message-ID: <63643fc3-3a3b-4aef-96b4-de42498cf47b@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe
 M.2 Key E connector
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, mengshi.wu@oss.qualcomm.com
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNiBTYWx0ZWRfX3vJIzdVweYyA
 Xmst9JdarkDLzQShGGyy47kOa9Mu/lzDgz6mSlkfe6GOBSa4vd3HJ/CJmn8Z8okCbkPPZVt72yR
 bwRI7qKI7Ujm1wJEUVtkYDF7n761x5Xj9M6bys7UQGZnDQetOu4lcee2TQKTocJSwubpAS+RzQL
 ks/t/IF1VbzZgN3HLMNHmiX6aydvVmkxr27INVnOHTUa56oXeSKvMl3fXL5oi4FqlsfXC42jzZa
 YzAHXRjLA9CAokMl2zk9kmC6514MgY7rfUb9/ROY+I40H689CQxs9/y1YxF/oYQvyWxXSjC33zf
 ry1hp53ymhHsEiZ0zdn/3QNUBUkPP+pd6UQxPq+61O8QrJfYXK25hRofmq8Cctfnvd/lHDTS8/G
 4rp/YSqy1RgsHo33imxGc0+bJNxlzlIlf9O02E5sEBpaJx4Cilwg+zP/ZxiNtymW+sqE0fY27Sc
 Ae+HWdgSfV44Y36cR/g==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50f8bb cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=MVNNC7U5w37-LmZrIMoA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNiBTYWx0ZWRfX7wVa0NVpAaoI
 W1V9n9K8uNX5SuP51+4pErkkkgBAcb2r1RYJ7OX0x/buKBHxmqiRYzyjOgJlJiPWetOwKjiZJH8
 3ghVQIM5QsGsv9xSniXCdHI55VLEf1U=
X-Proofpoint-GUID: yoTeUUoVpzbN6LYBYFqm6xfeRI66CRr_
X-Proofpoint-ORIG-GUID: yoTeUUoVpzbN6LYBYFqm6xfeRI66CRr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100136

On 7/9/26 9:29 AM, Wei Deng wrote:
> The hamoa IoT EVK has the PCIe M.2 Mechanical Key E connector to
> connect wireless connectivity cards over PCIe and UART interfaces.
> Hence, describe the connector node, link it with the PCIe 4 Root Port
> node and replace the static BT serdev under UART14 and the
> chip-specific wifi@0 child node with graph port/endpoints, allowing
> the pwrseq-pcie-m2 driver to power the card and dynamically create
> the BT serdev device.
> 
> The M.2 Key E connector is powered by vreg_wcn_3p3. WLAN enable is
> controlled via W_DISABLE1# (GPIO117) and BT enable via W_DISABLE2#
> (GPIO116), both described as active-low GPIOs on the connector node.
> 
> Remove the chip-specific wcn7850-pmu node as the M.2 connector
> approach replaces the WCN7850-specific power sequencing with a
> chip-agnostic one managed by the pwrseq-pcie-m2 driver.
> 
> Also add 'compatible = "pciclass,0604"' to pcie4_port0 in hamoa.dtsi
> to allow the PCI subsystem to associate the DT node with the
> PCI-to-PCI bridge device.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---

[...]

> @@ -1025,19 +1004,10 @@ &pcie4_port0 {
>  	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
>  
> -	wifi@0 {
> -		compatible = "pci17cb,1107";
> -		reg = <0x10000 0x0 0x0 0x0 0x0>;
> -
> -		vddaon-supply = <&vreg_pmu_aon_0p59>;
> -		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> -		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> -		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> -		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> -		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> -		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
> -		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
> -		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
> +	port {
> +		pcie4port0_ep: endpoint {

"pcie4_port0_ep", please

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

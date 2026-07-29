Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C348124F
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328298; cv=none; b=lhBREH6pIUswiBeTmAlVZRqMUfCqg+lnTje7BCoca0MPc1w+5G3T9i7K7ncHkPn3akPdJ7ScgLihBFjcFEPdkPGYRYWBV4rrKwGVa9t9xr7sV2PqNk6udO9AwZAS4C2tqjm3fzILGnurllFiT4ggYsqLW+dpPu3/Sb67hxGa1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328298; c=relaxed/simple;
	bh=K7JENK6sa1LbpG3FYRwucrEeQvC/xIG5ldJRqbSaYOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhNwPhW537ZiFmAUUgT5MsW7EYGS7ueL3bQtieot/V1SW2Oy9Gyn8hjkShpsxa0S/QlfINfN2u7YQB0GH7CXBkbjOKu20DuabrhesFkq7L6FIYtj5SrO0OyTEPU34zJRDkIuQKwssAkOiCF6W1BjHLMkyluuP4GNQNQ/XPUFf5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oimkaaSG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f8pzdW9V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oimkaaSG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f8pzdW9V"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBXV0S1218101
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 12:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lxiDiTYlOyIpoH+2VCVs4iz6grC8x089+hk593hC4o0=; b=oimkaaSGYveBTVoV
	NF53THaowvNxWrC4+ahInrr7lPlHlaj2dt7cdHXh7yQsp1anuipsBiiZWGgZX1nE
	OzbVZWbolbrK9WZkD8MNuOBZO2Npe+0CFnB9aHJcI5np66pCARahSPetP6v1qmKy
	rG5YMf3XA+vKy9BD8ld89TYf2fuQ/tknyCnhWum5lbwhaYTmy9hl8JbCX26RPQLe
	jXCIPhHupJLakuDls2Oel/5ZvE63fRaO2S2bV+SiCnXTpcnM+y8zNtRYszmCX/3n
	8sgpZ1Vj96aQLGfc4dmc+1tWcjmIU2zLWP4UEImOefuNI86dSxG1WGs8/09K+Wgt
	cjEmBg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj07hv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 12:31:32 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bfc23053f6so17082e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785328292; x=1785933092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxiDiTYlOyIpoH+2VCVs4iz6grC8x089+hk593hC4o0=;
        b=f8pzdW9V2f1amQtrgm362KNmOSxSGhPbcOynvBNqehkSQguSJXiSB3RJqNmjjG9Tsj
         kAT/5bdDOzFKpZ6RN+SA9CUPOEcSnOrjR1EiuoAO/UnIrkOY6+EWpt7lRfw16zrrTYWy
         g+Urrc6pg1MRe3UJY5IF71wfRheFuAad/RGUuVr3gCdi4I66eMFoPpVd4dvZBy15hc33
         A1nzQDN2V4+I6aO27L+zWpQwoPltBW0kf2HnpRpZQM8jXPcc1os+RxkZkZUnYchKY8c0
         81y8ldYTWKUSrp3u+XdamC4h7ClN/nPKRiuC6kxH36QU/Nv8nNOLCnqq6BlyrWu1/bIz
         XW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328292; x=1785933092;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxiDiTYlOyIpoH+2VCVs4iz6grC8x089+hk593hC4o0=;
        b=J4mqr/Fsxua6SAIglDNo2amsN+1J8IIbef59XmOsZs0rQ+xoriaCfbQ+Baf7SE8iKt
         mzdDCkJLWaAUBaVax5eT27vW/sPKE4exe4gDisf86/xopFTIekv/qEdg3TazdytGnEuA
         ln0Hs2uZt8r2UVbm3AYaibWwGqJY9SpRY/YZHIdKqoOPgZCC3aah53qUo9W0xv3+3KRf
         aZnwqk+8Yb/9PWEio6q5i1MUFlGVMQ2SniJ5Dk0s3IJUXLQ20N6Z0RO6hJpfEUpujvpF
         bZlM3s7su1gI30/am94K8y8NLgygK+FY9lIVqYZ/Iq6nAQge0CBla4aFiohzToHjLrGH
         qcLg==
X-Forwarded-Encrypted: i=1; AHgh+RonWE416nfnChNcrcjIiSc3HKgxzNF/pPEmv5xAcyPRiNc7A4U9x3kd1vkJbeG/82f0KiKGlXGFMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmG0Q4xFFDc6Irh57M9zmSLqx9WY6UoU5HmuWIGD5+42J26vN
	qU4GeESh2RFHdzHKZC6LgCGU5qc7ajUOyQxa9bAoHUb5kg18CRCTQ5ChWapIwnlXSivCUh66ndm
	ajaERqSsfarUhvVInneeh9j/WC7N24p9mtoIsdFxov7pCTdcjCFcWp4vdbTPN4w==
X-Gm-Gg: AR+sD11FAQoqlL7FGehkB4sAR69hLWjqqekUrTiAsmVj+xkK869uu0g30EwpYzHH4av
	ksow9sM0mDRWSqeHJGINMGf4fOHaSnkOCLkJGk0fas5e0KLm7mB2kUG+lxB3rSjNgDuWS4JB5TA
	ukAc6JH8Bm5Gb9jFo3/N88wEUOCDhapyZepgpP8aMgy2UNZIKJObRCdmsJt4s7APz9HT+1FcTor
	jiwP2NUCGw+V2Q+/xI+4xDaA58fclKM0b3Qg+S6QIuQbPJjH2kwSzrzTn+ZYft3uY/kJBmWge/q
	YL79R81rtuZZNifIMSWUJL2U4M0LHl3kAnjlfoPSQjJ481AnsxOMbKdYpJk77XoSOo+gYeT3Xih
	PK0FMG3J/O/AS3WRHFrmcqCLy
X-Received: by 2002:a05:6102:3591:b0:745:17b0:10d5 with SMTP id ada2fe7eead31-754a1ba976amr1357737137.3.1785328291543;
        Wed, 29 Jul 2026 05:31:31 -0700 (PDT)
X-Received: by 2002:a05:6102:3591:b0:745:17b0:10d5 with SMTP id ada2fe7eead31-754a1ba976amr1357686137.3.1785328290927;
        Wed, 29 Jul 2026 05:31:30 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cde9cbsm109495366b.16.2026.07.29.05.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:31:30 -0700 (PDT)
Message-ID: <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:31:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
To: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a69f2a4 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=iMgkBSKgpprIcW5G8oEA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: ElTPUUZF1MARBhWYxWGaRWsKyTf31YGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwNCBTYWx0ZWRfX4aFGxaAN52fn
 hDnu9/VNe723r9WOAeVvo6WvEhJNVpXCHhiSC0T/EzBeyGT/FNwCgXPdeh+6ByyCktu5J3UBtPN
 snFW0VhhtX1oA0cP8UIKvCnf7v4uViVc7LJEjpYfXpZr/W/rUK+Bmn64hUktMtke9EcY/MPX1zf
 lWOjaRO0TgvHMPW4kTrcETQdt0YHtmYJ8+I2ao4I9Q1oX6ct86Z/a+PppyoeYHk8xdz7IB8/QUR
 8G9dtsNnciLTqbvz+AloJ9em6nrEtYhMJg5XIDeA4hWEZzuv7ezp4bt2Doz5+FfUhNF18hFY45C
 XayU8MW2qOxG4g2HlSrdPO7IvcoINEoVrJO5lzqX4A0Z1n1vzAsV9cwc5PKdLfbXAAA6l6+BD0m
 j6IiSmXgrfh5kdXbckQEKqj7TfyXT3HQBM9kaOFJk+xH8BTBORIerplt9/cpBz7D8m94HMOugHv
 3odDAoYjxy8PrZlCDXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwNCBTYWx0ZWRfX0v979nuxVkGl
 077hVaFpymjoi2nIe0Glc5+UQhFUKMAaInUh/rKfz15NZkUsZIcJl7ZKGiwrI18fFfDZHOjgzQu
 iKdVPHtME6dkn1ymu7jT5xai25KJbRA=
X-Proofpoint-GUID: ElTPUUZF1MARBhWYxWGaRWsKyTf31YGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290104

On 7/27/26 5:45 PM, Rahul Samana wrote:
> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
> instead of the default Bluetooth-over-USB path.
> 
> Build this variant by applying the common Industrial mezzanine overlay
> first, followed by the BT UART overlay. The overlay models the M.2 E-key
> connector graph endpoints for PCIe and UART, and disables the on-board
> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
> used instead.

So is the onboard module disabled? Can we not just use two in parallel?

[...]

> +&pcie0_m2_e {
> +	port {
> +		pcie0_m2_e_ep: endpoint {
> +			remote-endpoint = <&m2_e_pcie_ep>;
> +		};
> +	};
> +};
> +
> +&uart4 {
> +	interrupts-extended = <&intc GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-1 = <&qup_uart4_sleep_cts>, <&qup_uart4_sleep_rts>,
> +		    <&qup_uart4_sleep_tx>, <&qup_uart4_sleep_rx>;
> +
> +	status = "okay";
> +
> +	port {
> +		uart4_m2_e_ep: endpoint {
> +			remote-endpoint = <&m2_e_uart_ep>;
> +		};
> +	};

Let's define both PCIe and UART endpoint sin the SoC DTSI. And don't
mention "m2" in their labels.

Just pcie0_port0_ep and uart4_ep respectively.

Konrad

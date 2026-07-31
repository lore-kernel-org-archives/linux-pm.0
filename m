Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE23346B4
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480849; cv=none; b=HhlBEmiV8/30utAJCZ16tSZ8tT2EfN8VoDs4qzPhPk7tRcqpb3GgA3eQiCCAnxH6YlKvdrvwHZoD4Dfmo07Kvp6bbmqm/w0qVTQM5O8bIh3cSxDY4i/v6Sq30xV2w0d8IqpuXVWX7NrZMIffptsnHYOPgvzW1Umdmf562dAc7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480849; c=relaxed/simple;
	bh=X96EtKQGRkx+GYgOWXgKTsQyCo1hlz/5BogBnNd5Okc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUpuz3pE55BczjmVv4JlaAeT5e0ej1glavEN/JJ337KKt4eeG/ZT3Y0ITITNTzHeiPQM1H2COV/MtHEJhPOALzlQAPNvq1UBVV0W3ETMkoJ2Pp1z8HlRkIlxLtb4KV6Aq2ZgiqDh0EOnKblZ6Fj/Lo4rR8x62pFImBsF13cCjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E3yeNwWs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KceN5XPx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E3yeNwWs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KceN5XPx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V67Vo72961381
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 06:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x8r3nwsUV7dCZxExVXM2EEkbrRp98mWiLhmFsQB5NK4=; b=E3yeNwWsxku+9GAl
	R0JtsbAyXzjwygvQHEnG0ZBGKHDLqgfWSA1gE0prS1AUGtVVoA2CZVxzoeohqhXg
	0aDSvP5g6kFJTG0ed3U/Q9uKLbzr88R8RANTNVz+qOM6VkzfdROnqz1JNCYFIRzD
	YBsOMFaa7LqueSAN0fLZoN+12gnWBCtIDEdFxfiKlpoGZljQAOIBxb5aSfGLERoh
	vwveEzaRu4Xt0T54nVZs4kRK/rR460u5Hwbr30ku3f2fuaY81PzLTjt8dUd77gCI
	QrA1HwY3+UF909oGPG/nApXK+7jlVljcG0ynykbPloZwmVgAZb33aRrVbiSwJrC4
	AssJgg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp5kg5gx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 06:54:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc86a9ef97so11768935ad.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 23:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785480841; x=1786085641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8r3nwsUV7dCZxExVXM2EEkbrRp98mWiLhmFsQB5NK4=;
        b=KceN5XPxSiI6Hn2rDCzvs+ARvLWbldxL2P4sFU82VJ9N1lnjdwtEwkWoN/BnDUL17k
         v/K0Mm6QrMoBN7J3L3BD0Xl8IBPRX2UnZYzZhlRuFqlpf41Yxk7IGShyzhO6JtuhGaS9
         5CECjCpGq50o8MFog0DnSKhPWqbERt+Xhlq70Lfxt8SGHCM9Ravy//BX/gVbyNabFB2O
         qLQ2RjgXJ/q8aPJZHfjJbX3NCh6A8cvpCsUnEXlZxuvGabTP9ANkwVzK/H89UXnRdW+G
         kLWugH1mNaNuHXsVNQ4lw9mqMtMiNDV5zFI7xhAVTWs6g0ULHAa7JzxVOO6EUbR3r7vg
         5wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785480841; x=1786085641;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8r3nwsUV7dCZxExVXM2EEkbrRp98mWiLhmFsQB5NK4=;
        b=LFIh54qlbUmcd+VPQ2aHcgZlb3vzB3AZ9NqaC8u9rmziCg+tVSjXkYr7b+I7bAwwDe
         LVPWrBoP4U1r+CYELmrYTaqed0fYyqQWz1SEPV7pQqt2R5t4A9k5h0A/CWkISU4b/YJe
         Y13EopqlOaSQl1BdKhDEbVDqHln3vfI5avaZSeC47doEBaKdP4YdOCwVu1asjLi7bG0+
         z8LAqNg1kgDesVfWOo01/HONVRKQMXfuFC4jrmcPQaWn5FbUiUdKhRDZWCaB5PCXrdRq
         1aTDcKrQP3ltyNZhaH6kmpqWcENy9Kw9C8sOkJLtvIni2gffIBcV5DUQYNBItSkVN2ie
         6uhg==
X-Forwarded-Encrypted: i=1; AHgh+RoM0uqnyNCGZ/o+HB3L6254EmQppGL857uuDuBgkRWCXvldRaJ1LbNfGDbbtISq+q1pWlcf1h4Ekw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhmawr8PS9gAtjnzlLZQnfofoAgXIPpkLQ2Tv2Q4WImPsasy8N
	5WHba58sLgEEJ8KgGBQundpFQR3+jfzcabNesnObujkdscYxfCcooWstZkuVVBGT1peVITM8eC6
	yMs9jYAMgfKhmezb+C9ZJE9bmKtubGv9c2/1BT2fu3KXJpqV3aOEEcahuATGuzQ==
X-Gm-Gg: AR+sD10J9LiAfjCchLYkyIUZAMbSRFqNm3SyqQzu9flwyCozbzD5Aqd6kkTX8AttO4Y
	A/FZrJ09gokRZod2XRM91BVyehl3LxuuqoBZkkMVPeZr53t8bIIRlI9ETQctGEnTQQ0EAicH7bF
	pn+ln/WGqjAwCKhsb/cP93ueI1Hd5t0LK6cVvro4W+iXd00oAbxcMewsz0d/mZa7PB8TEnXHk1J
	7+VbV2cYZb9RUL2eyNOa44LjwEl4+vgtsMS0IwPLoUYTcYr+N4piJGoFabH+GLuB7CgEdCm9c/G
	P8I/U7uV0QEzyRl0ktAVeUNpBsWnu/reoaplqfM5LZrPJqo3oKmEVY/DbnlMINKxp+6OPiASrew
	bx3hWBcgC3lhMGHAOX4jREsKJsrBi8wWf
X-Received: by 2002:a17:903:4b08:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2d046eadb8cmr9012195ad.37.1785480841638;
        Thu, 30 Jul 2026 23:54:01 -0700 (PDT)
X-Received: by 2002:a17:903:4b08:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2d046eadb8cmr9011935ad.37.1785480841193;
        Thu, 30 Jul 2026 23:54:01 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b15914bsm1273885ad.74.2026.07.30.23.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 23:54:00 -0700 (PDT)
Message-ID: <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 12:23:52 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0NyBTYWx0ZWRfX2w7Vef1P4QeC
 UUTRO0CuMuV6hkC+z2HyS6bh/tKWs+hwmURba+srRNuD7Hgcym/ZGdPVTvFtwlv4pz12xwRtfKy
 p9dxangUdeWsnJGpD2twHKazN5Pjzao=
X-Proofpoint-GUID: srruTqBlwPwxhQQ3RPpph5g-udUEk5Xj
X-Proofpoint-ORIG-GUID: srruTqBlwPwxhQQ3RPpph5g-udUEk5Xj
X-Authority-Analysis: v=2.4 cv=c/Obhx9l c=1 sm=1 tr=0 ts=6a6c468f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Lfqoa_9HXnV3lTQsdxcA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0NyBTYWx0ZWRfX4S6XbmUBTukk
 0ckjJiqsL9qVuIyXaOu2CYWlWhKQK1HBge+rgZZ8WpB9LgZEo2zqBjc9+PkLV3NimlfAVdN/Tvc
 T/mmK0IZR7x2/JQ/AXEs5W2ZrdZyrGyMyPVM3i9L1aUaF8ucojzZyeKr3NNzWQHq9tAvi0E2jY0
 bVKg5mdlbNdkp2e+Pz2ifs+6BdgYTAzaocUCKkYe2AjKlD0kAXV6G2YAdcf12CVBdFMFtbbji8r
 sFzLoh+Zuny/+ogL8Fbm1PV2FIJBaaxJlkXdR395BUlCTZFx0HC8K4BvFFjB7A4dlIV1o6CrV3O
 f2FLkWnOePGyiKymgyh05L+YpXlNFKEqHqkKF5bZuram/Rk1X2wHp3YquRxYGJZZpryPhhCJiHq
 R4YC6EDGVwr+67zjetYwGFaMVNMAJd7ltLqUId502qRUEov+kOUmdVEMJHQEDGV57Q5zf5uf9O2
 6jalJyXlIIsHXt39MxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310047



On 29-07-2026 18:01, Konrad Dybcio wrote:
> On 7/27/26 5:45 PM, Rahul Samana wrote:
>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>> instead of the default Bluetooth-over-USB path.
>>
>> Build this variant by applying the common Industrial mezzanine overlay
>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>> connector graph endpoints for PCIe and UART, and disables the on-board
>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>> used instead.
> 
> So is the onboard module disabled? Can we not just use two in parallel?
> 

The Industrial mezzanine variants do not support the on-board WCN6750
wireless path. The common Industrial mezzanine overlay already disables
the on-board Wi-Fi node.

I will move the on-board BT UART/PMU disablement to the same common
Industrial mezzanine overlay in v3, so the BT UART overlay only models
the reworked M.2 UART wiring.

> [...]
> 
>> +&pcie0_m2_e {
>> +	port {
>> +		pcie0_m2_e_ep: endpoint {
>> +			remote-endpoint = <&m2_e_pcie_ep>;
>> +		};
>> +	};
>> +};
>> +
>> +&uart4 {
>> +	interrupts-extended = <&intc GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>,
>> +			      <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-1 = <&qup_uart4_sleep_cts>, <&qup_uart4_sleep_rts>,
>> +		    <&qup_uart4_sleep_tx>, <&qup_uart4_sleep_rx>;
>> +
>> +	status = "okay";
>> +
>> +	port {
>> +		uart4_m2_e_ep: endpoint {
>> +			remote-endpoint = <&m2_e_uart_ep>;
>> +		};
>> +	};
> 
> Let's define both PCIe and UART endpoint sin the SoC DTSI. And don't
> mention "m2" in their labels.
> 
> Just pcie0_port0_ep and uart4_ep respectively.
>

Okay. I will move the PCIe and UART graph endpoints to the common SoC DTSI
with those generic labels in v3, and keep only the connector-side wiring
in the overlay.

Thanks,
Rahul

> Konrad

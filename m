Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DDA3E9C05
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520220; cv=none; b=Pwy2C1JDnk8pecSlRamTwB27kyc5J5Xz5beFBJYUI/8huLIUN5qPPWAzYJKt5WFb0lCNSuxCYKuW0Lhuj0PVQH2xxLdMEffHkIgxhkSn2Zgus3Nhyi1p4L8KRi7b27PvAZ5rKOg9ZnoCvwGMnk9s5XqHCAMPP7B2LFgqT0MReCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520220; c=relaxed/simple;
	bh=W+jYCexIEEQ0uU8y51WVpnMWkSUysalkAisSyNtFft8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEiS1iqhhE5W/nmZX1rzlTmq5POHsNcSXF3IFrP0R6Yh26w1Af8ovEcGxCggnyAtGyZR74AIowTK1Ih9wRBn75iSRRreC3eX0yOQRJxSvOYPSy1ltvwfqoc1ZTRXNWDCIgW4NwQHWT0re4EXKCT8BUdilvGsLoWRoZomN2wVeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WylN/WvW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aGlkblPy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WylN/WvW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aGlkblPy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFNwrF019766
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 17:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P701Iru64K2mSQrogLQeosSLRzpER8DGLClpum85WkU=; b=WylN/WvWm4a3hQ7l
	gR3enDQS3p4eFfYf0588nOrDLV9/FM2qvAcZKlKQSflCDuDxAjrB3DQETg+96Y69
	N40bAl/ojeTE2hi8KKZXI39SbtPK3qu5zzx4i5NJ0u9nJUIiIjIywx5OaayQdh/6
	ZGOesjdSKCOTUEfxCqEsZaZIzqOJdRRYSkGOc/g4/lc3GnPuF1lBdvWFAGbP3fUB
	14ImkqtqENwuQskWBHX1IUXllnZrqmgSTgTfiynA9c8LG4iXXd7+Qf3Luk680xjy
	VpLzpKGCPQYL6iwvJvdRlY+ewaZJJrCihYNj5uF3UivstPxptN8WRX2rErHq9BmY
	lZdl4A==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frugh1hwt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 17:50:18 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4ab4af22d09so1615339b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785520218; x=1786125018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P701Iru64K2mSQrogLQeosSLRzpER8DGLClpum85WkU=;
        b=aGlkblPyNoZ6V0flfTJNoZ8aeGzru0CMxlBYaYUI78TcZp0zMK3rYT+leXstx5uY4M
         0dcTRjPFRV/5A8IVG8KpNnDM154/gH5ohcT9tvMbyA1mjRXfCgOHkIfmkgDUibx05JdZ
         ZI88nKqKfqwu8gV1YMlOsq9YnPjmgL/7BWURl5VAhEM2nLb1Y2l5UZCDzK9UwQVyMuNv
         O28cZnDZKs/gQMGcVQDTdPb89slh5qULoHu9K2+aOcelpSA+XTDLaHb7En9TS1XSpbWw
         57edD3reE1L6Heq96Uk3/7sDLhRpsIe2mWwGcGwRfCd/ax2ckti2GU/TziX7R/eE9vgD
         iX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520218; x=1786125018;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P701Iru64K2mSQrogLQeosSLRzpER8DGLClpum85WkU=;
        b=BNmGdZbjniv9ZZHKQ+p3+aq0iPYtNgq0tgfNoM1zTvgta+ARzhMUbOTECN2wdpNNVC
         8a9i5fDYTBHwmMdujEZSbhPskIgW8jNz2+YVXuxAzirlBx9aCoiA400Ya2p2TZV/3WQ8
         Qm179/ZNZxdFQpnbowZG1F9mwX+BvDYdmyyaknzbfHYYxRt+2+XUAOWwtI3QbTMLnhiR
         ByzJeR5mVDghUG9LVc+mpuZgMeIvJIpgMRgx6su9KYnjb/3qZqbpEnwLnyG4wVeRro+M
         oUCmder1+HB2JYjs5kzU/t1hHkEKgAxpk6WdkKvFgM9VqwD7DDiAcxd29zec9YGwU7Eq
         zk5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqj2weRwutVVWN6RXiMScaV7vTxUVP1UenpQMuGkFYAZyhu4NToQq6oEaF9pbgB5ZGRp5mkbeH07A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqv55kkXOoooEAfUMPwyqTzCZeAepBOdY34KABtWFm4g0weE4
	ZmtOtyBlhhtyCstI178Jpevkqlpqb4QtZo/bNpzIBSwrFmPtMR3wZKozRlS2Dhwx7szJvp+p6Fk
	jUwsUfATNrXcSsa0g0rDR3RMqRMt5EOFypaaIKXPXd7PQPLNicEH2wPSzjrL5ZA==
X-Gm-Gg: AR+sD10ZRRnw0Pwku/1rWODed4fOGOQgCnCx8ukk/I+77MtSsV6CRUL8tU1voi3GVKE
	LTDj2ovf9xqZY/zCySLhVfW1aHtucb1S23/By/vEKcpPFL77NVxpBDOKNEAw9Ycb+gYCHaLmdW2
	Xefff2u8XC7zQ/tNLfU7rTchLmPq5/2JkvWA9O6/XqeNJ+JAfWSCgAJJQWjIJL6pTvuADmhtNeK
	YDXOpWnnTeNd7q95dPjTsFXC36l46G6YIdDlAXvtfkdEvr96JgCaiSnJO0F6e7TLGTPlB0mHygF
	jiJYhjP4XkjaXd8fIT2smWn5lxJTiKMTS7BN+l/9ncxSXsOrDZHC65aVyeomosM8NubQLWRAlgE
	OC7+71vtxOgbvv7Xi9htH7ILhAFdkVzii
X-Received: by 2002:a05:6808:2384:b0:496:e0:a47b with SMTP id 5614622812f47-4af5e329e27mr1603426b6e.20.1785520217688;
        Fri, 31 Jul 2026 10:50:17 -0700 (PDT)
X-Received: by 2002:a05:6808:2384:b0:496:e0:a47b with SMTP id 5614622812f47-4af5e329e27mr1603356b6e.20.1785520217171;
        Fri, 31 Jul 2026 10:50:17 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58933884sm1164801b6e.0.2026.07.31.10.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 10:50:16 -0700 (PDT)
Message-ID: <b5afd21c-4516-4a8c-bc8f-6598ec385d27@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:20:07 +0530
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
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
 <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
 <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
 <6d61d749-440f-40ad-82e5-e1e909afad06@oss.qualcomm.com>
 <b47345f1-1c7b-4424-9c6b-3dd02c0f4ab6@oss.qualcomm.com>
 <bf7821a2-d813-4f89-b891-9c26d228ae67@oss.qualcomm.com>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <bf7821a2-d813-4f89-b891-9c26d228ae67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNiBTYWx0ZWRfX6jVohcOD/LlQ
 aWy9p8mVtNvEouP2sEnr5Pn7uMRiaA9oXvUMp214yxOB0qoZIsTWZqXNak1ZxxuBsQK9oJ0oinx
 UXJxcCSl3b4OuRvvgaTPn8iIENddaJChnqaHUivl3yWA6oRyQ/BCb5nj6gd/haokrzurKbkcmcZ
 sNdfaEseLLWPwBGFVZX8jYBsQt3nBXdCSGxx5GiVNDth4CONYbMdAMdSfOVnkyDNDn7GQ5xV2Tn
 g2AePjtvpekdSk41Y1yNIAfe72iy4evNJVVJ0XUizBoC5Oqo45s6ffvrvvUufZ4BIePPIhIDNYY
 5kmcsFhvIQjIGUF4wXe6aVGSkGcsrc5lsOjgmWp4QYP+A7JKwXkgzQhjVtrwIy29CLgcyocEHqB
 ySB8vyty3+QH96Vwzm3D0zM3p7GCUmcs/w07QJptHc8mch7tLyiznxop0tBrs6OsCBxvcaeMDNl
 u/NfN826Je4aoHsa1NA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNiBTYWx0ZWRfX5ejcCQLNThcE
 dXdh5NvssaddcbbXAJzaMLGJujZrJyyVmATGIn7hEI3UqhTRvzaNwIUe74cb47oObBXci+WUdaq
 Tg9TYZb/TbCnD2HE1YEL2fxk+muUsSE=
X-Authority-Analysis: v=2.4 cv=U+iiy+ru c=1 sm=1 tr=0 ts=6a6ce05a cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=sZyqPLha_0TG7Fz-sX4A:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: 3CRWrF396Z6Lad9ROMmJwvlJ068dohwo
X-Proofpoint-GUID: 3CRWrF396Z6Lad9ROMmJwvlJ068dohwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310136



On 31-07-2026 21:19, Konrad Dybcio wrote:
> On 7/31/26 4:48 PM, Rahul Samana wrote:
>>
>>
>> On 31-07-2026 18:20, Konrad Dybcio wrote:
>>> On 7/31/26 8:53 AM, Rahul Samana wrote:
>>>>
>>>>
>>>> On 29-07-2026 18:01, Konrad Dybcio wrote:
>>>>> On 7/27/26 5:45 PM, Rahul Samana wrote:
>>>>>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>>>>>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>>>>>> instead of the default Bluetooth-over-USB path.
> 
> I only noticed this now - are there 2 variants of the industrial
> mezz being sold concurrently? Is the already-in-kernel one some
> sort of a prototype SKU? i.e. should we support both?
> 
>>>>>>
>>>>>> Build this variant by applying the common Industrial mezzanine overlay
>>>>>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>>>>>> connector graph endpoints for PCIe and UART, and disables the on-board
>>>>>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>>>>>> used instead.
>>>>>
>>>>> So is the onboard module disabled? Can we not just use two in parallel?
>>>>>
>>>>
>>>> The Industrial mezzanine variants do not support the on-board WCN6750
>>>> wireless path. The common Industrial mezzanine overlay already disables
>>>> the on-board Wi-Fi node.
>>>
>>> What does 'do not support' it mean here? They are physically present
>>> as part of the SoM, so unless the lanes are somehow diverted away,
>>> why is it not?
>>>
>>> Konrad
>>
>> Hi Konrad,
>>
>> The WCN6750 module is physically present on the SoM. What I meant is that
>> the current Industrial mezzanine devicetree already disables the on-board
>> Wi-Fi path, and this BT UART variant followed the same board-level policy
>> for the on-board Bluetooth UART/PMU path.
> 
> Okay, and do we know why that's the case in the first place?
> 
>> For the endpoint labels, I can move the UART endpoint to the SoC DTSI,
>> kodiak.dtsi, as uart4_ep.
> 
> Please do
> 
>> For the PCIe endpoint, the PCIe path to the M.2 QCC2072 device is not the
>> PCIe0 root port in kodiak.dtsi. In the composed devicetree, it is
>> behind the Industrial mezzanine PCIe switch, under:
>>
>>     /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0
>>
>>
>> So placing pcie0_port0_ep in kodiak.dtsi would not describe the actual
>> topology.
> 
> Yes, that was an omission from my side
> 
> 
>> I tried adding a generic label/endpoint to that downstream port in the
>> Industrial mezzanine overlay and referencing it from the BT UART overlay.
>> However, when the overlays are compiled separately and then composed, that
>> label is not available while applying the BT UART overlay, so the composed
>> DTB build fails with FDT_ERR_NOTFOUND.
> 
> I think this generic description is simply not achievable today without
> a bigger plan in place
> 
> Konrad

Hi Konrad, Dmitry,

Yes, both Industrial Kit variants need to be supported.

The default Industrial Kit uses the common Industrial mezzanine hardware
description and continues to use the existing Bluetooth-over-USB path. The
reworked Industrial Kit variant keeps the rest of the Industrial mezzanine
hardware the same, but routes Bluetooth over UART4 instead.

That is why this series models the reworked variant by applying the base RB3
Gen 2 DTB first, then the common Industrial mezzanine overlay, and finally
the BT UART overlay.

For the WCN6750 disablement reason, I will re-check the board/SKU details
and come back with the exact reason instead of assuming it only from the
current devicetree state.

For v3, I will move the UART endpoint to the SoC DTSI, kodiak.dtsi, as
uart4_ep.

For the PCIe endpoint, the exact PCIe node is introduced by the Industrial
mezzanine overlay, and a second overlay cannot reference a label introduced
there. So the clean label-and-patch model suggested earlier is not buildable
with the current two-overlay setup.

The PCIe graph endpoint is needed for the pwrseq-pcie-m2 provider to
associate the enumerated QCC2072 PCI function with the M.2 connector. Given
that, would the nested patching style from v1 be acceptable as an interim
solution for this variant despite the concern Dmitry raised?

I am open to other suggestions if there is a better way to model this within
the current overlay structure.

Thanks,
Rahul


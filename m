Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF0400DF6
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983794; cv=none; b=BfMcP87tFPPGLeq1UeTmlwOdf/zQAipibpCeJBV7v5hq4lXTIb8/oHDB+OFY3qB1N2xE3wu0Ay91Ox0BnCld+49OHO6YOeQpGJ6uRkr15H+yjD4FbD3stNuL3BP8zbYdxYrJX9nyCOnLRrbL9HAAbUDrxPb4zga6ZFrrCdC+Dss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983794; c=relaxed/simple;
	bh=U7YdXAJ4ITyF6ZKndT3lGcKju51uo1JDSJZg7uAQLkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzmVp7dr+PIZxe2rTA17GZZEgLRYT8PVmnnktQH2wc81a7W5LjOrCv5QMkALVQEv1pMTt2QCCEOR1aiVx8NxLqNpnUPAeftfVprtGwstG/dSq/MiN80WQp/RK9RwIPwAnDWee01m/CBn6P4sVcVJ5+yl9Ftfnso/7fq3GJJylOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=loCM9+yG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gmPFUV97; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="loCM9+yG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gmPFUV97"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vqJp124476
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 15:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mJvUVRi0vvfQLNiWak2YMqZx53Wx7cTd4RQlSZ8GwSw=; b=loCM9+yGd73E4j3l
	Oo3ph4qkphPFUXv/aUtrcTG/20IJgjJktbu5r6EQQZ9xK7IK+IATcE6IeG1Vpnjk
	IAEmIioJIdA1oyx+ssIgIFLcw1azNwvJUeKClc6MHa7n/0leFQ5g45pI3rL8uS9A
	xj31Ia1Y1HztysA8G0AzmdEufA2fYdfzjTzacfkJJa0utCg+1uXApw48g5/aPuFa
	GlwfiD/WEAODMKSxy1ekqLSy6JQRg8Nkyq+qdrJKLQUkC1TW2iaZFLELjIIHmJmN
	4NIl4abhhMlIKYz/9PWe4R5aSI36id99n5KIc7uLINXE36ocF18S7+wgEt7jCAcH
	TIXV0A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycbhk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 15:56:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2befec3fd8fso8716275ad.3
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779983791; x=1780588591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJvUVRi0vvfQLNiWak2YMqZx53Wx7cTd4RQlSZ8GwSw=;
        b=gmPFUV97VRaDPJYagsnkGFViDwOXpzjPM0SbdJGAq4IS04o4sRL/+Aie7L+rspAWRc
         Q9grU/YTthXaolCmATJj8qg/iT/+6IJyann5PX2m5ZOnGHOls8xQwO9JY9rWXfsIr3rO
         L78AULLK9iiYO7WwyoTvNtrebLl+yQfOUlg8Rz2Qf7s8DB7dxPXdl+9ZSzOsZBpugQx1
         z2af2wCs0IwUoUC5VrmInlx0nYpnshPQh3dczvj4LEGgkOGk04vJiTLMKYAPhau5KbYA
         /mduJh/tWp+MCUl/gyCfUbPo7/y0vfga17Cpw6NAOevnb/GCNquX0Vr5lbnROwMZ7w1h
         4URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983791; x=1780588591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJvUVRi0vvfQLNiWak2YMqZx53Wx7cTd4RQlSZ8GwSw=;
        b=Y1nbdbsllv9TcGFu6+EWXo/S/KvVYcyeALwWcXIKaY47o4OD6c7ZTrrI39d++ktdHC
         Z2z/SwUthPKluaJrhA5sXcTcMZusTI3/Jgb2Rs+cjWDNugKZLbtmUDOsiD90jcdKNVXt
         vidLzFEv1f6ZHoBL1UklxSfbYp4OcHP2UVRhoCKue3zx+sL7YaurlK5/rDiJ0fgHDAYM
         hrNrqXios4mmYJx3c+BD92fV6uBx44aCKhsWvqIgTIIJZwjSzOSRJ0OUVWFoILSnoPE0
         4pEC02D4tHRfCujt0ij7/2mHZKc0bINZkOyt8vAfTCrjmm0urzHHNqfC8R3JBjXuwfCz
         8zeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jxg0dlzcIUi8DX0pUUHZCn0uZbFqnpgCVKB0BVIVIHNx9wjcaxDgJ18NBYa8TK5/IeG8JYV+68w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1GFuor635+4367mHju5LpjDjwjjshdNYB6xujn9BvvbTLMds
	GRuFjLX94NYkApDzATg9a2cS7N1CaPPu8UKsAPihzJ90GnKmXnFiUVCYgn6HJOHhv+az7t6ON6q
	GzUQzXY6UP+xgQalKiMttZQymGykmuDuePQcGLC0gVgFW2mBmdTBRvpkKoxVXiA==
X-Gm-Gg: Acq92OHlS7M3H9rMcpAEtf71XdUwIYzWiEPgIZ66juITsR17vSiGrtwXaHNC62O98Ca
	yO+V+6yEnhw2bQpf7qEZvcbFPgaDipihLkV4oV85Nc2NXx/RUomV2S9q/F0cCsvD4D5j39K2dGx
	7IqgF0XAeRQhDnrOBFUErx/vtMASOyd6C8xUPuhvyi/vADoqxt4jyapfqjX8Qhv+O4FO/69IqWP
	+JgaRQZmIuU2j+bZTz5xEjsiIB0rZE/R90TX/kSWuJ7Y9PnGRnq81TiWBK2P1FkhaFaLRkB0yLx
	KMwnZ92aBKDypJH6G67aBgpzwCpIxCLblevK0cvDJb+LvWrFb5CD2pigGFyZL51xH9Sncjo42Xb
	1EaC4fJq5XX84idkLOkE11pTe9hN6tWn154PzbtXTgD7Kq8C/9nNFPBmq7XdiEWw0HX1oRZL0xP
	ddAxhSDkt7JuxcgRscPuk=
X-Received: by 2002:a17:902:f544:b0:2ba:6ed6:aa35 with SMTP id d9443c01a7336-2beb05e4133mr311390935ad.19.1779983790937;
        Thu, 28 May 2026 08:56:30 -0700 (PDT)
X-Received: by 2002:a17:902:f544:b0:2ba:6ed6:aa35 with SMTP id d9443c01a7336-2beb05e4133mr311390485ad.19.1779983790343;
        Thu, 28 May 2026 08:56:30 -0700 (PDT)
Received: from ?IPV6:2406:b400:28:d1b6:cccf:f0b9:3035:3538? ([2406:b400:28:d1b6:cccf:f0b9:3035:3538])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3085sm181890915ad.53.2026.05.28.08.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 08:56:29 -0700 (PDT)
Message-ID: <d44a3924-f60a-4d41-88a2-280f3d8b71e3@oss.qualcomm.com>
Date: Thu, 28 May 2026 21:25:25 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] arm64: dts: qcom: shikra: Enable BT support on EVK
 boards
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <ysiddu@qti.qualcomm.com>, hbandi@qti.qualcomm.com,
        rahul.samana@oss.qualcomm.com
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-14-f51a9838dbaa@oss.qualcomm.com>
 <rbu5oub4uc4rubdlfth7undrirlyfwbnst5clgyvm63fde3tcw@fulet3k3a4sf>
 <30a33da1-6424-47f3-9e7e-a09ca61a1234@oss.qualcomm.com>
 <6lkpmjtpozsfrk6ljnzwek7q3kgj7t6cjzre7k5vijx4ta6apu@bdotfbblxpu3>
Content-Language: en-US
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
In-Reply-To: <6lkpmjtpozsfrk6ljnzwek7q3kgj7t6cjzre7k5vijx4ta6apu@bdotfbblxpu3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a1865b0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pS9QfrAiGz98euA4Ec4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: v5ha8B3QmvbULcvV9dFbXlKf6f8-JNVi
X-Proofpoint-ORIG-GUID: v5ha8B3QmvbULcvV9dFbXlKf6f8-JNVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE2MCBTYWx0ZWRfX+5P6pwiUgb9U
 dreTHFq89LlIMkHokWIlg3TMwPGR5MvD6SH79uy7YtVChLzpatx2iQcGUAWtOhWf5HA5u67/235
 5sACnBZUxeFdOaeQVcI/OClBWCKI6VnuhMczsqTglUjfiJE15cb5Ras3pDctIP20yoynocRq5/n
 5kxX4t//cZrJcs1C6/SztbXT7xx2WRZYSB6F3S0ER94vDT7oQDcksDVVG9fMqC8v3zz0B+xPxwG
 SLjcq/jJWftaiJow3iaTu5CWif+cL+p4bYAudfvq9D+zxXBt9yGzRmsQkoPty5rl0TruY0Hl+dH
 6d1ZJQWW5yGY99qz2GzFcH8nDxc8A+y9jEVSHRemd3x/Ij6/ho0BELQOP/a1x1VNGVOQFf8UONl
 8vyhSSVyWLSobaEj5PlnloeuSoKLfFTKyHBeCsbMWsIu66rzvU/oRuTEG2ZulySLHekrp1qaGac
 PmQH4bm9SdbZs4ODl+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280160



On 5/28/2026 11:01 AM, Dmitry Baryshkov wrote:
> On Wed, May 27, 2026 at 06:53:30PM +0530, Yepuri Siddu wrote:
>>
>>
>> On 5/25/2026 3:01 PM, Dmitry Baryshkov wrote:
>>> On Mon, May 25, 2026 at 01:19:18AM +0530, Komal Bajaj wrote:
>>>> From: Yepuri Siddu <ysiddu@qti.qualcomm.com>
>>>>
>>>> Enable uart8 and add WCN3988 Bluetooth node with board-specific regulator
>>>> supplies across CQM, CQS and IQS Shikra EVK boards.
>>>>
>>>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>>>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 12 ++++++++++++
>>>>    arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 12 ++++++++++++
>>>>    arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 20 ++++++++++++++++++++
>>>>    arch/arm64/boot/dts/qcom/shikra.dtsi        |  7 +++++++
>>>>    4 files changed, 51 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>>>> index b112b21b1d79..259032bd20af 100644
>>>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>>>> @@ -16,6 +16,7 @@ / {
>>>>    	aliases {
>>>>    		mmc0 = &sdhc_1;
>>>>    		serial0 = &uart0;
>>>> +		serial1 = &uart8;
>>>>    	};
>>>>    	chosen {
>>>> @@ -57,3 +58,14 @@ &sdhc_1 {
>>>>    	status = "okay";
>>>>    };
>>>> +
>>>> +&uart8 {
>>>> +	status = "okay";
>>>> +
>>>> +	bluetooth {
>>>> +		vddio-supply = <&pm4125_l7>;
>>>> +		vddxo-supply = <&pm4125_l13>;
>>>> +		vddrf-supply = <&pm4125_l10>;
>>>> +		vddch0-supply = <&pm4125_l22>;
>>>
>>> Use the modern (PMU) bindings. Also please add WiFi.
>> The modern PMU support for the WCN39xx family is currently not available in
>> hci qca driver, that is why we have defined the regulators directly within
>> the Bluetooth node.
> 
> Of course it is, see commit 9f168e4de5fd ("Bluetooth: qca: enable pwrseq
> support for WCN39xx devices").

Thanks for pointing out. I see that pwrseq support for WCN39xx was 
indeed added in commit 9f168e4de5fd. I'll update the patches to use the 
modern PMU bindings.




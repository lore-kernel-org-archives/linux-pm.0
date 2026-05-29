Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DFD3C1F4F
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048309; cv=none; b=AJmvwGUlhmodacAh5NNjA3s38y9hp8wFMdhIuLyzh+07lcIMM1qV4l4CZUp1kH+Lh43Qrgr4Okj3HtkAFV4M9FNlwkYtWPUPE5Ii0laEbW4rIfTztdIFdQo8BoqT5yay6leN4F5Cz7syWV5es2Kxv699579Wjg/2tk4qIGtFav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048309; c=relaxed/simple;
	bh=zoyilBfk5qDO8hOlBWwDvNYKqnHe5RN10J6n1BXF8tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sR6uLUKdHPe0WStsQj2fxsfz41VgV33BDDl8U+OignGDn1zcpotSSYxhzYNP8lsCORlc5Lu9s/Cga14aDPO5G8AMpXHKPHGaKktjhpBgvGEEdjsQnzUUEm4IsYbZ6jkyTlf9+ybK6jTishLL2MJ+aQ+BGoS+Z0SvmAgoEiwEJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UmKtrD/V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DKXtChek; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmKtrD/V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DKXtChek"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T4Tcew4194136
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kb/59PC5N1mTfolTJiRqjQBDqh2SUyjAiE2eqB+Z8IA=; b=UmKtrD/Vlb1grMgd
	5XI19AMj4izHqFDpeHpoNpUfqKZsP2XEM6zXaz5kX5EEZF9W82T/flTpVpJi3M/k
	ZMyp9SNWmhHFOBQFWjy8S0XPjzweWkxll0TddRmpds8ZA1nF6IRwJHGySClBrF4P
	2becXo2opzklkwMVO53N1Mblj97AqoDHPey+cqEBwgcTUjQz++roPthsURDNagdz
	SwwKejLMIWx/sqKW027P1C1TRGKOqhRyWS8p2+ty3dLfCCTepWpincXOz/w0cgAB
	WTkEVzAXxjRzipe07kX9kZnBkqkH8lJZ++MEMQRy3xjUP9uhiv80KezIvbFjGwu8
	mK5R5g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te19f3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:51:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bd4146cb2so250029a91.1
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780048307; x=1780653107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kb/59PC5N1mTfolTJiRqjQBDqh2SUyjAiE2eqB+Z8IA=;
        b=DKXtCheknf6hFxeW7vRZGFB4gWQr5DKeP4nZPRquVajil4ikHUdQ6nUjkEUDaCHHF0
         /AauzyfwA9aTkyXZABdov2rF1c4wlzCQ+6zMAsMylQiAtmaAhDiQbW6hnKzl+DrrDEzP
         uUC2V/62cOilHrFpmogdHIeEND3ymu1JCCS3d7PiTMfJ+KVYs4zzqIYHLzW3PYOeY/nL
         LvTvtwctut2fA9e5/2psVlPkvXyF1ThP3YJYU64e65ch2pGzvNky5gDEAs28mx5yP71M
         ipqmB4Kn4Vy32NmuYwDkMx4FcirETFJsJrCPuFPCXjm1fhMHyVTOL5rBVYKLJ+dUbOm2
         TiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780048307; x=1780653107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb/59PC5N1mTfolTJiRqjQBDqh2SUyjAiE2eqB+Z8IA=;
        b=rvcLwfzjGoZ+s9QvFK8k/xT3xZ7LkC2fJNDsCR72n4H5bf9PYKkpcDwzStpSxSvZ7D
         D9z/6zuTXae1yvmkbd/iJYNNIds1tdTbH773O6onAI62vQTNDReaz3JFeyUTWaE6SLJT
         XhJQtOy+ElZgk72RFpjyXS/5j9pP9exhtNPoaByPzMjnFdKhBU9B3AzMcM0kN45Uj4Ar
         iQf2oQeWO6uBcpDdVkbB1Qn220YWkF7m+f6HrxWigkhnIBeDtgFDYRl3Io83jVGIUc5E
         JH+ENpqAlwpVEVcSpesVQNughQ7FyPYbIYRS/eaNESeN30SetugvcDBS/rz/j5l3FhC+
         CT0g==
X-Forwarded-Encrypted: i=1; AFNElJ9Q+BohVXO0k/osBupf9sD8lx3wn5sitijPn8I+e8Fmcm/JWjX/+LoU0bu6c8lgbFTwB+5ioyR2Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMaf6kJcD4731OQeFSQ7n+jMud8Y9LbPii1wrw87Ie9ouoWJS
	C6p4eqXFGLR9VAGgCg7Jp6HNecPlHIUrmHmQ/h81v57OeCbfn6S6I6LyJPREaaqT816ebtZKrvO
	ah2wZxv3HyrKturVh8H4POzWVcOa51/DVNskXHJxKKGNm2dX2XpHgcUGZA3/D7Q==
X-Gm-Gg: Acq92OEgqNX1CDttpX4gFfD/2FTIfdWteYeTw92IFA44wSyTfAiFQYHsK8Io1AFl4my
	D3ZNvqAv7NCCpd4V8hu0gzSOjKXhj88TwRNe7GesHt5xLgGhS8AXT+e81/3ylPQcBR6iGQBkEq1
	iZ5Sxnm2zPbCNqIwLBqvNuOQEpPGKCzBsGxsxkmykW1FxC48vVTnLRvna0qZjZza14lx3oeKiO4
	3N2P4FNrexrSNDRqD/2T+G58GoX6KaUoKaXYp17Sz3MogG0RgOLA5gNyZMkzX4I1JaVuoiXcuyh
	rDBdEMDTSch1PIwolkL3GDP6jkoXzpHCIz+wUhgKfW7rXa4yT55jPIQbo5DqpISqbgwTn90GP8b
	yQHbI4NN5BfQKgVbnmpZl73c9gCfrLMWqm3PuTdyIooSlwMYKRFneCdWJc+8=
X-Received: by 2002:a17:90b:268b:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36bbeb52b1bmr1787565a91.12.1780048306713;
        Fri, 29 May 2026 02:51:46 -0700 (PDT)
X-Received: by 2002:a17:90b:268b:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36bbeb52b1bmr1787370a91.12.1780048305759;
        Fri, 29 May 2026 02:51:45 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c3d44fsm1608825a91.17.2026.05.29.02.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 02:51:45 -0700 (PDT)
Message-ID: <924cbe51-2f70-4d62-ad8d-51a7cc7d1656@oss.qualcomm.com>
Date: Fri, 29 May 2026 15:21:38 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] arm64: dts: qcom: shikra: Add CPU OPP tables to
 scale DDR/L3
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
 <4ugjyb73ftcjypi6wfqz47j2vvvfxj3ljunsqlixzdzzajy72c@3gb2bnx7coy5>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <4ugjyb73ftcjypi6wfqz47j2vvvfxj3ljunsqlixzdzzajy72c@3gb2bnx7coy5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Qt5D0owth5DdWmMdJmf4OjO7LzDIJMxw
X-Proofpoint-GUID: Qt5D0owth5DdWmMdJmf4OjO7LzDIJMxw
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a1961b3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2PthHyxMAGplJbN0v-YA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA5NiBTYWx0ZWRfX/m/MvE4U6OLB
 LdiYxuxuM4AxiMr5IxBAiExOYHKsRwGoGR5/yjKY9WMlrW0AGV0DHndZRn2MdtIuAO+lumshPS8
 rSCTjC5N4ivnP2Km2sasyAl6mM45QX2ERAkdtPJ7NNuoroi+tZ+qPMuQuQ1gzWZBFirQQzJeCn5
 AzXPYg2AmJb0OG13F6/Fbm7HdWtonDlrJqG5TXq4Cy9oPMG4limmwkENKJ2KODY25oKX5qTs/3Z
 duz1STT/vxnx3GA86ns0OblISu5vhGoJZ/w6JVB1PyCgSRa/A6rM9XfUZKkCChg5nbAKwB/NQoM
 opzNfZpc3jFfV5eVNCj7LSUd3D/LhW9XLalp/0G5TO7abMYmBDQGym7HhToPaceCDPeEhWPFCuH
 Onw0PLGp/LRqMMgE0NExiGuBVZ/rUNobm8zCbnrEzS2hUBoKAG/eT2trtgopAEzT8/Hp0w9xv59
 wvKHQwufO+LlgV5Klng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290096

On 5/25/2026 2:53 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 01:19:11AM +0530, Komal Bajaj wrote:
>> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
>>
>> Add OPP tables required to scale DDR and L3 per freq-domain on
>> Shikra SoC.
>>
>> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra.dtsi | 84 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
> Does it really make sense to split cpufreq_hw, EPSS and OPP tables into
> three separate patches?

Okay, I will squash these three into one commit in next series.

>
>> @@ -144,6 +164,70 @@ memory@80000000 {
>>   		/* We expect the bootloader to fill in the size */
>>   		reg = <0x0 0x80000000 0x0 0x0>;
>>   	};
>> +	cpu0_opp_table: opp-table-cpu0 {
> Missing empty line.

ACK.

>
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		cpu0_opp_768mhz: opp-768000000 {
> Drop useless labels.

ACK.

Thanks
Komal

>
>> +			opp-hz = /bits/ 64 <768000000>;
>> +			opp-peak-kBps = <1200000 17817600>;
>> +		};


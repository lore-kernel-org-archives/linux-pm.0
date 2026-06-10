Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3699F404893
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094019; cv=none; b=YvV7afjRANjefNNnf+26jHkalo9+GDILG1jblWJErTCc526SkaNvpdCEgeNusQyK+PQaaarX9Ywjq/PyAmpmQ6FDUorCYYaOYyooj70g5NeHT8vACmI05onQkJzmon5kqGm95cwOegK5QiXGgsk3UcnuNrVBO9dyTyQmPN6Oa94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094019; c=relaxed/simple;
	bh=n05w7UKa4EOGpacFVht3bcetkCd2ImYv2BLEkQIR8ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ug+JPbg/Sw8mxr60rX4wWz6/SCNixxSgxhLEfcC+ZCrjO0JcnIDP9DXx325kuRrxbaEIRFmOH+cWXuhqoNyUVl4j+loDmlmJRo0UM3SJkEVw2wo7k+VjPOK9o2cI8HbUjNkKywOIReSTRJO4vtXRmQnnIvNV/i2qyCoQeWQH6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rro6mXnw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FfOsT6gL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rro6mXnw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfOsT6gL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACCNHH1554809
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mhV6KkeF91rvMR0xezabgIbHP1+phX9VACeNByFDZyM=; b=Rro6mXnw2bwZJ9kd
	tAEdKPr/Yu453AEL85ph0zrTEDSXmP1sU5EICBb9z2bS3+SEOxLbVbQV36x4tyZu
	JRQGSHrMl03F1jaA5OoFEkE34A1ez5Up4VY+4DmYrHsaJ8N1KZwa/duytBYycttg
	aqxqjghoYF+Kx1uqlMpX8kaCWs7ms/nR2OwGF7a71RQnvSKiX4VbTObbSSgwseb3
	rUeKo++PUvWmrUsBlxrM1fGRfHucZ7ZCp6rTZD4t9o//boO/Z+AiUNQweWEsdW08
	5D0ctAr0b+2Mch+G0ccnCp/bHHmiVrwqxBj+dQfgUB/a3rGsnSNVu6TGG1MWXp1E
	Hnnzdg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnntde5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:20:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157b3e5182so86235585a.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781094017; x=1781698817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhV6KkeF91rvMR0xezabgIbHP1+phX9VACeNByFDZyM=;
        b=FfOsT6gLz0o69nGWhwEifSbzRv08yMIiWIKfAeNcgJ31A41iWRKq79CKxTCV0hYLVg
         XA4YSl4D/DhoyOhlbgxURnf48vS77FmlmuVmwSSKkdvvfzAJpaIX+x4xx5Vp2SDqec2X
         YNSrv9/MAKlzf7Gr8hyBzHMvlbPfrDHS0FYDXxDGIkFJcY8zSHzxoGHB2ik6bzj1c9mj
         B8TxlauMi0DWrYnk++ey0Szvnf6GNJanWWR6rGA9FvOqMFajqmF2PqIzbsZkZ0EzmCrQ
         lnXLpyBpPZskWa+dA7UUGVmZvb3OOgo+PBo1cpoHaoeusweXDre756LBB95z8nCvNHJa
         td5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094017; x=1781698817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhV6KkeF91rvMR0xezabgIbHP1+phX9VACeNByFDZyM=;
        b=gjhDsFxqea9I2w7vgG/RVFEKCxxPO1d7pwjw363tr2Rsh+TbJU3bNm+Q/WCmU3/z4O
         wWiYDNIQ0nIrDUqvJYB/gqErKDGRyPwORy9EYb6OeGkv9JC482AA/Z+78RGqHmSitnGp
         bso4iageQ20sYbE40rngYjRyd8qevcVaqFeHb2KWItwS5KPnsYAhFXBUKarBHqxO5cX7
         LY1wvljxDpgmrP7qdyCUxRDquGPVrRVfAx3Y0hdG40oZuJVdw6ioB007buXkLhGMEwvw
         U3FEPZKxvU2gl+miA2vnec04N7aXOrvcBYMTmJ3AUtVuDwOuwoOOTEvD5i/EnyYm3vAp
         IKsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/m7ylPd2SYustPitgmhznMgmluDadLjbSuDxmR5B4mP6MYss/lcFYvcxeD55KLZBh/Ct28KnRSTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIvb8qQF/vksIiaV0cESxuMXMTD6ExQ9C/NDp0/i2gpVbBrQI
	PseuskBveJvvv5jTdGPBLzH3IIOij9oQFL711IA6VRV4URA3TSwEjCS4X4K+/aSWrw7cZ7xmG3N
	8dHym1878k3hF8dIxsnfGrOPJZSiTiWjRy9D2dKX4SfB3HR7YlQ76jUaDaqaP8A==
X-Gm-Gg: Acq92OFYH9ACKK4sqtAfjdfiKfRxMjCPzmC+Cl8fefOqO2MuSanwVKmqGOUHv7BU/Th
	bNDPlsRDwYpziVh92CfazTmkJC2cXmLxxVzEHOn2y1LRcta1g5Tu2aLZFVWkSuvg+LnndpfSc3C
	7T1QFghoTBhm3L7V5sVlAk0qf0Nyn/wPx5SsIOb+uf52wRJIxJu72atlDM8vB+0NvIenTou2ScF
	UxQLzE+2PvdfqQPz7y2lWDmOrG1t9MUeWGIKdJh8BrU+lS9I6SylbV9q5GCux0HVhl7IQC4xg96
	R/R3O3BDbPQjVo+P8td3WndRNWBo9iH2PSLKVDTCI1e3C9XCXqWR1iKTXpHf8NP0RI0EUvIcGs3
	6bYMTCqZCs6ScJlC+KqDzZ+ixVHiLAPld6e8vqYK+arVy9CB6cTvt9e1L
X-Received: by 2002:a05:620a:2a12:b0:915:6433:2599 with SMTP id af79cd13be357-915e6cb8633mr715457985a.1.1781094016392;
        Wed, 10 Jun 2026 05:20:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2a12:b0:915:6433:2599 with SMTP id af79cd13be357-915e6cb8633mr715453785a.1.1781094015831;
        Wed, 10 Jun 2026 05:20:15 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051cfsm1189730666b.38.2026.06.10.05.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:20:15 -0700 (PDT)
Message-ID: <29e58a22-fe1b-402f-81c0-e12e540730ce@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 14:20:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] arm64: dts: qcom: sm8250: sort out Iris power
 domains
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260604-iris-venus-fix-sm8250-v7-0-7bd2f0e5bae8@oss.qualcomm.com>
 <20260604-iris-venus-fix-sm8250-v7-1-7bd2f0e5bae8@oss.qualcomm.com>
 <400ff1d9-1d58-880c-8004-271bd7023831@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <400ff1d9-1d58-880c-8004-271bd7023831@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3i79XocC0x7iIVkYHcQHH--ZCyTQdIDd
X-Proofpoint-ORIG-GUID: 3i79XocC0x7iIVkYHcQHH--ZCyTQdIDd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExOCBTYWx0ZWRfXxVerOxuHOqVi
 iV/bwoleQreLtcC9vXzfyllKU1WoRu4YjaIEnXNVNt2d2owaJBYkTea6Ud1OGLpVk7qKEH1W8lu
 t8WWmSxkBWMoGTEtlBdKLLRmtoZLNh/L/Z310iYt8mDK1oofybH154RgQ8h11XofRbvLxE/Scxs
 d3rFJNlPxtBiZ61/IwUVUFETlKZXodG/FQjvd4Z1Zr79qh9FyeOB7T8nwxEKujlekfCU5QSR1V9
 btWGjJ6qMThrk+kFIM3kCt8YyEVDpP6pvOxjo6cXeWMbJlksFT56EnAbDErv17+u54QN/v/0wI+
 d3cuV3uAnjl4ziZBtAmtdK07lVpNXLpgRsj/zeWDeWRcW+7vpgfu6o6Jl/r9K+Lk9bJ4n7T6RoI
 Ti2henhsM9uJjlubMmyRCIoNIQGam8ExaZ+KBaTaCMernNHTbJ645yWdwwRZGaDuOxRF+Cu3c7Z
 CTJnWIjb1+CxQtuPnEg==
X-Authority-Analysis: v=2.4 cv=epLvCIpX c=1 sm=1 tr=0 ts=6a295681 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=B3kY6bDR6iGi-FOxjEwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100118

On 6/9/26 8:00 AM, Vishnu Reddy wrote:
> 
> On 6/4/2026 9:52 PM, Dmitry Baryshkov wrote:
>> On SM8250 Iris core requires two power rails to function, MX (for PLLs)
>> and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
>> qcom: sm8250: Add venus DT node") added only MX power rail, but omitted
>> MMCX voltage levels.
>>
>> Add MMCX domain to the Iris device node.
>>
>> Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
>> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> index 7076720413ab..6150380795b8 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>> @@ -4326,8 +4326,12 @@ venus: video-codec@aa00000 {
>>  			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>>  			power-domains = <&videocc MVS0C_GDSC>,
>>  					<&videocc MVS0_GDSC>,
>> -					<&rpmhpd RPMHPD_MX>;
>> -			power-domain-names = "venus", "vcodec0", "mx";
>> +					<&rpmhpd RPMHPD_MX>,
>> +					<&rpmhpd RPMHPD_MMCX>;
>> +			power-domain-names = "venus",
>> +					     "vcodec0",
>> +					     "mx",
>> +					     "mmcx";
> 
> With this change in place, the backwards compatibility for the incomplete
> SM8250 ABI which was merged from v5 in this series, which handles the return
> value of devm_pm_domain_attach_list(), will never be hit right? If so, we can
> remove that piece of code from the driver.

The point of backwards compatibility is that we can never assume
that the user has updated the DT (because e.g. it may be embedded in
the bootloader)

Konrad

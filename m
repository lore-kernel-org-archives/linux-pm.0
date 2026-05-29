Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F63B5318
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049850; cv=none; b=TWRUA+VBJb3X/2gCfOH+0uyGwkbmNUNo5frBDbgbAs64+gbM/RdoQ0gle+z0dzard/0U/aHghlo8yp9Up6jEW3LCF2nIcmTEICDzfxoz9IidwLAbi3IdYCEvYsfTZp7MD9oifWSgRmrpsZtwBfiAtZEWhQH09CVxs7ObC9LvIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049850; c=relaxed/simple;
	bh=wsTTRuHUZyUK2eHffcCelXOtF0Eanqo2UbgT/sM+3MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+f3s4i/z91Lo/0kGd6aG9Y40wGKH1jruMszDfYZ836O/JAY2iqGwBgbzoUeKo6Xz4SIydQuG1PYLjZIpPtDms5i+K+0IZSjBzjiZDhHoZsYIq/lcpWG1tMT8wrPCZHgSZqk0SewS97/gYS5RF+VFJuXQ9jY0WJip/7Auqc0fbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BIqgbXkg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EaOoDM4c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BIqgbXkg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EaOoDM4c"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6oh7v1829475
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QlFPCdtZLGigc27wlhIiQC/YA2l7/69jHdSprQoVZBw=; b=BIqgbXkg22cpNPPU
	1pY0M8VNRN7Oh/5UUY+KY4rDi0rHJ5zM3AhUWS0ilyFhJVAKwzFCwikg54MO0lA1
	ZZwErYVBCuXb2AVwZx8i4j9Ff8B7Li56H4/0kVW0y5y9o6Ei+MBSzhQryga4CZba
	mqi80RoAbOYQLgOnyVtnU4xSFf6NZBZDbcblS2PjDw0yprxYs9JaSa+TNFA9RWCe
	0b5BhqB4JJhVQPRo3EMgUZnSUfeb0/gUUHFeFqtcwxVFGjjQ4dcPTA0X1DvS6OX9
	tJ2x4ztc7kyLEvWtTtJSMkMw/gTtlKloitSvx2D4Vvr1hjPFnYkzE3lHT0wmwvB0
	Fb8lrg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eex6m2re3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:17:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so7104841b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780049845; x=1780654645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlFPCdtZLGigc27wlhIiQC/YA2l7/69jHdSprQoVZBw=;
        b=EaOoDM4cIm/Nwax77CEjPXaXRTNolksC2fmv1EZefd0mmUGBoWEq4+X3nCfqfgpjvH
         KWgL3hklRSOX80C5an1AA1FtuC1u9hQ1IG7tNDtHCRBLUuG4x7P65a004gLCaJLdthGA
         Zh/OfT6CZ0RSz2yuIQbpEhRidcWnijwb9KQoXZ1v1r944P+/ybMWxvNOHrX7sJjWctVb
         dg4RnZIN525RykBzwj9xSiz4Rut7w037m4V/s3skOGeVoyQe/dK0O/i8mNZJbE5vUia3
         6wNXp7JqyGpa+Z3D7+R05VMAOb3WZwwbMj9RC2R7Fpib2s+2Xidd2Vq7FNovTxKkwkxS
         VP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049845; x=1780654645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlFPCdtZLGigc27wlhIiQC/YA2l7/69jHdSprQoVZBw=;
        b=kjcvI6xB/4xqFn/BZFevJwsokBnlceiFR7TM9TYUkMEaINTmHVAWLpx5QxIIyPdHn1
         f8SwowjAdH4213fwGwulYJ95HXqh8B4spYAx9DtRaQC0MgppULUlb3fKDN0Mb77N1ta7
         Kp+k5aQgRrV26O91timthk5HQ66YrjC62gtGubCCo8XBHd639ZJaO47u9r0HTzfW6he1
         BVxnh8WY7XmLLOnbL2qrArJ/N1jxBzmNF6b+Oo7ppdqbF7BaGDr/WSvMkhMscwPoSJqK
         VpPvNAmwHpq6pq84PybplNjunNdlypE0B+IlgiWlzTo1jSYz9/W2AJM27afIe5LGh1Ra
         xx0A==
X-Forwarded-Encrypted: i=1; AFNElJ/0nuG8pEF8SRoI+xTjt+m/dbFtxD+akBsGsz1k/szaq56+64z6ptAOgBYI4hPuuEsHPTzfLaDrQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hOUjIIN0fQfI/3FHIKyOXVp06rz2qP8Sv7CJ0p4QH/Laifs2
	WZvo8Fk5BjwKmKyROB3nfS7DX55exJb1oHIPKmPYChdr1kf5Ueze5469jhZoJOjPQFSbHGCI1aE
	WvSFcgm8Oc0r196eD7pDOQQzDuf8aW0b9gfTOXvAwgt9MmWbDFAFD1yn5nRbSOg==
X-Gm-Gg: Acq92OFDi4iOiNPnSmZYOasMKNQz5wUWpGM0ZCKHMz+ciWHablH95a0+dBUr0Yo0sO1
	J3tvwQLAX/8M1LrbWig3n+Ygl6F4NQHAgYzUU/mZKJVUKzSPw8LEDY0O7d6E1LJ5WhS8ZGEGI6k
	RZIiuohnQY717e2W/OkS3NEQG9v7Sb6WKGwBp1q5ubDDgJzKlquaWwK8AWtvshBecCgVHNyGPny
	65q9Vnklt6ojdxxiHdTTP9gkzawPys7PY4PAj5jTqHdskxOssS4hlmkvknXnxkY11eXAmxaq8gP
	C+ABhQ/0ycFPiMWPE4d7RsB/37kjXdKDhQ269Qg1rLhI4U8aUTJpHwmDTsA7XYv9OIqw9VOs9dg
	YDOo74agIM3cDo8fxzpHpn6VfKXYYR+xozcI2Uv32CFLCWVhVV/JCCvBNhms=
X-Received: by 2002:a05:6a00:3690:b0:82f:3828:a01d with SMTP id d2e1a72fcca58-84212d35431mr2340237b3a.29.1780049845189;
        Fri, 29 May 2026 03:17:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:3690:b0:82f:3828:a01d with SMTP id d2e1a72fcca58-84212d35431mr2340201b3a.29.1780049844647;
        Fri, 29 May 2026 03:17:24 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b307acsm1440342b3a.21.2026.05.29.03.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:17:24 -0700 (PDT)
Message-ID: <63794650-69d4-4ebd-91c4-89bce022c772@oss.qualcomm.com>
Date: Fri, 29 May 2026 15:47:17 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] arm64: dts: qcom: shikra-cqm: Enable CDSP, LPAICP
 and MPSS
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-10-f51a9838dbaa@oss.qualcomm.com>
 <xq6vkeer7c32fmmofhu3yxnwxns4mn7umzwjf6k575m55s5mek@zrjiuo3eiq37>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <xq6vkeer7c32fmmofhu3yxnwxns4mn7umzwjf6k575m55s5mek@zrjiuo3eiq37>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMiBTYWx0ZWRfXycZ9jx1yaSQe
 MdKmi9C08fdEgt4KG/d/KHFSuT3QiKa/FyGOZj84qhrp75RGOLMnWgjPWWP5IreElwuEsXOC+3V
 hcUKcyPsmNgklhW3pCkpIhU98ZWaByTtbBoypEAESeUTEHtlMWQTlvfyYlYbPLXvCCbF2HtAGwS
 uQ4O329/aT0KqJdbVV4U42IWxwIXyU7VxQvbb7paG81HGVG8FAuxfV1eUVDDKcmZF51s7PXnfVa
 co7ZZlad0rVQyFtFJWmUXTYTfPhnBu/di+dy0ZSKlP68bFUxh6GUJeKA2A3d3FjCQh2XIyOPKj+
 fqELp+Sh2TwviByvmnU557HGRrjkqf8RhzWXWDQl5z/ypVTHkZWi1A4Hjz1PSq6fHYGjUj7Bcqz
 SA61z/9VO37xfgUoCPNAI+rkZH7QEQSRwQtSQi3CguVFHnzoF9GBdgTdc2Iz7LUymWYSINhUwQ/
 wILd5lw5DvL1s5LkYUg==
X-Authority-Analysis: v=2.4 cv=frnsol4f c=1 sm=1 tr=0 ts=6a1967b6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=S9tZMReaGwYLiO49R74A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: QRrlkH80SS2aZNvJecqXJn7Fx9oKrZQe
X-Proofpoint-ORIG-GUID: QRrlkH80SS2aZNvJecqXJn7Fx9oKrZQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290102

On 5/25/2026 2:59 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 01:19:14AM +0530, Komal Bajaj wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>> Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM EVK board.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index 0a52ab9b7a4c..b112b21b1d79 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -23,6 +23,25 @@ chosen {
>>   	};
>>   };
>>   
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/shikra/cdsp.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_lpaicp {
>> +	firmware-name = "qcom/shikra/lpaicp.mbn",
>> +			"qcom/shikra/lpaicp_dtb.mbn";
> When can we expect modem and LPAICP firmware in linux-firmware?

It is anticipated to be updated in linux-firmware within next three weeks.

Thanks
Komal

>
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_mpss {
>> +	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>>   &sdhc_1 {
>>   	vmmc-supply = <&pm4125_l20>;
>>   	vqmmc-supply = <&pm4125_l14>;
>>
>> -- 
>> 2.34.1
>>


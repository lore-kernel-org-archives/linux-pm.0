Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C153CCFD8
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989130; cv=none; b=dTWIkWpaEDDVqlyI0comwnnXCUPkpFQjBZw8nGk2D8rYhyk8IibYRvEZrhWrx/zwmMKEp2VsJ+BYPbMAti5o6RzS1mEbsPNDiX4NLcDx3m3+xUN4CK0TzSwofRxEcSOXGN0t9xxbgXOEcKt2ODdhmNGOFOtVG6QNhk6HhxgQByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989130; c=relaxed/simple;
	bh=Di9Uy9wM6dm4NQAVkyjXVPUSJhqJc5J0i9cLaf1DGxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrBYuhYrHusJsTq0W3g1l2Md2SzwGKNkmL8xbgmwlCEh4wV2fR5Dh1TV0jQU/L4xn+CT+hui9mWuVxHvOVfrgGK0w76HACB3W3KxQDJJ6jM93pQPy6zFtdK73Mht5DO4NTMvp9HWmB15twcwLRWZ85RHHi731i+kWlJV+CIp7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uo1iqkfX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pzxintu2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uo1iqkfX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pzxintu2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593wktd1515318
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 07:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/XSEYIwz5RHp2qgsZn++HUntrNJgTOGYlGnqOYr4W1c=; b=Uo1iqkfXK2krkuOZ
	xCHzlZr7I9Odrfr0rheDc+2GIjlxkt7HIUBkU7iJY5u/waARSBfZ2iowbIsrVvuF
	Om+edxovn6edbLZC59gOL6dr5rR+Rr3QCAQrMKklfANf4NUEhZkxz51Li8QEaLTu
	iwJB3/4IskH2kQt6S9xZGkfQZn3i9YhOi33z94cwFqj8DYHLTgx588iR/oRQpH82
	ouaXziYvqVljb00eMh1mP1tY+6vzvWN8bG15VL2i+huCSd6xjnRVAe83xy0OHrjD
	r6nHBy+WmNkjTCTV95Fbu7ZAQn1PUW4oWV27pBcBBb5ptxLuEXr2IX0oRVfc7rRz
	7Y63tg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsvcg56-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 07:12:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c20f7581so56194355ad.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780989126; x=1781593926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XSEYIwz5RHp2qgsZn++HUntrNJgTOGYlGnqOYr4W1c=;
        b=Pzxintu2W49u+m+NfNkI/MOfpJaZB2cNrcvFD1JJzTQRMw3Cm0nkGSfON8gq3AXu6c
         HVeaWgsQLEyecg/uCpRJjZVyrUuDp8dORb3RClfxhe2BTHWt3FsUkwY4yImJUfQkKgFi
         Bw8ZAq/QVj6ApxzAVxTNxBRlsNx655FoWIKREAb9PO0brMMXtuOdhBtURVrgdK8nLX8H
         vD3Eg1WRNReos0Nkfx49gQpxPNx2R/ltthWsPRm3rAEFoOsmnALP/VyPvwSUWNugkqvj
         VPUvWbRKTPP3GFNvS1j1qR3D5BcfkLqS0fTDURCY80m5VfgAH+ffA/WGs37TT5SHXqHQ
         N4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989126; x=1781593926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XSEYIwz5RHp2qgsZn++HUntrNJgTOGYlGnqOYr4W1c=;
        b=N7awtCu8y2LQUAXDxRFNxURU+dWaTUxWsWrpATSUJzcERFBBuyaDlVK34MXbh+MSD0
         xbzcPuoHHPJkMedUogmA30KCkB5vP2NYJQZKdi+E8PRxxr4PJYe1inbiG+OozmwGGjF8
         +YyX/DK3ZkqT63akh+IruapdYzKmfVRFSsbNr2rHvTYEQ+6bznLPN2Qkt2zfuEQ/XTjK
         X4PyKsTzh9JvQHP6iUNEz2cfB4lF8mSyZDL9KPAipfcVYTlWXzPoL/7pinn/ogohZcw9
         q4VgBRnVqUAgWTvIstIOgK3f7ZoDJvroOOxMBsY0OcERpRylk62ygDcqHrhTm3nMdoLk
         oyZg==
X-Forwarded-Encrypted: i=1; AFNElJ/tPE+GOkk3JGExuvFJnk5tQFJxMb/0SaR11I6DvQy1PBa6vglfQ2nxBsr90GmeI2ud5KfmeWYL5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9q3d4g2yXzrPI7HUCwpZaDkgo7fFEuAZDLvpYzLwbzPgJS0X
	82+TkvowIQknhVPOpb8OxbZ7gn+mBQJXhS+jWS/r1sgIEGhwK8vbqtUmCafU+hjLtE85JRHIdmR
	r7PqSbKBkvTJfDNu04zMDYSekllGG+fYTOJLsGt6JpDTy9vvrizW/7jjNkbRrrQ==
X-Gm-Gg: Acq92OGYcpH1sxAijvAY+W0ld+nn7de+oIFxdmbMOXadd1TFD6BcsU75AJdrRmIW9nb
	R6y/6Cat5NRUhM/BXjZqdPYVNFSg+94J408lGO9HlOiyhWSxDnqC7ghFm2yZh4/PVXE2EwJzCoI
	6JZ9IqzFV8MyBvpttkeY6rMCxNHe/hazfKXJrkJDsAR5P77XzkO6YFkYQV3ZjMvOuVysQFfXUPZ
	MzuUaVhcxHBGTaOH/tVRH70OqtOXypq1svXseNifJzwSB++5+Oly0zdSAVscQHf6xVKrYIB6ez0
	6eaAPJ+Ghs+SoXE0y8YSVo9b+lbKIf4gStDCmEQKcQAczrIS1fBuegOjwyNiDpfJxWvJQ5MEUKn
	NkX5+Ef/TTQQgjkZOUmB4n01SCKvQWfNgGCaVVXQngWyaZ6jg9rTIdfJaXBCsXgVf4Hk=
X-Received: by 2002:a17:903:1aed:b0:2c2:245a:3364 with SMTP id d9443c01a7336-2c2245a35e2mr142420945ad.32.1780989125608;
        Tue, 09 Jun 2026 00:12:05 -0700 (PDT)
X-Received: by 2002:a17:903:1aed:b0:2c2:245a:3364 with SMTP id d9443c01a7336-2c2245a35e2mr142420525ad.32.1780989125021;
        Tue, 09 Jun 2026 00:12:05 -0700 (PDT)
Received: from [10.92.193.107] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d69csm200849265ad.2.2026.06.09.00.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 00:12:04 -0700 (PDT)
Message-ID: <9e3f3f9a-e176-4f34-b9e1-1eb90751c096@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 12:41:59 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: limits: Describe Qualcomm SPEL
 hardware
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-1-75356d1b7f94@oss.qualcomm.com>
 <177921242050.3254832.4034348981825996968.robh@kernel.org>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <177921242050.3254832.4034348981825996968.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DSNKXN6bhULYG5CUPsRHHX1XYfEwMWGZ
X-Proofpoint-ORIG-GUID: DSNKXN6bhULYG5CUPsRHHX1XYfEwMWGZ
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a27bcc6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2NiBTYWx0ZWRfX9GD6Sn+EizOk
 N3i24QRH0vtPoR9N93xNROMvYFlp86heA7DOF/l3tW6uiunElByxXK9ujTfE8jczHcgxgAyBMaH
 F7xNfvUsDKKks2sSRasHvd8dSjsPnrzgeICUV6rShQOrCETT7iADK/ZjMih6vKzXvTji8/KKvTN
 w6WIZqZArw68i7RbV3Y7Hqc41LcfkvoedHvczz+gNdSs8Abf/8+Se5EwJXmatXKH62Nmi23gJuC
 9DFZNaI+i0x//tPtbllyQJmNuUf+ulh09wTVylnhRhzr97myvkLW1hUznpdVnNBKwUMsIT9W0XF
 n4QcS8kA3r7Gw4V43EFQ5Cvgq2sOOztnfz39J4wOfE6+tuHKIoquH2FVCDLgsB9egP3YfCmcVLr
 v/VpntHkrlo3qy6iLTfhv+v3uUothdoZ6NeA9s+IzpfbrVEyMvdastyV9zsrLmKN7l04Cm3qc6M
 /Qk3JyIyf5BEEbn8LBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090066

Hi Rob,

On 5/19/2026 11:10 PM, Rob Herring (Arm) wrote:
> 
> On Tue, 19 May 2026 16:19:49 +0530, Manaf Meethalavalappu Pallikunhi wrote:
>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>> based power monitoring and limiting capabilities for various domains.
>>
>> Add a DeviceTree binding to describe the SPEL block on Qualcomm's SoC.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>> ---
>>   .../bindings/power/limits/qcom,spel.yaml           | 47 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  6 +++
>>   2 files changed, 53 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/limits/qcom,spel.example.dtb: power-controller@ef3b000 (qcom,spel): '#power-domain-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/power/power-domain.yaml
> 
> doc reference errors (make refcheckdocs):

Ack, Will move node name to power-limits instead of power-controller

Thanks,
Manaf

> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260519-qcom_spel_driver_upstream-v1-1-75356d1b7f94@oss.qualcomm.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


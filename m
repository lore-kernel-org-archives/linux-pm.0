Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7C363C62
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775105151; cv=none; b=bb0c7jX3OauLSH8CbzcDS8tD3ok42Y/tVc85CKZ6uNRySil/OebtPz9rqbeIqabljomnZ2NjAVyuSMiirkPON/hboBHT3hSvimqWGfn0pCG3lOe/4/SGQe4cbyCPwCFNODuVQDpW28ArbSX0vBVsouxQzUaLzY0orxF0Zc41T3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775105151; c=relaxed/simple;
	bh=S2HRWbg2cXokvlJe4+gfE1ed2YFZPrLpddriMACrmZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQZYUWoLf39roFk00ixMadF6c9Vl8GKBP09z3edZBFalekyAPS8dyu5qzyxbMeX3bytguJ7sFVmQHYngbXDHhwIYWQ0caaXutnvx4E1JBFleH87T0rwZ+BY9aUX/yapSMoIrP7PNhaMqt4ixCZyD4I6hk8HPczJ9dSNCVtCEf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KMteYK4p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O5zCe/cq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KMteYK4p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O5zCe/cq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M4qE81966350
	for <linux-pm@vger.kernel.org>; Thu, 2 Apr 2026 04:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S0q1OJWl3HWaD7MjgKDx2gsOdwwWx/uxoHe/O42qC/Q=; b=KMteYK4pTKOcpS/A
	SI+E4+FvgC8thGdTZonuRwBuPdFmMZrWAY7d864iNhgwBZ5JLZJfsUngZDIo+t9F
	xsBzJoEUxrU+jIAk/HHudRVHc1rLCyvRthyLHiWDZLvwAt/fRb6QcJ2DgG4U9PPl
	D9aotHKObeRZKalZO0S7pZVikiagGnz13ryW7DeKn7lZCSQipGVObio865wEOa6/
	77nKqam7J/ulf5pBOTQN7AOXUE7YLQkolK5vCiuSRkmIaiWVllygwE0g9FSHtQ0g
	Pw6ZhIg/ZSlDWXRuxodJ4YvC6C0CYlomyD5t9VVOHy/LhUqwI/UvHySotiHhX2VJ
	M4y0rg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9b9h16ed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 04:45:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c44bf176so540177a91.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 21:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775105149; x=1775709949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0q1OJWl3HWaD7MjgKDx2gsOdwwWx/uxoHe/O42qC/Q=;
        b=O5zCe/cqoWKPByg7xZktXutMLlm3DkD+sChhrKW/iDAGAFEFh75UrCLW753AfN7kW6
         g1uJagR80eAGQ1rpdgvtPp+V/GfoSWKXKpMz+k91IlZt4DYatQfxIC43LX8H4lpytjIl
         oZdzqOK9r6V2izxpwOi04l1b5DFRQb0PU4PPxOCsfXGkjm5IYHnvRPATteTv9ZAZdqNA
         6fRmLbeqtWBA9vErBvYYQf1rBbJ7LPzDpEZTLaRcnqlH5wUyLUgk1Kn1qb2I0KmKJ1sa
         jF5AM1XyolOfthZzKSB3BfkMy2yMKGbbkWZRijrVxaKPiR4wVJ9XwwmbXVBrYwF0joSp
         WmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775105149; x=1775709949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0q1OJWl3HWaD7MjgKDx2gsOdwwWx/uxoHe/O42qC/Q=;
        b=rbVkfSWtDtXIVQBY7HGIT8wWNMPfkMayBuUWZkZv0aE5CW1nLh8h6XyHeInUK01UU/
         NizG8VnaPwPDJfbnHg+E1gvjurJhUJMw1OsxcyFTpKhmaeiSsmnJ5M0x+i0NP2mj8wLT
         ObLPeIjX0E/dXeYyMPX+CPtcRZW3sCAAUvNMW0/SdemEyfKS3DWbavIr9IENsJhtMcK2
         hfoN3XVmBsc79X1mZjMfzefRvxlmFosMMseGhNRTGk3/ANBOUKmsCVFNplWolHhB2dCi
         6yRCzxNUgrMpZE+2golXRyH7f7uzh3aToipukb4Km7M7uHl0GD/qp1S8Cp0EsHW5ck7X
         jFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXeafTwcSht/qUN0rSMUwTrS7OV/SDFjc1tThX4FhTGTdKqI0xuhDNQ05My7RFEg10aXjDCjK/YVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pV2tiCD+5L7K0f+N41ngIgl/SpICDvGKa+nTVhoFjhIDmrh3
	TfX1N/rZVUImh0ow/HXH4FMv4k1/3rjgfvJRSBQBFcBGraCWiUx6BatX5E068iM7msax+9v3qKC
	BhXORC2CORHLrn4jUFDddRp5KquoHW6Vh8SUgQK6s/EiYmxkL9mbqVoy7Te54YA==
X-Gm-Gg: AeBDies/T0lHmoC8JCEgnffK+0F3oVnN7nOQK68jP8wFCoO3duUkBvfIwEC/BsID1mf
	6pPFhbVYGYDmJEyZMyKNiKGRKEvDZXTaUUuo94MJ4YrW+zzdHXrrneCaBQx7a5KnnxMynK6E4i+
	MSq8G3j/dNovC8yzDLzHZPF9UGwMbChRwBrWLmxDR0tyhYNbXFJOWljaV9b5cnh7jjhYS+LoA2N
	Id5t/uV0Qd+9njEsNn2bC7eHRZ+p16CtRkLJMqdIg7+E4wRG2YPW45ALvRELhasY+Sj+b1u1Ef2
	VYcx/+4G6H6oCqR5kbwaJzmXA5TArBvXXUnx80tPp89nXRdICKWT2gngW6OJnEsd57RdjwvCRau
	qUPA8ubEdJzl/MRMSJixEkdbRfNmtN01JKIrsniEqBam1+tYu71reJ3hShNeGIPKg0cSjW5iaLS
	5Q1Y9L9oYjf4CNkQ==
X-Received: by 2002:a17:90b:538c:b0:35c:a8f:5c5f with SMTP id 98e67ed59e1d1-35dc6e9aed9mr5569002a91.8.1775105148988;
        Wed, 01 Apr 2026 21:45:48 -0700 (PDT)
X-Received: by 2002:a17:90b:538c:b0:35c:a8f:5c5f with SMTP id 98e67ed59e1d1-35dc6e9aed9mr5568970a91.8.1775105148512;
        Wed, 01 Apr 2026 21:45:48 -0700 (PDT)
Received: from [10.133.33.59] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f52c8sm1300532a91.5.2026.04.01.21.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 21:45:48 -0700 (PDT)
Message-ID: <f54ec155-fe62-42a3-ac17-f521d419c0b1@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 12:45:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add power domains for Hawi
 SoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
 <20260401-haw-rpmhpd-v1-3-c830c79ed8f9@oss.qualcomm.com>
 <ht2vvduvxvz3s36cn5m54hv3zon7qelrgat3tnykfvqi7f56fd@t24kmaliap5l>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <ht2vvduvxvz3s36cn5m54hv3zon7qelrgat3tnykfvqi7f56fd@t24kmaliap5l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqLrRTXh c=1 sm=1 tr=0 ts=69cdf47d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-zmIaJwIKKk_Kx9d9LEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: eW1QgLdCP4PF80_pMeDRV5gr5-T7439x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzOSBTYWx0ZWRfX/sq8qnxgpBkJ
 +vbgHib/17tqBWx1Wz3r+GhkeUWcd6GPS4BMX/xC5sRYeTQEJeRw2ECRqyHRD+Ye7HAZTTV8XfJ
 Zvxsms4qilvJ1/OSuzfyw4aHlLt3mebmNQqHtpauKXqLlwtroij4sCrLi6gDsP6tskOoIvE2Wwe
 4VWr2jipx3SrF6+1MjjDHW9t0dBLcKrKALqJFYM6JeQhichDkdQgG8aMnEOOHm16ClkdgicYvwv
 KAW58nliXxRPhZxX18Vf4WkThBNWGIwnIoYKdy5RSdX/e/0dA7VOdIuS3IBHw3rMEIBd+kgLOKk
 6iKyr/77un2txYepKGobPUE02bGkEvS1TqbABcONxN5MdtBoByfq7sG9ACY5N9RSW9aojjlxduD
 P4YmTWCxnWpYIJUHpbCB8ZMrZhATzxtGMyP5leexBBoglyfyvBbST0wlLFp2U1DSvwHirYzjCgE
 zm151iXC8tfiZTQiEyA==
X-Proofpoint-GUID: eW1QgLdCP4PF80_pMeDRV5gr5-T7439x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020039


On 4/1/2026 7:31 PM, Dmitry Baryshkov wrote:
> On Wed, Apr 01, 2026 at 02:15:31AM -0700, Fenglin Wu wrote:
>> Add the RPMh power domains required for the Hawi SoC. This includes
>> new definitions for domains supplying specific hardware components:
>> - DCX: supplies VDD_DISP
>> - GBX: supplies VDD_GFX_BX
>>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>   drivers/pmdomain/qcom/rpmhpd.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> +	[RPMHPD_LCX] = &lcx,
>> +	[RPMHPD_LMX] = &lmx,
>> +	[RPMHPD_MMCX] = &mmcx,
>> +	[RPMHPD_MMCX_AO] = &mmcx_ao,
> So, should it be just mmcx or mmcx_w_cx_parent ?

It is mmcx.

There is no such requirement to vote cx before voting mmcx on Hawi SoC.

>> +	[RPMHPD_MX] = &mx,
>> +	[RPMHPD_MX_AO] = &mx_ao,

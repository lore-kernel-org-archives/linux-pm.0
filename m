Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADC374A1F
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209711; cv=none; b=Vk1cow9wW0KEryx+XvbXqNZGBg8IjnHJwrPUer/0WEKhNKX3BTJEBOz/3z9Lzbd59uJCnsUNpwQbdFLVWFbp6cqJ/7tCkwiGNIz5GcxpZjeCc8dzEL0ETtFmcusIdtRn4GRE9hSCc/oa9aROwNVhcotsxex/aTNI7ih3wgzwKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209711; c=relaxed/simple;
	bh=HRjTJvpI7OkyQuWdlZOrCZFlet+k8nzSkJL0BGd/LMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4xphdsIGgmvs+D+nsN6/TNGzLIzARoEyif5ceqP+r5fF2inD/MY2AozcMKSZSpyd1PLrkMzh7Q55W/0viedatjm6c3MJD8pYOSsix4eGtxzUKfrgoQhGyHLLBKOaFthTkxFTvPkeVqobWPH0UzKoiesQ43CV4mywFshbP4QFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HfcyVXX/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iBzIl1lY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HfcyVXX/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iBzIl1lY"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cnLo3338661
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zGTaa7c1vAQuKuwagzAaMmJzNETAmkixjUoY7bUjtvs=; b=HfcyVXX/oVYqot9I
	aihKXfOxY4NvBUE9xKbzrCXS8a8WbpF3L80rrQbUp4Q4YWvD8fV0reUu6GPua/Cn
	sRW7MEAY4u9pdgy8j26SnXBHPPlkEGtKpVH7FiY40HOaXSbdEZ+z1+KV/64ctY8G
	J57dTC/F74zfNu0uBRQs3hpLKJQuXGMMwjHJASMVFd79gwPM5IiKbrhT9j9bZilb
	sNqbQzER2kH6fkQoquUpJZ4ZQEYQ4Hnmrb8QJsJtA+ojPqK8uTnqoW4d/mhT9BrO
	D+sdTpefBWtWAnLLTky4yc5dxYNNaBk28QT4ZCPlE5+ZURXaJ5JHGWCAOhJlzCoO
	5sxQ7A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjhtfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:15:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0a99db8dfso43610855ad.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782209708; x=1782814508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGTaa7c1vAQuKuwagzAaMmJzNETAmkixjUoY7bUjtvs=;
        b=iBzIl1lYC3iBGsn1bntQLqStFy8+eZX1nu2sYf3PzmJDEFp/qIP5NQLnopmIKyucdS
         K4phK6hTeF2GxhovR6/wMSE8QcUrgzHF2/7hRwnp09FN4kuiVHwt0Fx33VAQsLr0zIC+
         JZddtigA1oLPuHXUZD1/ylv/8GwT1reTjrPspsR9XWQeh3wQOtunVHPKcy36KB09lALz
         PCCW4iAcp9V0LbH9jHSlcyuxzBdSrS8kjiGPseMnSKtAvt0po7uL8LhLFeenMpDIVS5v
         XxEYujqRaDScKRJEw8jL7ZPjtMprf93KA3iCg4aKPlqm1a2uwVgZc2G1sHOuQFinnLbs
         NDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209708; x=1782814508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGTaa7c1vAQuKuwagzAaMmJzNETAmkixjUoY7bUjtvs=;
        b=jf1cIazpLyGyAhb6fx7+FAZweSS1fhZSPy3/p4B8V3PWrdG5x1v7CD35C+OUfnNHbu
         leALY3y+Tfz6ZH0os/Py8Ahwj/iiHY4/lL4N0aWy0wx//49UQOawLC5ZUiOwkqRYU5uG
         YMeKlkXvIE5m2APwQnnbaayb0hEMhDNvxUn9hUaUEcAXv88un5L/kiFEyQ0IFDy3kYLW
         zzVTUnJWXjAO78EY1tOf9GZOEc78scOLBAlUeydB5xVrEtjXvpAuytT8s1Oxzle3IGCi
         dq484baFAB+kKwSi28kVXDPrwiu+RC3ZSi+sVaQmj2zx242W+tQXqT5gXBC86svNO+bM
         vieA==
X-Forwarded-Encrypted: i=1; AHgh+RpmF1VAg9MFPx+RwPzm2c7RkSfqiiPp4JaIGbk9O7VolJDGhpTYspgcA2L5GqLbfO4neB4pyPDC7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5gMaRJSa6PSEX3ynMCOq9d31ARLEJ2q77DiVAN6j13C8SKYX
	UpOHbCCLc23hxPS66m8irT0TOjPsi4eQFRCXaykW7Vu3y9aKtRZVKdgl3swIhayr7dERMg2JJBk
	io8sf+DSI9p2d3SN5g8YKwKIiMVc+ua1BLq5aG8UtOLtOngGQ/hFdVWOiaeZLbg==
X-Gm-Gg: AfdE7cksHPXqxnEl81Qbye1IrKM5DF/R7onjc+iRRVLNb7TKDZ/Tg5Nm3VEwpk2rc5B
	DU0/rXgvPItdhgF1uOsYUSQfsh8DfEtMkTtojBA+vXS0v8P0vWHV1zNLlb+oi4UmJKVK91TMKLQ
	tnq8r2GznC/+vZhw24feAw7EfGVnrVcUo1ejUx/vNgZVcHFw1aj0gnoUJXmbM3sJ00jqvAJxKoN
	e+MLINRvjcAWaZWLwomlWslj2nwbZ/cofg39I2ysDQkaI1NfT01bu759feAqD6q0RVjOQz4BRz/
	WVDzCfV0yzFL1aa6bszVvIsAgiJqxIcxZ1L/SmOPYcie/H7wWjYGozvrCedj2hZLZGrjU6us/s6
	fhd+k4bSSZTM6lBD1aHCKif+PB3KWuzzX3dqVVHs=
X-Received: by 2002:a17:903:41c3:b0:2c6:bb55:4078 with SMTP id d9443c01a7336-2c718c88c55mr199553235ad.8.1782209707781;
        Tue, 23 Jun 2026 03:15:07 -0700 (PDT)
X-Received: by 2002:a17:903:41c3:b0:2c6:bb55:4078 with SMTP id d9443c01a7336-2c718c88c55mr199552735ad.8.1782209707315;
        Tue, 23 Jun 2026 03:15:07 -0700 (PDT)
Received: from [10.92.171.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f5ff5sm107134765ad.29.2026.06.23.03.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 03:15:06 -0700 (PDT)
Message-ID: <0a911743-b372-427d-b188-3521c6ccab63@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 15:44:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Add Qualcomm MBG thermal
 monitor support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20260601-spmi-mbg-driver-v1-0-b4892b55a17f@oss.qualcomm.com>
 <20260601-spmi-mbg-driver-v1-1-b4892b55a17f@oss.qualcomm.com>
 <20260608-sweet-powerful-ibis-8b2adb@quoll>
 <4d643a18-a044-4350-b7f9-2c61f50cb792@oss.qualcomm.com>
 <97a16bfa-2315-47f7-ac5e-b130e7fdcf26@kernel.org>
Content-Language: en-US
From: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
In-Reply-To: <97a16bfa-2315-47f7-ac5e-b130e7fdcf26@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX2Jcoek0Y/OPJ
 YdiwgkX+61h1neX0BHoUuWYkHArqRHrTSxSiLVQ6YVmjvD/qirGHPQ6k4MNm8MBWY29CagA4f5q
 wKgsFEZlBWFX6lmBLUmJ96R33WBIZk+8HlPg4sr958GZu3BULdexAOQmAfUAm7wnehFRbPJrIDo
 R0Ck0P34hHpflrPVCFl1wlDk83YpsbJJ9LF3BMHyrh0Q692El8gGFG+P8DA1Zqqs3tRsYk45tfW
 t7eYX/wDl4PEb7rEefXmr3X2VIvdvvA4XVxQ0JLLJUlFeqeBbdjVR/TBBN5YBveLLrYW9YxefxC
 j2mGGRbkdGYeVC4CsCED0mI6/5X8IhntbAXMonypJHHrP0LNQWvmfrQXMc3ZEfMuO82G3K1g+UN
 ULWfFJqMwLMka6FKE1sftYOABtO55yTKqusvjGmAURxWnLaKcqai10kLOvfj4QdxCLqS6ccGycM
 G4PCiFJK8kQJCqbVOXw==
X-Proofpoint-GUID: 7X5hjcUDST4sC_JVve4RB8IKYPrjO6HA
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a5cac cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=cM1uwEMTts-In_BrvGwA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX4HEnpTmbvRXU
 QG+Z2bsD2VS/Z7zjfl0iG/3yZsN88p+EmW6yM9Nqhwme3MbJP78flDc6p/C6wBUmqw63VzQFm0U
 5YKnNR4qxNoU8v5/93wPoi1OnDt0Xx0=
X-Proofpoint-ORIG-GUID: 7X5hjcUDST4sC_JVve4RB8IKYPrjO6HA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230083



On 6/19/2026 6:36 PM, Krzysztof Kozlowski wrote:
> On 19/06/2026 08:44, Sachin Gupta wrote:
>>>> index 000000000000..a0ecc9f35cf6
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
>>>
>>> Filename must match compatible.
>>>
>>
>> Thanks for the review. I can rename this to match the compatible naming,
>> but wanted your preference on scope:
>>
>> Should I use a generic naming scheme (qcom,spmi-mbg-tm.yaml with
>> matching compatible), or make it PMIC-specific (qcom,pm8775-mbg-tm.yaml).
> 
> The second one, please.
> 
> 
> 
> Best regards,
> Krzysztof

Sure, will update in next patch-series.

Thanks,
Sachin

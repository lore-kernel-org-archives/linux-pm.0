Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB81285CAD
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480146; cv=none; b=KnKN4KIAaVdyOwudf4+KHRk6AIU9UbbDERu5HYQewDpVEAlAkaPdtT7i3wqPS+SbJhC8tiixnql4frf2QIqjcuZ5/t5BJC9AiWNzpqdYMmRs0OjDyLbaZiTflypAUE8AnHH0rr+i50Xety5mPSVbLgbuFTvb08XPKMCeR8v3xxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480146; c=relaxed/simple;
	bh=nMNNMgNt0qQdYKCR7rqoHv/euvrL2jsocSLSsD4h6fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW9W1uyyC2kfBYSkVs/VaxUvljz0M0OTOUCj5yw6cFYlJ6dJJPtpkWivPXUdlyUrOiDUmO6oG9qJQ2PG7DdSgrmwph+5/PTZA81vUT9W9ZrvimeLBKHOmRPIMdd+2ERdgiAqhbU7MwlDRkUpVCq/ie4jovQlIq4kgyBKOOz7IDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EK9LmJ38; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hIhrbZg+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EK9LmJ38";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hIhrbZg+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B37UZT2640156
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 06:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tiqxzGqdJED19gib91pm/fKKRdfR7tXGS5FzfvQm0To=; b=EK9LmJ38kWQuZnuL
	/1pZnSBwVKgBb5Ut8kv96k2d9rMiok4HSQqvPM5D5rP6weIiBypL3N4lxCzW+pnT
	B2KlJLsJnIVv/jVz0ZEWbkvfHHxFMvgJaWGaxwY618q/TGKvoSh9zI/kr6sjz1o0
	xOCfyLe/7BQd0jQx9Z8ZB0jZQlJCuTYIcztHD0ZJtaqUdP19wHU12aHQa4r8nLAk
	mvIL83mc33R/mLWCDR15ALqtEJTy/58D8th7cHrPCBaXRg0/ckhiObCmNptITvAW
	WT/9nfQP+bEA+y3ReybGgPcpZWRPYrFBsUqSX7pi5QAdTGuTydw5gMvJ28lnxFb+
	i/K6eQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1uvsmw0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 06:15:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba7662827fso36491435ad.1
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 23:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778480143; x=1779084943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiqxzGqdJED19gib91pm/fKKRdfR7tXGS5FzfvQm0To=;
        b=hIhrbZg+xm0yaYtJ6qjACXTDOyExSR8uJkUhfXtg5ZpjhCzzsKumhnEeZblPvA7PoN
         IBoMfv4yGsXtoSbiz5gShsbCX7z/pmiWrDH0/recVSnTYUUco54oJbqJpooPXaSxM142
         y6fHhkLrFC6CQh2cLGv0DAgfO3/j/+luwiAbY6v5pQcSFqODdnXeODhpD+mB9hg7U6oP
         ll6kojK8ds+pUnlyUSsQnWEfZ4cB65qrcvk35U4x7mwXKiMh1ixZkL/ftGf+S5ZeuX8k
         3R83WhCxPwBbNPzOkWMqdmLWF4xUH0os8rvPvTKCtUHXDIJsDd1ufFhkT0De5Eqg88E2
         7OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778480143; x=1779084943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiqxzGqdJED19gib91pm/fKKRdfR7tXGS5FzfvQm0To=;
        b=fJF6M569YYoWZ+lc+AXS+/oDaq907tfr+H5EQTvGAEezh4152Otq5Xv2mjIfhIGkpF
         zt/LNsXPDQ2e/iegaKDpUNyDL8udh1u4zdSHQnVzosA77U+SPEsTMT0AaQDdQbYkUwIe
         zf5S8LeJHKDaPioKMgDBLr9xnViwe2oI0MB0di9wEIKkzjnLolb10bzwaFZudiAZiTsM
         GHK5JF+OkJdB6hxaIWpgRRO5jX95YlNm6qtxpS3Rh/PxeG3PHG/BY/HYKcNFQIveNuiL
         /lrB6unxnE3ONJ945rybhpMNB6EyFUuQM7g3QT0a85TxA1q+ErSq4ybKKsablvIR6sS6
         ogKA==
X-Gm-Message-State: AOJu0YxcNMN0496UpcAm8elWH2JljBG+zZ9tXM3zDjUX9hYyboC9+Y21
	6Y5gVIyp/usXYhGRDIDzBuoEtI1zMREnKRlApEnzakh9Iett+9LEhYbmQoFwt8jLPKqJ7UcnC2o
	ystsazdiMOdnFzRMjKUveWi8/8aE/PfIyW6MprYGsfsErjPcmwOiSz68gewb86A==
X-Gm-Gg: Acq92OG0alkzqebKid8qsJWDE4Y5qMzxRTikRuW1hNi009ltb7F+by+YZm+jomW5003
	XRCKY/xCPoo21hDmJwQnarW4BU7GasDI2+iMPOoCvN1THkRAVlclhxizW9RObOYVtnIi/fJIfxQ
	mwb1kKnRewdZcOfyYHmm2zyqjByo51K1uT4YWxBDDUO6c1yUqvzsTk1+OwGuVsKUH6KN4241TbQ
	QbrXgQSbeRaEBXi+b+OE7rOkB1QvvrRcXHswDPue4ZQYIGlIVQcqW4kSb2DtgOBHkLzES4WSshs
	3PJVR7XmtFel1tH1D30EXcXpWqRlhvh8i4YViiIk1VOirwh0BhnagmfunC7Bcm8Q+K5+KM9+90d
	OIG8SnAsxXa4jcSChoSVp/hvVGJMwiWp8Obv0zP4MqjaJhN5wrkE=
X-Received: by 2002:a17:903:1a86:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2babd4cd7fdmr142843505ad.20.1778480143248;
        Sun, 10 May 2026 23:15:43 -0700 (PDT)
X-Received: by 2002:a17:903:1a86:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2babd4cd7fdmr142842995ad.20.1778480142633;
        Sun, 10 May 2026 23:15:42 -0700 (PDT)
Received: from [10.218.50.10] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e36c65sm92563845ad.40.2026.05.10.23.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 23:15:42 -0700 (PDT)
Message-ID: <6e0081a3-a28b-49e5-825d-405cc157254f@oss.qualcomm.com>
Date: Mon, 11 May 2026 11:45:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260508100700.772985-1-priyansh.jain@oss.qualcomm.com>
 <20260508100700.772985-2-priyansh.jain@oss.qualcomm.com>
 <000ababe-5f9d-400c-b7b0-380ff25e9fad@oss.qualcomm.com>
Content-Language: en-US
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
In-Reply-To: <000ababe-5f9d-400c-b7b0-380ff25e9fad@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA2NyBTYWx0ZWRfX1OfPKYTKRoZg
 zlosYBaf3j0WgpWvP5Z9DNMxcWBuOGPbgAvARwsMkAWBC9twfmpKBn1cVGJ14x8ZRrPEQ2a1XhG
 74pHOsSlqQuScep/mkhavi09xb6Sjk30OnN36FFZXnhKT5aI3FzQgqGkA7FJsXRHZUd48z/hy+/
 axBUmoVH6Ca7i6jxrKotbucl+emFwZ26Fk3fvR6fNUg4CWUr6zswlgvsT7HbcGqbvcJXHcn3VKU
 1XqZMPP3y14DINc17LZuzMs5ll2FAJl7oQe1hvsLxJNYGmRJTXPE9ps8RYok8s5572oXybXxcgE
 3sfncqG8a1t2GWGF2c24cYxwzpnAj99yc8Q4C0k67EtN8rVwG07+BayTa9otzNgzFZpemecM7Op
 J1VkYDd5NG/oxJiJZCQdIiSA9i3YR+4UdfNTg/z7QfYgxVv1G9oP6nrGlRDOqH2mhhXLcMNphQL
 PxilGD1X0dDowsdfNWA==
X-Authority-Analysis: v=2.4 cv=dujrzVg4 c=1 sm=1 tr=0 ts=6a01740f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=c8u1hPl0b-36Wx5Zf68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: W3SeejqLpNs2_fA_BcsCEVRQWEzOdKE4
X-Proofpoint-GUID: W3SeejqLpNs2_fA_BcsCEVRQWEzOdKE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110067



On 08-05-2026 05:39 pm, Konrad Dybcio wrote:
> On 5/8/26 12:06 PM, Priyansh Jain wrote:
>> The existing TSENS temperature read logic polls the valid bit and then
>> reads the temperature register. When temperature reads are triggered
>> at very short intervals, this can race with hardware updates and allow
>> the temperature field to be read while it is still being updated.
>>
>> In this case, the valid bit may already be asserted even though the
>> temperature value is transitioning, resulting in an incorrect reading.
>>
>> Hardware programming guidelines require the temperature value and the
>> valid bit to be sampled atomically in the same read transaction. A
>> reading is considered valid only if the valid bit is observed set in
>> that same sample.
>>
>> The guidelines further specify that software should attempt the
>> temperature read up to three times to account for transient update
>> windows. If none of the attempts observe a valid sample, a stable
>> fallback value must be returned: if the first and second samples match,
>> the second value is returned; otherwise, if the second and third
>> samples match, the third value is returned.
>>
>> Update the TSENS sensor read logic to implement atomic sampling along
>> with the recommended retry-and-compare fallback behavior. This removes
>> the race window and ensures deterministic temperature values in
>> accordance with hardware requirements.
>>
>> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>>   struct tsens_features {
>>   	unsigned int ver_major;
>> @@ -522,6 +526,9 @@ struct tsens_features {
>>   	unsigned int max_sensors;
>>   	int trip_min_temp;
>>   	int trip_max_temp;
>> +	int valid_bit;
>> +	int last_temp_mask;
>> +	u32 last_temp_resolution;
> 
> You don't need this now that you aren't altering the regfield
> definitions
> 
Yes, that's correct. Thanks for pointing this out — I will update the 
code accordingly in the next patch version.

Thanks,
Priyansh

> Konrad


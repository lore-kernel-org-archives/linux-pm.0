Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1A233933
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601912; cv=none; b=OJ5B3+XxIDwJjWzWhDESPUfjCo3Yp1+5YHQZAKdGra4sMh2f5Ii99q0/2d/XRUYTEVYuPuwDzO1raYy0vS5f7xi/IBgdfft4QkCJIgpBxoWNyqAxbw/cP5TcCjh3cELncyTOdJce/T/CcgGMBEzOcjTkxZgHl6eRlVP1vKKew8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601912; c=relaxed/simple;
	bh=2ncECmYmGOQWfSlXNAejUij+wOyeq+XTZ9+N+2uYujk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS+v9Md92HwytiC0/gQzzKmpoNeuJRDgbjwZ95HzDFRJfsOFWZUdcFsnnJhDplS4lYiD/WeO7bEMPPLmBsbIbYSJvNaWx9NOCPYS3mfkF/+D160ArVwRcAwg1LMK7K6N+MEjQzH3IHfLtWgn+f6ioDrDWT08vrj9mDMbi4cN3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QRO6rqNL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T6J2JnOD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QRO6rqNL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T6J2JnOD"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNNEL1628516
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 12:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6M8ToX+cI6vvxtv01dKbu6llFvdM/QyNtn4NMUQwymw=; b=QRO6rqNL7ngIgGWG
	nH0n7MpLDek89Qgyo3Blz1K2m2/sUbLwWsEDUjFyy42oMSg00tQDMo537C2FhCOG
	T1UaM9f+Rm+QYF5F2nci63FIqFkzmcslRqWQVHvD/Shq8b/zH+1aBY8rIMqN7Dua
	ciYb+EojJCnMQfrVeOvpknX3R1iqigaK1dL4bvOLT9x1XZNae5+8H3+Oip0ugasZ
	66SPN4RNPHMrANPv/vrvelv2i8kDBWYRknEq2tKVsE80jCh4FeOTmtqLydTGilLF
	n03R8CeU45slUU74D3Zfvmceuc6xrFcF3i/pACZuXc82NnN3r37S9Id9sCtPFSDY
	qUHTEQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvura5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 12:58:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5e21552dso35217185a.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783601908; x=1784206708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6M8ToX+cI6vvxtv01dKbu6llFvdM/QyNtn4NMUQwymw=;
        b=T6J2JnODd8SbPyBrFw+TKQHp+2h3AzfpoiNhfyYxAe9RYzrriOoFUTi0ZN5E/3JvpY
         9aLz7e3Fo10n9H+2RzB95UR6UM77vqDJ9g56pJyqVC3zojl35E8UgKxOfK2YTIxsnjPB
         ib8cxZRIIQ2WBn8W+VLZ8tEy2nidG6vwo61XiGNdfun1+TaD1qeZwTQAIwtX7jEPYtsq
         q2IdGG/hwxxNEpM4Mg5MTrbxw14QSocvh3iIOZeBy1gmL8fdvd5Qk09Q2DvGZkXsZyLq
         XbHYtSmXMQuk1J4ZIX9tTET+QHt4nhSXISluA+LVepaXoNy0Q8+KUDJ7pcKU5ejRBk2c
         3/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783601908; x=1784206708;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6M8ToX+cI6vvxtv01dKbu6llFvdM/QyNtn4NMUQwymw=;
        b=PAHLZpqbmoJ6I2Hwmjp7soSSJgUtAnkG30xXSB2aShrZSIWncJIVBwUoC3GnoaL/pX
         NT7omxV/lV3tzHN0Bbp5Jwnql80u2eh/7LygErWf65phPiHX29GHdCNE6o2ew/fV1Arq
         zkMR8iFf+6ytgz/pk4EGVNd1O48UtQescLMHzbTEKePmZXoa9KlX7jFB2NmF0mwLvgnY
         pWObu9TOFATgIsv2UcJUEYKX/6OBvYKfC62axx/LbIPBjrOcP8PCELG6pE3PkvdEf25R
         KShdDfGS6jSIdFOQgKmZTc5+fu7KwTKCd4pNP/0/LNrtifRMShF7Nh47QgDRqZo3z40n
         /jQg==
X-Forwarded-Encrypted: i=1; AHgh+RpWCjjEwN2rUKN4INEvElKlCccQgkuHIggLtzCBMbuPWwjKajOYx7PlQxJO4iS/Tk/M75h73X//XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8It9ZAto5Q3xIIxWuE/sfarnT973NrikusVAkz7W11NTBozSf
	uWXO9n9kG36HLRzNjUtYnqOQ+cfT96pvvTVvrUmKz+dXwxbgKzkz8m1U5j+kJRhstklPC1dntyQ
	sVODN7LxsX7QrVz1k7apxD7A9ocX7gos1sSyvu8dX3y4F+CtYZ5kKmERXzSTNMg==
X-Gm-Gg: AfdE7cmTsVl8E/I6CWFNDUAYni0Pec/NIk/eg1i2FvRmHryYmsU/ikyGOdml7W6VGCZ
	4hzqMmIXF5AE3MvBQo0r5tp7QRr5SxxvTnFZEH86KLIamisP3tg6hnDQThQzQa4fgaYtNptY3Dx
	lrl78RKO38jJtKZrOmv2nIc/ZT5gUfJ9P0Ad1cEfXoP667qyDcTQJe/7JkxuofF6qjBAAfTouoc
	I58feGBzJt+Ot9wXuBhTQn6nf7G3H8ncVSoURMvqLUyFpyn0r/4MOhTbNtNA2s0bgGsTto/vPi2
	GzcMhJe+LVaV0cafWQFyGuj5fnA0ANtgHEmZpzZVBLRw3n9SkX3USp59LCBVAFfZ7QaIQz467Xl
	jiHxiZuFFRqRzPU9mbIrIKRIY/qija6TbAoU=
X-Received: by 2002:a05:620a:178f:b0:92e:7436:5284 with SMTP id af79cd13be357-92ed7a1c5cemr287076285a.5.1783601907677;
        Thu, 09 Jul 2026 05:58:27 -0700 (PDT)
X-Received: by 2002:a05:620a:178f:b0:92e:7436:5284 with SMTP id af79cd13be357-92ed7a1c5cemr287073385a.5.1783601907084;
        Thu, 09 Jul 2026 05:58:27 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c6bd0d72sm296238466b.7.2026.07.09.05.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 05:58:26 -0700 (PDT)
Message-ID: <f5d0a902-5ff0-4591-bcc7-3cddb9f4d27d@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 14:58:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] powercap: qcom: Add SPEL powercap driver
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
 <20260702-qcom_spel_driver_upstream-v3-3-434d50f0c5b0@oss.qualcomm.com>
 <21f13da7-94ee-4eb2-b2bd-6200d70f38f9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <21f13da7-94ee-4eb2-b2bd-6200d70f38f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyNyBTYWx0ZWRfX2O80Uap4j3Te
 D/zRCF+vI+a8+yp/t86SXj18KD6MBtzdiDVcCBfhL9nQaNIiziEPR6L3y2v6/7d6blMvSLN54s6
 MPOYNA0ISTYXLQubwMqchB60N8r8raI=
X-Proofpoint-GUID: Y2CQ1jHJ9npUXKp5qW-J6rq5IJNl5xM_
X-Proofpoint-ORIG-GUID: Y2CQ1jHJ9npUXKp5qW-J6rq5IJNl5xM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyNyBTYWx0ZWRfX/i5L2KpAcmSf
 qCtiMvPSeGjrWDj+vEAfDMsuuezbIEpwtTTUv93rWd51kJeWz8J45PeOIDBODvQsVxQHcE/Ael0
 BVVtGkKjnEnmi/rzQ9fDS4Usas0S+fZbJrRk6aYo/oGSa35lNE2VtejQk1pJclv1diaHYPtMf6e
 7XDglPc2Bw5VUDqO21HF3iqsOms8yNYumKm8ntpc27CPFbvRwDO1o1Z4uMdr0TAGwAeVsBc2fk9
 q0du0QmmLjom0Hw96eKj3CI6+26BXjb74hNkcXXPEeifSl2bPpnNof8nY7KZhd5MC0oplFWp1W3
 zQnR8uWsPXGFD9nd9+myogKx4kKDfHbZ9uS+nxYjwwUujmidfUs1czVakvlSKO3qirln9SAe7p6
 gtUTy0cIy7z7OBWNiObqerIyEMJkTn20wu35YXaPmEsU3RPByFV0q5QDzSpFwK817ped35dmGAE
 CZfQ+QsdfK0VJmjYH5w==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f9af4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fz3elM8aSJ4FunxCNjAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090127

On 7/6/26 1:57 PM, Konrad Dybcio wrote:
> On 7/2/26 7:22 PM, Manaf Meethalavalappu Pallikunhi wrote:
>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>> based power monitoring and limiting capabilities for various power
>> domains including System, SoC, CPU clusters, GPU, and various other
>> subsystems.
>>
>> The driver integrates with the Linux powercap framework, exposing SPEL
>> capabilities through powercap sysfs interfaces.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +#define TIME_WINDOW_MASK_L		GENMASK(14, 0)
>> +#define TIME_WINDOW_MASK_H		GENMASK(22, 16)
>> +#define TIME_WINDOW_MAX			((FIELD_MAX(TIME_WINDOW_MASK_H) << 15) | \
>> +					 FIELD_MAX(TIME_WINDOW_MASK_L))
> 
> I am having difficulty correlating this mask to the register
> description I have available. Are you sure what you call
> TIME_WINDOW_MASK_L actually exists?
> 
> [...]
> 
>> +/* Constraint configuration */
>> +static const struct spel_constraint_info constraints[] = {
>> +	/* SYS domain constraints */
>> +	{ 0x10, 0x70, BIT(0), SPEL_DOMAIN_SYS, POWER_LIMIT1 },
>> +	{ 0x14, 0x74, BIT(1), SPEL_DOMAIN_SYS, POWER_LIMIT2 },
>> +	{ 0x18, 0x78, BIT(2), SPEL_DOMAIN_SYS, POWER_LIMIT3 },
>> +	{ 0x1c, 0x7c, BIT(3), SPEL_DOMAIN_SYS, POWER_LIMIT4 },
>> +	/* SoC domain constraints */
>> +	{ 0x00, 0x60, BIT(4), SPEL_DOMAIN_SOC, POWER_LIMIT1 },
>> +	{ 0x04, 0x64, BIT(5), SPEL_DOMAIN_SOC, POWER_LIMIT2 },
>> +	{ 0x08, 0x68, BIT(6), SPEL_DOMAIN_SOC, POWER_LIMIT3 },
>> +	{ 0x0c, 0x6c, BIT(7), SPEL_DOMAIN_SOC, POWER_LIMIT4 },
> 
> Similarly, these offsets are difficult for me to correlate with the
> register names in the constraints/0x0ef3_d000 space

They are apparently correct, I had outdated information at hand

Konrad

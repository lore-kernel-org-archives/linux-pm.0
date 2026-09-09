Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420854B1A9
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955079; cv=none; b=f5ohEu3ss/s04cBUUS3kYp85yY6bA/Jz2gWYYBhOG8HOgFT2beK3QHrVkxa4GZNB4cXmWYhkUjsoKd8oF4YCv5VlQpY30gUZuBh+aqQL+0z2N2yh1W7A5E3o/91gtWmcoRdI4TRIa0A472hzXRW/nr0sbisTz40nNRCg5G6DaDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955079; c=relaxed/simple;
	bh=lvHuBtyH8PU7WAC9E1zAzmSNFh7r/i19FyIT1zoM1w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vh/06lxrW/Z80fUKd5E4ZBTA9qsnUnpRaZ0IDWKgqxcio5O0KZ3f7P8QNM5Iabyt80O29UIrwCl+HxWTlKBBL1lyn7jip5z2/iFT8341K/binhpoZygU/avsCE+t4M0S6d35FUGS43Giv9DIwQ01cpcrecdBSXVbPs0PKFXLrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5VDNKJm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AuZafS8e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5VDNKJm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AuZafS8e"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU1e31809814
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 11:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWcE5nOjG7EYYp/TKk7d6uZY3yzA0oSkS2vdFUfogW0=; b=k5VDNKJma4gx7N2M
	bNVnCgOFRaeXbZzGItFtTmYpTv/gBSXOTIG+gOJ7tCdewnPFmTduVh4Cg6/dhKCY
	HAhJQyfQiWH2DVRHJYIWRKz410iLNuLH3u9cMEE5y8VxB1SjQ+CfwTQ7hfIYCZSa
	2ge4VK3Jzo7OsRA8OXKd6Hfr1xLTr8qzkSdW/ooSf2PoHtEHuD2vgvzlw7GpDv4X
	pqIUG8ZhkLV9ezcepSAPRlJSzXwmlhY5mmaLuqiSpLS3wNXu6utg2sWnZ222Gsfl
	dFhdO1kamLsCmebm1m9or8XcSM7NRv9FfubiUSS/JJUsvPkfkzJIxs1MCWPe8eRx
	2O3Oyw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk4xj0gpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 11:57:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93821883e26so113559285a.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788955071; x=1789559871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWcE5nOjG7EYYp/TKk7d6uZY3yzA0oSkS2vdFUfogW0=;
        b=AuZafS8esa1ZQc6loG9XI5YBODoDmCBqCYv1kKyXljU6NRh7f9KrfaZQizWqBZ3b+t
         QYdzS7jIwQzgyfzpLyFm4O/BchrbUFLITBwoWVZZv7QL/04KrQHbePJwlPqErBDshj7S
         YDbcQJ9tBAv35fD18cE64LvN7P64uZL/s8miP82mPmqz9yynuwyekc9NRg6iqVxc9pj5
         d+0QadTXueJplE3gNjlEsWeD7Aj6XG920VSDQhlYgcXHI0o3voXMVja2+Y9GmrjXh6cj
         fiQ9hZn1rFxPr+EU2fWCnU+9DcCJbbevUFp0IzpKPN8AYWHGwe6DuYglZblHuq7e6N4P
         tjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788955071; x=1789559871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWcE5nOjG7EYYp/TKk7d6uZY3yzA0oSkS2vdFUfogW0=;
        b=hLFh6vi9aMkKhlYsK5sjje6BIQS2ql9x2ANQ7S2omkv0G7Kfb5h4DgvjzT2FepevZ9
         VdaL/cYViCHXBv7ZAv0x1caynLS5XJgckUWbyJ6Bq0/iKAKcVJ+BrBLNXAhx1ogMm+6R
         3vrHFoM2WrFyDvRt1qKLLWnu2S6his5ROiXmGaqls9jnNyLKa4o9t5I05eoSLu3mQDj5
         dlRhTGyYXtjxbnMBoOIsT7p4Sqnk4BfKFdVTo25nXcoZMuXN2Uti2oK7U6xtDWQhRteD
         DSh/+SrSMbizGikDgGs22eYJevrcOeqaQ1L/QLSrWb1DtNUAZe5hIPbnf7N9JCla9P/i
         GTzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVz41Q6Fflawq9ulzuQPi7KB65SMwwgnuI52c/ZXCTyDrcvOpzQvcJNtzw51Bicb0tAHeG4Y6O9A==@vger.kernel.org
X-Gm-Message-State: AFuF++lFCZrpExQcWjwX82AR9RNoefkXac+KRRdFsldl9lC1i87TU31e
	5WqO7jfAQi+gyqGDN+c2NDUwnV2XpwijSZVu76nrQJ0rpz4qO2O01k9Nq2HFFUtn/LVbtJssZ1M
	jOMxikPVkqsFlDwPAu0h/qjbf2xdSqXHz1Ire9s3lWcT3E0Ht138YLS1mxJKrxQ==
X-Gm-Gg: AYBFou2I0znQMBGQSIQ014F8OwQra/QOQ+HOfAvJtgY/fr/7+cC7VTrXoHLzT6mIodi
	v/VDfXyLkQLZ8/ukyR8tJfwmtsARBIc0qyJ1VxlIQbU8mjFgP5XMFcOjA9gQmh1izs19zrrNmyk
	Pjon8fAl9VTy2mTtINcQBh3unUF8WRqphSbxTgExPBgnG1SMUHhHsQ1pxj6rFf1Wx4eCNNvSZz9
	9r5Fu2KQyUTbCX4NRnvlvqLX0SZH00k8YrrRsH27nZ5NxOVxuf/94XhFat3WDr0oDruN19HH1yO
	zqdiGa0EOOQ4gG/ZUgpXntknv1gemvXdj/Tg7lCnWuoYNQmq9ZNiWx8Wmq4MGcN3hhNxOgbHfqF
	kNvgqJdFuo4BBk2s4O/kC4Q==
X-Received: by 2002:a05:620a:9c4:b0:939:9205:4d78 with SMTP id af79cd13be357-93992054effmr1798995885a.3.1788955066435;
        Wed, 09 Sep 2026 04:57:46 -0700 (PDT)
X-Received: by 2002:a05:620a:9c4:b0:939:9205:4d78 with SMTP id af79cd13be357-93992054effmr1798961285a.3.1788955061188;
        Wed, 09 Sep 2026 04:57:41 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a94f2e167fsm1614641a12.26.2026.09.09.04.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:57:40 -0700 (PDT)
Message-ID: <cf856c97-ea82-4a33-aa9c-57cd317e5b79@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:57:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: glymur: Add ADC support for Glymur
 CRD
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-6-9c49b2eea6f9@oss.qualcomm.com>
 <52c023c0-a61f-4116-851f-ed19de4d23f2@oss.qualcomm.com>
 <695dfc01-2c1f-4503-9049-2ae266774ed2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <695dfc01-2c1f-4503-9049-2ae266774ed2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMiBTYWx0ZWRfX71/EHa4xF1Tj
 hTgy6DgmQ8Ho2B8jw98E86FlS9U0mUu8yWBJ10Q/rJ7aCvMF1NplJG+IEluC64s1RaO8Z6xiUe9
 FKLOv1p2KCQidCEdMwHsz7gnk/jF2Z4=
X-Authority-Analysis: v=2.4 cv=J52aKgnS c=1 sm=1 tr=0 ts=6aa149c0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=CY4bWrPPlyhwilDFwNAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 1FhgC2WbF0-bZHl12iYYBvwlPXFTKTpY
X-Proofpoint-GUID: 1FhgC2WbF0-bZHl12iYYBvwlPXFTKTpY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMiBTYWx0ZWRfX487evFWeH+MF
 Jkn3r6OBdn4yddCDF+4wHpbrF8DK8hrdBj0ZG6NcXgfp1Jr4eez+yum+Gb5yfR/OTVlbvEdRR2s
 xqd9IvMsph8G1zOGThGv42tYP8DB7PJRjr3cZ7NlOyMonjmZ0HfWtl/pJ6eaJ/rxF7NY2q49Ys3
 4MnEoKRmHmt8bcmR2pz0uUEeRfwKmR7aONryIJbsN9GyhYzpb8ToAzcw/8jOGd6xUVX5+vwhxAP
 ZFxlfIB8fchgj44sb/CbHttCRqncslngrQPAemnwOdfldqhMvNPRuqVEDHqMnpRLFbHokQkB4F3
 39/1puDll50loGX03W/S/ayMbt4Em4smNihrqCrUOvxE4ki8q4Twuo4n4tSV1uWV3xsXvUml8Ur
 MdHUBOnMviLawS9YgLfWmVoBlAWJHH4z4y5UQ8RRC6H5QLt+lEgYk7/15v0kkKwJT6bnI+OOaqi
 rCZ+XQWAiYB7PsYNThQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090132

On 9/9/26 12:39 PM, Jishnu Prakash wrote:
> Hi Konrad,
> 
> On 9/3/2026 2:19 PM, Konrad Dybcio wrote:
>> On 7/31/26 8:06 PM, Jishnu Prakash wrote:
>>> Add the ADC channels under the PMK8850 ADC node for the
>>> other PMICS on the board with ADC peripherals. This includes
>>> die temperature and VPH power channels per PMIC.
>>
>> [...]
>>
>>> +	thermal-zones {
>>> +		sys-0-thermal {
>>
>> Please name it xo-therm or something similar to make the connection
>> more obvious
> 
> Sure, I'll update the node name to "xo-thermal" and make similar changes
> in the other patch too.
> 
>>
>> [...]
>>
>>> +&pmcx0102_c_e0_temp_alarm {
>>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 2)>;
>>> +	io-channel-names = "thermal";
>>> +};
>>> +
>>> +&pmcx0102_c_e1_temp_alarm {
>>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 2)>;
>>> +	io-channel-names = "thermal";
>>> +};
>>> +
>>> +&pmcx0102_d_e0_temp_alarm {
>>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 3)>;
>>> +	io-channel-names = "thermal";
>>> +};
>>> +
>>> +&pmcx0102_d_e1_temp_alarm {
>>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 3)>;
>>> +	io-channel-names = "thermal";
>>> +};
>>
>> Are these going to be always wired up this way on all Glymur boards?
> 
> I'm not sure what you mean here - each temp-alarm peripheral here
> is using the die_temp channel from the ADC on the same PMIC to
> read the PMIC die temperature. Die_temp is an internal sensor
> and the die_temp ADC channel is always present on any PMIC
> which has ADC, it is not like thermistors which are optionally
> connected to AMUX/GPIO pins and can change between boards, so
> I think we can consider the above configuration will not change
> between Glymur boards.
> 
> Does this answer your question?

Yes, thanks, I overlooked this

Konrad

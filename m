Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920F4AA02F
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366104; cv=none; b=s56MZi6+69x6qmQJqAqNWzodIIzdT7i57o3L1KW5VBIxTZ9oA2O9PnwsUs0gsI0D4ovozHFz+W7HuRrpnitf3JyYFZ6evfVoWMiOQUXWZ22KGwWbCltKLYsykVXvMgn/df0Mh4Oo3wtY3stADgup7ncU6H2ALW8JamfndpMQ0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366104; c=relaxed/simple;
	bh=TahGuo3Lcj2WLJB8fMf1qgiFJz56dvCExcf4jVNRKao=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kIWix4IZI0b8eINp2hdAJY8X8Sw7U+EhcVLrb1CzajcSuXGKyufA7RGOVchpU8OSqiLvlvpgIJuWQxxcF40RYxJU4sLUF8oBHw0abDe8+zVd4L+tixD3xdJcHGoIsn8H5xKuWpwLUBqSQEtYTfEbtNeft6jtfGiGcd8RiDtPGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iHbFwbGE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a+NJXU+A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iHbFwbGE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a+NJXU+A"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682Fctst1807187
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 16:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EvXCVAcc/iZFfCMT3GRM70uAbTcPAN7trsG4OjSDXeU=; b=iHbFwbGEf+ovYvZY
	zVUMC5QvfDjAzZzzfQYexmEIpK/9gg7Nc9fdnoz0tKtT1N2IVpWDJdLD6u9nU/ef
	GU/L+y4N0suvaYM2ICxQIz+AVA8hHZRvuU1ir3IX7Q9Olf0Qxb8RZ0mF/jPetPar
	iyvhVlrnV7XCVolvmU4wRBGoVZ5K4vLqmaHICCvSg+FW+Wni1YVzjo08bOYg2QlM
	lgDxmu7VyjZybKWaC1zn1aTO9Xbm+twMtMUr+GKZQTnjuKkCP/zvlbkPgCdDoxWp
	D6kyKbev/ufLEgprAf/lL3Gd1U9Ks9njRBuh2VZi23236xK+f421l5qNrLQ6OLyo
	F+dHwg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdrchj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 16:21:41 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5bf89cfb2adso41098e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788366101; x=1788970901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EvXCVAcc/iZFfCMT3GRM70uAbTcPAN7trsG4OjSDXeU=;
        b=a+NJXU+ApcSq3Nvao0Zt5hf7TMbtOK2yaUPhep4jpZbTvdpxPQb0FPasgHIfe8AqP8
         UWKN4RzQ954/d/fny3E7Zb6vaugms4ZObjDIVbyIrr1mJbQ9jKa1DtectAKGZgVxK2Zm
         WrPTtXeATpgdInXApSsOhOey5BEL8Uxx885toGs1ittExmXx/qpJhuw30R/Yc/RopR89
         /siLb7ZdqlvABe2/C4FTdaE1ptzj3HwNDt8lRzwXjUGbAxa1eQSx6vhEAJP6bej+Jm+J
         pfDHxrS6AQXxJ1nmuv2p5gbyZoIQ5+pt1CGChK6bF2+A9aUJesoHmE+l0WoIP1Jq5R0w
         Kfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366101; x=1788970901;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvXCVAcc/iZFfCMT3GRM70uAbTcPAN7trsG4OjSDXeU=;
        b=J2/u4Ri+GpiFcmhyIaxoqjVrfanwcHhSC9GCdgdFzANmkAUMkdxc6FRQ/MD4TJJfd7
         8To/x2XFIqEr40/h6ClSMgPSZ/pXhmpdAYr7A79betRyXWHo72V8VaMVijAgfOYbd5jc
         u96HDOo9HldDgrVZfRgjlty1YoR6785UPJ1yctPnDkF3ldycEwNo8STpYGm1hBkI378U
         2E1c22WUWF325SyfByxk2KI8fqLFrVoxk9QlhvoDqZULrW3h9NXBLMx5n31/4pN/oIsq
         UsrWB2JEe/fIxSq5Qi0be7p5WFOeEAPq1s+sRX71pRlTrvnr3KYT64uA2zQ25/PYkvNB
         OgsA==
X-Forwarded-Encrypted: i=1; AKwUvByV9q5Oog9W1+dYmvcw3s1j+5T4kPPdIvjIyf+Ym/CGPmYPaydj6p5hUwBOQa+agiL10XHQvYw1kw==@vger.kernel.org
X-Gm-Message-State: AFuF++n1LrPHTd5fEeftktLFYp5JV82u9apzBa7o70c1QE6Q8VxDY+2O
	uSVJTedM4gc7F/zfeZdKD16UTSZguBksna3epFDK0QyH1BUGAwKLnAk/8f7HzGghSIa05qjINkd
	jSU0Ja5/XxiTeJD922Av+Fz16B1OLjL5cnaZEYKcwlMmFRYPIODwzIolWkWZTIg==
X-Gm-Gg: AYBFou2PddscS+NeoLI+TTCLT0DqFmWOx9GMjSIQJTfoScSE2kxSkmd2BoL2xm3K6CY
	BHn2m+So8ebqOpeBX3FsTzqfZ9IMJIMSXp/muYVpLv25Jv5GpqJfF0WEozZGRpQKvMXA0kLMWIR
	M2UBrn8lVXBQGtdtyPebuDG+6c/9+UZClo/GjzZCLiP9MqzfUNfyPUy9P0KD545G4ZKtMGv0xwM
	rxChGw3fGEfJvNnDDRV3toLNEldKotZsvaKn2yjv1rDP7mJoF+Bi5WNfn+0Tjh4qP90y4n29HE/
	VcJ7OjH5+ibm6KoM9x22NKL4DE2HdcW8d8ghCFOSwdTtB8nUNHnIqZWwkTJ1x3G++I+F3mno1FC
	p9INf+ZhYuUsb/koW3mn29Q==
X-Received: by 2002:a05:6102:149c:b0:787:74cc:2b68 with SMTP id ada2fe7eead31-78a1f5dd312mr919819137.1.1788366100613;
        Wed, 02 Sep 2026 09:21:40 -0700 (PDT)
X-Received: by 2002:a05:6102:149c:b0:787:74cc:2b68 with SMTP id ada2fe7eead31-78a1f5dd312mr919808137.1.1788366100067;
        Wed, 02 Sep 2026 09:21:40 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002df62sm165902966b.15.2026.09.02.09.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 09:21:39 -0700 (PDT)
Message-ID: <73e4b46b-6a26-4124-920c-7638b449fc1c@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 18:21:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: expose CHARGE_NOW on
 SM8350-class firmware
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Jan-Michael Brummer <jan.brummer@tabos.org>, sre@kernel.org
Cc: andersson@kernel.org, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260829054546.86210-1-jan.brummer@tabos.org>
 <20260829054546.86210-3-jan.brummer@tabos.org>
 <a2f3de2b-90f6-427d-9994-a8b1ec8cbed6@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a2f3de2b-90f6-427d-9994-a8b1ec8cbed6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a984d15 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=DYa_1O34AAAA:8 a=cKoaJvaT5YP-QF2Gj2EA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22 a=piCpHeHFVjWJlYWd443B:22
X-Proofpoint-GUID: rGvh-XnhkyaS78EZpG_lVVV9gKZZ6_o8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NCBTYWx0ZWRfX7u9JBU8IoGHy
 8381f8jgp9z9fV+hFk3AB9HkuTGinEJd1+WzQRvpoNoJ6HtATy+B+pwWc8TJAZ0ka7ztv4AAKvj
 jEe8dF5PlgVox2UdFbFjYswHIXpftS/MqaZxq72FD9UGIoeG6hUiIXDVMCkgQOuYplBVJ+BxKvu
 Wx4Unw+SkC4Azvta5rpZI2Jji6HgY0Cv8Nnn2eeFWTJN0t784TKQsJMj6u27OSianPn79/lS3gn
 wOX3R75/vk0RcgjPk6qfqHPAChV//BPX91oALyft0s91Qu8+ShLHko/sDgTWhrseJx3ZsxJQyda
 ow5pjiNI2uljHxLpB99PxndcgZpVT2ftcwa1/7xf3mlG1oMlV/HZVoMnP7pIC+0otjxulc272dy
 FDy+2WlEmicYKTNx2Plwc1c9L4vQ8DLLFHVXS9Co79E0yTssW9vccYI1MOoGWuY8W8KhEFlXZt2
 Ungcv3vr9CHKvFitiGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NCBTYWx0ZWRfX2ipAu5CJJ1Ix
 0QMwH/n0fKQuaARmhfZaZIDVeDMIsFX8RGvrTKktPcLQJN7hs4RXFjedA3uumEp63HMpVstJ2XN
 Ns3mz4kncSM8mNJdli7+xxhOitrVGM0=
X-Proofpoint-ORIG-GUID: rGvh-XnhkyaS78EZpG_lVVV9gKZZ6_o8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020144

On 9/2/26 5:02 PM, Konrad Dybcio wrote:
> On 8/29/26 7:45 AM, Jan-Michael Brummer wrote:
>> The SM8350-class firmware does not implement a dedicated 'charge now'
>> property. It does however report BATT_CHG_COUNTER, and on this class of
>> firmware that value is the remaining charge in uAh rather than a
>> monotonic counter. Measured on a Fairphone 5 with charge_full at
>> 4116000 uAh:
>>
>>   BATT_CHG_COUNTER   reported capacity   counter / charge_full
>>   2434614            59%                 59.1%
>>   3525354            85%                 85.6%
>>
>> Map POWER_SUPPLY_PROP_CHARGE_NOW onto the same firmware property and
>> store the value in status.capacity, which the CHARGE_NOW/ENERGY_NOW case
>> of qcom_battmgr_bat_get_property() already reads.
>>
>> Together with the preceding patch this gives userspace both the full
>> charge and the current charge. UPower now derives an energy level and
>> runtime estimates in both directions:
>>
>>     state:               discharging      state:               charging
>>     energy:              14.4347 Wh       energy:              15.6003 Wh
>>     energy-full:         16.8807 Wh       energy-full:         18.1505 Wh
>>     energy-rate:         3.39313 W        energy-rate:         7.3492 W
>>     time to empty:       4.3 hours        time to full:        20.8 minutes
>>
>> Signed-off-by: Jan-Michael Brummer <jan.brummer@tabos.org>
>> ---
> 
> Ok this makes more sense now. We should still gate the other property though.
> 
> [...]
> 
>> @@ -1442,7 +1445,10 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>>  			battmgr->info.technology = le32_to_cpu(resp->intval.value);
>>  			break;
>>  		case BATT_CHG_COUNTER:
>> -			battmgr->info.charge_count = le32_to_cpu(resp->intval.value);
>> +			val = le32_to_cpu(resp->intval.value);
>> +			battmgr->info.charge_count = val;
>> +			/* the firmware reports the remaining charge here */
>> +			battmgr->status.capacity = val;
> 
> Let me try and find whether we can rely on this - on newer targets
> many properties are more or less just front-ends for vendor
> plumbing (because there's a ton of different chargers etc.)

There's a comment saying /* remaining capacity in uAh */, so it seems
like this should be OK

Konrad

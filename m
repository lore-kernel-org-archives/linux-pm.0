Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892774;
	b=sYJ/W2NVs7e1cB9/bRd/EP89Yg3iDpx2HlV74EJlOhxZaIgTOGXGMSesohXMAZl6aA5q
	 x0CZ8WIuZIc1Gvf6tWeLvNkaYcd0Jsqrk8keF8kjDv2qe+/JE9WSvt887YfaWWtNNRyUx
	 G4WGUmiMiAgC47A/ZqdE1blsoF5ko9Gp6e3pCppfl0oCbXnlP703MvVVDchsDhGTXjBsd
	 uJR/kK2VO5/TbQD2yUIickfHSeCwbOyGS4TixDTfbxwJdM121o0Kru6Rno2T83jb2G0L9
	 E+58uMdm1YabQLyvUPOYQXpDMmrqzoq4+XvrBKnHrv6X5QcC5pW/mmJEegZsFAza7/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892774;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=e3T5k0SQ3pw9Nex+iwov0/iwckU6tdcd+5LX6TaExWs=;
	b=MzVEHpbHT3iQwW/mXSnoJ4vJiW+e4XWhHSjdDN1/VAeELmVsn93g5EMXi5vFX7mK5R0Q
	 wQJHSUi3X09rC7PoN85rxlILgLdMRzlVW4NHTeQzXgKNNeiE8UGOHi4T+X4PYK8kGmHGb
	 20n8wnZqiFu+7iMjpUr91aMAP7As/ie9BBePtKYE7LQHe425mpURYG2VO2hbSrerQJ3zD
	 fz3UC6NBFndP6pWl/cTM13UN1Zw7JFLrHo2+r7JIbKhJSGm0D8l9zDEs2IoghQHgo4uIU
	 jouSSDuHKNJqmi0d+K39+roes7kqvBDZBtr3OmI1G9KszjN4Ib4aRZjTR6VCtxDX1Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="PuL8Pg/J";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cItFvPM6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C09606D83E
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C09606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PuL8Pg/J;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cItFvPM6
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQATl686808
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 15:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e3T5k0SQ3pw9Nex+iwov0/iwckU6tdcd+5LX6TaExWs=; b=PuL8Pg/Jtw9+GRpt
	TCefO5vm1ZbG9PwmjWTfHYJH+mZbkZsHTZ8QB5AakK/7hmJOZAVF5hpxKswTOFP8
	2grUk8+dn9DJK48kfOXFXgFnsfeWLFWDBhqNMtZJ5liuGb+tzLlKRnJvmoQZZue3
	+ACIZRTIgBN8vJ/W1AlwtTOEc5exHtyDOubofYGQDTZfXQcQfp2fkLlHi9apKjoC
	b5aZu1scRuHPwStGmoi/ZHmJsWYu61Fu+4Qf4ot60pktfolStT7XRnnPmpVeKoqq
	MMIAD1vRhxDCwBGRiAeWMpK5scOPgwQH2VbOjY/+rhEbXiZOuQwPcImy7++j5uRR
	57EhqQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p1k9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 15:32:52 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9984a7eb3ddso1615432241.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 07:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793892772; x=1794497572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e3T5k0SQ3pw9Nex+iwov0/iwckU6tdcd+5LX6TaExWs=;
        b=cItFvPM6LpfQg3OeFMqZEDAlxsI+fYymc3zR4xY9jJWE9lz9LIOtT2Acu5C7qpJ2p+
         0zz3o/Ut5bpErKb+q8p2v6Sxg5Q5ZJjqYoxa1gZb5cm3vvCANRZrpfJGBBp4cC2S53de
         LTSLs8u4BNSzbdAD++2pWMlua9PNE1uDWGxVye4XVxmTmtQCjASFiiXBuATaBX6uIcaQ
         0vNHjy5/A5aEwKUiCcg4mqTFdnOxcEY379VEE7EaNuS6e1cFEjZv19w7ZcPqEYYTxxO9
         mB3f+Z9ED46JEIjS+GyccBvRBQ2qK/kG8OOpM5JiTZkCM/wWiAdtEP9qbVqQP9x1zjI1
         VKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892772; x=1794497572;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e3T5k0SQ3pw9Nex+iwov0/iwckU6tdcd+5LX6TaExWs=;
        b=bnteg+zZeLO+huNUYxd+DbkOKh4ewiUQeJrFh3Lls1PZA74cHNuySUZPgKfaZu/BrY
         52fsFt5bOdwuolKdy0sLUmcEtCRXQFnwUl2JVBiMSfPoxymSuemDHitAM/lBR5wH+ZYC
         962oWcnfeBdMICtv1zJWLy3okDQt2rAsyROarwvizWkbcwdsaxR+9unODRO+wO24lxHo
         BwiZcdFdITBNF/IcsxTTqvuuuS8KbVS/A864l1LnxKPjOxWNBG7YNvV3CZkkv5YM37Nt
         +WT753s8RRMuB9OHAqlbak0FW088ra7nMBuJVnjMxKl80EK7itGS2AC398EMYq+Ez8tl
         Yyzg==
X-Forwarded-Encrypted: i=1; AKwUvBweP8ai/0KaW75HyqXlM/NNSaWeCHCtFcuq4OKzxAAQQl3TyKUJMCi+ANty8xib0BSD7CJHUSRJEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+xXGOMXn3NIIoCUSIHI8fJlUkR5QL/bYwmERlCIsr4j3tj9H2f
	N9ErWD+FPW8F2Gnp252WNboRm2NGp74bDaMGCqUANeUwuO6HbBE9PbwWh1vopIwD9JGMHWcBaU3
	V0Vruoo9SXcNggaoFCtiIqG5AVQPU2Z2eKnGvEz05NcqiNglFVnW2lO7RJAGQwA==
X-Gm-Gg: AYBFou2DUQ0o+5WVCUARN8gc5hTFjMem1JjLvPQleh7oYevRjIsp9ecjY1tE5T5ljX1
	ra0+G6f8Hnw8hRDVn0AuVzqFgQAGOuxZTk/vgwh89fecG2Wcmu71mQgM5uOX7rB1Wrw7AOzr6uI
	VA2dxNyfNoPF70n1miPa73hkh1ilKkrMpcm6FYqUBBG2wfev4V18b9Xfz/ZXYX+FN9kLXlBbpNv
	LNA7gWkxx7S3Sqn5BuljgHwKAbtnY/uKbpP9K5ZcwqbzrKN2Mt1WqB2D144Zx+6XD/OH+HJbE6z
	l4fCKPwniqHSm/AgRKZ6Hv5pZah+16ZZ1gOd/9knw0466XCwyPVkwF5GcY2IphHC/VDhQ9S1vyl
	qIjMwbQnq9NJR/iokKagAml40+1wM/ykC05+i+PhvEwJsZuhBUl3/HVyxWBv7IGLX80+OueDZtk
	DeAqmbL2SgeC/lWIpg
X-Received: by 2002:a05:6102:3589:b0:7c3:f36:c7b with SMTP id ada2fe7eead31-7d072c2bafemr10657467137.14.1793892771745;
        Thu, 05 Nov 2026 07:32:51 -0800 (PST)
X-Received: by 2002:a05:6102:3589:b0:7c3:f36:c7b with SMTP id ada2fe7eead31-7d072c2bafemr10657452137.14.1793892771275;
        Thu, 05 Nov 2026 07:32:51 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda203b6sm10594945f8f.48.2026.11.05.07.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:32:50 -0800 (PST)
Message-ID: <65c4b925-598d-43d8-a6af-ce197d9b5c27@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:32:46 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: Use signed integers for
 coefficients
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>
 <a53ebde3-ca2b-46dc-b4bc-93379b05a1a8@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <a53ebde3-ca2b-46dc-b4bc-93379b05a1a8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aeca1a4 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=8VQtTDxmKkvejqrRUPYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX+rUUtZN8FrGa
 KJvmD2VC8MQnY+P5wCN288Uh7cUo3tMDx3F8yQ7344TpIXtcXwV+VakBQjBVEj0lsCj2Wt5MKo5
 Bu/sLwJIu/aEfJ0Gctk3HLBoQADGuxlQa3CUgm+aqi6sApkUYHjeTD+AcNTHyFQ7lkw3zkQjfH4
 SIlo5lll8dDXbJ29NUG6cQfF4nDBGIBFQc630ur9QhiJxDh7kBdFSCaRghGM7+8TmZ7v/XU+R/z
 uzQ20opHxF4kbWIndwRpCDezkCNd+uWlIBS6k5hfEIz1V02j71+BnyZnwfrXGOPk7gp4q5Ph1tj
 1Wo6UdY4oV7Dk2o5zrQsCpeH4blXEdUb/MxAtjznnBypMS/MBHnPH41RybITnH5J4RNamYBEyjb
 Dr7BIxrOJfpji0VqXvK+JRZXg1g2gmtAMlA5iVH/5HRmMaAsQHcI8Va9LYODdUP2UaZwoI+yrOz
 IN1844Ty77Z98ViEodw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX/ynAUVLXqyx9
 lr3YWcy6XM/bJOBIaiJNcHpNMiGoJPG3LpBp6LSP84ho3ZhfopXNJwvwo9Yo3gcC2Y+zhAWQqw2
 eCKdKJTarsQ51TePm8+w1prz9ll6NMY=
X-Proofpoint-ORIG-GUID: hnDhbiNkqxAx5nCl7ZPLakwHTZwIirkj
X-Proofpoint-GUID: hnDhbiNkqxAx5nCl7ZPLakwHTZwIirkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050061


Hi Lukasz,

On 11/5/26 11:45, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 11/3/26 21:43, Daniel Lezcano wrote:
>> The coefficients property describes the coefficients of a linear
>> equation used to derive a thermal zone temperature. Both the slope
>> and the constant offset can be negative, and the thermal core stores
>> them as signed integers.
>>
>> Existing Device Trees already rely on signed values. OMAP4460 uses
>> an offset of -9301, while OMAP5 uses offsets of -1791 and -2992.
>> Broadcom platforms also use negative slopes. Declaring the property
>> as uint32-array does not represent these values correctly.
> 
> This looks like a good argument which was missed back then (that
> the negative values are possible).
> 
>>
>> Change the property type to int32-array so schema validation decodes
>> the cells as signed 32-bit integers, matching their intended meaning
>> and the thermal implementation. The cell width and binary encoding
>> remain unchanged, preserving compatibility with existing Device
>> Trees.
>>
>> Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for 
>> thermal zones")
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal- 
>> zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> index 999ad40a20d5..72e419124f98 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>> @@ -101,7 +101,7 @@ patternProperties:
>>             thermal zone.
>>         coefficients:
>> -        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        $ref: /schemas/types.yaml#/definitions/int32-array
>>           description:
>>             An array of integers containing the coefficients of a 
>> linear equation
>>             that binds all the sensors listed in this thermal zone.
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Thanks for the review

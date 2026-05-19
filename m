Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C5369D45
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187660; cv=none; b=tCMqfWUDLWMox4e+0d1ogfFbVJ9FGbFCjONOs8vFS7C1Yf+q0dX6T6nHKrJa97B8L4/8Xxa4/9TS0X5PWQrdm+QHMQcCsj0UBCMMDcllcTNupKncq/VpWkijHzWkANRfodnKAeXoJlpXWg1yhU9p7HywJX145qCepDwd8Putxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187660; c=relaxed/simple;
	bh=yzHc1KrwjhHvrLapddPECGSX00VBdLIHE41IjyQ90GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo8w54LWk05uHMLoCHNSuhRQHX9qlYkYHbVez2LIcOiVzeJp3XVzaJQa7d0nUll1R5QVgnkREEVyVQIMDbxMwUh1DIzscaZcqUIxGyuK71HRNdoNZaLijdwIv4pBScnczncHww4fNb9kIqoraFKFHhx0NiFyGI8dOgMBboNzno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ei8rYPlj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gy+25Dim; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ei8rYPlj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gy+25Dim"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JAEOWR4131344
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AWmB9KzPMe9DxK/PQCkNZX5bHmWFcsUK5K9kGfphZKc=; b=Ei8rYPlj/vf9zcGR
	uZzcR8gkATmw37dBpVS09/wAGfBMJ5M7eXF7i7nL8KyUoBgMcAhxAEk5CCl0VQJd
	xtRY8x4O9rPp/oKJRuRUdknaxIqWMm/qvoiPJOCHKdlCl0ib4Z2tDVt/SThzrtgK
	jjACPda973p8jFjY5wt4EO1Bogh/nYdvmfbOqLvHy1MDrYik8FrDsqrgGESMGtlc
	V0pTNvYh5egqUaPp4hNBCNfBewq8xwuY5klZxC6kDf8oWjbUEH2Ah1ZTU97b2aTt
	8zLe5oeFrDBSRdZRYGHdhiBaqi0ADH5cxXyBOAE9RAo72ZEZR8fQmaSJSyVSwGDj
	wV/f8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ht1hasr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:47:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e62562b6aso11396981cf.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779187658; x=1779792458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWmB9KzPMe9DxK/PQCkNZX5bHmWFcsUK5K9kGfphZKc=;
        b=Gy+25Dim+pqzHHEkF9lGYvO/m5CfQcaiGYbx4m40t9jmy3Rj/IrDa4hmHU/Cpfy1JV
         dawtZfSFqUtfJSEfzaB0TH8neIqqvaUyS+1evz7JTTX9Vw+CdJ125A6FP6FqbflJdpB6
         z+PXWcz7oRkGapsPv2p8i7dOEHP11a5E6VCuB8Qpw3Z76WI06dnciN/ZZJRAdll3114k
         XPqW0CJN0sOu73mwAM273ty1Xuvds/iUvMrgNthA9yPbcZ7ArFblFz2fV1sRRd4mJTaN
         f0h+i043iePDcLDiuHAu49p3/ZU3dse8IQVugIOaxZvVkqE3HxqZbUhbKhks9PdEPWXI
         3JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187658; x=1779792458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWmB9KzPMe9DxK/PQCkNZX5bHmWFcsUK5K9kGfphZKc=;
        b=ACrn/mB9BVuLgCxnKdWsxmtVI22MGMmdwL9UcsGwoehL1S9zMK+oeU5oDWtquB5dBw
         qXWRNiWR5Ug9Kyp1X0QFyF2S0Gu0tP9PtwU7OqC55MrXfOIO4Nyws8yXvWH92xdeqkK8
         rN0KtqPeNxcitWcUqLRoOMdnMXLgxbAhAn6ACCSxoKmcPZex2xtlBDmZ+IkmAQPnKD1q
         Rd+DVLHx74MD+Mvd1Rt+V6yaZTaFhiaGS9DwrgdjokZ2vloystHDVkJL5X0uBXIlUV7k
         sJZ7affn61bmOeQJRg8tjoDjWsYHPC923ZKJAfLv0MUGbJ+TCjEt3Y6X6idre+z3rTV9
         2i/w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZLkkNNbcdXel6Mydsab1k41klWfGqsKb3shmncfXGip7RDlFbMkUWKRuTMM1by+u0Qr9j2Vsk2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3QnSxr2biGxYXQzRP1rvjnqNbgavDw2f2AC0JTXd84v12BVh
	dfRJb8LyqZGCeTQ2/VmYIVW4OQwlA7pP1ZNLHFE/igjp9tb10NCHwdWWzQSDilpiUKgr2AGa2w8
	nTPQeL0L+jGkD7bidYRDugnN81bOrnmS1x4TNZk5MHoUcv4LIjlElDhhC0bK/G0TOV6sZQg==
X-Gm-Gg: Acq92OEYRUedjlPEBaRfiqb23KnMJxS8REmuZ6k/5eDbOBUt7aFVTgyzqmLoJqhlec+
	UYrq8/DBEPyYXMuUAJVjfBLdEXlSjVUkP5Ut1lJVpqIZby9frikZfJrey31o8WCyC/syBtDhETC
	/yETV9g8U0aOfqQH16cw/iBnooa0rgOrKw+l4BUTflbJ1UabHxSb/uKWwfaLX4qufVxpnI613RA
	5e2kQkXh2b4+YhW8AwVjNGLNGzVF86cqESNnLcGHgxM8Cf0wBFmiJ1CCWXN9dBppfET9IubFRJY
	+yNBxrly25uWradEX9/dvQbi2RUxe/5kx4ST4nTI3dg4VJ6UcyTFXMl50DqrvZdIPLI7O9Dki12
	FFATzTCbBtt4gpB2FX7XgLdo1u9/rdr7wZ/3Df8YmTSKTjGv3U3ksxey1nSf4+sRNCO2LdrOrrm
	YzjZWoI0xe2zUmUA==
X-Received: by 2002:ac8:7f10:0:b0:50d:ec32:b84f with SMTP id d75a77b69052e-5165a0c922dmr184664761cf.3.1779187657923;
        Tue, 19 May 2026 03:47:37 -0700 (PDT)
X-Received: by 2002:ac8:7f10:0:b0:50d:ec32:b84f with SMTP id d75a77b69052e-5165a0c922dmr184664441cf.3.1779187657444;
        Tue, 19 May 2026 03:47:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ec000csm693210366b.60.2026.05.19.03.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:47:36 -0700 (PDT)
Message-ID: <ef1edc3b-a34a-48cd-bf68-572fa57babee@oss.qualcomm.com>
Date: Tue, 19 May 2026 12:47:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: pmic-glink: Document
 batteryless property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jishnu.prakash@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <20260518-add_dc_in_support-v1-1-31fbaa329879@oss.qualcomm.com>
 <fd58d6d7-26cf-4b11-82ad-05b4863b6dd1@kernel.org>
 <20260519082526.odmn5dqi2jftwnln@hu-kotarake-hyd.qualcomm.com>
 <20260519-first-wine-bulldog-a6a4c7@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260519-first-wine-bulldog-a6a4c7@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JKULdcKb c=1 sm=1 tr=0 ts=6a0c3fca cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=ZX6by8Qv5zPJwBpBueMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: K7i16swFqPEhjp0sYA1u_c-zSIBds_g2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwNiBTYWx0ZWRfX8PiXv4zvMfmi
 GUMu0+eelBftXgguHt2ndGZZKxnS9voUqWl6Fo1Zgv6czW8vA17glSjbtRLJtJZyf1FjlXxbvo8
 H08PYSkcCOjMQLkBZYJxVKEZnYnWAThoWVeZs1VI8hLfnacgdVzfClrrCF/bAPeSwbYgpqhXdMZ
 kWewWLV2OobsTUGxpSAt05a8Ep7cJsS3a3Yhh+g2e/wedTmM1JydSPrDLdAnZPlI5UrHddAXNXd
 rMrZ/IauxxSuo0UN9LZmtFidLBGKhoY4fIPFZZTemOqaDASM75qe4SHjzusWIwV1CQcFGOlt6Jh
 lcgyMiyX2YTR32Rm0H3VzE6QNT9t2Atb1u+6gIqUFyJAVofvgVy9yPISA9UhIbJyTLb7nXt9pKK
 sSwSL3KxRh5W8Fx79GcgGAW7b1x/A5shjjcC+7EkYfc3doYMEaDd1C6FN1IxpCL6h3Kbd9PKcy1
 zmzRhDDRxWc4waKS6YA==
X-Proofpoint-ORIG-GUID: K7i16swFqPEhjp0sYA1u_c-zSIBds_g2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190106

On 5/19/26 12:35 PM, Krzysztof Kozlowski wrote:
> On Tue, May 19, 2026 at 01:55:26PM +0530, Rakesh Kota wrote:
>>
>>> And isn't lack of monitored battery property enough to indicate that?
>>
>> Regarding monitored-battery — its absence alone isn't sufficient. The
>> BATT_ID line on debug boards is pulled to ~10kΩ, which is used during
>> development phase where some battery properties are still present. The
>> same ~10kΩ value is also used on some genuinely battery-less production
>> platforms where no battery properties exist, making auto-detection
>> unreliable. Hence the need for an explicit DT property to identify
>> hardware platforms where no battery populated. 
> 
> I don't understand this logic. So you claim you have debug boards which
> do not have battery, but define monitored-battery? Then these are wrong
> and fix them first.

I don't think any pmic-glink device defines a monitored-battery node

The firmware is in full control of the battery charger (maybe with the
exception of some coordination with ECs on some laptops and maybe if
the vendor has some very in-depth custom charging hw, but that's
educated guesses)

Konrad

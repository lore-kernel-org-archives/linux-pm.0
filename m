Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466C3F23DF
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901443; cv=none; b=t+/4a+nJFPMCYPkoplfCbKIE3JihoTo9O8I9yNBuKYQD2g+3OFKztbBadYC2l3ehOQT2PtPyJo0g/Z0As9nhDRCWm6CExWjouoCX3FYifHKTtlKZlbnMitYdPiEtQUont3mhggwKxkOy6wQ1HQ6g5IiGVP4JOpk1tUznBgZiBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901443; c=relaxed/simple;
	bh=SyE2Z25hzP8HKj4fDJ94fsBx77haZvgbrgT6zrnosF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XV4WwSzPqHiRPiZB9UWHKNjswQXH/Dtdb5DyFHw4rkRFVIDmsXgTojrj97p+HgsCKNZnAjZxI2wlHyFaDw18kOIrfEdeugaB3lsHxxTARL4E9HtnzPl7fGuifdt2LntMelm22iJvTN+SvBDN5AEh+mdt0MGFLF35vU1Bavp6mnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WbCqkCaV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VP31E+RW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WbCqkCaV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VP31E+RW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE3uCe1460112
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0nM8qXXdR5YbmFnkFs1b3gqnhsYEi9FrdxzOiNS83ok=; b=WbCqkCaVPtk9UIzR
	KDKCSMaLmcYdP1tdpf5tOpRaO0mn3OH1PnNolvBIODrRshpHOQfeyiC+HAXuuXSb
	NMa9FhyDweL/7ImGGK8oKAqobGVozeO6L87r76PpKW+7iisKT0zS206/mAvQ7DOy
	kyQZdimk5uqwwh/51UT868ZFKMrZOTn4+EN5b/SxxASJqRgF7BfceQ9oa5t9/VIo
	K6LiMfrkkofmAUwth/Rp08/e82hXilLVyHidvYkaRGkAA1aVu9T1JaO9O+qDHZ4F
	XUPdAnjZ67Sz2kIDDaDH8cdmpxJclU/KNn0vRPg4NpQRLKwZ1pGsHfr8ygRY8WOI
	bvlirw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjsawq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:24:00 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917a109c937so41823276d6.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791901440; x=1792506240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nM8qXXdR5YbmFnkFs1b3gqnhsYEi9FrdxzOiNS83ok=;
        b=VP31E+RWjjXDpdmtRhXqyS5lIdoqFwygLrAkqc/e+meRskF3iEk3EiCtdksVwRKL6b
         SVFt9JIzmZNR7qWljPagdJZlwaW3HlqWIXGGf5xxk8PW09+oEYBhK+Rvd+GVYkoZLywt
         VJ9KYshbdJhejyfCw/wnIUWZTRdITRVWLaxzAfWP5WAdg2ooqR12BBtxwqyVud8o1O29
         4gyb4dsGS6qaibD/MflADrcMF8VV3ey7Ics79DA1+p0EtJK8g1ogp6WJknuQ71Tvzs1S
         vRKQ3jjpOIWt0xVIs0Dmt/neiRmf026SWrLovOFWyX9tTLwnUOx8TEbOMt/8l9lUAt26
         WXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901440; x=1792506240;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0nM8qXXdR5YbmFnkFs1b3gqnhsYEi9FrdxzOiNS83ok=;
        b=YjLYbxBAtA4PyIutIpweK/psMg9VgCnlaANjKR7g/1g0vM7LoeJdKt8gCmTzyqRGdf
         vri1gsWxddOuwNB1f5nps8q4kixwEBatloEi8UkX2eP/sxPJXma2qqXSAbFe974ChsFD
         ySDu6LY5XDtMwcKBLLbhpY4jXs5n9+QEDvL7e4quHLof33tqA4dJU5/+Xl0QCwTSRXR0
         8/LOIFG7J48MzHnNwAXnyXoVJaQWP+UNctcfb38NSaD8mHU8zAhqN04+ml07cUjIQ/7L
         4NbUcnNXNGr9AorxfM0mHeheXc08BUSIuQifCw+cQnYtwwMGPGb37EyKDJmReWdlqNg0
         rMLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMTMZIBa2ODKLymUrcHZWhIf9Bc1/S7/RLTeIUsqZ6zMA8TAajChint60QPuKU6HwW/9cy4S68ZA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIjcgX8SB3vq+JhcV6MaSxIfl3Oknfu+6ouF8YVghCR6xds3xic
	ec/aLwWUOM+m5Y+4OMxjbGHrH5jaNzihrJzP6uklZW11ym76SSUCabLnhIRHow9DgOhNM/PQnO5
	2bqTmYtDghJ+e+fqAcoNsB8fVDIhfLuS7DsLWzqnzNfSR1k8FFLmTN7CYefHf/A==
X-Gm-Gg: AYBFou1jx5mIRgngtwQfZhk/kB1T3wOzkJpp3QhXzau/WG3e/GyYYkZdJW0OnhmFoaM
	skFKOJ4kHLKUR/QMMdBiVzJK0axJJZlX9AsIoAuR6qj61YW+p4XrXkJlOJtD8KIen9/ZVY+ebz9
	0LuzTvPaPNT6jmpzi7rMBhaQDxe6x8Id0knGUyS93nFtQ2u35c4v9lnN41LaSljlURHEQYkC1rs
	Agc1xrA+CkvhNJUukr2iOA6lh07Rldpa/SVuNEeDIG0oszWk7a7bvjyUIuMUIL9u5hgnt9LtTCB
	Oa0iu9yjfQqYPCOdtb+2K/VGpH1jr33aJ6CfrRbHwdhKXXxrMdlqoVlseOD8Dbw/5o33EQreR6o
	giEA+jXEgGWrXpGXs
X-Received: by 2002:a05:620a:6081:b0:93a:1fa7:1afb with SMTP id af79cd13be357-93ebd24d180mr2046719385a.42.1791901439881;
        Tue, 13 Oct 2026 07:23:59 -0700 (PDT)
X-Received: by 2002:a05:620a:6081:b0:93a:1fa7:1afb with SMTP id af79cd13be357-93ebd24d180mr2046711485a.42.1791901438883;
        Tue, 13 Oct 2026 07:23:58 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.4.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab48a7sm5417001f8f.24.2026.10.13.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:23:57 -0700 (PDT)
Message-ID: <5cf4bf60-00c1-4aa3-b264-aafba8af19bf@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:23:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
 <8796cfa1-5ae0-41fd-b3f2-c6b588157b12@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <8796cfa1-5ae0-41fd-b3f2-c6b588157b12@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NyBTYWx0ZWRfX2Bw9sxf3K/I0
 v8CSxcJOtgvvwhOtDWuScyXEigjuCiKIrn7tGZyDPH31eePK1g3kv3O+C9/bumi+BXjnuz2MQUX
 Xm7R22rR3F3k9DnRnmxIeJId2djs0yI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NyBTYWx0ZWRfX8bm5QSZHr2Sk
 e/QF/YQNiHZGbg47ibulKzfd3nVomjMwMrDLOWywxe3wovia3rFDHFR5NNYrGV0th6pvlfK2/gb
 J5hwO8V2qEbzna4yAK52667mwRPhCtWjPDl2ItBDPgSuYBC0A+vWBdR12utP9I51I5chz1PeaXm
 RD2EIkyudh+q2wyPqyX1XUV8lvOY27Lsgm/B/cevNxuBIClT3ceVH/o4fV1jU6cKqZwzvagsB3/
 GsHGVZYA7ezwO9L5sxwE8YHb3Fxs92mayP+RLFvg8CIPJWbKWZJ5DJY7nAP+DiGIY/v8wuwY6Ob
 6DkdoeQoVKAVruEn2ZGuFLqeGtiYJ9oYfHyH9hppL9R3+gAKmidKrw10w1uvRB/xUWlfdkS9zny
 7MqH1ComC9mHf9CNnIvAMxZStKBxxiu7dihYPHViGcYUwEVzUBD5or664VGrkDsvmNYn2sWyQ9f
 d/ugQwK5lw2uKkOdyjA==
X-Proofpoint-ORIG-GUID: WDTpzTPrpJRKV_SbSwg8A7Smzyd9toX8
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace3f00 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=Pwpi88Ktxb2v7RWwfB9ReQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=4bmiNBAiDDOXaXc57RkA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: WDTpzTPrpJRKV_SbSwg8A7Smzyd9toX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130057

On 10/13/26 16:01, Krzysztof Kozlowski wrote:
> On 13/10/2026 15:33, Daniel Lezcano wrote:
>> Hi Tudor,
>>
>> I noticed I picked up your series without notifying you
>>
>> However, I did not pay attention but picked also the dts files.
>>
>> Shall I drop them ? (AFAICS there is one comment) and let you handle
>> them separately ?
> 
> Were they reviewed? I think no, so that's another reason not to take
> DTS. Anyway, it must not go via driver subsystem, so please drop.
Yep, I agree, I'll drop them and keep the driver specific changes

Thanks

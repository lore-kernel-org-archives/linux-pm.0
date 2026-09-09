Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8C52B1DD
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950375; cv=none; b=VT4LcG8OcKWHWAvWveNo8fYF2vPIKtfuF7Moaq8rbJVjNZ6XMfY0e3B2HvYO0Mb+fyt5MhZLJxliy2Akv54Y/C9W90yBxN51hfV3ib5Hz7lkcsmJVm7pToMHSkGAAVBRsdrkDZW2mqpoPj2fULrX7ozayGQJPdNDeKd9rXtGO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950375; c=relaxed/simple;
	bh=bw0FcdNE089UrGqxgOxP0tC96Q7Q+avuOnPdcBrOj9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyKNe+vcdBnNFEfSVL745/d4DSGNRK/UUReBI3s45VXMuDeZpVa3SO4yoftbJaKE/pV0/USHH9T66XEdE0LYNHMJDLVIBtxP9FPsVpcweSf3UbiXXkWTq8fHmS9HpY53aCFqFhFOO+7QfcoLc62ho+rJSjxwnD/xF2UsInmzJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IRzdTMDH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nz+YKWYu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IRzdTMDH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nz+YKWYu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689ASdZ31048745
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 10:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ah1D05y2ARWiyzPYFDN5/jrEHY4yrUD3AP0+uHK2Us4=; b=IRzdTMDHjgyG+q32
	69dCsbkXfba4JNM3bf8G9jPYyFJjgU6Nd/x3kgpS/ZPEA0FedT3MvqKpbkIyA0oI
	Jf7hAT0w+lzy+NvCn234JZ5joeMoDsKO0b3XkzjLV23KgLo4EIGAPtHDSoEh22X4
	G48mWX0HMF0KObEH2rYNtu6ES7hgFJzeRhqZJkYu0nGzBVK+oXiPNPgyIY1vkITL
	lEGkwrfX4LEBGxD5aIBVmzIbHWLx1VJHvDJjtbmEYDC+ys6BSZJoDpaQqeU5d6nw
	E5cRfaSxWPRGOn/mDT5BiimIVSm+OuPGBdBpSljQxkOS+4rOmfPtP+OPMnJsFppy
	QuMFwQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559r68w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 10:39:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398d292eac1so11428408a91.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788950371; x=1789555171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ah1D05y2ARWiyzPYFDN5/jrEHY4yrUD3AP0+uHK2Us4=;
        b=Nz+YKWYuH0dhUdQ2pkn1GWn9n5ythD2QId2pM400L3Ti2NYdtMloTo+RfsD56JegBB
         PR/UmdzEeISrzrvmhchiUllRG1l7OxJBBC+5r6dHQGe8bfz/gaiV1TM8t9WlNROI6gx0
         KxyiQQISVd6CIFdVzENfC1aCnrzavi/3M4zDPHX2mXUGxTVjfdWfeElfSqZ9bXQGVvsO
         OODKxgWAEK92NxXV45qY6rx3hZ678j1CnkYxYCaa1SMIn0wphnJHXuZY9UjTlAEdlOPQ
         0Z7nCHwDwjnT+V0jHtDlSHnJbPEERIm6OaeOBwtCxtcjklTMZbMmBT1M2WiotBfrV2r4
         psdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950371; x=1789555171;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ah1D05y2ARWiyzPYFDN5/jrEHY4yrUD3AP0+uHK2Us4=;
        b=WPAIGidh5RvP01H0j52itf2ZrohbIo+FBwt0te0x04xIcYkVtAwjhfh6IswW2VxZtt
         381BiAcj14I6U99rRbxlAzUWTRtlFz0T30/riRaYYWHTwu+EBwp9qFzJUb2SuF6jvRzd
         o+odiXtVfeq8NqA7qMS+tqcal40yN7jK5EcCkcmgXM06er5gC408vZKU9rTVtob0aq4C
         SYbBgaQSSh8P9lOqKO1Oq7NUOtRK3eEDCYe+jiOcbzDmO3400DWlPC1YMm1P+Mak3Mau
         u1GYyZg32O8RtxbIE0YgRdmEN7nEXO3f/n+sfxG+Kra5dP1DKJSNDPevRQW2GaYACXGH
         Nhqg==
X-Forwarded-Encrypted: i=1; AKwUvBxTtzNk00Im+uIx48M+bfBwg6INEUG77jQfCzHukEsBf92TuLniMjydsvc85YnqZ+JQcmFkKzk9fg==@vger.kernel.org
X-Gm-Message-State: AFuF++lFq1pgFuTT3PMfAf04ZZkrcarbx31b3uxaLvvOGAWy5LY/SEGh
	vEWCox0/+VLDKpgiqvY8JP/UOhcaHHE/vA5eAy+tJkIkBXc4DPyIO4uTuUJLWQWQrAoyTHsYN+C
	+YK7L3DCLgXFytmA1owdy57MgZXAeSxUIxtNxuyA1Vn0zDmFY0/rHTeQvjVrv9Q==
X-Gm-Gg: AYBFou0D0vgnL9N+VQL5gF+I7VbAt0jchJFG1U50VDBsGd7l0yC/KIgmVplINaIezjr
	CtkEnzvLGGYKGl3R29Ji061S0+khlgoJhPJUSJpHgA7E2HjhnwaLhCxl9/1flArAk3nBBg87/Vt
	ZC0AzHsX0rYMaSkT36rkiU/bpRAQbq5m9mOqKRUVZv7hXqVRTWVoJRzpOUXDNYdsGrqCEKIKCm4
	X8jxRoVQnd+W/V3BiyPjn9jc0Bk6OwaYAcEhbKhIusMwNMb1H/4lRGJV8YnNcATHIsPjKpwvznG
	CJAxbB9Y8xUU02puPcSkJKpor8qDJYtkJ1jjy4t8c+bB0OS+3NlI6/EoGCcv6/tO0IySZ93010O
	/zvNoAe09i4GsxHrEWSE5GNlCqjKkag==
X-Received: by 2002:a17:90b:3d89:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39bac3f9063mr7705616a91.20.1788950370702;
        Wed, 09 Sep 2026 03:39:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3d89:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39bac3f9063mr7705565a91.20.1788950370145;
        Wed, 09 Sep 2026 03:39:30 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397c13dfb1sm6400531eec.2.2026.09.09.03.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 03:39:29 -0700 (PDT)
Message-ID: <695dfc01-2c1f-4503-9049-2ae266774ed2@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 16:09:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: glymur: Add ADC support for Glymur
 CRD
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <52c023c0-a61f-4116-851f-ed19de4d23f2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa13763 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=MEGDCpZww2ShHeW_oQkA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: HxosE5J4_zN9nkN95XI7_mqcOBY_ho0Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDExOCBTYWx0ZWRfX1PcaEPEgkjjG
 /xNMcMd2LlcjnUZlzB38R6EEyqiztfrzHdI7FXawOn0/pw0slNyM+2WxgEiBPid8V1bbnmueE5k
 C4tyO+wIrzl8CgqvWhdqPVdegKEGG5s=
X-Proofpoint-GUID: HxosE5J4_zN9nkN95XI7_mqcOBY_ho0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDExOCBTYWx0ZWRfX/rBhdffT1zX7
 t8r9Qj9tUbJkr4r2su4/O5a34TPJhzXZ3RhJmXKG8faaSJbhFvdQWz0kk2o+Y9DOjKiXLDXt3DY
 7eluL4IrXfmDJ3JFm+akijITzyufNRLPkh2h/xE8y6WWcNB9OyOv0FYKmvG0/6AFM+bS5Ni2dA3
 KtkFeUwVQTMj63kZ31esE6iPcC91UDkJ4VjBFpVVUyaSgpRzi6qHDt0sNhw9S84WhZTtbpIp/VE
 KWRUgtJGwA5CGkBM2QM9zxzjlHx3PlJ3UrP1DW58NNPBtVCrz9I5uZuOkRdm0PRs0MsR0sWm2gD
 O4Y7ZQSnXx64C8McM40KuwF+zZO0rne9TW+nCan+Zwk6xkWkKyyZeod+RCIvJMzBpjrWveTdS7A
 15hQ+y117gNWjblaGwKuZ6WYy8zSRpx3RokEHx89cVpcfo5glhdZNi3Ms+pUduv1tj3R7bA7M5c
 BQeEgnK2W81YTO8cDXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090118

Hi Konrad,

On 9/3/2026 2:19 PM, Konrad Dybcio wrote:
> On 7/31/26 8:06 PM, Jishnu Prakash wrote:
>> Add the ADC channels under the PMK8850 ADC node for the
>> other PMICS on the board with ADC peripherals. This includes
>> die temperature and VPH power channels per PMIC.
> 
> [...]
> 
>> +	thermal-zones {
>> +		sys-0-thermal {
> 
> Please name it xo-therm or something similar to make the connection
> more obvious

Sure, I'll update the node name to "xo-thermal" and make similar changes
in the other patch too.

> 
> [...]
> 
>> +&pmcx0102_c_e0_temp_alarm {
>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 2)>;
>> +	io-channel-names = "thermal";
>> +};
>> +
>> +&pmcx0102_c_e1_temp_alarm {
>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 2)>;
>> +	io-channel-names = "thermal";
>> +};
>> +
>> +&pmcx0102_d_e0_temp_alarm {
>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 3)>;
>> +	io-channel-names = "thermal";
>> +};
>> +
>> +&pmcx0102_d_e1_temp_alarm {
>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 3)>;
>> +	io-channel-names = "thermal";
>> +};
> 
> Are these going to be always wired up this way on all Glymur boards?

I'm not sure what you mean here - each temp-alarm peripheral here
is using the die_temp channel from the ADC on the same PMIC to
read the PMIC die temperature. Die_temp is an internal sensor
and the die_temp ADC channel is always present on any PMIC
which has ADC, it is not like thermistors which are optionally
connected to AMUX/GPIO pins and can change between boards, so
I think we can consider the above configuration will not change
between Glymur boards.

Does this answer your question?

Checking some more, I noticed that this file (glymur-crd.dtsi) is
included in one other board file (mahua-crd.dts) and that board
lacks a few PMICs used on Glymur, so I'll also make sure to
delete any Glymur ADC channels absent for that board.

Thanks,
JIshnu

> 
> Konrad


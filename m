Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A53C4163
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664670; cv=none; b=gIknIMSvQAO8iAW8sl668AYRgOyYWKaLT/lRSvncWwO0HWfOYi7OHACY2LcPNvZ8YANGpTBc00CJ5X/Ue6Ns/2ojvJaOO5rBOV256rH/2M6ROQBvWbkuWiQHDAiZQ6JViouBYkHBDsqzglBcHK7QoiQi5kF3zR6VjAwbvu1ivH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664670; c=relaxed/simple;
	bh=xBcsERAGMD9eGee+SFf8E3U4t25wa6AVynACUUStgmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+wKZgaSlqIYdvBAZyqUsreWGE91tCaAmO/qgEZw+10X0R52zdAcI9G98mh+K7hVOlkYJlDoOdpJ/s/kHrOz/07W7K7Wsj1wqdfE0TCW1Okp06OriMN2Ii1pWLEXYoWyiuKgwgtTtAs6Kw3O/LYP+9y4irJs+V0kVVGDn3NtlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nn1oTJqZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=atOMOI3L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nn1oTJqZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="atOMOI3L"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T6ojLi054070
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 06:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ETLrKADipHnQ0SvOXNNqJhUBO4FGwFDlpJ1cHVM8gQ=; b=Nn1oTJqZKgpL34gB
	PYd6lvc9jUtOrzbjx11pTeoFrNmIxW0en6/g71KyXJ39sqFDHbGo+3m67xNCmTpR
	2mgvv2L2qO/RtMmJ1afjOzAOjbv+lTkgTSS38pdoSBL3rvCe/ZHwegTryIPfDtZH
	SCZ9v9e/+7uRFb55nJlWPu+65DCT8HKA61N4fHPjCWg2biLYIIaNzWCY+sX530EH
	KYg+SFS+785CLIpvlQBejGqM9Li5S6vI2b76hHK9tPk8eU/siHnaW3vMKyQm4Wq0
	ndPKEVAhMCVPJw7dUNvyPVjVPBKiKY7/OfcDss5JTGsfnIhKHo/phICgg6f+R6kk
	JPbsUA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0g01t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 06:51:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-88620af3beeso2703b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790664666; x=1791269466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ETLrKADipHnQ0SvOXNNqJhUBO4FGwFDlpJ1cHVM8gQ=;
        b=atOMOI3LzLpcYZDBF1czx7FzQ14ZzzWCbOUmsuquyWyjXWzqYRyuS/dsjAV/OKN49H
         nb4UbPHuz1qteIL0m6OJPc/f9TrrXSC7dyiwxsxTsD4VJgP++6MG3Pdy2LeQxwwTNUzW
         MhMH5jZIMT1csecNWyypi5JtbFmdvgklfU+BEQ+HQybPLrLEBfMbpmpfP4NQD8XOEnM4
         FaPx+mWd8lCkvOeGXUrzbz3jG8tf/lVwVs9ze85sSfMDJAxn1rpUQlRjsO3bHuUCWTLb
         YrjiHpMj+9xCuVaojgieWvGEVydTD4deFqPT/TnF+AFIDF1adV4UQpxXcsHMUvvXs0uK
         g3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790664666; x=1791269466;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ETLrKADipHnQ0SvOXNNqJhUBO4FGwFDlpJ1cHVM8gQ=;
        b=G62K3pAANb/Zo17q6HcOAF7el3w+NhtbU4PY/IAL7GesX2Ml1QBI6UODNwpOMvudO7
         2aMlU028ELPuDG0FP9XIoIS96ohrBEFLcDMV2QrTqxn+ItsvzLH0JY9BD2NGtCwlr6Nt
         5XwDsud9NH6LrG033d8sVeDHp1WUYx9kNWOr1UkXtRu4HB8g5R7B6Y4wqSEsrES+qhrB
         JEIUOqQvddwPQerVefSSWh+fGoosMNTN6fvkVKvyhe6L4/4Qy6rmtb8DblevLzFbFG7C
         oeWWD2upku8WNkf4IwMhH9EDfS6dKLeZp/2Z8IWNeGd9mRTxM+4twOlaHituCozlkSv1
         6Gww==
X-Forwarded-Encrypted: i=1; AKwUvBxMtkg0OBso6fXHPROQJnuAPF4y46JhytziRp1dCc497o2j/pw9lY3ZJhc/g+X2O5zI+r/lPrv4cA==@vger.kernel.org
X-Gm-Message-State: AFuF++lo/sOgs6y3OPLt6JGhdqwBy/81onb9LeyGYyjI4LcHYCqp6G7o
	mnzMOOWKeEhnLMcfL017ym+5YDelWTwuvsbdaCzPHJnu+amyIinabq+wW3avIQflWLin9JtyKJC
	nH28TW/vIUzJEluir2waWexSXf9DfH3tGhH6alDkWsv0aMSh7CUAph0fFs0aHmQ==
X-Gm-Gg: AYBFou0FMRmdgc71VJxXyYNa7zWFVj2G6V1CDY8eqGkvz3X42lU3xoz12SE1alitKwZ
	ulA19ykTpAyX6TXFF49QICNZ5GQGQqsD2ZU7kb10UVFHFtTu99Z6gxZl3FUrjLlKEzdTYa4ROfK
	INbAaUrGA/H552aNRXJj0GDmJbsUYsfC+hlqi5wijx2zbULg44R+B/uu9GsisApVbax4pLD+RzC
	8ENqqqq6XwCMoqnYhX6trDOkhinOkqj0fKILnwLBgldDfAXLHyRJW83Yirf1GSUHVL5pQFdpBG6
	Wprw6gnDarWI2otXas7Vj060O57lGZRySGrKuqq3Q5WLKLuixlxKTezZjh1OPQpikBxqOkg6vnf
	Kiokq0LP6tty0gOHCHI2fKIAR5L9ID1arGxO9oS2pFcSJ5CmxspLmUFvxDUqczqwyzdAz4vmFUc
	PpZBHR/djzjQ6uL/7oSosO
X-Received: by 2002:a05:6a00:2d25:b0:881:236b:748a with SMTP id d2e1a72fcca58-8855fb8b546mr1025624b3a.16.1790664666079;
        Mon, 28 Sep 2026 23:51:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d25:b0:881:236b:748a with SMTP id d2e1a72fcca58-8855fb8b546mr1025611b3a.16.1790664665618;
        Mon, 28 Sep 2026 23:51:05 -0700 (PDT)
Received: from [10.79.116.189] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-885e28d7d23sm258534b3a.56.2026.09.28.23.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 23:51:05 -0700 (PDT)
Message-ID: <186fbca3-3676-492f-9c8e-fc7a75d5ead4@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:20:56 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-15-6d47636a8f09@oss.qualcomm.com>
 <1a167d6f-2dce-4d06-a416-9fd1e25c69a8@oss.qualcomm.com>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <1a167d6f-2dce-4d06-a416-9fd1e25c69a8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNyBTYWx0ZWRfX9i8GZDXkVbUl
 nKq4TF33N9epQX+e6WZ/28rmAMGa7QQ7y4BKEDnK6Y9ElqSpGtlS7/sXRNfBTprB4jqsV3j/Za+
 FOcuLVDycwLcYJMhLg0oWPr9bPfRAb8=
X-Proofpoint-ORIG-GUID: kJNj6-yWdiCj2r8ZNT1mwlvIhz7BycRu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNyBTYWx0ZWRfXzmJQAKoruM6j
 lE796JgJ0NvFXT0LB2yPR4k9Q2SdKrs4+QJXIvg7A06flhsDjSQuefLykA7tGSiePTSAnIwX7ck
 ABfItpbupLwiBTHG/3UKXRd9YDWVoK0m43oyEMhG9vX0R66F/X4Ch9aCH0aFmFNBrkCE+Qdotmm
 OlX/r4hscp+CeMFuNCbQFrvSj/MRoC+D7d2nzCT9aGPpNYqjizubzRAOBt69vno7Mr3K5QbMvCo
 M0Sv9SN4NGZC2UvjSVxNuMkfqwJ11WfhaIvEwCWBQor9CS+7ZStsiINf4P3a0UTAeADTLanqh4z
 SjGhb4oZSkOfI/Yt7URx0ZUnOFW2q99bgZOBuOzE+M5oZQjimMd5FWQ1SPmrzEWMn27Sg/KP/5h
 sR7iF29Ek7Q/8x0RcOe+ijPe5W0PH1Me3aH6Y++uwFWuKy6mYTkdRrIXgzbp2dg2Ig9axoVpzy3
 PCHCWwcGtKWBBld+kaA==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abb5fdb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PaPtSKYIirbzHVDMbN0A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: kJNj6-yWdiCj2r8ZNT1mwlvIhz7BycRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290027


On 9/1/2026 9:26 PM, Konrad Dybcio wrote:
> On 8/27/26 7:51 PM, Hardeep Sharma wrote:
>> Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
>> (qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.
>>
>> Peripherals included in this initial set:
>>    - Single Cortex-A7 CPU with PSCI idle states
>>    - RPMh RSC with clock controller, power domains, and BCM voter
>>    - GCC (Global Clock Controller)
>>    - TLMM pin controller (110 GPIOs)
>>    - Interconnect (aggre-noc, cnoc-main)
>>    - GENI UART console (QUP SE3)
>>    - SMEM, hardware spinlocks (TCSR mutex)
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> ---
> [...]
>
>> +		pdc: interrupt-controller@b220000 {
>> +			compatible = "qcom,kuno-pdc", "qcom,pdc";
>> +			reg = <0x0b220000 0x10000>;
>> +			qcom,pdc-ranges = <1 148 6>,
>> +					  <9 156 2>,
>> +					  <17 164 7>;
> GPT reports you're missing a whole lot of entries here and that will
> lead to the wakeup GPIOs silently failing.
>
> An old local script suggests this map is correct instead, but please
> check yourself:
>
> <1 148 6>,
> <9 156 2>,
> <17 164 7>,
> <26 173 1>,
> <29 176 1>,
> <40 187 1>,
> <46 193 6>,
> <52 266 32>,
> <84 249 1>,
> <85 256 1>,
> <86 315 4>,
> <90 43 1>,
> <91 45 1>,
> <92 154 2>,
> <94 158 6>,
> <100 171 2>,
> <102 174 1>,
> <103 23 7>,
> <110 147 1>,
> <111 31 4>,
> <115 175 1>,
> <116 177 10>,
> <126 188 5>;
>
> Konrad

Thanks Konrad for review.

fixed in v6 : 
https://lore.kernel.org/all/20260929-kuno-soc-support-v6-1-a16afafbcbc7@oss.qualcomm.com/


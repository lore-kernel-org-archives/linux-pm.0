Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A73AE1BC
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288113; cv=none; b=dZwVEjX5VKeSNN9NhNgL1yVLl2ozzvOV7LltPrhh4TFDCYDzjG9aLm0HKlo/pANqRdDk7wVI2AOclJmIjl5R1NaHfdn6bF/gBJSSOoroZmcQ0ZyGcDhHtmm3bhCnyzhliYJrhqRzebpb3TtFgfA5ETWD2TxWINnz2BQUkDCvB/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288113; c=relaxed/simple;
	bh=jbmancpsHTjVs2TeiXOri8bQFZyZ0a+JoVJMwsnKP0U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M87difSAFAvlwjdkkhzMrVI5QLwlhywaWyE4HGad5FetqQJH72vU92Hg7mTjMT1HW7TX/Gf9g9O8GvozDlp1KeV5xJ8MmIL0HKSNEU57Gc3aTmJmQDxf/A7/FZX0yvsfB6TELyKsLomzPEWVJ8HVWc6CemY1TpmSTjwnkulf/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eujh0OHx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gjcKdwH2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eujh0OHx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gjcKdwH2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L4Frkg2347432
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 04:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uk9NLu6lCcY8JkSba9VV/ahy8MrSZ53djuNpID1PR1M=; b=Eujh0OHxd2HnZjx5
	dBlEVwNEtHMvBseOq34Pli3xN1EBm43dmAnwCuFKJVEKiKLlXYA5qnfc0d+tByXk
	eGemOaPGFTXmqVAiecsxmlYX/78ie4koD08WRd6qGOuIP4+ln2StYCgskgqR+Yxf
	VaIsdwFnGPlgDtrDUEc0i+g6eEyy6YefZBYiwMSyR3gMw4yYy2Q9FcKlVeEO6hS8
	pZqmgedIcbnPX/x1rgkoxO4jUXqWKCMtW2IfVtopu8LNk1fi2E4xivjqHzwmDe/Z
	iKu2lgNhpLAGQyNMpAnixEmuApMYpS8dELmqka9aCQPA+vFmdYXFLiWAg23pFkHt
	Eb7qWA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9r3g2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 04:55:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so1091480a91.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787288108; x=1787892908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uk9NLu6lCcY8JkSba9VV/ahy8MrSZ53djuNpID1PR1M=;
        b=gjcKdwH2I68HWHNWrCrWWxoo+3opqwKoalW4BE7yP8FI1HKsjZ0IPEPibp03V5fsft
         +fbSNo2VOt4vMD3Mce9oyEjQi5yCJc+roXe4hKATFswz7vUmvH5uKBDJL3cxq49Kazd1
         W0k9lxmuDxQiTyugjZMCPlwbd1ZcwA6FGzvlcY+uSVSp8C5/+/iSC5O0aP/Xo62JFpvp
         CD7oe7uSeeJ+U/kXiy/kI5sk9jqvVeWU1st7pDlQUDKNHlt1/Q3gXc1KxAQlKpCOFxaJ
         HSyos6fYFBol7oO79wjySu1Yyy7DrMQ1Eioiz5tHiU2VnCtzS/75+8zz17PF8UsbIkaF
         mgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787288108; x=1787892908;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uk9NLu6lCcY8JkSba9VV/ahy8MrSZ53djuNpID1PR1M=;
        b=o5UhJ2+iIzYQft6ZF1quDPx/RPbs4exhnvbLCj1UZm+u1VuF8iuJudjCMRrAwNKIgN
         nt7mAKzmyU04rXgoa7/NauYPrctNT9DhfCOazMWwVusEJRpohEZsjtk5O2sXnk9Ln5bF
         Eudpwqg44LjerJh4FulCbApRWa8PrxUvG07UAzkS/TfcnWAyS0+a5OzauY8Jn68rpbqf
         34msO3IYZsUhMoWRQR0HmZdL1OccVLd/LDT0GLrZ47gSCs3TLASDrGuc+zOOhe/e3du/
         OWBq7TzwvkhaPDrgIfNAuXsImSuwq/zPFTuTelLAC9xKknyey+FibWTjhgGGd/SjAEJW
         6YPA==
X-Forwarded-Encrypted: i=1; AHgh+Rou4R4HsbwypoNy4+wbs7NKfKx2wIZ4/kdA25w8Pby6PYEMSzgdXRSRyHKaQFEVfLRvmxcLrWWIjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWJhCz+L53mRliJkK43j72grnyWbdg+cfR/WHwxYkhqQRlwAj
	9DXJjkO7+E68aMGdif4LDbMF+gMWDECJT59G+5RjYBHnBCenE5ku9WmjdLW+4fkB60UGy04zm1c
	Om2PGQ7pMUSlraUY/chIMo4zlz8pdTh9OMpVebx6kXdZ7keu/hLC25EvnCZQQ2Q==
X-Gm-Gg: AR+sD12BRs7GEsWpDdQhDvxyTx5YwYf5wludMGqNBSJGyJ6xFf6Vltlv9yjKimtRQ4v
	cpted4AHzskUAnuHiAnPAdfUJ3hDKgCEElrzRb5r6HTJ+tYUszhdcMqC5uNJdwtWryumZwC+H4l
	RYvQjKFGJ8D01JMk1yLTNuwQWhnUPpoZyjoo6dMZavLo2Cigyor/HmfWkUE9rZvCSVV2wXSXtq8
	mBJcna17zS2XpjBkD4JVW+nqGlQG51PJ3Zeo7Hg3uFdQ5B5C1t6xHR+IYxAOk2CJ56oTwpxJgdX
	Ryw7kKLs+qqi3PcBjnp2HO8axUJO+avBoanqevvfT5iCM4xFP7E4yibS5ax7aIimASOC/Xp08RB
	HZDe2flhMjxC3at1hsxINFwLN75ofJw==
X-Received: by 2002:a05:6300:67c1:b0:3cc:9620:5816 with SMTP id adf61e73a8af0-3cd306150e3mr7172997637.8.1787288108179;
        Thu, 20 Aug 2026 21:55:08 -0700 (PDT)
X-Received: by 2002:a05:6300:67c1:b0:3cc:9620:5816 with SMTP id adf61e73a8af0-3cd306150e3mr7172878637.8.1787288107721;
        Thu, 20 Aug 2026 21:55:07 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb46sm20562131eec.3.2026.08.20.21.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 21:55:07 -0700 (PDT)
Message-ID: <16248e00-5ac9-43c8-9e4f-1b3fb061dd2c@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 10:24:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen4 ADC
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>
 <20260804-marvellous-crayfish-of-recreation-d06401@quoll>
 <4e25b74c-baea-4283-9730-7313162284b5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4e25b74c-baea-4283-9730-7313162284b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDAzMSBTYWx0ZWRfX9jd3QIZz89pX
 bK5vFc1e5x1QtlRLbfaLb/dSG6frm7/oe5QD8JENoLoe8XGD5T0rpN9OZqqa1l99JlMKle0Qv8T
 YtuddDGME2oyjx76c+lfw9xwHcVofxEmEQxwzt+RHZuNNk6USLcq5hg+9FTdT/T+A+ew6lTmOC7
 JkrkDbg0tHqhtx8GmVvlHK8CvDVNx66C9HwmUku2hUly+KDS1gvxswQQpQzlonzwVKR5AoOOMfu
 f4iAiAK3Vxkchq+T+YtWy+iwvx/jmTBY2wXBBwFA/jHF6+bV6VXq7OvhaoHhtpmUZEJRwmwGhzi
 dmM8Kbi+HbjyPpxhk2kYpMZATdTCkWC4B+Fj73Z1D+7CrF2PDRRkvhsA85eJ/U8YaW2usoBgqxj
 zewC1WJupV+QgosuGF8M8Nuuphrecx9r7Bbz2dhlhJCtEVAHnv+7WrZwbOUVBOaGLWy6skg2qjO
 2uq50ybh1609wiA9c3A==
X-Proofpoint-ORIG-GUID: -_R7KIOVbrUlDbOh8JWaFbeeNT0GzAsR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDAzMSBTYWx0ZWRfX19li/HYuQ7g0
 BELF5eRaEEy7Ttv+6nuLdFHtA681awUCVSo2ti5BMwIs6QSUeM0hNTfwWSH4pupm97vhH80vIuo
 Mz2C9FxDTwtNUgwnSbGPR/1lTum8f6Q=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a87da2c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JbgVt6K1tEAjoNa7P_MA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: -_R7KIOVbrUlDbOh8JWaFbeeNT0GzAsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210031

Hi Krzysztof,

On 8/6/2026 4:23 PM, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 8/4/2026 1:50 PM, Krzysztof Kozlowski wrote:
>> On Fri, Jul 31, 2026 at 11:36:14PM +0530, Jishnu Prakash wrote:
>>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
>>> improved performance, mostly at the hardware level. The main differences are
>>> increased ratiometric conversion resolution (from 14 bits to 16 bits) and
>>> increased bit field width for PMIC SID (to allow communication with an
>>> increased number of PMICs, supported on latest SoCs).
>>>
>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>>> ---
>>>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 47 +++++++++++++++++++++-
>>>  1 file changed, 46 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>>> index 149f4af8f4b8..e79ddc2acca0 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>>> @@ -21,9 +21,14 @@ description: |
>>>    All boards using a particular (SOC + master PMIC) combination will have the
>>>    same number of ADC SDAMs supported on that PMIC.
>>>  
>>> +  PMIC5 Gen4 ADC is similar to Gen3 ADC, with some differences such as
>>> +  improved ratiometric conversion resolution.
>>> +
>>>  properties:
>>>    compatible:
>>> -    const: qcom,spmi-adc5-gen3
>>> +    enum:
>>> +      - qcom,spmi-adc5-gen3
>>> +      - qcom,spmi-adc5-gen4
>>>  
>>>    reg:
>>>      items:
>>> @@ -83,6 +88,46 @@ patternProperties:
>>>            This property indicates ADC_TM monitoring is done on this channel.
>>>          type: boolean
>>>  
>>> +      qcom,adc5-gen4:
>>> +        description:
>>> +          Indicates channel is of type ADC5 Gen4. This may be needed in cases where the
>>> +          master PMIC has an ADC peripheral of type Gen3, but some of the other PMICs it
>>> +          communicates with have ADC peripherals of type Gen4, so channels of those PMICs
>>> +          need to be marked as Gen4 to ensure their conversions are handled correctly.
>>> +        type: boolean
>>
>> It is implied by the compatibles, in this case the peripheral
>> compatible.
> 
> This property is needed in cases where a Gen3 master PMIC has Gen4
> channels under it.
> 
> The main point to keep in mind for Gen3/Gen4 ADC is that the compatible
> describes the ADC peripheral on the master PMIC, but the master PMIC's
> ADC communicates with ADCs on other PMICs, which may not always be of
> the same generation. Under the master PMIC's ADC DT node, we have ADC
> channel nodes from all the PMICs it communicates with.
> 
> 
> For example, SM8750 has the following 8 PMICs, having ADC channels:
> 
> PMK8550 (Gen3 master PMIC)
> PM8550
> PM8550vs (2 instances)
> PM8550ve (3 instances)
> PMIH0108
> 
> 
> ADCs on the first 7 PMICs are of type Gen3, but PMIH0108 has
> Gen4 ADC. So ADC channels of PMIH0108 exposed under the PMK8550
> ADC peripheral need to have the "qcom,adc5-gen4" property to
> indicate they are of a different generation and may need a
> different conversion formula.
> 
> Similarly, on some variants of the upcoming mobile platform Maili,
> we have the opposite case (master PMIC has Gen4 ADC, one of the
> other PMICs has Gen3 ADC), so we would also need the "qcom,adc5-gen3"
> property for some platforms.
> 
> I'll add a description for these properties too in the commit
> message, hope it helps.
> 

Please let me know, does the above explanation look fine for
why we need the channel property "qcom,adc5-gen4" ?

And Jonathan was asking me to split this patch, to add the
new Gen4 compatible first and channel properties separately,
do you have any preferences there?

Thanks,
Jishnu


> Thanks,
> Jishnu
> 
> 
>>
>> Best regards,
>> Krzysztof
>>
> 


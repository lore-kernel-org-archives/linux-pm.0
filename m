Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB013988E8
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268963; cv=none; b=E+zr40oojZVzMDTWCbTXWwf2bdiXAtU0qvwe8koVFXSSfQ0QBRlLBMOPZO1UGsnyp1brs2DaDXtnZqQxtm9fL04EzI/RNyHMMgsa+RvEiALz5IvA0uBbeMLrcviXofCXqvvk+mLNEt3gVTdxp9awz2BsPOBHt1Qc4b3cEMa/CQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268963; c=relaxed/simple;
	bh=V+5nwfuchMq7THgnJ8fbiivWk1WflIC8KpzjAag1ohk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sudAVQnrej7DcukRXQIGc/qEr+FFRCxISQthshI2Rz3difXDE11XUV4OILlmrc3ZSFTSZBiZHiVxct1jcXrtTRkDI/a+EynH+bdxWGktsg1rDLC3ocaQB3yWriqXaSCdRLkvNqtJcSNlvxybCzLUyc9Pyu6PGFSQJJuClLbzVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NS0uq6fk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f1MHYkAL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NS0uq6fk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1MHYkAL"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N73Jf03452104
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 12:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2+VRrig11+i8e90Kq8n9FlHXGOQI0e/YsOltrawFtIM=; b=NS0uq6fkT8mmbEJU
	KAeCbH8tKvFzKqTlYohKnfchVEW1JE5PBT8+hbEIzoVuMA6zOugzSFjKP86iljD3
	4hVl1/UveCEVOi8pqMUqhATmLyUtjoirWKm4cHje8jcgirZ2gunVi2M5ZRMCIsgH
	cxiXNKFow4po32jXGLkrGsql7/9ziCjzQ+6/XsBUKvzgHwbCZmRQ+fYjDjzkjc2m
	Ll50KnmGIcQZpLFwajq4wLjn7TFMrcDSNQYzVcyoZ5DHFXdkW39NZGqgfRc/R7IM
	3uKvo4viRn6E6BonVec4HbGlV+K4UxV50TSggbeGv3hEQ3WSqM7t1v593PZL4EUR
	jilwZw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d2ca8k87r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 12:29:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b2a1f123fso28595791cf.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774268960; x=1774873760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+VRrig11+i8e90Kq8n9FlHXGOQI0e/YsOltrawFtIM=;
        b=f1MHYkAL5VM2ij+10OUTeqmDlggFVLlrB6AdYnmMsFFlyjGM/RMOx1evpv7ZeeAvG/
         zgi93ZgGDrMc4IuYVm8iggef5v6X5gxjDXV3sZ6OPBJeRl8KMU80eg2qL2TG/DaFJgbC
         CK1QNsMXlz1K6xhyySQ3hrfFZHrg5ufrP1hfbJvAmiJ9Z0vh3eI94xBWP3Su20Fc73Wl
         gPM+V711+CCJjFWXXhLH0qQE5tuCIW7Ov44b6m/+WYUCuco/87qxN3lu/7lc22cjTbVf
         bEIhQfdh1Z4IY6UE9klHN4ZnSCMkzhpgJHhI5p2ALXv8rjU3brZvKPAb98Ndm38zA0Nx
         wmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774268960; x=1774873760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+VRrig11+i8e90Kq8n9FlHXGOQI0e/YsOltrawFtIM=;
        b=ojZLFz/uY3cZyCdRk49EzEW6ogzsevoNSBQlUEqRVz8W9lHbkchKVCRl83ktvQUn+s
         puOWEcj3jykTfv+H643GzapVp5MnZ5STvdn24IVb/WgCCvs00CtRmvZN5n4SyxBQpiDv
         dn+/Wj0Z2yr3v2BAsMWz2EBaUTK9Qp4AGIk37KvHgp09qKCsaLBIoMh9Gs1OQsRUVZBa
         F5dKoiU2ccwA0PWoeQy0c2aP9zN3qRN31hTKfHStOJsr+4743t1oyGtmPYVbRMsOXQXD
         E1oxdjLm9THDKpEFdhIk8hPBEQZqgu7bM4Zj+jUZwGo2BaO9gnZClE4v6AA3HWXoK9Tv
         /t8A==
X-Forwarded-Encrypted: i=1; AJvYcCUBxC/xBT+o9Mq+UQs4Ne9RGrS7vixfUyk4hnDhce5yt+8llOtnJAfoVl2xyaecW2aTYSZZNbziyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEr3Txtqgqf43GJdhVvg/lNPFkxzXp4zm/meDGnIDwXafuxcvp
	HLZ+pbZxN9WcN8bcvShbGfk7Ad/CtfnbdkVcXAoz2pNhOrLJpGvsO1SjGVI3wfU+a0hSBh96JHy
	GBS2kfhaLTNpoCfwzJh5f5d+rg0kjfxoASgBnPWX5Ja4DySiXsC80UB+uhSJR0g==
X-Gm-Gg: ATEYQzw5tbBX63CVhTsoPqvZU9tPFYFSliCRbU8bXF/2j0OY9WwUYmp92HBM3DNgTeK
	6HnKcMuvGw23Qm0tuvt8mGYSCzauM2//IqNmkNif20xy5zk3FgXP6Yfs9xLuolJ7ZJv1/9cfbqM
	3bsQmY00mtBHDr3d4j+PAcMf2Df6eelnAL8LFJgV1+GJQSXfWWTgxpgi7JmFAocWhghlI6E7ypN
	qxwwqvpj7goalvLCWUGTDN1oykyjsQwS+/US/fSB1TK0uXE7zHtKOBDH5h1wRTqO+Rf5KGOdI9b
	0miUHSK3YUIFXU7vmRjNAwhCiLQhG0+wNuuclDWCllzbM5Ls6LT1jqjK87Vti6kIi0uqDQ3I9Oz
	O2RZf0DInFX9KZKJqz5bgL5wlpy7SdFOKh1DGsz/kDwam16L/nyCD+eaSpNBfyarFZSJJ/kZBe0
	TTJ84=
X-Received: by 2002:ac8:544:0:b0:50b:5286:f761 with SMTP id d75a77b69052e-50b52870775mr46456271cf.6.1774268960262;
        Mon, 23 Mar 2026 05:29:20 -0700 (PDT)
X-Received: by 2002:ac8:544:0:b0:50b:5286:f761 with SMTP id d75a77b69052e-50b52870775mr46455971cf.6.1774268959650;
        Mon, 23 Mar 2026 05:29:19 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668d2390f7csm3607046a12.24.2026.03.23.05.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 05:29:18 -0700 (PDT)
Message-ID: <7e50100a-514f-4f73-a976-9858ce5cc0e1@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 13:29:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <20260128-whispering-caracal-of-respect-a26638@quoll>
 <36706481-2549-4716-8e6d-0e4db42591a2@oss.qualcomm.com>
 <546faeda-d896-403c-a449-5c9b0cd7159e@kernel.org>
 <17474333-bb82-49d7-bc04-45ab21095c38@oss.qualcomm.com>
 <ae4c1f7e-8f4c-4ce0-a6b8-bab29984e693@kernel.org>
 <c6136314-5bdf-466b-b19e-43062fb11150@oss.qualcomm.com>
 <e6679f94-2648-4d35-80cf-d3f823f9dad3@kernel.org>
 <4f815a0f-a815-4b77-a4cf-a4b18e776eab@oss.qualcomm.com>
 <95142608-b5b1-43a4-b8b6-38e658275f30@kernel.org>
 <abhgxF1RcAJD-cK9@mai.linaro.org>
 <3922012f-25e6-4b75-9183-f9277ef5d040@oss.qualcomm.com>
 <74f59ef0-ead7-483f-a80e-a3da2f6ebcdb@oss.qualcomm.com>
 <909009ab-53fe-4b20-ad2c-bc8eac9e8bc1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <909009ab-53fe-4b20-ad2c-bc8eac9e8bc1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5NiBTYWx0ZWRfX3mfaSSpk81O7
 CBARGOwnyh5zvgox3qZmSCnt6Bv/64PD/UKWW4TJE+y9PuZf5mG9e7FCJGaVNc91qWPLN1bgfCM
 eL9o4SuxKaB2YDt6CYNhi4Us08DZrHdJOJ7TP4iZUTHlpq1xNNQfX3rTNhyxYUH3xdWPkjLK22i
 HzueOeTv+XY0EORAmeUblI2uvgcuWCBVdw0sGrW389k63wxRtCGwUBxOEbM+0nVxeNjG0IPPrQ6
 ZnHOUtKrfGv0b8ZKNamdBHQUT8wtdT/s5EjKU+sm2YV5ec0WdcwqPKCH6DMQe27al1yxqA3k2Xt
 uYZIpbPZCNd73QcEWWAwqzYmeHGexhvdQaXIEtLsJoUjIxbAWEYGuQQUSidNLM0cQvmkBqFXoZ/
 pwGfWpbPKgBlUrX4Aw1VLiFMFikkEVbP+41YbEXeLskzBDJCm/8I01sST6oSUb4xOF99KW/bP2Y
 Jx8HUS5vxRbOBMuYD6w==
X-Authority-Analysis: v=2.4 cv=cf3fb3DM c=1 sm=1 tr=0 ts=69c13221 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=LsSkit4W3LD1FCZXXk8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 1fOPJ3YToqcG_UTENwL5efkyIlX9qSsS
X-Proofpoint-GUID: 1fOPJ3YToqcG_UTENwL5efkyIlX9qSsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230096

On 3/21/26 10:00 AM, Daniel Lezcano wrote:
> 
> Hi Konrad,
> 
> On 3/19/26 10:51, Konrad Dybcio wrote:
>> On 3/18/26 11:17 AM, Gaurav Kohli wrote:
>>>
>>>
>>> On 3/17/2026 1:27 AM, Daniel Lezcano wrote:
>>>> On Tue, Feb 24, 2026 at 01:17:22PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 24/02/2026 13:09, Gaurav Kohli wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>>>> As a result, each core requires its own cooling device, which must be
>>>>>>>> linked to its TSENS thermal zone. Because of this, we introduced
>>>>>>>> multiple child nodes—one for each cooling device.
>>>>>>>
>>>>>>> So you have one device with cooling cells=1+2, no?
>>>>>>>
>>>>>>
>>>>>> This will be a bigger framework change which is not supported, i can see
>>>>>
>>>>> I don't think that changing open source frameworks is "not supported". I
>>>>> am pretty sure that changing is not only supported, but actually desired.
>>>>
>>>> Yes, IMO it could make sense. There are the thermal zones with phandle
>>>> to a sensor and a sensor id. We can have the same with a phandle to a
>>>> cooling device and a cooling device id.
>>>>
>>>> (... or several ids because the thermal sensor can also have multiple
>>>> ids ?)
>>>>
>>>> May be an array of names corresponding to the TMD names at the 'id'
>>>> position ?
>>>>
>>>
>>> I am using dt node like below to use with cooling-cells = <3> approach, will post new patches with that.
>>>
>>> cdsp_tmd: cdsp-tmd {
>>>      compatible = "qcom,qmi-cooling-cdsp";
>>>      tmd-names = "cdsp_sw", "cdsp_hw";
>>>      #cooling-cells = <3>;
>>> };
>>>
>>> please let me know, if you are expecting something like this only.
>>
>> My question about the need of a separate node still remains, i.e.
>> why can't this be:
>>
>> remoteproc_cdsp: remoteproc@cafebabe {
>>     compatible = "qcom,foo-cdsp"
>>
>>     ...
>>
>>     tmd-names = "abc", "xyz";
>>     #cooling-cells = <3>;
>> };
>>
>>
>>
>> foo-thermal {
>>     cooling-maps {
>>         map0 {
>>             cooling-device = <&remoteproc_cdsp CDSP_COOLING_XYZ
>>                       THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>         };
>>     };
>> };
>>
>> where you'd presumably call something like qmi_cooling_register(...) from
>> the remoteproc driver, making your added code essentially a library, not a
>> separate platform device
> 
> I'm not sure to get your question. My understanding of the 3 cooling-cells is exactly what you described. The second argument of the cooling-device map is an index corresponding to the id of the TMD. BTW I prefer also the compatible name like 'qcom,foo-cdsp'

My specific suggestion is to _not_ spawn an additional node, since all
of this logic relates to the behavior of the (e.g.) CDSP, which already
has its own node

Konrad

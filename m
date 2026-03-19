Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DC3793AB
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913905; cv=none; b=RhI1GmELMAe88P/rdoGr/W1Zw5RqfSS82q1PQdALvBfUu2LGh7LxvbsSbmiBtkQ5itrw2gkZuM5wt0Re5dIcaO9lAEq3H/6exPreSoLfushvqTMDRibeg0ZpY0xhClvS0ovIf+n7GqVMKO6jICQGjOuvmh67erTB7T99SyUXXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913905; c=relaxed/simple;
	bh=XIdmcRzrt08GSsEQ4KFKAFyQ5HQ5y5xpQzyxlIuxn4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0KUuoM/POKtuAiP0IGW11teuD8wBpXo6PdNfZjM0OR1b6wIKDwIr2yq0vqkomjqZqlTkQnHegJBBAwRLo+2BQ9/tTGyQC9ozgIaWUQZrf0IUhP7NUHl+L0K496p+sllW8tb4QFgSzrH1POhnEqn6hA6I14oH1m4J+67eWYLADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0Mp2sKY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=InPE9ygW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0Mp2sKY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="InPE9ygW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J742v71027199
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 09:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UmvEiofQurE2JPcx+JH9BN8SvuA/6RheoqV+inHN3EU=; b=L0Mp2sKY609qYZaW
	DLrD0K8jML/yrhLgUc+BIUoL8l7Ee0gxITVtK2RVaVjRWUa8vDV/Y9N7mD7VptTq
	WdL+F/i+nj6eYnPHWb5GgG2ziIDQNYlnrvZ5I02WwTUoeloaWnJMjB5Yw9FzuBkg
	hI8gXNERWdw93QSK8L68UoA9eZM6ApLM71xQ4XuUbC3MZ8XjToPcnURrrOU5t4QJ
	aH7WOAB4v8yZxBxejSsXcCfkmvppHEuObWri/3qJM3W3nlJMHoRh0pDicGjLRaaa
	FCSUtW/X6apxE/p1w+lAR25VrYtnURS5OTwA1z8MIQZhGDl+XvmOQoGcnj9gnlsV
	/q8c+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032jt9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 09:51:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b33a19837so34471cf.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773913902; x=1774518702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmvEiofQurE2JPcx+JH9BN8SvuA/6RheoqV+inHN3EU=;
        b=InPE9ygW4zOFbFlVbUsXuFwe21kfFpw8/GQPrLNXE7j/c0CC4rlYs7yWIbNNvRTvU+
         MOrD6ZmuzV3JRe0sRmfoCc90v4mHRkZzQbPMUJ78cGghdsOKbqr4yZlTc/eVtQdgtdqA
         mPW43ipahaEbf7ZgcmrbgCL5nJkJseuCti21wV7c6/agFdRSeieV0/MfFDC6DX2/b4C9
         Bp0k+arNnWazWhRN+C4mccHNckvjujD3H3JppeWKlMWA3UHvdgHx2xSC890a4cBPDHj/
         kmPKNFenRgIjkPOQjoUKVvwd/jBzq/1bK/5z+EDxS7BvCfBUs0KKhxVIWlJYrOqDJ9Mh
         RK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773913902; x=1774518702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmvEiofQurE2JPcx+JH9BN8SvuA/6RheoqV+inHN3EU=;
        b=R7bjzP9WRgswij1uIMAnGhiqdn/liD01TswaFEccGWd9IeI//dwLyCjgzzl6ktf4gD
         XLbOOyveeE/vEgEG3fd0sEUn3D8+Z+Nesswk6xgP+VdEzMGyr6YyyaHlp9SVsxkDw3kG
         6DbC2LxpRIkHfN7zMJb2m3Vw+UspyqO4MgSUlS6/XgnNk2iOxVJZkdzEqlQlWuNqDOua
         Y1gILHeBXuKf1PQ1z9A/WA/+pKg3IUTePW3j/jFPB1JWJTgwxNQ6/cG2Ky3jw6GjiULw
         xK0bTJYdJUIZY3MRIUGX66YQPs/MjHKMb4DCA464slUWvAmH6pzJKQn71JlWjgOKlZrf
         0mRA==
X-Forwarded-Encrypted: i=1; AJvYcCVYRAgEdWz1XNMxpY6D3TT6jJasvrKtBms0E64v1lJwxpwko/znqM4Fu4RYe7y+Wft888vD5O8xZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeaV7owJoLYHinFnpHBpMkxqdIluDQNf0ismcJkqKBTHqBs2IW
	X0Hrun5bgFyCMHeb5n7t5k4c+PJ4pz+k6XtlS5yJWydD9jn+f0h/esS78n2Wf8kK0o84B28R1pg
	8K3RbHi7XLCAhPPJCKb4wsS05ZysWK+cRhBn5Bq+TPaZ8HCyXbNu5rG7ozTRuog==
X-Gm-Gg: ATEYQzy1xtmg3w/GetCPtjXb4p1JgC7q/zbFRezX3XPKs9621ayRg+Udu+VimWwb0pG
	8GKrJFMY6xGHhSibtK6EvhKg9b8hhwBbflb7s7h4wtV8ekEpNYYk53NlU6+Lp1F8kVrixFUYj0O
	/0753OrWIiUkXCIHXJYW4cuySLCeAQfoeQlvMGCWpl44iiWJSiyFpxYclgVjXsfg2mPCrEIu01A
	0of5aUH8EJ4yIuChm54/qNfsWaU9voWc5FRXmr+YX9w12TPmuU7dfr36scmb3K/Ra2IGKXOAWuy
	fFEHl4b7mpSiBKnMKURIsQyD3SAvVh6h6qst1bB2MTifUn8mYNEqW9tOxS0cN8ZOYaaXPLakpbg
	PL9M09JbRZB4qf2KCZ9J7awRcWOMNwDNemyDflUnSNgOfkQOLWXTZXweU8nw4RcfXcKsrcMNSaH
	MURTs=
X-Received: by 2002:a05:622a:a955:10b0:50b:1e21:1733 with SMTP id d75a77b69052e-50b1e212787mr36118791cf.3.1773913901690;
        Thu, 19 Mar 2026 02:51:41 -0700 (PDT)
X-Received: by 2002:a05:622a:a955:10b0:50b:1e21:1733 with SMTP id d75a77b69052e-50b1e212787mr36118491cf.3.1773913901222;
        Thu, 19 Mar 2026 02:51:41 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16868b5sm415548966b.30.2026.03.19.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 02:51:40 -0700 (PDT)
Message-ID: <74f59ef0-ead7-483f-a80e-a3da2f6ebcdb@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 10:51:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3922012f-25e6-4b75-9183-f9277ef5d040@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vTshhvThczpPbpkxFmF28th73G11rjkR
X-Proofpoint-GUID: vTshhvThczpPbpkxFmF28th73G11rjkR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3OCBTYWx0ZWRfX1m/EHa1rgmgP
 g3aF2bwAHaM4Eo1vit5INiCTb3vIJxk/55LVi5t5SdnXZtg5acDqUMcfBI2MRBFY7sSewclI/Ar
 PG45z+ZFuEAOa6f8VVqHAtK6Ok2sjLD5ygf1V1I/Q7UlOfYAvjy7MnVyXBFPW0Fntfe030PXNrA
 o2IyymvBlQa3wcuXFMqWrV7vS5KDBj/ferDqaqM88O2P2k8e1PuJuCKVKieyDh0NQUIZrz1A8Uz
 u2Y+URp20h3BIHPmIn4Zf1udoOVaRF5BQI2/V9ae2kbiGt7N8YCtIvbMMGKLUuvP25K9pMqsS8T
 eTUsQZwe04508tEc6dMOuv9qrRUpaUegUbg3uXi04/VMNw18WgmiRvUKyRKIrKnC2zm8VNhYqH7
 Bk9JjGcPLNRQEh+BytgAswQl8L9d106TcRAzJREF2rqoKwbGf3KVdW7IXxSMJhwlf8P2hqhtSsY
 1z1k/JgG0zC4oKquXDA==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bbc72e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=znx0l76g26A9csr8bQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190078

On 3/18/26 11:17 AM, Gaurav Kohli wrote:
> 
> 
> On 3/17/2026 1:27 AM, Daniel Lezcano wrote:
>> On Tue, Feb 24, 2026 at 01:17:22PM +0100, Krzysztof Kozlowski wrote:
>>> On 24/02/2026 13:09, Gaurav Kohli wrote:
>>
>> [ ... ]
>>
>>>>>> As a result, each core requires its own cooling device, which must be
>>>>>> linked to its TSENS thermal zone. Because of this, we introduced
>>>>>> multiple child nodes—one for each cooling device.
>>>>>
>>>>> So you have one device with cooling cells=1+2, no?
>>>>>
>>>>
>>>> This will be a bigger framework change which is not supported, i can see
>>>
>>> I don't think that changing open source frameworks is "not supported". I
>>> am pretty sure that changing is not only supported, but actually desired.
>>
>> Yes, IMO it could make sense. There are the thermal zones with phandle
>> to a sensor and a sensor id. We can have the same with a phandle to a
>> cooling device and a cooling device id.
>>
>> (... or several ids because the thermal sensor can also have multiple
>> ids ?)
>>
>> May be an array of names corresponding to the TMD names at the 'id'
>> position ?
>>
> 
> I am using dt node like below to use with cooling-cells = <3> approach, will post new patches with that.
> 
> cdsp_tmd: cdsp-tmd {
>     compatible = "qcom,qmi-cooling-cdsp";
>     tmd-names = "cdsp_sw", "cdsp_hw";
>     #cooling-cells = <3>;
> };
> 
> please let me know, if you are expecting something like this only.

My question about the need of a separate node still remains, i.e.
why can't this be:

remoteproc_cdsp: remoteproc@cafebabe {
	compatible = "qcom,foo-cdsp"

	...

	tmd-names = "abc", "xyz";
	#cooling-cells = <3>;
};



foo-thermal {
	cooling-maps {
		map0 {
			cooling-device = <&remoteproc_cdsp CDSP_COOLING_XYZ
					  THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
		};
	};
};

where you'd presumably call something like qmi_cooling_register(...) from
the remoteproc driver, making your added code essentially a library, not a
separate platform device

Konrad

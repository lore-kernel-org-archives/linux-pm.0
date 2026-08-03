Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61741167C
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766899; cv=none; b=pyc350sExKtZBDBE65Mpl/V+zyvZIsKkRT9GdpExvn5IJnyzFJCWup+u/krOppywKwC4E1iGG+C7FwvDvjwod81gh+Xq3nnfTW+si/vaKDBiujQ4psSWu//0NQfiq9x7odVLJMvf8UAZ50/jhTLP7dDtvOCj6GUrkMSfmiZB+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766899; c=relaxed/simple;
	bh=xxVLiq26aREFwmOzoSKDuEH5j4IUCHnzg0NLhiqqzC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doQvkVRkBdTmARTvFPhQdfoQQPt9za3Nfr5T5f74hWyaOCX4WHm8QFiMJnkFkHXM/DhSo/3CKLMKuF7pTFB3dG25YgZSZt+LbZxXuiM8o1hNEjGlSNk+C3HrhC0GnfIoA0rKmcqq6z5j9qPpXXNrBwv8cHeBIgTFJwndBQPmsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldsu9lv+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=buF63Jbg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldsu9lv+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="buF63Jbg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EBlwd976580
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 14:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdObhLmEiO4/ihNrGJ7V+rN3FSXGswWQoclVhlDfKmQ=; b=ldsu9lv+B9cFgVQm
	CGZAe5mke5nONmvdusNdpnNtCCICcx+WU7F9n8DBFt4tT0lCDVrUhHsyTCAjVHD5
	GbDiALptzCutqbkSc1si8C89mrD7pdirGp3pmOd3INW3Ra6cSEgYbCVc0UjvRS78
	vBXnRwTG7P37/G1di34v1C3sHQS+VLz+3G8EIb0WMBo49pFaMjbDgc8H9Ji6nD96
	wpNvH/bPVkc86E5K8V21E+YzzxcTfpAo4NXuJL6ODj22eV6388cjHDbdCufCj2gq
	UY9SI4RjoH38k+VqZ5mZWz05nIMiM9ucbrph+10lhljx6QNK9XnJlO26dDn0KWP6
	Fn9ffQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftp169uh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 14:21:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so2384220a12.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785766891; x=1786371691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdObhLmEiO4/ihNrGJ7V+rN3FSXGswWQoclVhlDfKmQ=;
        b=buF63JbgkYJDia55P3e3KDE8X/6KYPODYz3gh68X+5a/i5Jl9AwBMwZYgv0CM7JTBh
         L12Ej9Qa6/3jIAsXXYTL7aufCxs+rN31v27q6ctx36nRYSAR553xLPRVt2v32MSBnPvu
         Az/lmHmutc8dpY4q7+EK3jOYKOgRmjZF3t/LxM9NFPC+xrrkm/uYVkVbK+yGVE54kJQK
         j3HlorJ57TCEhQoLz8bVWA0/NI0NzeoFSrgQrTbd/lbHS86Lu2HqGLj7YeTGMifd01IU
         9XId6gJQz1sTuBK8RuTwqgPnKPtRcIQiVbDD5Ksfxyx+COG6G59tGdqrF0aSmvxIVJnZ
         8mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766891; x=1786371691;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdObhLmEiO4/ihNrGJ7V+rN3FSXGswWQoclVhlDfKmQ=;
        b=Bwca2L8VstTtFZw5H4P/t4DpZssIwCxkEES83fePZOqyFeYoOSzqikNUGa5xQ2XPTM
         tSEMQbC2GNlTvNw8e741+p9LsEafRo+fGZps+0GO6eVxt0AmDJ3/CrFt4C3TpnLIMgp2
         tdGrXRd2opkraZeG65DBqqhn310MXxJ/x+K/+Xf1TBq5fYg+pb8z8mUobBijIAMsqVyl
         b2hTKxKNyXregQQDnLzqQUOJihDM6qSWANNz5OfGE6NahbnDoDKHS79lkGovm7XoUtOL
         rZgjhOd9qLjhmbalGb848wjP5dv1mc2LH5o2cUpGVI/x+L+MwgK4lAIaPJL351ZxjNn/
         7XQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmRVQzlOWcAteuHvMOrCLqorrHq+qjOF5bHT0HUO54r4G+NHZ96R8YYKq3u3qw3Fjazm7mR68NYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XhWNd4NLdpD2enQ6RZKL7wH3Hx72lozL1SoA7x8V50FJ1TyD
	RCRy0AIhrSzdZ242DmTmw4CI9iba8uCF1iFvQr4uhCKB1EUry695H4erIkJjN+u94H+3lPPP3A3
	Qq20hcW4jbQGnMfr6h3mx1BBok2TQ6y4Pk7zTRE5vPtB7f/6msxgSWSiTSTcCRw==
X-Gm-Gg: AR+sD125nGw8zlpIWhVC0fgiuXkx0hr1smrhSU8t7L95sPL4+g9RDhoGnqGM0FrEqXC
	AIoVaXEciY3B7UO56l6CRP8WgyytkVn886UQwLhr9nbV2FVBQ2XnW/dCovHjjy6U8O9V7U7R+1d
	DV61iEPLsypNtUYFFRRbTIbiYB3NiInBsyMnFHaw1Jpk+FZ521ZHvZ4qPZgze9D9riLVc9fqNgl
	OiFDSHqOHqF/CqyuJhwB4bu83RkpWf/hCIn8r9YdFryejNowM6gODle4rrZbYrMm8W/zDJVKl+z
	WafD+w+QEiJUbWtG3CWWfyq2R4f53h36/30UFKV9Yy1dPUReEdwxBYWJbIlruB1mNy7mWpvGlVa
	wphko8SOurMl0TgT8rZM5Xh8zp69Hn7XRNA==
X-Received: by 2002:a05:6a21:468a:b0:3c4:1c9f:d91 with SMTP id adf61e73a8af0-3c92aa7d0cdmr11448415637.59.1785766891391;
        Mon, 03 Aug 2026 07:21:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:468a:b0:3c4:1c9f:d91 with SMTP id adf61e73a8af0-3c92aa7d0cdmr11448370637.59.1785766890901;
        Mon, 03 Aug 2026 07:21:30 -0700 (PDT)
Received: from [10.218.44.82] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04491dsm51441432eec.16.2026.08.03.07.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 07:21:30 -0700 (PDT)
Message-ID: <069a7ef3-7c01-4366-8643-11d791bd0d96@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 19:51:17 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 05/12] dt-bindings: arm: Document reboot mode magic
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti
 <pavan.kondeti@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Srinivas Kandagatla <srini@kernel.org>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-5-889281373870@oss.qualcomm.com>
 <20260803140222.GA3188037-robh@kernel.org>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20260803140222.GA3188037-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyOSBTYWx0ZWRfX3PxHaxjn4Oac
 9IeTcP+SgjHwGRRRomEjnDIVKIitGTzzi0kx2gnyvBvb0tEahNg12/28W/E7uj2tyN/oGQCoyMi
 Dl6AC+3KMmL5R6kesumuDGFyNfxjvoR8BOlsz6Es87XLYZa7F0M3vGBw96vJecC2Fq8emgKFQUh
 wA0k0zuXCjs996wQNsrqxIiEtAMLegX0qNiJs8L/Jo2mvmGsPwCgtQ1jjraAoj+bgdwTRVaEy3B
 YOy5TXxx8TWiqsTowl6NxPZZ4LumQGzSM2dM2dDE4oTOYvwOZdqs+TcY3MuttrxTWredkIQzxQL
 l8khb9cwDYRlmTVTU9zmS4RK1chDzDJ7Jw5ZfGwH+7CuI998v8qhNUHT0XDFc6rATt8WKZll3f+
 8/2UV540RctMgPc2KwzFb1qIE84DDTtg3FXkTdJOhoFf4uGbQAsQBLfS1pgke7ly6XYW/QOUzdc
 8Ts4UA5X9S+IoHOqVAA==
X-Authority-Analysis: v=2.4 cv=Wpob99fv c=1 sm=1 tr=0 ts=6a70a3f1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=O-cBmbsoh36Jwjk5jm4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyOSBTYWx0ZWRfX/IslPbqzCwd6
 hYhDLZiXQvBsq1esLsGMNFVGuzKeFKPzgHL4teBkZJLluQMNKe9dltz6dafgw2FVdc8McFXGzF0
 lYFL7QbLoCm5Fck7h6f2EMK8zaKz0ys=
X-Proofpoint-ORIG-GUID: s9QU4d4RWldcFdi8yx9M9JF-r9uLyVeA
X-Proofpoint-GUID: s9QU4d4RWldcFdi8yx9M9JF-r9uLyVeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030129



On 8/3/2026 7:32 PM, Rob Herring wrote:
> On Mon, Aug 03, 2026 at 03:13:36PM +0530, Shivendra Pratap wrote:
>> Add bindings to describe vendor-specific reboot modes. Values here
>> correspond to valid parameters to vendor-specific reset types in PSCI
>> SYSTEM_RESET2 call.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/psci.yaml | 58 +++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
>> index 6e2e0c551841..7d6a86690a2e 100644
>> --- a/Documentation/devicetree/bindings/arm/psci.yaml
>> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
>> @@ -98,6 +98,41 @@ properties:
>>         [1] Kernel documentation - ARM idle states bindings
>>           Documentation/devicetree/bindings/cpu/idle-states.yaml
>>   
>> +  reboot-mode:
>> +    type: object
>> +    $ref: /schemas/power/reset/reboot-mode.yaml#
>> +    unevaluatedProperties: false
>> +    properties:
>> +      # "mode-normal" is just SYSTEM_RESET
>> +      mode-normal: false
>> +    patternProperties:
>> +      "^mode-.*$":
>> +        minItems: 1
>> +        maxItems: 3
>> +        items:
>> +          - description: arg1 (vendor-specific SYSTEM_RESET2 reset_type)
>> +            allOf:
> 
> Don't need allOf here.

Ack.

> 
>> +              - $ref: /schemas/types.yaml#/definitions/uint32
>> +              - minimum: 0x80000000
>> +          - description: arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +          - description: arg3 (cookie_lo in 3-cell form)
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: |
>> +          Describes a PSCI SYSTEM_RESET2 vendor-specific reset type. The string
>> +          after "mode-" maps a reboot mode to a vendor-specific reset.
> 
> Blank line if this is a paragraph.

Ack.
> 
>> +          A vendor-specific reset takes two arguments, a 32-bit reset_type and a
>> +          64-bit cookie. The arguments are encoded as up to three 32-bit cells.
>> +          Each mode property is encoded as mode-xxx = <arg1[, arg2[, arg3]]>,
>> +          where:
> 
> blank line

Ack.
> 
>> +          - arg1 is reset_type and must be >= 0x80000000.
>> +          - In 2-cell form, arg2 is lower 32 bits of cookie.
>> +          - In 3-cell form, arg2 is high 32 bits of cookie
>> +            and arg3 is low 32 bits of cookie.
> 
> Indent the list by 2 more spaces.

Ack.
> 
>> +
>> +          All values should be provided as per the PSCI SYSTEM_RESET2
>> +          specification.
>> +
>>   patternProperties:
>>     "^power-domain-":
>>       $ref: /schemas/power/power-domain.yaml#
>> @@ -137,6 +172,15 @@ allOf:
>>         required:
>>           - cpu_off
>>           - cpu_on
>> +  - if:
>> +      not:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              const: arm,psci-1.0
> 
> SYSTEM_RESET2 was introduced in PSCI 1.1...

thanks. will update.

thanks,
Shivendra

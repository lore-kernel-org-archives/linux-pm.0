Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E072382363
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256306; cv=none; b=AJHv2GHXXx791c/d8/EExk9mpUSqdSbWGeQ+2e6dxqXcEuaj0f++rKRYSfH6QhmElEE24lwMW7hW0d2A/pUOv9YIHghRVbnlcFi8RoKxDQMOgUjtnkdFlJ1S1o/fyYIyjXijfARxCRSGRstH6U7eYqKKBiaiFY8vCF234jof5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256306; c=relaxed/simple;
	bh=HRn2Ky4V1JZSWSHSC+EMGHuinKEViXVgeQ3zyubsmI0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KZtc3Q/DIWFxKvfIHyu8rrxT3C6OrpfafpLVPfuxS2jf1G5JMEk7wkyyOPoEUrulzfXjxxp4r82O4EoYdqOw8gVy5tGKovdxLn+mzJ1XxCXjPV7faEvt3trylgpLN0uGwT2MRFS1yPrDwcBQeFQTiwFtMLbIU52vEvqFTa8oPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aonQmiFG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jxu+lqqR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aonQmiFG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jxu+lqqR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G4Fd81093702
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 16:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iMxAGx/n9sSrvDZ+nUU28V9GmLoIy4DjjLAMpMsKrTk=; b=aonQmiFGg9G/8ttS
	RHlIf23vQr252oSLyiaGxiiemHGtyy0gxyErsOyUdw8UvmQSUnsi8XdKqG79ukYA
	D6swubeyDPk1pSwv0eS7uUuQkF98mRgpa0kuCD1PMC2RNIM3tT4mTHqSFuOpFFXT
	cSmYWQju3wr0f7VXUINF3r1wm3/x4VOPmXDg6MrJEokIrodT7UPyyKoLbNc6zvh1
	jac/VDOkPvLJln/zxFy+QzN8KXc727ZcJ0qw6HHYSHKF2+3/TvraRqR28w1E2Wk9
	tuM5BTXU6HEbTn1QSERvdOpotLmh7M0LBsLleyG1ZhbAphthpeB8jQjURIInViCd
	8undRw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1d004t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 16:05:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2babbeff9e4so24630185ad.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778256304; x=1778861104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iMxAGx/n9sSrvDZ+nUU28V9GmLoIy4DjjLAMpMsKrTk=;
        b=Jxu+lqqRiXKXw6RcWvqb67QW8Kq2frrEL8QHrWuB11sWs/LzfRvZ8Gjj1Mm+QHTOfV
         KOua9WVZmy4DRCYmf/C4H2htp6f5d9gTSLMZmY/pLNJWwYYNQAwOhYFw/KKpIboODNQI
         36LEoIXXONwQqn4BHBtJGt7LtmR1GolHkP65Zjuk8g2G3hpgTho8UH1gdw2RSzXZAhl8
         bzDIvrF0pVUOfApmcrT58oTjt/63SxMN6bX8ahjCG0/pGscrLnctjvt7VdQ/2qstQkFd
         /0zYJoPK9dnjM6kKi1mq/fV8gLb17OVA8aSPX6YgfNWTlfB13x8FpOJyq4GSazDFTS46
         VTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778256304; x=1778861104;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMxAGx/n9sSrvDZ+nUU28V9GmLoIy4DjjLAMpMsKrTk=;
        b=Fo8RbeJ8c4y0ZTw0lEmrsCvjfJGQDGBjwGugjX21/pn6dd3M59Ds8F9FfcAgFg2iGc
         Rrv9/IQeP+NicVCz6qV7gtcJ3iHXqjr9kHL6mARnSsu2uoDk5gEcwVznxQlMBet9msSA
         hq0PeiUuAqN3TWXr+oSu6jD9p5lZ1nifzX4zo91giDrwLxkVJmTuwPCT7JdhcoM+ZIA7
         QpWb+D9ZWLfffPL48DQRdYOtr9KyHpG57s+8vEYXI2MIRmTbk0zmh253OfNcA+R2Itid
         Q5Pc+YjbLGNk0GST1ivZJnCcMoLoHTuBoUAcoQJ/gJhAcRhI1W/qEbxHYuPV4LyBsMTn
         HKnw==
X-Forwarded-Encrypted: i=1; AFNElJ/nM92cQlSJQwN4abP7sAahaZac2ESmpRQp3E4v3w1v7iK0MCiZ6haMxMVbyKqJmQYQNLrBi4BVkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtAZ5nKkX1vjkLrJNl+rQG6nnscu7sF+ez08DsjlNYeNZaFrC
	W1Tc64yEn1Q6PsCUEL3U6driD9/+Qntg82SP0LNKPOY5ZTrYFWYGmi2cBBtw3eVxKm6k/84DKB0
	v6itJ5SkQOSrWF5zC0gSv3f7p9X+3aPsqOkk99d3udmTjCTTimDlDW5nG3Bas5g==
X-Gm-Gg: Acq92OGR2LftvKHCFGixqTv3QdIs6VAteZlnASP4S6rWYZUQkaBkls+84Eo0WVhuwGv
	MBsGN7p9v7gHWHZUGxVlsMYwJvtrpVKWgENxsdA1LK+g5NxKEMbT7C54sn6hGsZUNOAMMGf1liY
	bVjAyTuDr+pyqbeQImEP1x2Y/grlwPZX8Zl8jiC7javgDBkJLAqo0oj702PKRUWyubZz4MQBA8A
	1CfBKbkMSHInC+arK3AQOdk5OiNHHBFpmbPtdsulO9tVylIgGE9eU0RLjLeBVNQ6bz1yRZ6nOQA
	itQXcFjb+/8i9ZfjfXqB7uKm6vMRYlIqFbQFejSuEQgR7htA0s40JIsZrQ3EC8DRKJwQIw4F0WN
	fCnPUyJq0zXW7HIx6x78t3IqdeAu3dLs9lUWq7o/l5xDsRQH2yg==
X-Received: by 2002:a17:903:22cb:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2babc857b01mr72746045ad.1.1778256303915;
        Fri, 08 May 2026 09:05:03 -0700 (PDT)
X-Received: by 2002:a17:903:22cb:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2babc857b01mr72745425ad.1.1778256303252;
        Fri, 08 May 2026 09:05:03 -0700 (PDT)
Received: from [192.168.29.32] ([49.43.224.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27242sm30234755ad.9.2026.05.08.09.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 09:05:02 -0700 (PDT)
Message-ID: <dfc3039b-c45c-44d3-85c0-0d131bb5e55a@oss.qualcomm.com>
Date: Fri, 8 May 2026 21:33:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-hw: Document Shikra
 CPUFREQ Hardware
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
 <20260501-shikra-cpufreq-scaling-v1-1-c78b95f53b91@oss.qualcomm.com>
 <20260504-fuzzy-wapiti-of-ampleness-d8bc13@quoll>
 <8101e2c8-0593-4325-a701-84f776dd4b0a@oss.qualcomm.com>
 <eebae734-3b03-4848-a728-a29d8a210e57@kernel.org>
Content-Language: en-US
In-Reply-To: <eebae734-3b03-4848-a728-a29d8a210e57@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2MCBTYWx0ZWRfX9JTamKrGAfIv
 LwegDQQhm5LRlR9X/nC+uuzE8cZ6T/w+/8Rk8HAwaJNYPxL7WhmWKdF1nEtlGf8SV8PraxuPySl
 RFNMRxIGlhgPBqMzO11+k9s41CXDFbzXqGCQu9dsEFMPN5qr1ZJOCpR/6paoSdOyee5vyIzxMFs
 Ibpz4VRRByySt1mKbJVZy797nwEk4Guhe+bBk0D+HM2URBUO5lg1FMPrigXVCiUWu1uUipTnYZr
 3kb/3HO3fArDu1GJrkiKbCQylHLi9cvy0j82L6EhhWvCFozeJjaDhwevMjvcYcr/qu9KQXs+LjA
 f8e5Y8g4wJ0W6aP5c1Ln0HS6WyM2HJ/XaO0EYld4xXfR6bDZ6z/m5dA3/GZ5l/XyVDsFBqWCL5u
 5/YDrh2d8sNEjNyfN1nZJ+JC5nyEUpRahjpxkrrp4pbvhT2gHmKGYZqE6E0m9ky1u6a0CfRGdtZ
 5ogkx+rV3fNaJMmlr9A==
X-Authority-Analysis: v=2.4 cv=GLU41ONK c=1 sm=1 tr=0 ts=69fe09b0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=laknryXFXokeiUDc/1ZVVQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=FCm5DZQdfCEVbhGlKnoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0xXwfWPdcKUG6YYbVuyU3q0VkGveyl2m
X-Proofpoint-GUID: 0xXwfWPdcKUG6YYbVuyU3q0VkGveyl2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080160



On 05-05-2026 02:23 pm, Krzysztof Kozlowski wrote:
> On 05/05/2026 10:50, Imran Shaik wrote:
>>
>>
>> On 04-05-2026 03:53 pm, Krzysztof Kozlowski wrote:
>>> On Fri, May 01, 2026 at 12:45:44PM +0530, Imran Shaik wrote:
>>>> The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
>>>> but supports only up to 12 frequency lookup table (LUT) entries. Introduce
>>>> qcom,cpufreq-epss-lite to represent this constrained EPSS variant.
>>>
>>> The entire point of having a generic compatible is that it MUST match
>>> all devices. If it does not, then it is pointless to push that generic
>>> compatible.
>>>
>>> I am speaking about qcom,cpufreq-epss.
>>>
>>> That's nothing new, I was arguing about it already, but now you have
>>> confirmation of the mess introduced by generic compatibles. Solution is
>>> not to add more generic compatibles, because what will be next?
>>> qcom,cpufreq-epss-lighter?
>>> qcom,cpufreq-epss-more-lite?
>>> qcom,cpufreq-epss-high?
>>>
>>> Same was here:
>>> https://lore.kernel.org/all/20240828203721.2751904-17-quic_nkela@quicinc.com/
>>>
>>> So that's second time I object and do object for every new instance. No
>>> to generic compatibles, they are proven to be wrong at least for
>>> Qualcomm.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Hi Krzysztof,
>>
>> There is no functional change to the latest EPSS hardware
>> (qcom,cpufreq-epss) in this case. The Shikra platform uses the CPU
>> frequency scaling block, which is a predecessor of EPSS and is referred
>> to as EPSS‑lite. The only difference between EPSS‑lite and EPSS is the
>> maximum number of frequency look up table (LUT) entries.
>>
>> This constrained EPSS block is not specific to Shikra and can be reused
>> by other SoCs that implement the same hardware. Hence, we have added a
>> separate epss-lite compatible and reused the existing bindings, as all
>> other aspects of the hardware behavior and interface remain identical.
> 
> I don't understand how any of this is relevant to my comment. I know
> what you did.
> 

Hi Krzysztof,

The intent behind proposing an epss-lite compatible was to describe a 
common hardware variant and avoid introducing SoC‑specific handling in 
the cpufreq driver.

While reviewing existing upstream targets, I noticed that SM6375 also 
appears to use this constrained EPSS hardware variant, which is 
currently not represented accurately and would require a similar fix.

Since both Shikra and SM6375 share this hardware variant, would it be 
acceptable to use a common epss-lite compatible for these targets?

Please let me know your thoughts on this.

Thanks,
Imran

> Best regards,
> Krzysztof


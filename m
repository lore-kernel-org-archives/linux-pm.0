Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891908;
	b=omfSAEVo7CplbrmQxeiTvfaQLeU+D+wfvBOxQbcK34gYd9jYuvJAvqmTLQKnKQb4dSX/
	 VoMHfmTpcFDOKwrxOZg3N/tR4zcwE8EFkhivXSbJnMYGPGq7sY6XIjEQltpdGdPssZ5fB
	 HIJikMuefaGEofIyWLdoYrYSfAs4clA8Gu5myqXVdWO7YFa5x0Rid1Lfewp302LOTS2Ju
	 ciDDIZ8CNDMkngjxnZvkfSGAsrXxTmX6/Raxyi72eVDhKAoe+b9IyDu2KsNZy6/wtfn3P
	 k6JVox67keLM8x9Ml2f1Ra3+wuK8NQO3KosEdJdEBCPPeN1BwMYeOzRxM5MP0g8WTwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891908;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=D3O8HSwk3gV+MgeK/2x8V/O+dnoKtfrQX17a7bHwQ8A=;
	b=ikPkXNixcKI4AnlJbC5kAnszGv5cfZ66VlgfnrF6IuZf3Mx0xBGy7BdxoPZoEz2DUWaC
	 /3FyG9IZjFBHgQ4CxVYlEv6b9twLCqBiTedGPH+V4TCTLQ4ap0W9tL8lDYMZQl8wQhp1s
	 Lq6kNWg1Da/aNzLKDCC3I8xpirenRhO/2+Xwhni3AMR0OtDy91ZZP8MB/0xmye/MfxrJH
	 Kqleo03Tkyn1yXyMspa45UxHE5AwVLkN6PT6Z4+r7IsSPTR4BBO2DiumBTxGzHKVL496W
	 W8Tlbeu7YHnENqrlqW90t6uFaLAkZ5gdjP88m3Cq1PL1nX12pKWyJ1yEDM49ygAdXOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UyR2Xvr5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RHkZQaS2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84759606A332
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 05:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84759606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UyR2Xvr5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RHkZQaS2
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH2aNvR2935297
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 05:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D3O8HSwk3gV+MgeK/2x8V/O+dnoKtfrQX17a7bHwQ8A=; b=UyR2Xvr5mgnBNFXX
	m5z2sk5nqcqjIuG2LbsieBw2xqL10aw688SmCyRstdkHPG1FJZOoKTLWGUZ8iYbV
	AadKpNBqRLG9aJxV715SCdaoPrnYPIm46bwK0akZUQzaycSCspUy5d74C46jmFfZ
	i1KKjkepaYeVferOskHGdIligD/U69dbi5WcQXtrMlMDVJKwwA2AdvDUF0Lr8sQ+
	qJjQR8FoUBZ+l4LG6Xp6lyQUtBn4UoRzU8uhkweKSUBUeQ16pFmNVfRDu/VHyGBf
	RMo43qg1oL8450LO5UkropBDG3sZoHLBrjjJgC5mPb1RjndC4BB4b4tM/BK+aH5q
	B62j3g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m09dcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 05:05:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso3945985eec.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794891900; x=1795496700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3O8HSwk3gV+MgeK/2x8V/O+dnoKtfrQX17a7bHwQ8A=;
        b=RHkZQaS2MZtvr9lY7Z8D8+OkVnghhoESST2B/YndphFb2ect3aUlXAa5fP33mU2q7u
         PE7TNn1kTsZghXhKHEhBL5nerfFkcEjIiOyYZY8ZuKL2j4GGoOFgnqB/rQ+TWe/q6Mxj
         q2JVcQ2YNM0bD7XkP+gfrNVmLUGB9C+prurACA59vOdP1dHRgq/yKVYCfcsoyOTgNQdT
         DxiGNN0RGFQowlqDA55JdwONfRXc6cZXYmnTJk/dohdTgEYmjFq+gJuA06M+ETNbb4es
         /Y0NnGm11O1EULBqhQzVl38t8ujxUXg9RDnoCT+0MUgYpuCR+/L0Bmy+ZSRGJ26Pz3ve
         F7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794891900; x=1795496700;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3O8HSwk3gV+MgeK/2x8V/O+dnoKtfrQX17a7bHwQ8A=;
        b=HZqCjlAltYVecN3BO01uVk/PFGm5a8cNxwtuvGAM1DZqKLSEqfiClDusC2o4Jh7GcR
         1bF/1K/re/V2Obm+5b6yjZLvIHlP7+mqdwRNMFhYiomROpCLIG0Bs+ekS+2gdNEZ5jpG
         jFhBiskSQ8a4GHQNAhq/YzaAjlpFOhbwyUXgBA09ctpioW1VdgQ74FFqXoLAzmAwAUXS
         RKLjOtC5NLPm48KB03PHb8lU2grL3egwT3PzsgI0WNz828yI23wKmOXzvZI7rESjfmXs
         NQgAKFpGzNtQTNjWYZphFovDucJSHe5tFA3MEs/yNljsjsCraWV/JmqqA/ajDu1iJXHE
         /Iuw==
X-Forwarded-Encrypted: i=1; AL+hErGErQK/hEaHvOpZCUOlxWZQCxTxmMYWuda3bey5jRAj/bYafMi7ViCouHTN0zp8eLP5VTRyWV/o1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dgaxSBcQJONkevhYXM/ANhPlnfw2yVfFpJYQSzo8zSuMWShon
	Wib36UFnJXWWUk9OGa5ccnGSVxtQU9hV7lmzRU2W0SVwQt56Tbb2UMB+ZcvgTVrLKOxUSxknKM4
	DUzWLCYkOKY47wJG9vz/JDgfpjkhkXQ17nJiGI1suoYmgkzKQCjwNEBpIRh+AEw==
X-Gm-Gg: AZFdTZfSu1RwPOSdoUaRhyh9huI/94IQClIReWFVDW1YVfqNmrC/XR5yVmNPkbEVN8U
	WwCqjHoPEsvt6kHotLUjZ6rxvkN28XEO3BQmy3HwqBuExZU+jjzSvR3e6H6T/crK5wvYpgKqCU2
	TtOJ7EoPKHsTqd/96D/n5XsS5hvINydzk9RgX0+bHtwxiWfr5t4d1n0KuDeZ4vBqJHnlQ14A1W1
	jR4bL3XrKY3ZZpH8tKqS4a2bZ9HR/XbIbl4P3kNavh4Tg0edMA9xdhxL4jAzUv8s1O6rC6HJZfv
	0Tb49AVQlMQFb7pVgUMPB+4YSMq83MiHb87+oLi6T5TEzr1B8O7pPyXI88oN074QdjagsaF4Vm2
	xf5njqhxw6JjKHWtdTo9FIfgrOui3Xc+Ef8Jovql0ulHSER7H7MetXyu6fwr1U+ohBl7yxD4t02
	k/pc4=
X-Received: by 2002:a05:7300:de01:b0:36c:a154:db1d with SMTP id 5a478bee46e88-37963373955mr11307807eec.4.1794891899982;
        Mon, 16 Nov 2026 21:04:59 -0800 (PST)
X-Received: by 2002:a05:7300:de01:b0:36c:a154:db1d with SMTP id 5a478bee46e88-37963373955mr11307779eec.4.1794891899424;
        Mon, 16 Nov 2026 21:04:59 -0800 (PST)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-381a55555dbsm1297729eec.10.2026.11.16.21.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 21:04:59 -0800 (PST)
Message-ID: <d3060950-04ea-4f9b-b160-0e068946e623@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 10:34:52 +0530
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
Subject: Re: [PATCH v2 1/3] dt-bindings: power: domain-idle-state: Add
 system-state
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
References: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
 <20261113-s2idle_state-v2-1-ad604182e7e7@oss.qualcomm.com>
 <20261116-icy-free-lionfish-c3eed8@quoll>
Content-Language: en-US
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
In-Reply-To: <20261116-icy-free-lionfish-c3eed8@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAxOSBTYWx0ZWRfXz+GFbcpbnxEv
 KYkZZMOXsLcF4nCjj0JAOD7p9uLZnh5bC4vUnhxgHZKbovYqLwdl+XIslD7Z1jl+70EIc6Ew1Xf
 hI2BCZG/BYo2UQxUF/hv9qAOWZP0NI8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAxOSBTYWx0ZWRfX6AktRPaSyVuV
 dSkOFYgFsDcXSNQ9DGbCPeOqcsh6MPIQw0OJWOypiWWMn2tkX5CRgF8kJjQRFRfC0eo7Sgmo6v0
 eaIdldzmanZa11U+ipXc5wVaRv34ey6ATx5qNnco5LNCqV5340ClVaMHjx8Yo1sG2lkhX2IR9I3
 UsCSf6A6Ni45NWBH+Pn174JAOFztOYeYqwVx5dAXGH05m2DEeKQ65iwAvrr2dmAmtq7uu9mVCUY
 t9ubpkCi6kX6EF/k69mIF/ncWjDMMwqNUrwP+fc9pIYNdoIOEZh5lKJQYFeyNk8+Ij+VDdP/Sik
 FEHNurSsdIMw7xWyA7GguraVE2jBmlU8dQ74BEd+ScRGZALkZAIrHWqG5AIm4ybwe01R1+qhJrt
 2swjiq3bkzIIauY3foqYPvO9YZyCyHQ9FGUBmLz7wEvTq06M/21j+tQruMtR1qzRQPUwjIn4yRJ
 IHG/Su3tEMOtgQzzJgw==
X-Proofpoint-GUID: rHBsEHqRlvBWF8RQRe0cQ0Z3GXl9Cj6S
X-Proofpoint-ORIG-GUID: rHBsEHqRlvBWF8RQRe0cQ0Z3GXl9Cj6S
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afbe07c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=CCHPWfvzcojU1fbeCg8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170019



On 16-11-2026 17:28, Krzysztof Kozlowski wrote:
> On Fri, Nov 13, 2026 at 10:25:25AM +0530, Maulik Shah wrote:
>> Some domain idle states require system-wide coordination and are not
>> applicable while the platform is up and running.
> You repeated the property description. Say something more. Why they are
> not applicable when platform is running? So if not running, when are
> they applicable? Why?

On certain platforms CPU subsystem deepest idle state requires co-ordination with SAIL subsystem
such that both must be powered down in coordinated sequence. During wakeup SAIL subsystem must
be powered up before CPU can resume. The wakeup can take a second or more.

Selecting this state during opportunistic CPU idle can therefore cause substantial wakeup delays and
repeatedly interrupt SAIL operation whenever the CPUs become idle.

Add system-state property to describe the state is reserved for system wide suspend.

I will update same in v3.

>
>> Add a boolean system-state property to describe these states.
>>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/power/domain-idle-state.yaml       | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
>> index 4dd4f59bbbec..b19952f6225d 100644
>> --- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
>> +++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
>> @@ -45,6 +45,12 @@ patternProperties:
>>            state will yield power benefits, after overcoming the overhead while
>>            entering the idle state.
>>  
>> +      system-state:
>> +        description:
>> +          When present, this state requires system-wide coordination and is
>> +          not applicable while the platform is up and running.
> So when is it applicable if not when up and running?

I will update in v3.

Thanks,
Maulik

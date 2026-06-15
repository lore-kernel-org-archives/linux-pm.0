Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1C3E3D9A
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525235; cv=none; b=lZUcZsUtA7jNeljlj9Ulw1e5zB4LU/n+EQW9u5whu4ydnNnGskOCV5bzKk5qmZpLBxDKwYwkkE+9Zrzpli20uWXzOTNVONXDpjOWlMUG7iAyQNWTqdPyK0HO2XmMsIWSmlAPuz5aeZphOHg/8qOtM++HywonmiNEFZKHkrRSpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525235; c=relaxed/simple;
	bh=ND7KG3N9MBrMZvVY0w5QREg+dNE6BwwRSSbIcSH9sa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFBRICcK76AZBDJ+0yRF00fFDg0ZEr4v+xyr/ML4yOkzSPyouVo/HBFtsFzaOLu5BcwQ2D2V+VJ9Wu1xpz8NLJWYyY8eP+2tpImtVydIHzn5px2sZX2fMuT/4tT/lC6TEbB32h619l/AeWSkcf5N1zxwWg7ZV41xqzMT2oPdpi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d5wJdni5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hKYPIJo/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d5wJdni5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hKYPIJo/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FBode5464258
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 12:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UuSAM3kSZuXdViGtqqiEJCksQHrxoR+infoumgosJxs=; b=d5wJdni5rz04nj0p
	B/sk5reO7L8PiLn/ZirW26K0iPUoli7oXhuOlzTC3TTBuXOG2YN0ppqfWoIfLLOQ
	ZddzEyqB6/OctbFM7QgjpROJvtCNt2CxcrDhnPsvpvk3vKJM+4aW+CSMAwAWX/yR
	tMILsycwUzCiSJPC5r530r3B6lK2CKbMjbEOICIafpZtCRzPV+2CdQzAG2SLKpcp
	9X6mH3jd0rgTc9ffmpgwKPb60fWtxEokNYKDlKyYOeDTJLitCwiOCgLBQBYSs3JK
	R09gZo8/QIQytN1Tmb/94io/OTY4klv0bM4m8+8qWX9LK+FLzVw7ThGRtPkz58t/
	ZjZ7AA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhg1yb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 12:07:13 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-96395e5f46cso3220790241.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781525232; x=1782130032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuSAM3kSZuXdViGtqqiEJCksQHrxoR+infoumgosJxs=;
        b=hKYPIJo/JbqVB+TVG5X7Cocd1lRtgjnZ3QTvxDhiOhBqhLtcGiQ3LyiR5lLdMelP99
         kUzEFqDX4WfpVDB7vF8GB3DgcH24bn2GxJ8KdL/5l9/yobbEMHJnQfPueLvWJZzKIO3o
         /jLXGGKS1bg9CyHKS5Blrt9gcvTokwJQputikpY0dd7lAVG3q0/thaDTOO03vGd7fQoW
         Hrt5V90mHrv3hXToTtAB80NInc/1sdgPuOH1wnRYrvQ2NHiWeRH5zdEWex6fXGiFycvx
         EnySNNKeMeQ/vIo2L+fOHaSMvLAqhVpKfMs5pF/knzISavc6cQkk3mcuhbtOnavBERC0
         w09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525232; x=1782130032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuSAM3kSZuXdViGtqqiEJCksQHrxoR+infoumgosJxs=;
        b=Af/YiAHQzMhV/EndJTAyO4BOamUoiTl48RwrzLAfePBBYzetm61Ev0O+5Duc8LpeZH
         pGJ8OnTwGJyBX1Y8UJs8udsRL/hIUT8pwGXVN4+zHeVNLopZ7J2et/90cCXFuh0AUrS+
         ZIJSlbQbZn19f87X7SwUO18pIqcddrSgSfWP7Xix/+LRCaP64ROG1+zSQwA/OyMt86KX
         mkysmn3Y3rSGa/nzJD1HdYLMzu++AJVMq/oX/cJ27Sfo+LX4hlGdRygWkhlYFn5iT4wW
         01+bsG0NLa4HJL2AoHPz/1oCuq/RTusEh77RyuksEbWv33Jc6pKKQ58Dg6IZcvzq7p5Y
         954Q==
X-Forwarded-Encrypted: i=1; AFNElJ+uF4lClM5OS5XuKw9wrXA9cUWawNyhjDyZCXCXLvjrW0TZb/J8FfAYbqHlJg3aNzccRUOoekSzgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsCT6l8dExURPxn/s8VLAx40DiIrtskMl9JfsHFf+i03HcNO0
	2+ZWNFLDQoKYc9fRjzBs6YdcgeG4wSc3cu6gkBkvb6ik/KUdlY9CfYnkeE5fTfCJNrdNJE7n7fc
	Cz905wY8Z/1ndDTJSP9zMn/0IC0QLjct53fjnwep1ltkYvW11/0t7FBtdxYRqOw==
X-Gm-Gg: Acq92OEDRGnCXWA9ASiGOQZV+NeDjHP5b6X0HQ7Kdz9SjOVV+4zA5Hxq4866jxLJJOe
	5fBfe0I64BWXnmFwuUoxR7HPQBnD8bOZuqsS7IKI0xOeh/tT/XQ6LpQvlvuuCD/rlCwtVzQG91R
	hrArn9ALZHPrJKXcvgXYaVO0cAQ0SvobAuTG4+mvm2xJmbqNXhLOrnh77SD0hGBKajfB37iVOWK
	ttnN/vRe9ATYrWn+3CkBwfCeDmhuw6ip+esX944pgUhumgmUGU/HnD9nt84NO+8NduIUyLTxSpb
	N4JxeJRx+ZsI3dwZMRChzERPINk1GGL1g28l6jXf6AAnAVRF42fs2QbnctQdanZgR9kV16QoSTr
	2RIseMHDbl/spxJ74RQt55hbeJv5kOSeMb1vlcEIB4en3Cj8+0YDtwOcOYtPWPRK/bvrzJwa178
	RTQIcuG2KjJ24tYg==
X-Received: by 2002:a05:6102:570c:b0:62f:3abe:907f with SMTP id ada2fe7eead31-71f5e0fa666mr4734430137.4.1781525232281;
        Mon, 15 Jun 2026 05:07:12 -0700 (PDT)
X-Received: by 2002:a05:6102:570c:b0:62f:3abe:907f with SMTP id ada2fe7eead31-71f5e0fa666mr4734386137.4.1781525231745;
        Mon, 15 Jun 2026 05:07:11 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30? ([2a05:6e02:1041:c10:b0eb:75fa:2a81:cf30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f23fsm33848212f8f.9.2026.06.15.05.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:07:10 -0700 (PDT)
Message-ID: <c85b658c-ea61-4d34-8327-2a0be2618611@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:07:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powercap: qcom: Add SPEL powercap driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
 <7ea2f2cc-ef11-4727-810c-e32e815bd973@oss.qualcomm.com>
 <8f045340-a6c8-41c7-b1c7-6d9b87b05d90@oss.qualcomm.com>
 <fe5ff2e6-4c54-4b21-be5c-0f06bf0e6696@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <fe5ff2e6-4c54-4b21-be5c-0f06bf0e6696@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyNyBTYWx0ZWRfX4mgxLY0hIM/4
 6/HdnHWAl+a13S9EPMAI47gfMY8ks9aU0fho0J+JV5Fn4gQNPY2jwo5IYF7LM9lXQNAtEubIWeB
 Kd02pQYRscveIQZENjnrd9lxj6SmPCs=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2feaf1 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=qtblmzGj4WCF7b9vubUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: aqJnI18xc7fLLkRB3mujFD5qJXToTt2t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyNyBTYWx0ZWRfX2oe8Q18EcXLb
 apE9H5XRdvlNwDyEUyT9/b3ZoFCCCwRaiExlMgBgdsxonPi6T0FmPNk7fu6h6qAmpNa9e6Ow7AW
 e1gBoDpUM4bMaCEuC9K8z98jblhlipy7sbcaTCYL+ZLqpmydyRiQKEBoRfeh4UIhO6GuXL2SMcc
 uyjrdSsQcL70bebzDUfmNCBPUFSS0VRvKnmIJFh187nOLSiBY8jZip/ry/AsrJPIaz3Wy/IFOqv
 KIq2XUeJgurUmJHXS+UU+IRLAI36Y9jQ96hawlrIUSMYYkUKS42rbNmzWeoVNCh+vQ/+16d5V83
 21pq1h/uGocns94lqoLbbNLSCVb3BDm92AEl3f2PelxNe4bmMhoL7zusjhAWzjp0o+JBG6Lu7EI
 GUYZu+Vesf/10r42OuDe4NT15CjZWzEviNaQ7NR61HCRiZwjiVxuxNDIK9vOkwjzZNNEXkSeJtL
 4/ZDwuiaGOJnmcA2eqQ==
X-Proofpoint-ORIG-GUID: aqJnI18xc7fLLkRB3mujFD5qJXToTt2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150127

Hi Konrad,

Le 09/06/2026 à 15:31, Konrad Dybcio a écrit :
> On 6/9/26 3:23 PM, Manaf Meethalavalappu Pallikunhi wrote:
>> Hi Konrad,
>>
>>
>> On 5/21/2026 4:46 PM, Konrad Dybcio wrote:
>>> On 5/19/26 12:49 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>>>> based power monitoring and limiting capabilities for various power
>>>> domains including System, SoC, CPU clusters, GPU, and various other
>>>> subsystems.
>>>>
>>>> The driver integrates with the Linux powercap framework, exposing SPEL
>>>> capabilities through powercap sysfs interfaces.
>>>>
>>>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>>>> +static void spel_remove(struct platform_device *pdev)
>>>> +{
>>>> +    struct spel_system *sp = platform_get_drvdata(pdev);
>>>> +    int i;
>>>> +
>>>> +    if (!sp)
>>>> +        return;
>>>> +
>>>> +    /* Unregister in reverse order: children first, then SOC, then SYS */
>>>> +    for (i = SPEL_DOMAIN_MAX - 1; i >= 0; i--)
>>>> +        powercap_unregister_zone(sp->control_type, &sp->domains[i].power_zone);
>>>
>>> Could you try adding a devm_ variant of these register functions?
>>
>> Powercap framework doesn't support any devm_* API, you meant add this support in framework in this series ?
> 
> Yes, this should be fairly trivial - look at e.g.
> 
> drivers/regulator/devres.c : devm_of_regulator_get

Given how structured is the powercap framework, I'm not sure it is so 
trivial. May be it is, but I doubt.

I don't think it is worth to investigate adding devm_ variant now (for a 
few lines saved) and diverge from the objective of this series

   -- Daniel


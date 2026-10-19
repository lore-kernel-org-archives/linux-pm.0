Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF934FC358
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419000; cv=none; b=rsXk11PW2YthT86vZqAyzbsDYvk0cKTYSjX16OMsYL7q5sjE21cuo5W1U/c1HcWhYpd9+rEIp0u4Yrrp4iZ6CAEQVdz5Bn2JKmAJ78rU2iVxFqwO3G2EdafWgMJzHexXn0h2XyJvLISnuZ8ed6Dgrg7BY7uaEN5cmLGO7PSkIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419000; c=relaxed/simple;
	bh=2zRswY1kMWQs0gXfYi4Jh01yqYcUt3kjlN5/njNXAJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtS10LoF2jAEt25F1KbH+hDcUaE3leHWz+zcOHZrmn1YARLBEqzpLYdf1U18UU0NM8hjDv3f/IazKs5OTtLQ48aWu/ljOLQ1+VxjzgKeENuuy19tB3fhtsUqCJuCDWdsy4uQVpB5h42APZIlTCPb69kaMqXptiHulDqOi9og30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gv4xxKaj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ay/qlqwq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gv4xxKaj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ay/qlqwq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE080H4041091
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ouV6+Wxc1injxeExVghh4cJm0g67UbarNcdMufji7eI=; b=Gv4xxKaj8Cit20k/
	57e2jFRI5tvJOAlEdVycQAm7aD75a6O52Om3wlOvEffPEIz+R0cn123su6ldFroY
	uRCx/1kEWkanakST5W+jF3LNsjT6A4HJTgNuFzwZHm9tHl0YpqhZARp7YiWs7Dvr
	TXqdcIfDJwEAq+Yy9MF+4Pn9WyIU1y4JkwdQ+J/4MMz+yMFLx31NdZp0pcSi70fc
	pcSz3jny5qvDcEVP+/z4ILWaxN4gCuNTASCuxVdXLB2XBz5k/Ow+fj6MuWuxiUFw
	iqQJHvVlIJTLfWaju/LyZAyvF4K2GkUmGJvcoIrwdjEJsTGer+dMo+bA1JWO1jT8
	eSZsvA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47hjwe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:09:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dfb24dfedfso19432305ad.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792418997; x=1793023797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ouV6+Wxc1injxeExVghh4cJm0g67UbarNcdMufji7eI=;
        b=Ay/qlqwqq05so18r0Zrtc4BzFlB2Z/1uKxSBx6VyXhwjOVfRK9IV8aoDAv6zehF2vT
         Xa/tXBSGo4IUz65aAvhew006DHycZnvHij6rnvxO5iIdAhCuTz6li8klXDGh9z2JoJpw
         qnRdgC/CEPlHGvIAyDXfmPjeo/e5MRiqWml6kz2wW8IldmP31964r0JZSvUXkJg/9UoA
         AYXDjk++DkYgGNAksuoamSxKoTUFzNtIHOG0OGJ9RdezgFbxXMfufrD7ikv7egsCDrU9
         uJMucWYFJPnhz4A/iDpzsfvQb2dTPO5EN465tXQd9zXsOA6v1+PuopDD0s2gMtc4KThv
         pyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418997; x=1793023797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ouV6+Wxc1injxeExVghh4cJm0g67UbarNcdMufji7eI=;
        b=C52iQCJC5NkWSbohaa/Hots74XZ6ZtclZyV83zvTs1A1u8UQiLF5yPcSyeWYGcqtyr
         siUnpJGcqZUE/NehUVUztACOup96/5TZyPuYJolFxhoBlJfywzZOwsDFlwunFZi8UEmH
         CEGaZM+KNnKSuJjrAMp9mjKg7appCP5lB+CpUzqMSR8ywQTH4jmOu+3gPQ6D/6I3AfW4
         o5JGX7cvUN8lT8S4HX9yOyqzDhDx3lHtGRitpW6JvxmU9ADHSL9kfPTulvs5wyp/mZJ+
         1JyflKISWAmoEEFMFhNx7zea7u8IbD7AiMlWh9/Oxc+BCeCDaAGnkUl56BnRKBQbT/2C
         GBKg==
X-Forwarded-Encrypted: i=1; AKwUvBwuoV3nQP0uTUgOyOj23bfkIPLL32uqvFd10yXXrFFtmk4Uc9H44eLPYzIzyQj+lSqowXCTZWCpmg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIoKnIcN3J07bS1o961DCou5PnjnsiDuR80uQps3eaxwuUGJo3s
	9Pt8F0mYkzZ2dmv9cD+H3/5TVA8FB9/6L0Loa8JCyzVr3DwGbloUiT+xPLYcdoq9OPfIXTCAq+d
	Rc/0mJ2it7MbFsTmpPlcCCJXrgYwVFbrywz3LUAc4YQfmMxYkuEHsNhCiur/TFjVL9NzDHw==
X-Gm-Gg: AYBFou1sGbyW12yewjAXkt43NJ15dlejY92tqaIsRgZPsOG9H2KEUo6x/X/F5cDA1pm
	rT/qp9eT+C1ni1uyQ0FbNor5SYlobiG99vXRWpHL6raNohNnzs9W7S1ouNo58kK4sCWT0di8ZG5
	wVUwqiyyAK8B3g2emCZ06Dk4LfMjR+f81dcUF6J5rXmmuLzxB+g4caURbbrm/tbbr4NhpqrfNxv
	n7Cmqe0tOuRSweIMebM/r6mQzuw/L4lanbYPW3eEplkIk2EVe/vCWV2SdbXynI1IfC11I8ST7ky
	ZkzRmszlJ4Wz5s32YHnuKnDE1gB0FD+qE9aQ7Ro44PQ6tMt3lFJo0NH5jjwSKFgoHuVA79rc8+3
	nFP/mYcjmuxcXBLMFbYM2cmWuO95d
X-Received: by 2002:a17:902:f54a:b0:2df:35f1:8771 with SMTP id d9443c01a7336-2e9a6c24bccmr68072275ad.54.1792418997292;
        Mon, 19 Oct 2026 07:09:57 -0700 (PDT)
X-Received: by 2002:a17:902:f54a:b0:2df:35f1:8771 with SMTP id d9443c01a7336-2e9a6c24bccmr68071855ad.54.1792418996622;
        Mon, 19 Oct 2026 07:09:56 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.233.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b09sm1459455ad.69.2026.10.19.07.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 07:09:55 -0700 (PDT)
Message-ID: <84ec68fa-358d-4339-aefd-ed100a4b7da5@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 19:39:47 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: thermal: thermal-zones: add
 hardware-binning trip properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
References: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
 <20261002-thermal_bin-v1-1-5a29be7e8ec5@oss.qualcomm.com>
 <20261013-jolly-abiding-wolf-bab43e@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20261013-jolly-abiding-wolf-bab43e@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Xpn8v1zhacD_dxEndSqIasEJjHhomH3h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfX3+zQLoVAfjO2
 vm2CWpIYfIFl8NQ0QhIFCcBdfLPrTlmprzaxHLNnPxJcTHpfVbhV9XozBl9ZQ/p2EjtwcmJgCN8
 b1pqh32gMdKYGteLV0g2NNSr6Jh5pBa/fw1FMWuYqeBxyFxF2NkWHrclbOZ39sAP5nhKdUWt2GN
 Z4tJ4JTj17Hbt7guSNYxNm0s4vbcNpDmZXfu7E9N5HlByrXfGf9oJ9JzDVle9meHY8VDSmj9Yme
 +BHZN63Aq+XGHlpQRwtOnqviHif0sJb6NlMZuUyeylab31ETDVX+244rSV+fxyzDixWqibbLkKf
 TBF/U1Sq77JL3kY6w3OjAFwiqvP8N9IakXKNcEVKIMa740Nn065s4G6ZEImnz2Yg30EdGQfOq5m
 UvMG7XNgKzOF+b2KDMQbOXczRhFLWU23WbvhtVBwAH5JgLQEmYKgjLHC0t41qQqyNdhatuIqw2t
 mLqoNTGeL0ecx/FC8ag==
X-Proofpoint-GUID: Xpn8v1zhacD_dxEndSqIasEJjHhomH3h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfX6LiknYxYGPtf
 GmMt58OJkR6ChZhZyrLmbFbdXgRUCphFw4H4CPCoqbKXFq/tyYLqZyNAp5hHLfds55TZgKlQLrI
 QPkc7qJ2mpz4UE5OeyQlGJPqev0QqNg=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad624b6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=A3JsiXT2jxe2NWqPQ1aCbg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-zH7FtNjIyeSShpWrKEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190056



On 10/13/2026 11:54 AM, Krzysztof Kozlowski wrote:
> On Fri, Oct 02, 2026 at 04:16:56PM +0530, Gaurav Kohli wrote:
>> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>>
>> Differences in SoC packaging can be used to provide multiple SoC SKUs at
>> different thermal and performance characteristics. The underlying SoC
>> remains the same except for how much heat the packaging can dissipate,
>> thereby influencing the critical trip point at which an SoC SKU needs to
>> be throttled. This SKU-specific data is typically burned into fuses
>> during manufacturing and can be read back at runtime.
>>
>> Add two optional trip-point properties to describe this:
>>
>>    - 'temperature-bin': an array of per-bin trip temperatures, used
>>      instead of 'temperature' when the trip depends on the hardware
>>      revision encoded in fuses.
>>
>>    - 'thermal-hw-bin': one or more bitmask groups describing the hardware
>>      revisions for which a trip point is valid, modeled on the
>>      'opp-supported-hw' property of the OPP framework.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/thermal/thermal-zones.yaml | 53 +++++++++++++++++++++-
>>   1 file changed, 52 insertions(+), 1 deletion(-)
> 
> 10 days was enough for replies to feedback, so dropping from patchwork.

Hi Krzysztof,

Apologies for the delayed response. I was away on leave.
Working through the Sashiko comments and will post a v2 addressing
them.

> 
> Best regards,
> Krzysztof


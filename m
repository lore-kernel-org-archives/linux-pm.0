Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F9376BC2
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333682; cv=none; b=csOUc+QrMp27swd/vbfhD1laxGMtpNkc0O7nmV22eKmkEyVmd+aQiIdcwtFFuy6NQjuNMFq4G+X/6GooiIughliIE2h65YmZQetuDC+nazv+ZJaZ64xkoMk+8/Sp2apVqRpPtGuFucPPXSkfn8/aJjZTGWwdqZ3LTcY1XnpIVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333682; c=relaxed/simple;
	bh=ktFuLBod6PkICS5eU2aAXOoPaoNHT5FsvcQS57K1xyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttH0xLpZMfEu5zXFFGtRb/rLdTqsOzqNYnMUCuQBdpwoGBt8KfkaNK4loBwsNANoDXDFnVfYbq73yf3orT1v/qmFsF0AX0L8CJt9kNt9YDd5oyDUAxhuplwd2JrfGRwmd4g/fdpH+sHzGhqwQqlJ8w23fAqUanZUf39OAKwUN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G+kOedp/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JOmz9Mzc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G+kOedp/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JOmz9Mzc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJjTWZ2395868
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 20:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RzilcVAWfMphGHBUGGTpHmQyinvK3m8bXOKcthvVDMs=; b=G+kOedp/l6hDz4IP
	MRKMghCFfffhYlvzlLhU2vsVFfjAUus19l6mhBa8bXp+Hsg2ItVlQLkV98/xaL+j
	6YeSbTAXsRLxxIBSUTxSX1lIBBXbmQpt9JWp7Ia7EzOSVBEx702+RG9+oYaLyBNk
	9O2eajtaQ2KqmA+cfyR/o+ewwMpQ4KDc6s34wSYMilMLAhbxysaRynubMjke3mNy
	HjefyLKQbFrweKdBLEkpQeIm8OXLdGuNVrGlYSyTKXm9GQwSICD6XMMT4CnvJt0F
	+otPB0GdvnNRg7zbZcS+NPgwvwuO34yaE41GLTUIg5CgWb6dMcR1kru8u4Iiqtmt
	osHP3w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f06r33ybg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 20:41:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91ed0e140c5so324482985a.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782333672; x=1782938472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzilcVAWfMphGHBUGGTpHmQyinvK3m8bXOKcthvVDMs=;
        b=JOmz9Mzc8MUB4pzitfG8Og5gL7ERfzzNDsYEK1KPUViDmUbHYAAKDs4gdSsJQkZYA8
         z3YPXuyj7fORp1OEIPXB/ncR05WnJPvkp8UJjojuFoZzb8atqjyzmFelOWbtjsSjV/pR
         KqKn9Y+1P7JRYydcGVfhW5dXj8U9HvqjJkysScLvDipY6dk45nVItvZSBD7LBqu6Du5U
         enYF63freqUWg480l3RhNzJi0Lx7DnASN9XN5I9TEkI7Ek6Ucxd4gmMC3KdLk1kyg7DA
         WZCaAUcj8Caj6NcPBudzXsT8p/U1+irn2MffTIGu9HcDz77a8BhTVrhiV2wC7yuYjDOU
         xkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782333672; x=1782938472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzilcVAWfMphGHBUGGTpHmQyinvK3m8bXOKcthvVDMs=;
        b=NV9lW2GhRaMGa1UrTS/HqX0P8YdTuaSN6E4gMOnXqFWej1m9pJZ/cX91DioPAGqWCa
         Hqp48KRHREIk5G/W1v1Swg7A6TXDvr8zc50yHGVlM5iqzQL2hJJqHxpXMFlshUtGH5M6
         AJifsPjIPjIWHcHpcJH8M9oUM5XJUUbDMf6Votalkctk8+2gvPWP8+Ylc26LjsSFB5BH
         dUZekEStNSIFlRTRKF7JRJTwL3upkLCee1RyZJIbJz8gntMbEVJQ40zB80wz4lM6k+/o
         fWe0Fk+HVjImFChu9M1X0jOxUIpPB6TXiSzzcdUJS4UeCPv+KWe0/28V2G9SB2SguQ41
         HVuA==
X-Forwarded-Encrypted: i=1; AFNElJ/gAVe//vspD79Wv1GjiH8EzwWmTvhv3uk9yqp6o+FbM8fv/1mct6lwJYTaaRmolsnFfGuHsCdcyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJD0o9lzz23FpYBgRgVBwU2wP7KTGUW25C2OkOt2mpW4EdFy6y
	e/b0OPV+LcsOMlwLyS8jGVW2eNQlZo8Bp4tEGdMoNk5va3AATVNLHjpMy4E+ljkPpSCAnnKCoLM
	fDvEFBxXg30Hx6XkuZCyWfQ6KtEcry6VAlpXKiCgP8PetF42YKBvluLVzgYP93Q==
X-Gm-Gg: AfdE7cno0rWRAlGoCvmpZ9SBJpFcjTIil+pfEqKvVG41yiq9qBSxD19MlC8lGaCVf6v
	XNtnqn436eOpZI8uWeo+eL+Xkuyc2NJ+Asb3KZ+IwsSWyBrJl/EcG9QYl4WMiHvhMn4DoWA7lpH
	G2u5KkujKjsB4RicKUFNOAJVFBdntUCy76aAQfZr3fxdzlD0YM8YC0kToz4A725c3ityAHtS3MG
	JPtxFh9EHp7D2I5jnXRX2IwVx7rwqwjTJn0fB/XTfDrrImyEW3PBA5k4b1lsugDSMo8STx1dlpi
	NymCNtvYMzpgnBtOpSwlgoUQd5fJi8hws9lx5oEHHQRGjwd7Xi1ycLBNiZ2opNfKdVJ+g9QPtPj
	Q6v7e8rk2fpU3zhxx3xNsvLS8j2QadCF/HD4K89EpxAawytTG+5OjkL2HHLL41AgOVnX7JmuIHA
	==
X-Received: by 2002:a05:620a:3724:b0:914:9ecb:9adb with SMTP id af79cd13be357-9277f6db9b0mr759157285a.50.1782333671736;
        Wed, 24 Jun 2026 13:41:11 -0700 (PDT)
X-Received: by 2002:a05:620a:3724:b0:914:9ecb:9adb with SMTP id af79cd13be357-9277f6db9b0mr759151485a.50.1782333671228;
        Wed, 24 Jun 2026 13:41:11 -0700 (PDT)
Received: from [192.168.10.101] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926544dfaesm1511725e9.2.2026.06.24.13.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 13:41:10 -0700 (PDT)
Message-ID: <63d42dd6-862f-4a9c-a950-5bc90ffab391@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 22:41:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: power: limits: Describe Qualcomm SPEL
 hardware
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
 <20260620-qcom_spel_driver_upstream-v2-1-a3ee6837c18f@oss.qualcomm.com>
 <20260622-armored-witty-tarantula-84a28a@quoll>
 <db8f06fa-0dda-4a22-baaf-8a708d43e113@oss.qualcomm.com>
 <d0528339-8be9-4895-a054-625df96ca926@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <d0528339-8be9-4895-a054-625df96ca926@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE3MyBTYWx0ZWRfX8wka+ixuJxAF
 51O+H4CwiIzNns3FLB3YbW/5/1HuXXsg0qqCeeLtfR0J0loKOmsTocTDSQKRSffFn/G3lKyWs3a
 hGZwYUZPZTdorknm6Io7YvgPGC4i/Rx9HeMLgsjAd6eFjRyQP8ADhvuGgYJW9OURVdVUfYAK9P5
 vxjPqNBPcfow6HY8gIOyVkUYYJSmkx/vrtfEY+xv4n/W9mZUPeN4mTNNlOiUbd2wZVfSFvBMQkQ
 ZiI/sXw9nsIWlOlb4dTb4XclMu9xq9G/j56W32DEVgiFm/BhmJnJgJYB86as2Fb2mzmUpGU4ML3
 yQMbSDrjX6M1c4x2PtLLvVDwzEeGKbU8nOQPakaZYS9GS6DtdGncltG6c7VUSafz0zCrxmTxq+f
 /+8h2bki5FTCGsQtC4LcEMJgn3lbbX/yDxgXcZToD2/7Wq386oSnHECwFxXKGT1mPn/4xTVGH5C
 AAuapK1WFZOIad5cBug==
X-Proofpoint-ORIG-GUID: Tv211OhvjnPitLluBPNx6pHL_JmjUWxZ
X-Authority-Analysis: v=2.4 cv=ZM7nX37b c=1 sm=1 tr=0 ts=6a3c40e8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=PPDuxORCk0BztKokjgsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Tv211OhvjnPitLluBPNx6pHL_JmjUWxZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE3MyBTYWx0ZWRfXx5hwX9HeylRv
 VUsuHR7/tZl1UJYPur0qPEywqrXJgAH2HwY+BPL/NuPmpE+aMEIhMVBqW8OfNY2KQK7DxGty11G
 H3L8sjW7aCDkjY5GsxaatvqwDBUnBzA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240173


Hi Krzysztof,

Le 24/06/2026 à 12:45, Krzysztof Kozlowski a écrit :
> On 23/06/2026 11:47, Manaf Meethalavalappu Pallikunhi wrote:
>> Hi Krzysztof,
>>
>>
>> On 6/22/2026 5:58 PM, Krzysztof Kozlowski wrote:
>>> On Sat, Jun 20, 2026 at 02:09:08AM +0530, Manaf Meethalavalappu Pallikunhi wrote:
>>>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>>>> based power monitoring and limiting capabilities for various domains.
>>>>
>>>> Add a DeviceTree binding to describe the SPEL block on Qualcomm's SoC.
>>>>
>>>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/power/limits/qcom,spel.yaml           | 47 ++++++++++++++++++++++
>>>>    MAINTAINERS                                        |  6 +++
>>>>    2 files changed, 53 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
>>>
>>> What is "limits" directory for? What sort of class of devices fit there?
>>
>> Added for devices that integrate with the powercap framework (exposed
>> via sys/class/powercap). These devices are responsible for enforcing and
> 
> That's a driver answer. I asked about class of devices. powercap
> framework is Linux thing, not a class of devices.
> 
> Please describe hardware, not Linux frameworks.>>> monitoring power consumption limits across different domains, such as
>> the system, SoC, or specific subsystems. Any other better directory ?
> 
> I don't know what is this hardware doing and commit msg is quite short
> on explanation. Power monitoring is usually hwmon, but probably this is
> not a hwmon.
Right, it is relatively new in the device tree bindings. There is the 
Intel RAPL which is the same device but it does not belong to the DT 
namespace.

RAPL : Running Average Power Limit
SPEL : SoC Power and Electrical Limits

It allows power capping and read the average power consumption for a 
specific device (or/and an energy counter)

Basically you can set a power constraint (power limit) to a device and 
this one won't consume more than that power (the power limitation 
strategy is managed under the hood by the firmware depending on the 
device - lower OPP, idle injection, modem weaker signal, etc ...).

The RAPL or the SPEL have a hierarchical power limitation. For example:

                                     SoC
                                      |
                           ------------------------
                          |                        |
                      Cluster0                 Cluster1
                          |                        |
                 -----------------        -----------------
                |     |     |     |      |     |     |     |
              CPU0  CPU1  CPU2  CPU3   CPU4  CPU5  CPU6  CPU7


If you specify a power limit to 'SoC', then the power consumption of 
Cluster0 + Cluster1 <= SoC

If Cluster0 power consumption decreases, then Cluster1 is allowed to use 
more power until Cluster0 + Cluster1 <= SoC

For me it sounds reasonable to put the device description under power/limits



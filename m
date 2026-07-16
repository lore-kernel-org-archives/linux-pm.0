Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6D2D1907
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213667; cv=none; b=kl/ZvSJpyK1cOT17ML6WkKr6oC1ZyDal+q/0E4+kI/m+aCvR4WHfOgK2rfqJYFRKDFGwkg38WwWC7QnxhK7W4NZ/6XZeS2nr5FycDYWWigorv0nBezsX1EtbSVVPhZ7HiKBYD+evxkOdGvd+krVqK43ogH8MgHYvw7ZRxyqJvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213667; c=relaxed/simple;
	bh=GgwHqOjFiQIX2+nPFjRSr1wyN5czxKs2OnHspb7l8Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2DdVpHV2Jp7Helig6IAlsjY0IISyDLXCCiXLACMjGf2GHD2U2IaCyb46xwTvi2fYslnb+5iGXp46GXA3GC2gX/t3o47y5yBi9UH/XN7wlF1wIxTSx7z0y+ZCTramqORBk15PWlu9HHQjqFr2pdeQiasSlrE4pk5tSvt17L31mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CmPqJnh2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heOHCZEw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmPqJnh2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="heOHCZEw"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJlU42691769
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HMiW7sqD34b4TNQBhq97l+5YnGfknF/TWxv3ZfOpvHY=; b=CmPqJnh2Ev5SXPHD
	YhAJ5S0iuGBzDjU2SD2HtwDLxu9OCQwOhA/7DtRDAYQsRUpoiuiLOftHZi1+6WHF
	8w52i28BKgW6uCOqev1Q2xLkCLo8IsPKTqmoWH6d8PfgHml3P8NdDW5/SZjdSP2b
	AmQlxLMZ22u5/3PSfAwUJzRSNpkJWCUiQrc8r6qZT5YOzjEjXmIo9LQq+t4uB+Ro
	1fRjtrCYrtlZRasH/qz7kYpueMkLJ9Vs3v5YeDT5pe4Ws8gjJfmg6ZgVJXIkWeyF
	VJNZuCk9NlJrG53Px+i6gU2BUI4LKf4qYpc/B8/HJ9+NuscLmANMsdGdv3XL+UKl
	LQimrg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7t1t0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:54:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e66f9e2baso540285785a.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784213664; x=1784818464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMiW7sqD34b4TNQBhq97l+5YnGfknF/TWxv3ZfOpvHY=;
        b=heOHCZEw9QP7LVYKVbXjUfVTksEzKBmBss7i0n/rLT2hj2dsJn+8WXeE5lbzEsjMQ6
         ho1mFoW8suXvcolO8/0EeReTiMiHQxg373u72Srx9IvmAVsyL0dym5ZdhFPoJB0gfFEu
         dEyCBqA90hSLjnF2mteIPhJzvIOETPNnjcw7Cy63h/pj9LBOLkHP+6g6w4NB76hW7t8k
         72seXr/BMgPAbqvN0wZ2BqdPgrX4a9nWNU0dPQohPPIqWQaoCb/yxvHKbsP53OpVi8Ef
         B02csjOFI6gcv4wjY2fFOw5eb8KnPrQSTsmgl9lmDDXcAE83e/yIKmB21Y59/Jn3UjY0
         kESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213664; x=1784818464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMiW7sqD34b4TNQBhq97l+5YnGfknF/TWxv3ZfOpvHY=;
        b=ACcg3zGsUkdClOcXub2tbPwILVe8CufdNx+aKs49JccTThAoCl+/db7Hft3Na1050H
         3f8V2/E7px+93filLv+vCV+PPCTYOf4WEUxk5kNNZburztlaP8mBjDA4N1Zw1mXR6PA+
         xK4KohZYcYLnUJpJVujTIQo6HQ2pRv9QxQaa6YwRorzl6lWT/Ysq8C12g/Cm50uTBV/a
         uvSNkO2S9PqL01Ao3EARNK02qX71mGpHw5xF9WDE+2WXC3oek/TuSoWIFcNsuTn8BKMq
         sLxjjopIaIyeW/MvSyL4oCN93K6/p5JF3C2kH3SVmaXe5GwuhCADTWw4kXcEkq1OMfLu
         1Img==
X-Forwarded-Encrypted: i=1; AHgh+Rqo/D0R/I9PqCjL7ma72738Nq4fkHxP5E9x7hlst6USX1gCMcEayVE8+TGG8TkXsirtSn3i7kL23w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkWzuaPb/6VAJnDdivFzT9aRlicVepP9poXNhN3kRROAirrDH
	mX1P+me+06jo06DjT4Y1n3C5ei/gB0daISkPUSKOwoX4bJ5+t9PLVaGPabA659AN8viUnAUDTtt
	BZ03tfybvsi6wwKSqPR4Wl/gClK9IfYa8xorpsLJmTS56IZUcFVY465SZBFoLsA==
X-Gm-Gg: AfdE7cnm3OVJ0sK5Sge3c6lNkdlIskCPFoy/rqLLTiRyQPH1DBVV9ED8FZMgMkNJ7Mm
	JFIT52+Wuv5vZXdnylIH2FpVcj0HzBASQ3bcytOqSyR0mcbW7iqz59LEzqRBO9y6fuV/Mx7nmCx
	ohY5t6y6kot/Z9Q/j0FUgLU3Anai7lYs0kBIuN2pv75LdGQ+UToar4MTwZbawiHEFsEuXbhiMKM
	XW4llkfc93Qj4onkZAqTjtsWlM8Nj9aJMDuFNhaVVD3oY3i5toTlSwy9jKOryadvMr53Kijejcu
	DDtBOi+iQOQ6xaKPn6BB6qrJJtrxsP3C4JZapWOowyRECytyAdf7AMBXkr7bXnopGSRUKW4SbSO
	Bx10DAZzurSlJXYcp6ujn0eOJUfq3OtvZAduy
X-Received: by 2002:a05:620a:a81a:b0:930:9c64:330 with SMTP id af79cd13be357-9309c641a57mr561582085a.87.1784213663817;
        Thu, 16 Jul 2026 07:54:23 -0700 (PDT)
X-Received: by 2002:a05:620a:a81a:b0:930:9c64:330 with SMTP id af79cd13be357-9309c641a57mr561569685a.87.1784213661884;
        Thu, 16 Jul 2026 07:54:21 -0700 (PDT)
Received: from [192.168.0.3] ([49.207.213.154])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfdf6fsm2181794385a.24.2026.07.16.07.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 07:54:21 -0700 (PDT)
Message-ID: <e5eb39a9-54e9-4ace-a587-7b53e2bef511@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 20:24:11 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 7/9] PM / devfreq: Introduce the QCOM SCMI Memlat
 devfreq driver
To: Bjorn Andersson <andersson@kernel.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, Amir Vajid <amir.vajid@oss.qualcomm.com>,
        Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>
References: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
 <20260610-rfc_v7_scmi_memlat-v7-7-f3f68c608f25@oss.qualcomm.com>
 <akWBtfG1j7-53fec@baldur>
 <ee407cbf-3476-4209-ad40-b381535b94ac@oss.qualcomm.com>
 <alfs7gOhE2D8wbVX@baldur>
Content-Language: en-US
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
In-Reply-To: <alfs7gOhE2D8wbVX@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MyBTYWx0ZWRfXxre6dRvwyCxb
 acS8aka49Q2fJUoHolHgiEsolVA0qUkQzp0Hn+FShDZR7SLb6Al75IWyQfRKPUnmYPNb25ZoItw
 6OcBU4spWdzUXmKVeqpXt7lSsW3curo=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a58f0a1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=S/f93LI4n8kOILjz9r/FGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bh7RdKFNfH2X48UuDvsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MyBTYWx0ZWRfX1CxrOofw/QRY
 pul8x32iN43vdgDZ5CpGMvG7wh/mpNgUQDN8hmmEzGDfZVWwrlP6Bj8wuYV/RUy9ehvAE+kxQli
 CvSUsiM+AvOzIiZmyZFJlmxV3Gex36c+KXY1ghuw+Tbcoys5k1KY5XfecKdlLjTBqe8MFdA6zI7
 1rVkL1HE1QJUbFRgvbv+Or/4QwFi+oJl8F8armuO3+ZNmAOuV6shIs/aT5FSD9xNKE36jjGXkmD
 JuBc914KX9/5fMKAiv0gOmsgAaXY4hXx8WW9lc43EI1sVg5NRlXFO6gx/6TXZ/lqmGPLXdEHgHg
 zyb+oQvxYhcrrsjZr7we9QU9HeT/zUP7/TU6J2xMPj9pdz3U5QUSYLT6pENEspRDIYGNtVlVPEF
 8Ish3c34fIB5U7WPIX3Wza85oEVEzOMcjplfmObxc0TYuPEPyATeUu8m2RuVJ3lFAg4poWlAa+x
 GZwzO9cvTE2czetDPAA==
X-Proofpoint-ORIG-GUID: ylXcO6CiACb5ITv4owKmZSONJiCMw5ol
X-Proofpoint-GUID: ylXcO6CiACb5ITv4owKmZSONJiCMw5ol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160153



On 16-Jul-26 2:14 AM, Bjorn Andersson wrote:
> On Tue, Jul 14, 2026 at 01:14:23AM +0530, Pragnesh Papaniya wrote:
>>
>>
>> On 02-Jul-26 10:51 PM, Bjorn Andersson wrote:
>>> On Wed, Jun 10, 2026 at 02:21:34PM +0530, Pragnesh Papaniya wrote:
>>>> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>>>>
>>>> On Qualcomm Glymur, Mahua and X1E/X1P (Hamoa) SoCs, the memlat governor and
>>>> the mechanism to control the various caches and RAM is hosted on the CPU
>>>> Control Processor (CPUCP), and configuration and control of this governor
>>>> is exposed through the QCOM SCMI Generic Extension Protocol, addressed via
>>>> the "MEMLAT" algorithm string.
>>>>
>>>
>>> This explains that there's a bunch of functionality running on CPUCP and
>>> there's a "MEMLAT" string.
>>>
>>
>> CPUCP does all the real work: it samples CPU perf counters, computes IPM/stall,
>> and votes the DDR/LLCC/DDR_QOS buses on its own timer. The Linux driver only
>> pushes static configuration (freq maps, ceilings) once at probe and
>> starts/stops the CPUCP timer. I'll rewrite the message to say this plainly.
>>
> 
> Thank you, that was not clear from reading this patch.
> 
>>>> Introduce a devfreq SCMI client driver that uses the MEMLAT algorithm
>>>> string to detect memory-latency-bound workloads and control the
>>>> frequency/level of the memory buses (DDR, LLCC and DDR_QOS).
>>>
>>> You established that there's stuff running in the firmware, now we're
>>> introducing a client driver to control memory buses.
>>>
>>> But where did you explain how these two "facts" are related? Why is
>>> there a client driver, what is the actual distribution of roles in this
>>> dance?
>>>
>>
>> At runtime the driver is not in the control loop, CPUCP is. devfreq is used so
>> each bus shows up as a real device with trans_stat and the remote governor's
>> parameters like sample_ms and ipm_ceil are user-configurable. I'll make that
>> reasoning explicit in the commit text.
>>
> 
> Are you saying that there's no actual devfreq'ing going on, we just
> expose it through that framework in order to get the standardized
> metrics out of sysfs?
> 
> Or that and to perform the initial configuration and start the memlat
> logic? Does the firmware do memlat adjustments without this driver?
> 
> Please make sure that it's clear what role this driver has.
> 

Both. At probe the driver programs CPUCP with the per-SoC config (event maps,
freq maps, tuneables, min/max) and issues START; without this there is no
scaling, as the firmware ships no built-in config. After that CPUCP scales
autonomously and the kernel is not in the loop - devfreq is used only as remote
governor so the read-back shows up via trans_stat and the remote governor's
knobs are reachable from userspace. I'll state this in both the commit message
and the Kconfig help.

Attaching past discussions where community wanted devfreq driver for this:
https://lore.kernel.org/lkml/20241115003809epcms1p518df149458f3023d33ec6d87a315e8f6@epcms1p5/
https://lore.kernel.org/lkml/k4lpzxtrq3x6riyv6etxiobn7nbpczf2bp3m4oc752nhjknlit@uo53kbppzim7/

> [..]
>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>> index 2caa87554914..98b5a50d3189 100644
>>>> --- a/drivers/devfreq/Kconfig
>>>> +++ b/drivers/devfreq/Kconfig
>>>> @@ -169,6 +169,19 @@ config ARM_SUN8I_A33_MBUS_DEVFREQ
>>>>  	  This adds the DEVFREQ driver for the MBUS controller in some
>>>>  	  Allwinner sun8i (A33 through H3) and sun50i (A64 and H5) SoCs.
>>>>  
>>>> +config SCMI_QCOM_MEMLAT_DEVFREQ
>>>> +	tristate "Qualcomm Technologies Inc. SCMI client driver"
>>>> +	depends on QCOM_SCMI_GENERIC_EXT || COMPILE_TEST
>>>> +	select DEVFREQ_GOV_REMOTE
>>>> +	help
>>>> +	  This driver uses the MEMLAT (memory latency) algorithm string
>>>
>>> Is "driver uses X algorithm string" idiomatic SCMI terms?
>>>
>>
>> No, "algorithm string" is an internal term. I'll drop the jargon and describe
>> it in plain SCMI vendor-protocol terms.
>>
> 
> In line with our discussion above, please make sure that the help text
> is helpful for someone to understand the purpose of the driver and help
> them make that y/m/n decision.
> 

Ack

>>>> +	  hosted on QCOM SCMI Vendor Protocol to detect memory latency
>>>> +	  workloads and control frequency/level of the various memory
>>>> +	  buses (DDR/LLCC/DDR_QOS).
>>>> +
>>>> +	  This driver defines/documents the parameter IDs used while configuring
>>>> +	  the memory buses.
>>>
>>> Imagine an person outside your team, sitting there in menuconfig
>>> wondering if they should enable this driver or not.
>>>
>>> There's a sentence in the middle ("control frequency/level of various
>>> memory buses" - that sounds like something I want. But "detect memory
>>> latency", is it just monitoring or does that part relate to the
>>> controlling part? "This driver defines" so what are those parameters
>>> used for, do I need some other driver for the control part? Is this last
>>> paragraph adding value to my understanding for that
>>> CONFIG_SCMI_QCOM_MEMLAT_DEVFREQ does?
>>>
>>
>> I'll rewrite it to say what you get (memory-bus scaling on these Qualcomm
>> SoCs), that CPUCP does the actual scaling, and that nothing else is required
>> to enable it. The parameter-ID paragraph will go.
>>
> 
> Sounds good. I'm a bit puzzled about it being a devfreq driver, but if
> you can explain the bigger picture, I think that will help to reason
> about it.
> 
> [..]
>>>> diff --git a/drivers/devfreq/scmi-qcom-memlat-cfg.h b/drivers/devfreq/scmi-qcom-memlat-cfg.h
>>>> new file mode 100644
>>>> index 000000000000..1ab8b61ea271
>>>> --- /dev/null
>>>> +++ b/drivers/devfreq/scmi-qcom-memlat-cfg.h
>>>
>>> Are the entities declared in this header file used by anything other
>>> than scmi-qcom-memlat-devfreq.c? If not why is it a separate header file?
>>>
>>
>> No, only scmi-qcom-memlat-devfreq.c uses it. I split it out just to keep the
>> large config tables out of the driver logic. Happy either way: do you prefer
>> I fold it back into the .c, or keep it as a header?
>>
> 
> Please move it into the c-file, move things around so that you have
> clear segments of "definitions", "configuration", "logic", and "driver
> boilerplate".
> 

Ack, will fold.

> [..]
>>>> +struct scmi_qcom_monitor_cfg {
>>>> +	const struct scmi_qcom_map_table *table;
>>>> +	const char *name;
>>>> +	u32 be_stall_floor;
>>>
>>> What is a "be stall floor"? Also, it seems to be 1 in all your cases. Is
>>> it boolean? Is it constant?
>>>
>>
>> It's a back-end-stall percentage threshold. It happens to be 1 in all current
>> configs (meaning almost any stall qualifies). I'll document it as a percent.
>>
> 
> back_end_stall_percentage is a bit log (and I'm not entirely sure that
> it is). Perhaps you can provide some kernel-doc and express what it is?
> 

CPUCP computes a per-CPU back-end-stall percentage (stall cycles / total
cycles) each sample window, and a CPU only contributes its frequency vote to
a monitor when that percentage is at or above be_stall_floor. So it gates a
CPU in or out of the monitor's scaling decision; 1 means "1% stall is enough",
i.e. effectively always in. I'll add kernel-doc on the struct spelling that
out (and the same for the other per-monitor fields).

> [..]
> 
>>>> +static const struct scmi_qcom_memory_cfg glymur_memory_cfg[] = {
>>>> +	{
>>>> +		.memory_type = MEMLAT_HW_DDR,
>>>> +		.name = "ddr",
>>>> +		.mem_table = glymur_ddr_table,
>>>> +		.num_opps = ARRAY_SIZE(glymur_ddr_table),
>>>> +		.grp_ev = glymur_ddr_grp_ev,
>>>> +		.monitor_cnt = 4,
>>>> +		.memory_range = { .min_freq = 547000, .max_freq = 4761000},
>>>> +		.monitor_cfg = (const struct scmi_qcom_monitor_cfg[]) {
>>>> +			{
>>>> +				.name = "mon_0",
>>>> +				.cpu_mask = 0x3f,
>>>> +				.ipm_ceil = 60000000,
>>>> +				.be_stall_floor = 1,
>>>> +				.table_len = 8,
>>>> +				.table = (const struct scmi_qcom_map_table[]) {
>>>> +					{ .cpu_freq = 960, .mem_freq = 547000 },
>>>> +					{ .cpu_freq = 1133, .mem_freq = 1353000 },
>>>> +					{ .cpu_freq = 1594, .mem_freq = 1555000 },
>>>> +					{ .cpu_freq = 1920, .mem_freq = 1708000 },
>>>> +					{ .cpu_freq = 2228, .mem_freq = 2736000 },
>>>> +					{ .cpu_freq = 2362, .mem_freq = 3187000 },
>>>> +					{ .cpu_freq = 2650, .mem_freq = 3686000 },
>>>> +					{ .cpu_freq = 2938, .mem_freq = 4761000 },
>>>
>>> Why are these tables hard coded in the driver? Are they constant?
>>>
>>
>> These tables can be either in DT (like in earlier re-spins of the series) or in
>> the driver. For the former to work well with the existing OPP framework, we
>> would need a clock provider created for DDR/LLCC/DDR-QOS just to derive the
>> cpufreq to memfreq map tables. Having it in the driver simplifies the overall
>> implementation. 
>>
> 
> But are there not different SKUs of these SoCs which need different
> tables? Information that we today would encode in e.g. OPP-tables in
> DeviceTree.
> 

2 things: we have added super-set of tables such that we can cover all SKUs. So
even in future let's say, any SKU is added: its cpu/mem frequency would be
between those min/max range.

We can define these tables in OPP DeviceTree like this:
memory0_monitor0_opp_table: opp-table {
  compatible = "operating-points-v2";

  opp-999000000 {
    opp-hz = /bits/ 64 <999000000 547000000>;
  };
where 999 MHz can be cpufreq and 547 MHz can be memfreq. For this, we'll need to
list two clocks one for the memory and the other for cpufreq which we currently
don't have. We also have no way to represent DDR_QoS in kernel DeviceTree.

>>>> +				}
>>>> +			},
> [..]
>>>> diff --git a/drivers/devfreq/scmi-qcom-memlat-devfreq.c b/drivers/devfreq/scmi-qcom-memlat-devfreq.c
> [..]
>>>> +	for (i = 0; i < info->memory_cnt; i++) {
>>>> +		struct scmi_qcom_memory_info *memory = info->memory[i];
>>>> +		struct platform_device *pdev = memory->pdev;
>>>> +		struct devfreq_dev_profile *profile = &memory->profile;
>>>> +
>>>> +		/* sampling time should be double the devfreq observing time */
>>>
>>> That's interesting, tell me more...
>>>
>>
>> This follows Lukasz's earlier point on Nyquist criterion: sample about 2x
>> faster than the changes you want to observe. CPUCP updates every
>> cpucp_sample_ms, so the devfreq poll runs at half that (sample_ms / 2) to
>> actually catch the transitions in trans_stat.
>>
> 
> While that's true for sampling in general, please make the comment
> explain why it's true in this case.
> 

Ack - CPUCP re-votes once per cpucp_sample_ms, so polling at half that period
observes each distinct vote before it can change again. I'll reword the comment
to say that instead of citing Nyquist.

Thanks,
Pragnesh

> Regards,
> Bjorn


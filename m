Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FC3E867F
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813751; cv=none; b=CnrTqeuvqmrMisEHQFNMqDr+yAo60UhAcwcpFj+IOoig6NEPjI76F4XNxKziAap7mH7X2UddKFgYzR0566sNb7dQQopInY8jNAGC1oa4xQQwysiK851NfI0mLOwLG8c2PCnO6VBh2ZEVprcfynpva+IHnZoi+UC5637/so0l9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813751; c=relaxed/simple;
	bh=gCfpK5S9QO/ftGgEqnzEXaD3WINOC6PqvtOcDSnO4r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gq8GkWCSYLwc7PFbxumUTZH9AeVWH+z5jofSAGCoV/WtmnXFmOUT/UdQr+wQTNdBbROwf7Y1SyCjRYUPNb6A7t2c0a14NTp4UU01Ix3Txd54Tj65bhlkrkLlvbSc/PZn5fQaVvJUiinYGd6End851K/Mz0/zywqmcmXk6b23da0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RX1llCWN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KpbeF2HN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RX1llCWN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KpbeF2HN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nL061590866
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 10:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lUbywPhi11XZzI5ppSu9FgDmSV/Q3ZgQenAYbUoS85o=; b=RX1llCWNwdiJc+V0
	v1oIbSF9gdJMDScIjA8M/NOI9cGwp0+5s3/n67gnmU7dqylWK6ZoRyXiBtRhKTYh
	GAe7RuW1bgSZk8uIdZSzyTflpMf6iblV7rOMIrqcSHx+ypTvikDvulQlrCbPwmik
	t3OY12rdA4MwZap8EzcQDs8e4EY7hHCNsMYGVt+vw2gv1npwhtxOYn/yoc6fCDN1
	KqzLCklL7DyPa3ufu6b5xk7X9Gwk4w7okTX0sndYvE0Ksk5XsAgIvKXLRMnBF56A
	6N/05Xvy/Z66fyP2hvooByL7W2TSCeLaaw9FHba51vlQIgxJEbcBaF3sGw7w5EWV
	44OqXQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k2vjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 10:02:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c987913b08so30789025ad.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782813748; x=1783418548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUbywPhi11XZzI5ppSu9FgDmSV/Q3ZgQenAYbUoS85o=;
        b=KpbeF2HNunKjpTqinQ1OGQWRf9xrd7WHd30sj25/20/t4YQQ3wCR85rkTIM06YO5+K
         0WIN2J/9sNgGv7q3shf+DBOIn7evNO8E8yACWKR0265g/wr1+THzdNTrR9G/t4xm9EcZ
         cqoEPyk2BCpwrJrPbpjZKhkEnWhU9ZDC+7cdpZXJbgICPNs/n6l5iIDjS95702huNioL
         aIQK3/ty9e9qFsjAoQ9fGsRC1fEM7EsQMILXJH7K9c3RhtM1O2U50QHQUlphKUc4Y+F/
         lPjqvYToZZVecppWcZ5Q6lztu/xJcJJ4BTzMtIv1ovq9IgwVjuu1SY5cTONPm3QNuCgD
         k3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813748; x=1783418548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUbywPhi11XZzI5ppSu9FgDmSV/Q3ZgQenAYbUoS85o=;
        b=oYFLeFJiQD+bR3MgKb51RmYVr5/ijUPgCed1UF6h7uWIlUG/K9Hh/uBzp5Yscuxi5v
         r9lX79J+H7P5I14ImVC/fBzFKaMMAb+Av6+Z+7TzQSQvKjYOxbi9Yhcdf6Vi9jn7UFXh
         fMUiYCSvnvlSsBlqhnOnn7KUMu3QPrV48amk6ImHzIoLQewRKZSjuTyfYqlS0fIzp/J2
         sc5xMhbsjC2h5Ug1Te7iGoyvauGzGMtMLcEjFhGDQ5lfix30fKVer/Z9Ik0fzx7NqdVb
         NvWNwdVZNCg03O2LUCqVJsfcs3GBIa+Ch5+P2+sczBfOWlltb/7d7fDTCvQS7REpWvL3
         i3Gg==
X-Forwarded-Encrypted: i=1; AHgh+RpiFWtdLp7cjD5oAcGQkq/FygJkqvmRT1MO6zua4HSBr4zbOJSPW2AbqFnVSu2wKZ+m0Qo518CCEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCZBHgUEAw/LBfgChbqXsgFQSg/Brd/xbVD+W2BqVCKwWDATo
	IWShSmDzDv3CKT4+z1khAw2l8eYxCTAkG+96IAJuR8zS3wGlnM0qIrpFuf1rr/GIoKFmpL6eX95
	50A/8FLaBYABEwWjl07kSVFiO9bQcVBhpLsQ/o8LBW5UMKpavtJSYov3vpDXfTA==
X-Gm-Gg: AfdE7cnOa+Mo5EHzdS6fjNwNektMD6xewi8twFCoRWBtb3jGes83+ON3seqjM/z28oc
	6+GS0m6K8mWd0fHgM65hlD4gqkDVAXtBbo7Fx+iLANg6iJ89yBiZNjmcK1Qmruh/mvM1o9GTMHp
	xH51Xl9e7TNDXvD5W668KHm0oUD9X4N5mdGVJIaanxNP46UL3ts47U+cKjRX4vcu2ORLxPcOvCn
	0jme/gKKJXofVbxWZ6FoVU1HCLA2qGq8guNVfZ9Q5e6faoBsN3pxyD4zh0mHOyaavK+/zo+bOnq
	OF6rZomq2AD3NGYs0BNwS+KA2w8yJUy3wbiRhgxeqIhVJUpX2VjhEqiBZMd0j8oITkcnlTKjNn1
	vPqYKIvy5OWIvWpqM8mqeFkeOrmmTHMhX5E9yv6VMw8AgfuX6titHm0oJSFl8HDNefCP5wQX9zk
	2t2+zFqKHYQjIXh8IicrS1U9/5tQWbPRcn0D1+
X-Received: by 2002:a17:902:fc84:b0:2c9:b480:f5d0 with SMTP id d9443c01a7336-2ca2ea1d435mr23586285ad.39.1782813747832;
        Tue, 30 Jun 2026 03:02:27 -0700 (PDT)
X-Received: by 2002:a17:902:fc84:b0:2c9:b480:f5d0 with SMTP id d9443c01a7336-2ca2ea1d435mr23585745ad.39.1782813747114;
        Tue, 30 Jun 2026 03:02:27 -0700 (PDT)
Received: from [10.190.200.168] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37c87ba2sm10318355ad.33.2026.06.30.03.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:02:26 -0700 (PDT)
Message-ID: <78443e98-2d75-4e02-98f5-6a8f9460679d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:32:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 0/9] firmware: arm_scmi: vendors: Qualcomm Generic
 Vendor Extensions
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, Amir Vajid <amir.vajid@oss.qualcomm.com>,
        Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>
References: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
 <20260616-responsible-junglefowl-of-chaos-7eda7d@sudeepholla>
 <8725caf9-cebb-49ce-b2c8-4960a6073322@oss.qualcomm.com>
 <20260623-busy-beautiful-trout-8cc2ea@sudeepholla>
 <ea9d0c11-e110-4d13-b165-1548875ef9cd@oss.qualcomm.com>
 <20260625-metal-chachalaca-of-fascination-eabc0f@sudeepholla>
Content-Language: en-US
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
In-Reply-To: <20260625-metal-chachalaca-of-fascination-eabc0f@sudeepholla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MCBTYWx0ZWRfX04LeUJFtBZTL
 tYMQQEbtTukgb9TzSb9iyH45FMgRpx+9952eGFuUel502vRALbvovKEA1G1MnagCZd64N79KAQB
 FNM/RwqhanLQHL304qN16rNvPoRCzYQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MCBTYWx0ZWRfX9HZYZvWaNU5l
 Dx7YocLag5/f4gQmFR5j8LmdY41IHNFObolzT8RQWbfddtbHOSfQtBEIY0q0T47zRGgBlGmn/LE
 Y06eLJahUNXjA/9LZBnKgChdf/k6fhFV3gfCDLkkQUbq4+hK6J8FbCCOUhe4zjrtUxD1WDCqQQ3
 XhaXAtMjDpnYSZ8CynP0Iw1WWc0Emdh4PZOHCYVyueBb9CC0mzsTqm7+7H0y4sCnUwcnxN0BWOa
 2mbYZf+RnbHkgn+lyixo8P3fwwxzGOQ3jSuVKsiDvgDSDDRZtGYSaCzfyrd13XjigO7/GjUD8gU
 AwPpfc+yi3dr8Tghwx3YHf3tAN36EB91MnbFeMFKG1diVm0S97wbw5Vvma3CRuJ3XFbkMffxbjP
 x24PSInm01aO+BVCxt0lugNpeN7lCsDmm1yyUShdnkiv1ndkGZzxPhAOZl4fIPzZlFAss7xlx+s
 AIAMFh1Iz94SC/E0GWQ==
X-Proofpoint-ORIG-GUID: 1BczRx2wm1YNPDQZ2MxFPb1R17lRvhWR
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a439435 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=RZRlv3HtSbeCCbZTe5UA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1BczRx2wm1YNPDQZ2MxFPb1R17lRvhWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300090



On 27-Jun-26 7:43 PM, Sudeep Holla wrote:
> On Thu, Jun 25, 2026 at 10:57:40AM +0530, Pragnesh Papaniya wrote:
>>
>>
>> On 23-Jun-26 2:17 PM, Sudeep Holla wrote:
>>> On Fri, Jun 19, 2026 at 06:01:23PM +0530, Pragnesh Papaniya wrote:
>>>>
>>>> On 16-Jun-26 1:57 PM, Sudeep Holla wrote:
>>>>
>>>>> Not sure if it was discussed in the previous versions or not, it would be
>>>>> good if you can capture why some of bus scaling doesn't work with the existing
>>>>> SCMI performance protocol and the monitors don't fit the MPAM mode.
>>>>>
>>>>> Please capture them in 1/9 as a motivation for this vendor protocol. It will
>>>>> then help to understand it better as I am still struggling to. Sorry for that.
>>>>
>>>> Thanks for the input!
>>>>
>>>> SCMI perf protocol exports perf domains to kernel where kernel can set
>>>> the frequency but here the scaling governor runs on the SCP while kernel
>>>> just observes frequency changes made by remote governor.
>>>
>>> OK if it is sort of read-only w.r.t kernel, why not perf domain notifications
>>> work to consume the change done by the SCMI platform.
>>>
>>> And why do you have set operations in the vendor protocol being proposed then.
>>> It all looks like something just cooked up to make things work. I need
>>> detailed reasoning as why the existing perf protocol can't work considering
>>> all the existing notifications in place.
>>
>> Please do take another look at the documentation and driver changes to see
>> how it all comes together, since it's apparent that we use SET operation for
>> a ton of things. Taking another stab at explaining how the MEMLAT uses all
>> the ops exposed by the vendor protocol.
>>
> 
> Sure I will have a look at the documentation again and sorry if I missed
> anything. But in general I would expect the document to be self-explanatory
> and not having to look at the driver on how it is used to understand the
> firmware interface. Please make sure of that if not already.
> 
>> We use the SET operation to pass on various tuneables (IPM CEIL, stall floors,
>> write-back filter, freq-scale params, adaptive low/high freq, sample ms),
>> the core-freq -> mem-freq map, and min/max clamps) required to run the
>> MEMLAT algorithm on the SCP. You might ask why can't we have these values
>> stored somewhere on the SCP itself?
> 
> Exactly, thanks for saving a round trip.
> 
>> We would like to but all of these are tuneable values, that can change for
>> various boards for the same SoC.
>>
> 
> Sure and where do these boards get these values from ? I assume device tree ?
> If so, are the fixed and can be done once at boot ?

There are no memlat tunables in DT (We tried to have in device tree in the earlier
revisions but they introduced unnecessary complexity). They are in kernel structs (see 7/9),
fixed per SoC/board variant and pushed to the SCP exactly once at probe. The driver
walks the selected config, sends the event maps, freq maps, tuneables and min/max
clamps via SET, and then issues START. Any further SET traffic is limited to a sub-set
of tuneables like changing sample_ms, limiting max_freq that the devfreq framework
supports.

> 
>> The START/STOP operations are meant to start/stop the algorithm, in this case
>> the bus scaling algorithm.
>>
> 
> Yes you need to add more details on that algorithm. Can firmware take random
> strings as input. I guess not. Please list the valid strings and explain them.
> Filter invalid strings in the driver if only handful of values are valid.

Thanks, will add a filter that just accepts valid strings in the next re-spin.

> 
>> We use the GET operation to get the current frequency of memory that we
>> are trying to scale. It can be also used to read back all the parameters
>> that we are trying to set. Another thing to note is that exposing the current
>> frequency to the userspace was something that the community wanted.
>>
> 
> More fun, user ABI involved, so the firmware interface needs to be as clear
> as possible.
> 
>> With all of ^^ in mind, re-using the perf protocol becomes impossible.
>>
>> https://lore.kernel.org/lkml/k4lpzxtrq3x6riyv6etxiobn7nbpczf2bp3m4oc752nhjknlit@uo53kbppzim7/
>> https://lore.kernel.org/lkml/20241115003809epcms1p518df149458f3023d33ec6d87a315e8f6@epcms1p5/
>>
> 
> It is good to capture summary of these old discussions if they are relevant.

Ack

Thanks,
Pragnesh

> 
>> We'll add more call flow diagrams as part of the documentation for the next
>> re-spin to make reviews a bit more easier.
>>
> 
> Anything that improves and helps in understanding this is always welcome.
> 


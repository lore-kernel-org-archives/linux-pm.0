Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB94611CF
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104768; cv=none; b=YKg2Mpo19L31ArrGsy+VxAvVmKptyidboy0ph+cu09eFBz2HADONO+AKRWCSBi5TsN/h81/F6U8oN1uYgHXq9S5or1J1uXYTr3udiz2apixaAxpMZ4x24njQ1FT6WqxOvztEAfpxdAyG7bfSgDk4YBOFMH8JUNCgTTey/xbU9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104768; c=relaxed/simple;
	bh=Bv/j3+YwE+jC2BUDvg+NvU+66yI03vLpRhssxggIxF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLq8oEmkiF/YMXwYtdAsHiIA3WFB8rJBPHBZ5rPnwJL55icXTEp6LLZvv+PuJODOB/b5jK2ORjSKJGFNYN0jfFWkOD+8MZ2pIhSpo56xpQtCrLdTcBJWCUJzicEY9fDM//HgtosgbonvfgL5Vl7e4cGOZ11LU7DAPfevlKpkZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euKP463b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jdoS6/Bp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euKP463b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jdoS6/Bp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777o4we3533325
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 12:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y7tni/GvmUJfIzIYK7psJJv8Q+0mTwBTdLTiDBhEsV8=; b=euKP463b2v6x2mgs
	wo4S4c9jAkmSalqftRXbR16ykaJxJrGY55EXK7yaYJN4PgRgD61t+hXC2dsZAbP+
	Cv+5Km/KRpBDq4BjWF+w0e9kWqDmZr9WzyRr18bXZ2KAbh3kIUC1gZ3wD5GZTz5q
	rzHsxSyOIHM2Bdw6gigQvV9cqBWUlT+55nCj7JYYDYBkH4DNOxz7T/EFgDHsBxcs
	ev9VwcPAG8okvi0ZkJ5tYLxrFitYzIeDzEAPXIa5mZzztVMHQEAiwWUTHc538H7T
	92cIHbzM7gYGej0rL7wjcdywVPn1fJBY31JyfOoofMIbyCYG1x41Z9/nupnZCqcf
	EwUnsg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6fuwm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 12:12:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so6933275a91.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786104742; x=1786709542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y7tni/GvmUJfIzIYK7psJJv8Q+0mTwBTdLTiDBhEsV8=;
        b=jdoS6/BpFTbc27/zOY3xoRhis7e/OcYJVpUavq6gUFBP6m5y1FS9ksLqIt77En6kUH
         ckvJu5ULWmN/0MBeDv0pIv95vs4Tm9ja/LdoNNrhGCyUvqIFzmEp0CyG6bQNuMuT2aHa
         O7B0ilMAQHharXzUDB2NSL5jWTKu8p+qTRPEVKKeH6oRTmQKzCghnrl22nXagLGXePw9
         Qn/KTt0qudjtU7Gf/ts/V6nfEQfs1HPh8teIwxFOfqyTnJbWCOYkm2o/1BaBKrilYqX9
         jkE4kcuAFNU52oz25cpkkENGe11OPKSmhuiXNzmaJ4C5+FaSoxTMPX6qgAAvFeumKC7N
         rxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104742; x=1786709542;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7tni/GvmUJfIzIYK7psJJv8Q+0mTwBTdLTiDBhEsV8=;
        b=jwZJI1sFtuXbmBa9hZmQjedoB3e768Zk+pJcQJNCmaSI7WOk6kJ/UqkpEQG6OR8qja
         Vl15M7s75jo7H1zJGN4rw8EL9XbfTUR1lNi/PbJrZ9WPvjzkWEZgh0S2/BHL8t+oNyez
         3yqvCnltdrHQKJzDJ4sgzB2ja5VoYXZhUvW9+AptYJhUl6FWRKCz8vZyeeyxgaOJytkE
         qOGbZfR+JBTj6R5UStzaOPZiezTzmwRHzL4azxRxIf+cioNQv6jtXMeap/SAr7/Aj3Nw
         mWHnn4uMSAhwg2yiHCfSvxpSsH8SpmjvaashNcc35x+uPTwZpsbvhQoQxRl4G43t3mJW
         53mQ==
X-Forwarded-Encrypted: i=1; AHgh+RpT1lOu3Zb/+gEn2yIy5gK9WeivdneqlW7GRi8/qQwgVNplq5VtXCvITKnTNEiT3qoEaM8pNV+SRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysSJPCmgLvjZ9X1fUfGF5YCA2EevJw43OBidT4YnxKsZkdwV03
	Hzen5Ncg1nxIfD9PwtgfBwoiBBTDFnBlPG3PrUC+5DK4zJQdgWvTHw+eY7t1qTeoLcOlIwkIvyJ
	XR0jqA7Ayz4NTOFqTcSX0LiwJEW0iCZZdKjeeb8Vbj4LPFnkK8nZARErPORYwkw==
X-Gm-Gg: AR+sD13/LaNNVp5Bh+kQfJlJx/sDNWEY1lR74seEAOL2Pmt9ViVm8QB9KiRIo9YyARD
	XrliboiYtWTO19Y94fadpbjtRBw3v+j0Y2smEDYI9Txo9YpJxoLuK7Wk6hYxfyuFtEMndMwvEeH
	fbJ5cyLvxFjsOHVf82DILXegXfktOIHUWWiX2mDKHL1hfguEdG1gg3apZ/Qlxnt20pBWBFYP9RO
	5OMFY+aG0jWWfUcOO1OXIigbhppFuUB4jIbjCjbTnyiq4WwAsGq4S8r/jiPTFO0zj/yURNAsw33
	Htr+lLdyN/WOVmkRazBKS49G+iYhboDEU10F1/4gFuIpr6RxmLHGEs0zPbRTl7cM/D9caI036+2
	pA7H2Xr6WLi9GIr5XkYnp2Yk+h9hJS5T+yB2l1JE1SywXDUOwGZCAPedwjdZBZCbX/BKviH2eyP
	fCkBrbPsbouzLffIo5ag==
X-Received: by 2002:a17:90b:134f:b0:38e:488f:7068 with SMTP id 98e67ed59e1d1-39261f729d5mr3901670a91.2.1786104742445;
        Fri, 07 Aug 2026 05:12:22 -0700 (PDT)
X-Received: by 2002:a17:90b:134f:b0:38e:488f:7068 with SMTP id 98e67ed59e1d1-39261f729d5mr3901577a91.2.1786104741939;
        Fri, 07 Aug 2026 05:12:21 -0700 (PDT)
Received: from [10.190.200.255] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm2440884a91.2.2026.08.07.05.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 05:12:21 -0700 (PDT)
Message-ID: <6d19e1e2-d1b3-4f33-8c18-4340edd6c567@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 17:42:14 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: allow cpuinfo max to decrease when boost is
 disabled
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, linux-pm@vger.kernel.org
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
 <35it74zycctxhpnbsuvp6a6aazrjavarhq43fqgruafjv7xkt2@recuceutrqrn>
 <42d9370b-aa10-4382-b6a2-bc441fd2335a@oss.qualcomm.com>
 <zg7bzwbv2svt7llwooeyhojqyjkmqjvjvxd37hjgeggnii4oa4@jaai4hnlpmlc>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <zg7bzwbv2svt7llwooeyhojqyjkmqjvjvxd37hjgeggnii4oa4@jaai4hnlpmlc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfX8uDLddKoltIO
 WonBFBQ1ScXb84ZiQfqEM3xR1FvXLEbpvANgMti3Rg7wjA2RxjtjLD6CIYVG82WifFNZbHM7bRX
 kDN/kycj6E6DYR2ntht4ymq7m5Ko3fr4Z3FEy9/ld1Kp1OrgNJQ4AxlxBrzD5RUB780PqXdDD+K
 zJ1sVnVCanaxI64LJoXoqL7/IWEGEVy4Lyg4f7X1pvMKNRAd576PkKDhl1H2vPhI7BjY05dSLO7
 wUElOAMMsa3/LnBuVahi7tR1BU1OO+VybewHvlUy9uoLM73g67KUQKEKVyV6JP03z4inF0s+heQ
 jtxba33y0806piRa441tRU66FRKpeUzdxpjKtvUjRVNgNULoyTjaiBY4nO4TSDieCsW6Zd/gJ9J
 NOKy372ZhGYao+8gOloQQBsyDyDaxqxg1mAP5lRqJHxrV2rCXnzoNMLWsrujRm7Sp/yfRZJcVnq
 H8ts6yeOB+SFnDW/VdA==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a75cba7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Bw_Xy2VeKd7xRC0kUEoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: QxE-YzY8_n6MQRIQD-v8pYZQBsdyw7uT
X-Proofpoint-GUID: QxE-YzY8_n6MQRIQD-v8pYZQBsdyw7uT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfX3aisHrEPGm2/
 3mM27pfk73BU38WkG4nJ0Pp32cdbdqP7OWABWNnE74jBHVqqfz4Tos3YTFmdoM+hhWSZgL2Thw+
 DSRfeSpE5IeANBmzx8UaJAB3Nf6ZHkQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070095


On 8/6/2026 5:42 PM, Dmitry Baryshkov wrote:
> On Thu, Aug 06, 2026 at 03:41:45PM +0530, Sibi Sankar wrote:
>> On 8/6/2026 2:58 PM, Dmitry Baryshkov wrote:
>>> On Thu, Aug 06, 2026 at 10:12:29AM +0530, Sibi Sankar wrote:
>>>> From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
>>>>
>>>> Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
>>>> if max boost is known") guarded cpuinfo max updates to only allow
>>>> increases, preserving values set directly by drivers above the freq
>>>> table maximum. This prevents cpuinfo max from decreasing on boost
>>>> disable, leaving policy max pinned at the boost ceiling.
>>> Why is this bad?
>> Copy pasting logs shared from the cover letter:
>>
>> # cd /sys/devices/system/cpu/cpufreq/
>> # ls
>> boost  policy0  policy12  policy6
>> # cat boost
>> 0
>> # cat policy6/scaling_max_freq
>> 4454400
>> # echo 1 > boost
>> # cat policy6/scaling_max_freq
>> 4723200
>> # echo 0 > boost
>> # cat policy6/scaling_max_freq
>> 4723200
> How is this different from the maximum frequency being unavailable, for
> example, because of the thermal pressure?

It's certainly different because the maximum frequency is available in this
case. Consider the following scenario where we use the performance
governor with boost disabled -> enabled -> disabled. The governor would
be voting for the max possible frequency, which is the boost frequency even
when boost is explicitly disabled.

# cat boost
0

# cat policy6/scaling_max_freq
4454400

# echo performance > policy6/scaling_governor
# cat policy6/stats/time_in_state
...
4454400 377
4588800 0
4723200 0

# cat policy6/stats/time_in_state
...
4454400 480
4588800 0
4723200 0

# echo 1 > boost
#
#
# cat policy6/stats/time_in_state
...
4454400 951
4588800 0
4723200 200

# echo 0 > boost

# cat policy6/stats/time_in_state
...
4454400 951
4588800 0
4723200 1048

# cat policy6/stats/time_in_state
...
4454400 951
4588800 0
4723200 1115

Shouldn't this behavior be fixed? The boost flag and per-policy boost flag
have no meaning otherwise.

-Sibi

>
>> Currently disabling boost after enabling it is a NOP,
>> scaling_max freq in this case would be pinned to turbo.
>> It will be reachable through various govenors. Also policy
>> specific boost flag is meaningless unless we have means to
>> reduce the scaling_max_freq.
>>
>>>> Remove the guard so cpuinfo max is always derived from the frequency
>>>> table scan. Drivers that correctly flag boost entries are unaffected
>>>> since the scan already excludes them when boost is off.
>>>>
>>>> Fixes: 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known")
>>>> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
>>>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>>>> ---
>>>>    drivers/cpufreq/freq_table.c | 7 +------
>>>>    1 file changed, 1 insertion(+), 6 deletions(-)
>>>>

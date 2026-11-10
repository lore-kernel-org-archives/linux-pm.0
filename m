Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304198;
	b=iRYXroIltg0hsc2IgKq7rWuQShwDubFjJprtcwcfwT5c+t3gvd0szeXfak8lubrEHzeY
	 68ApjtBPzH9t9Y05WlkWqG4P2FR4KVcYrvfsi6xPK81GV55fmjUy6rJXgPZVd8z9+AvrV
	 0rqZzzQP6YjTcXt70mcvtn3xkJ8e0OiFl/0JZdTB2DsEnJPg5bqzNwk9hlOWK6hqFDpJD
	 q0FGQjJ043UAN6MHBFi3hW3nJlD1BJoO+zU6Fhq2NzctGkHajh1Q7tPhNuom7h8TjlknX
	 70Wft553tcmfqESL3gdWPoLnmJvIjYkyiqvYjUib2wOBzqXJK0HOL/aJ5p4MrzK7mfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304198;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3y+sTdFUbt/uQljUyhxFdhCIKZlyrlBK5Yk/ISfLD0o=;
	b=t5K91iyDTRQ0mmQSe2ZLKlTsgcddLFip0VfsvyV8G8yR8UCJRUOvXKag9sfXft8qrBJE
	 RNEMD0IzRDdx/+1CPVh/hU8Fmo9wW2Wj6mzZwBMyPvTXLNrCNn5t/fCBOZQHUH5BPR6rd
	 W6Boy1zr8HwGsAyXOaSgoOA9wLZIApZ0MjMaUavJ2nQTZVufNA/pcDnPnw8ORENCCWh7l
	 W8HQ63zGCWGzQAWM4X8C84GCbnnyaC5ERPuSKkPFGn9eD2l8EpH+eaqjopHyYZLIIE8h+
	 fnOsED6C/qq6rwJeZ9YrsMKtl6AH8XwdFbnKj75VezlDbXybpBjk96tuuAaNohK5/WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hAglhyjb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="kQJU5WK/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB9606BF06
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84EB9606BF06
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hAglhyjb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kQJU5WK/
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7kj9j2779804
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3y+sTdFUbt/uQljUyhxFdhCIKZlyrlBK5Yk/ISfLD0o=; b=hAglhyjbR2WEJdBt
	ZR/CDPRhVJaEv/OX6ZrMDlwlsULdY/DXOdvBHnZkXtwhKSv3dklvWzLTnu2ACsg6
	65IcBTegkXuw5IUm/10ODGX//18V+aD0nY4BZZE00ZR8/IhR+2IJZnA98FEFxVSZ
	PvXGwg3Ddyd475rgL5RLGfZsU63TCCo6hplmXWomFoqmIOtM1xQkcLHLvQzHnPR2
	tbDoDp9rKNcrTdcQ19EIa9ZkEs+dNVB4Udg/+9IYGJQ/I2qaYAuX6DD5HJfpovJd
	N8dgdP9ogQiYxjjrmjQe54PQLPRwyLh3Siv90Prcux8nc+oFASdQxYrbvkZxKANG
	LOTgHw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d8fv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:49:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd66551e02cso2146780a12.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794304196; x=1794908996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3y+sTdFUbt/uQljUyhxFdhCIKZlyrlBK5Yk/ISfLD0o=;
        b=kQJU5WK/NhNnatNvjfbCzHj7+q6P3MarceXZ/X3gk3OvIdiKpUWVzG7F09hbePCMzi
         FLsST48oVaRi14lITk/RvIDfy5+P0Cyukzek4TJr+etAhr9ZBbbP/r/W+Vz4vjmn23Qj
         0ixF6GuuQiOYemCYDv8etnkZLsCxgUVdGk0eHXYBMshhB3/7FSyS/IYZ3glV7Tc3XLLJ
         BaEHkOJZN/xVNnYpUB/h1V0z5yT2HkPIey8+pXEf4GEnVx1HWVSKL7sT98fWBN7pQeMO
         vuBMf51Jn45Qn+INsoh7dys+GX22CgXhQDFigyc8jdiLYR0nr8U3DiTESIJKBHt/xlgS
         JfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304196; x=1794908996;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3y+sTdFUbt/uQljUyhxFdhCIKZlyrlBK5Yk/ISfLD0o=;
        b=hNhfb+4Z5t4Snl8Yy2Jt261Bj92ZlqyviNvSNHDB5WjB4/BqUQjrKJjVlWrYylOF9S
         PFTPyVlq/e6ptXIMm/9yg8s8QEoiNbd1KYFv/HFUurb2FrQKdmU4ZsoQMMsqi4EsIiG5
         0WGn5FoMnbBfSnKzwqkRB2ApMgzJG0vb5NAsxplIuIn3G6SUaZ8QlcJ4h4CDBej30fjk
         EmuxtoJVMINRsrQixLdRZYKLA2cn83WjzejhYIUVg1R2eDSjQ2g+N10fofGRq23hi5xs
         EGygN0uVwwxXO9I603PBxZEHdDKeZmkju8IdLekBLnMXjfGDT2UfQ2ero1hADK9H40PV
         FDdw==
X-Forwarded-Encrypted: i=1; AL+hErGuITCs2QX3zriMK92zCNTRbSwfVlokTVndIPNCnWkC6zfJyD3AC5x6lUWoYb7vxLZ++0AasB+JFw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/CaAc0sTGMSWo1iJFW6TT3zw+VyOK44cCNpUdVlETu/kXYTUfH
	xlPhLVFiRQxIAoGaLEiXeZN1uzrKVnkZK+LZDEjjNcIT/BkjXDDDagX5mAaq1w+97b9hkovQUGh
	CVnnk9ln9GqGVShN4MZ9AMIXVjsUHGq/d6MS/gfU26a5yrs1vJYxEVn+IBxaZhw==
X-Gm-Gg: AYBFou0Mj59YWOaRICkbQQf958Hjf2j7bc0xLRsNmcuzTuthhvjfxc6YbUYZVMLj1VO
	ITZVPDKnvlKTAlU4P6l4eqCWmw7378eWwkGE6HUt4G3j3Y8kT9uyJI+Gi6nsWKNdTW9DLU9VqJn
	IG/VFp4b9eMcAAKpujSuA1uCioFSlKQD8rV5ndqR5AAf2RaVQxuJWd68o1NvCg4Pa6w6VqyxC1q
	UIt5lJRAqzn+HguY5h7NvEdmJSu/5tJfRkmGmI2aZxsYNG3l3UXwoDSfoawMxc70nI28BR3qIzn
	eP85gQboB8D2BA+eXjgKB6m3aldLRFksMVGMzz50oErtSux/NefdgvR9nF74FSObvOwpdQRsKml
	A53NM7BXaVoglLWyPPlgrFt2lP6sQVuj0/rbi98wyV+16wz+eeGIhxnKYX+F9yJUJejk8tgk=
X-Received: by 2002:a17:90b:4e86:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3b166cb9a9emr2260500a91.1.1794304195808;
        Tue, 10 Nov 2026 01:49:55 -0800 (PST)
X-Received: by 2002:a17:90b:4e86:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3b166cb9a9emr2260483a91.1.1794304195253;
        Tue, 10 Nov 2026 01:49:55 -0800 (PST)
Received: from [10.64.69.121] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676d83absm3212483a91.7.2026.11.10.01.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:49:54 -0800 (PST)
Message-ID: <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 17:49:47 +0800
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
Subject: Re: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency
 ranking
To: Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, xin.liu@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, tengfei.fan@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
 <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com>
 <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
Content-Language: en-US
From: Guo Chen <guo.chen@oss.qualcomm.com>
In-Reply-To: <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VmDwKZ6cjgMiX--Z5Pyj7ui-Zhdgn-lL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX3wV4ZdfR6tWq
 HPb6lE9xeAqtonXhPv+Rvlqdc9qq/JVWlBFnGQ+2AOzqcBf/+EEZFXx3VG69RPx1K1fnpHMhLnm
 KjcLr8ven4aOiT/Z0pKHd2gwTh0B0VA=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af2e8c4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SYcPWxKpZSGen2qkHQYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: VmDwKZ6cjgMiX--Z5Pyj7ui-Zhdgn-lL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX6UENqyO7fZbg
 yXpYi8OOvUWfy3nUfVK+wGlH3Wfd+iPNQ2bXB9R3v6j1ZUt2d8d/FV8f0T+Pwexs4yX4MRUNlIt
 rbZZ+eVRf4LQXTdR6rY3kcK1eMjBJ5orB6PslnRKSkqWGmbEXDn6iriNIEJvi8xSJPX5zb/aqEb
 wEa/LkNKqU0ukvNjsCLJg+IkZPj30GzfveAKoHD1w0vag8Sab8J066Ve8tGTFOtZmxXkca9Cmf1
 J8qqi7nDttq14s7bDcUZI7qroyM3fXWmvLXXQAxKgXeaSV2fTVDHAMmXbtoGH+p9xLoix2NV6IZ
 xlIrw/jmtRg0C+x5D0hN2vaWsfEGEmdi5JHoYtDQG3zVPOo8oSv0WmMRbCB68uIbCJAJXuitxu3
 m6fMspY7opkHjsfQ9ELpe6NGJd3KQJAtB/2HqDcf6xkAtFBFAUN+uitr/r/D0YEw1XAzkbomWy8
 RrukyawoCpkwI2E2L5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100039


On 11/9/2026 5:40 PM, Lukasz Luba wrote:
>
>
> On 11/9/26 06:47, Guo Chen wrote:
>>
>> On 11/6/2026 11:15 PM, Rafael J. Wysocki (Intel) wrote:
>>> On Tue, Nov 3, 2026 at 12:21 PM Guo Chen <guo.chen@oss.qualcomm.com> 
>>> wrote:
>>>> em_compute_costs() ranks all the frequencies of the table, boost ones
>>>> included. A non-boost frequency can be marked inefficient only because
>>>> a faster boost frequency has a lower or equal cost, e.g.
>>>>
>>>>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
>>>>
>>>> With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
>>>> skipped by governors rounding down to efficient frequencies (e.g.
>>>> ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
>>>> the best selectable frequency. Several frequencies can be affected.
>>>>
>>>> Exclude the boost frequencies from the ranking in 
>>>> em_compute_costs() and
>>>> keep them all efficient, using the highest non-boost frequency of the
>>>> CPUFreq table, returned by the new helper
>>>> cpufreq_table_max_nonboost_freq(), as the boundary.
>>>>
>>>> Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
>>>> Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
>>> Please see Sashiko's feedback regarding this patch
>>>
>>> https://sashiko.dev/#/patchset/20261103-em-rank-boost-separately- 
>>> v2-1-5a13d1b38d37%40oss.qualcomm.com
>>>
>>> and tell me what you think about it.
>>>
>>> Thanks!
>>
>> Thanks for the review.
>>
>> I did consider this case. If no policy is found, max_nonboost stays 0 
>> and
>> the new logic is bypassed, i.e. the ranking falls back to the old
>> behaviour, which looked like the least intrusive option. I also thought
>> about warning and returning an error, but most of the in-tree callers of
>> em_recalc_and_update() ignore the return value (e.g.
>> em_adjust_new_capacity() and exynos_asv_update_opps()), so the update 
>> would
>> just be dropped without anyone noticing.
>>
>>>> ---
>>>> Changes in v2:
>>>> - Drop prev_boost and keep all boost states efficient by resetting
>>>>    prev_cost for them, as suggested by Lukasz. Boost states are no
>>>>    longer ranked against each other.
>>>> - Retitle the patch to match the new behaviour (was "Rank boost and
>>>>    non-boost frequencies separately") and reword the commit message.
>>>>
>>>> Link to v1: https://lore.kernel.org/all/20261030-em-rank-boost- 
>>>> separately-v1-1-238a6b2bb888@oss.qualcomm.com/
>>>> ---
>>>>   include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
>>>>   kernel/power/energy_model.c | 16 ++++++++++++++++
>>>>   2 files changed, 40 insertions(+)
>>>>
>>>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>>>> index d3d0d9d02aa4..c93316141a11 100644
>>>> --- a/include/linux/cpufreq.h
>>>> +++ b/include/linux/cpufreq.h
>>>> @@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct 
>>>> cpufreq_policy *policy,
>>>>          return -EINVAL;
>>>>   }
>>>>
>>>> +static inline unsigned int
>>>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>>>> +{
>>>> +       struct cpufreq_frequency_table *pos;
>>>> +       unsigned int max = 0;
>>>> +
>>>> +       if (!policy->freq_table)
>>>> +               return 0;
>>>> +
>>>> +       /* The table may be unsorted, scan all of it for the 
>>>> highest one. */
>>>> +       cpufreq_for_each_valid_entry(pos, policy->freq_table) {
>>>> +               if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos- 
>>>> >frequency > max)
>>>> +                       max = pos->frequency;
>>>> +       }
>>>> +
>>>> +       return max;
>>>> +}
>>>> +
>>>>   static inline int parse_perf_domain(int cpu, const char *list_name,
>>>>                                      const char *cell_name,
>>>>                                      struct of_phandle_args *args)
>>>> @@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct 
>>>> cpufreq_policy *policy,
>>>>          return -EINVAL;
>>>>   }
>>>>
>>>> +static inline unsigned int
>>>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>>>> +{
>>>> +       return 0;
>>>> +}
>>>> +
>>>>   static inline int of_perf_domain_get_sharing_cpumask(int pcpu, 
>>>> const char *list_name,
>>>>                                                       const char 
>>>> *cell_name, struct cpumask *cpumask,
>>>>                                                       struct 
>>>> of_phandle_args *pargs)
>>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>>> index d19a65461ae8..5b1d095fd376 100644
>>>> --- a/kernel/power/energy_model.c
>>>> +++ b/kernel/power/energy_model.c
>>>> @@ -255,15 +255,24 @@ static int em_compute_costs(struct device 
>>>> *dev, struct em_perf_state *table,
>>>>                              unsigned long flags)
>>>>   {
>>>>          unsigned long prev_cost = ULONG_MAX;
>>>> +       struct cpufreq_policy *policy;
>>>> +       unsigned int max_nonboost = 0;
>>>>          int i, ret;
>>>>
>>>>          /* This is needed only for CPUs and EAS skip other devices */
>>>>          if (!_is_cpu_device(dev))
>>>>                  return 0;
>>>>
>>>> +       policy = cpufreq_cpu_get(dev->id);
>>>> +       if (policy) {
>>>> +               max_nonboost = 
>>>> cpufreq_table_max_nonboost_freq(policy);
>>>> +               cpufreq_cpu_put(policy);
>>>> +       }
>>>> +
>>
>> The lookup can be made more robust though: on the update paths 
>> dev->id may
>> be offline while other CPUs of the performance domain are online. In 
>> v3, if
>> dev->id has no policy and the performance domain already exists, I 
>> will use
>> an active CPU of the performance domain instead, as
>> em_cpufreq_update_efficiencies() does, and only warn and fall back to 
>> the
>> old behaviour if that fails as well.
>>
>> I did not use the performance domain for every lookup because at
>> registration time dev->em_pd is not assigned yet (it is set after
>> em_create_perf_table() has returned):
>>
>> policy = cpufreq_cpu_get(dev->id);
>> if (!policy && dev->em_pd) {
>>      cpu = cpumask_first_and(em_span_cpus(dev->em_pd), cpu_active_mask);
>>      if (cpu < nr_cpu_ids)
>>          policy = cpufreq_cpu_get(cpu);
>> }
>>
>> if (policy) {
>>      max_nonboost = cpufreq_table_max_nonboost_freq(policy);
>>      cpufreq_cpu_put(policy);
>>   } else {
>>      dev_warn(dev, "EM: no CPUFreq policy, boost states are "
>>                          "not excluded from the ranking\n");
>> }
>>
>> This makes it much less likely to miss the policy, but cannot rule it 
>> out:
>> the CPU can still go offline between picking it and calling
>> cpufreq_cpu_get(). em_cpufreq_update_efficiencies() has the same
>> limitation.
>>
>> Would that work for you?
> I also thought about that possible racy corner case, where
> CPU can go offline (or already be offline). Although, in current
> usage this should be OK, since we do this in boot phase and
> platforms are sane.
>
> We can can add that step with 'cpu_active_mask' to play safe,
> but no hard promises it would be atomic.
>
> The warning also would help, for bring-up phase, so engineers would
> notice it and address the racy hot-plug booting system when it's there.

Thanks Lukasz,

I’ll add the 'cpu_active_mask' check and the warning in v3. As the
overall approach is unchanged, I’ll keep your reviewed-by.
Please let me know if you’d rather have it removed.

Thanks,
Guo


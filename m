Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D141DE08
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042335; cv=none; b=oa0IdoO+uSA47GLTA9rhMSypIL/MwxHlPbEXwfFDWycoPUH0gFJPVqVyYFGU3wc2eDIo4ZssTRgFqV5RBIrPevQGFQ+yCOsfgzRlL1VAtIn4QoIn+kki2jbcw/c9HbWduJHzLlaupLuluyCtB/1IciFIKGN5N7Ll1MTHtR7ARII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042335; c=relaxed/simple;
	bh=10C+aKkndvTFwjX2ouUKHjE0IojdR2l9XxRR/+V6Onk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ea/J2t9PejD/qpOntHbVvlg50oD+rpJyDK5CV0nINSiIef6GxTwpnlP9EK3SHeEyjJgTFrnjf9wb5mQ2LYfx0rpqmvAPriklCVqqKGgL6EMZT8xfz6DlatdKPGjaGBEVGqdrZbPDMefaZoBrKe93KKmDrkqVP8VqKi1KlQZ92I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G2SnlebW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jiYl1uhF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G2SnlebW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jiYl1uhF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BLsJ310051
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 08:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dLREtGWTkSUjn29exUK1OZ2N4OeeZT3AxstfVt1QzL4=; b=G2SnlebWQFAfqrBg
	MIWuVmTjzzbvVrcxU8L1W9tLHSRXllDFerL6wnMJZ85+SdeKajwlHIKuw4NVudTP
	5ZC0ilbhyXHoFEo6NhiJIVBKhqLx/Gztk2ZQWSWRBkQAGdiqMoPX8qMoj+qXXvoD
	q+5Q/bdwoMfb7weXIOev2UxBcQstbEicMKUg5e1TZVjKjMuyYA1Sf6bCu/8shSRb
	3/E3m7Nw3bgLJ63opTOEHACXXLZV0dlhPH3p4YknjWhWv+sh4DkMlXwLr/lw7GzB
	UA3EVkyeuLpxFQU11+FwHZZv/l0qUEPldTnYNXoqS4HDTrU8w9bn2U8hRvyLfsVp
	DfxOsA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fba99d0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 08:38:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso5172248a91.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787042332; x=1787647132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dLREtGWTkSUjn29exUK1OZ2N4OeeZT3AxstfVt1QzL4=;
        b=jiYl1uhFk2zi9zsvhzxCKa3bv9enulcHbei2chbGz3T57uV7++AAW+s9FLLsIbqmZ6
         Qjq+GwKjp9f8PokTEPQaihascnB4vbgosWMn9YDS50Xodfwek/oMKkk/loLI3+5t8t4I
         VG8wBs16a95RgcVFN7Pgdo8tPUluk4Yxtc3kvMAcuoHPvlU9ELuqP13vhxz2fwpBKJLw
         jTrJ9v/WdgZGwrqAVvJjV9hdxesGBbvlZyQdqgZufLpxZdGWFBZmRlfSrkMnUhYC1Fvd
         3nez2FjVaYSHxDIIAaxixug+J+/b1GrGij/ZzgyY7eMrxqWyj2JW04vZbd9/Fv0dD+XS
         ldRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042332; x=1787647132;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dLREtGWTkSUjn29exUK1OZ2N4OeeZT3AxstfVt1QzL4=;
        b=BSRdY4YRHYlZ3HqNzvi0VOOoJElIAGzYwb7lDPgjtFkIaIxXUSGMwRoQY5ADgT34iZ
         aFzY+8k/yxGtbwFWG84eqmKsNkgXmLnlkRWnUpK5W9ZQc5i8ec8LubQZunhnRfgLo2VC
         c/sU1TcVQbHi+8PdLPSRC0nTmGPAbMRAYaCgG+kdpWgy3vsbRwaLugLPMO+azPoZqUW8
         jeaBC34qQfxHDsmC0tOJz8pnryEltUrMT9kfGyk387t+wC9Hz2T7AoBn28VmNxxbiAgl
         JN/qe9IAuc8CMpIfJcL+5c8lQQxjnMBtjSYrYMeUzj8lM7jwFEhGsAQULhepJbnmJ+fe
         2bzA==
X-Forwarded-Encrypted: i=1; AHgh+Rpgv/rDlDhEHle6hc96PMpON0E0qN0/1+qFEE0qvfxABU6uj9ao6jqZcVw6QBo8Zf+4juowtRsqNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMBv2s/i/jFtsnGczZQTVyiwxZ3F2SV+xd/SAoZS/H+fxGCoY
	4IQ6fDzJrv2CoI4yPACmUn2QSwNNbeKCHK1gKEk1LGFD+WF02qkUXrlCtmRZLVeC/9tfHzVaW93
	aB15gaHTSD53AlZA+c78vRQQOvxL20V6+XX3xBJ675oOElE8lRbmTZiBcVpcZiraPQ7yi9d7m
X-Gm-Gg: AR+sD12AqWVJSW2A/Eh8O5djjtAUIC662sPf0V4rL3jvilB4mkXLMXIgejtDheAsunP
	jjKmbQySZG+zuW9Gh+eQA7LwH2KLwBT6osHu3FruVNBp9nraxlc4nkaNLo+dZej2J5qrlqH50aS
	O3TnFQXTJEi7L9H6zMhGAxo9Hc/Ajem7OAEjQ2pE1+ZMnzuUAiKH6rbhFTisiM86TtC9xKq9NFt
	DPWNRUAiN8e57HqCIar1A2da6yG8W7JdYprkeENacql4lR2zzyn16M52fdpUG9NIuHDAF9kVUXp
	joEiL32HTtHCUgQRDaHHEM+IgJi/4nP6atsi+b4TFxjAyVYGm8iQqRVjx6RFOHTIlAyFTLY3YbL
	j/7hWGBkOO67OsU5cZ0RQy2QdpT4v
X-Received: by 2002:a17:90b:3842:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3933b89a285mr27085466a91.13.1787042332061;
        Tue, 18 Aug 2026 01:38:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3842:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3933b89a285mr27085430a91.13.1787042331483;
        Tue, 18 Aug 2026 01:38:51 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b71e1f9sm5281522a91.3.2026.08.18.01.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 01:38:50 -0700 (PDT)
Message-ID: <95d8a7fc-1167-4cba-b3ca-9d88e9f0f165@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 16:38:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQQVRDSCB2MiAx?=
 =?UTF-8?Q?/2=5D_cpufreq=3A_acpi-cpufreq=3A_fix_P-state_index_mismatch_in_ex?=
 =?UTF-8?Q?tract=5Fio=28=29?=
To: "Li,Rongqing" <lirongqing@baidu.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260813090145.2450-1-lirongqing@baidu.com>
 <20260813090145.2450-2-lirongqing@baidu.com>
 <a647d4a0-d713-4e73-8b16-b73dd3b35ce4@oss.qualcomm.com>
 <6c7fc9bf3fb54d94893b0de76dfa2897@baidu.com>
Content-Language: en-US
Cc: zhongqiu.han@oss.qualcomm.com
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <6c7fc9bf3fb54d94893b0de76dfa2897@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2MyBTYWx0ZWRfX28jR8+747sP6
 d77KfPlVlzAl8WxAri8r53SK03UVkl2Pl/V4cQHkqaDCWMkOuXC4CI2LwcR0BsvvA2wyH1WHm6y
 0Wz8ayXoFxUL4am48h+afG4PqWMr3YY=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a841a1c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=zuLzuavZAAAA:8 a=IrGDMXkZbe6EnHNMZBoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 8s0oymFW6JFLVPpiZc4g4u4Hs2BVy-j8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2MyBTYWx0ZWRfX2BAvyHlgOsf0
 lI/p7Babs4gRzWJNP98EeyVs3/Mxn8gsp+RXE+St1e08rQFo4gCdghk3eZ4AO+ANldTMNMlRr2v
 QIQ9vuIxgrbN2qDBo/QhSk0A6cFJ8zaUSADyCXbSU6tX9eVpkBwpcq62i8eVNQ9tF3XltqiKUS3
 Wdw6hTt/uw5hVvVpyDKjTs54VmJ1DJHPBFyZ9tFND2U78xEtsPTEzBYlI47vH+TtRq8gMah2/tH
 NHDDIWQJeqDWOW5O6JdzLqIFSwPMe2EnDLVEKpqXRXhKZxlshQOkZ8IScSs3syFla8vJ4ZjzJnD
 mgc82VamA8LLx252WiNn7EGYVlzyocE1GjjEK1Nkp8P+7PORmvN4dy3gAlTSvbviL1aUyC+UoLR
 siHEPdX9dlL+DYwoUzNdQr22kFZ1YFjE54MFJ7yddshrfZAgUyf3xQg4bsk0FQRhhz4xyAiAyIB
 J25G7kxuob/5x+1rHkg==
X-Proofpoint-GUID: 8s0oymFW6JFLVPpiZc4g4u4Hs2BVy-j8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180063

On 8/18/2026 2:46 PM, Li,Rongqing wrote:
>>> When policy->freq_table is built in acpi_cpufreq_cpu_init(), entries
>>> with duplicate frequencies are skipped. The original P-state index for
>>> each remaining entry is stored in freq_table[].driver_data, so the
>>> index space of freq_table no longer matches perf->states[].
>>>
>>> extract_io() walks perf->states[] with index i and uses the same i to
>>> index policy->freq_table[i]. This causes two problems when duplicate
>>> frequencies exist:
>>>
>>>     - Returning the frequency of the wrong P-state
>>>     - Returning 0 from a zeroed tail entry, or even CPUFREQ_TABLE_END
>>>       (~1u) reported as 0xfffffffe kHz
>>
>> AFAICT, It may be worth expanding the changelog to cover the consequences
>> described below , particularly the resulting divergence between the hardware
>> state and the cpufreq core's view of the current
>> frequency:
>>
>> Furthermore, extract_io() is only reachable on ACPI_ADR_SPACE_SYSTEM_IO
>> platforms, where cpufreq_driver->get is not installed, so its only caller in
>> practice is check_freqs(), i.e. only when the acpi_pstate_strict module
>> parameter is set.
>>
>> There, the mismatched lookup makes the frequency comparison fail even
>> though drv_write() has already switched the hardware to the requested P-state.
>> So check_freqs() sleeps through all 100 iterations - at least
>> ~1 ms of usleep_range() plus 100 cross-CPU calls and I/O port reads, all with
>> policy->rwsem held - and ->target_index() returns -EAGAIN. perf
>> ->state is therefore left at its previous value while the hardware sits
>> at the new one.
>>
>> The core then restores policy->cur to the old frequency, and because
>> __cpufreq_driver_target() returns early when the requested frequency equals
>> policy->cur, the driver is not called again for it - so the control register is not
>> rewritten and the CPU is left running at a frequency the core does not know
>> about.
>>
>>
>>>
>>> Fix it by walking policy->freq_table with cpufreq_for_each_entry() and
>>> using perf->states[pos->driver_data].status, aligning with extract_msr().
>>>
>>> Fixes: 8cee1eed8e78 ("cpufreq: ACPI: Remove freq_table from
>>> acpi_cpufreq_data")
>>
>> The real tag should be fe27cb358835 ("[CPUFREQ][2/8] acpi:
>> reorganize code to make MSR support addition easier")
>>
>> That commit added both the entry-skipping loop with the freq_table[].index
>> (now .driver_data) back-pointer, which is what makes the two indices diverge,
>> and the faulty lookup itself -- back then in a function called extract_freq().
>> dde9f7ba60ad ("[CPUFREQ][3/8] acpi
>> cpufreq: Pull in MSR based transition support") merely renamed it to
>> extract_io().
>>
> 
> Thanks, I will send v3

Thanks, I will review the patch v2 2/2

> 
> [Li,Rongqing]
> 
> 
>>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> ---
>>>    drivers/cpufreq/acpi-cpufreq.c | 9 ++++-----
>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/acpi-cpufreq.c
>>> b/drivers/cpufreq/acpi-cpufreq.c index 21639d9..1abe9ab 100644
>>> --- a/drivers/cpufreq/acpi-cpufreq.c
>>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>>> @@ -197,14 +197,13 @@ static unsigned extract_io(struct cpufreq_policy
>> *policy, u32 value)
>>>    {
>>>    	struct acpi_cpufreq_data *data = policy->driver_data;
>>>    	struct acpi_processor_performance *perf;
>>> -	int i;
>>> +	struct cpufreq_frequency_table *pos;
>>>
>>>    	perf = to_perf_data(data);
>>>
>>> -	for (i = 0; i < perf->state_count; i++) {
>>> -		if (value == perf->states[i].status)
>>> -			return policy->freq_table[i].frequency;
>>> -	}
>>> +	cpufreq_for_each_entry(pos, policy->freq_table)
>>> +		if (value == perf->states[pos->driver_data].status)
>>> +			return pos->frequency;
>>>    	return 0;
>>>    }
>>>
>>
>>
>> --
>> Thx and BRs,
>> Zhongqiu Han
> 


-- 
Thx and BRs,
Zhongqiu Han

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F546F4BA
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061733; cv=none; b=hYHQ4XZmchUUBGVhVwJRMeB+owN0myyg/+XnN6iYfADmXbPWhcMy2eMOo6sdzrwPe2BEJVTEEZXFWw0yN7ca9AkG5X0oy24Sldtg8lgVjnzNErPuaB1Eia9Ln6sbInq61z9KTYaTI7U3FpXWEentenYCQtqhOh8a+JxVmMmIDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061733; c=relaxed/simple;
	bh=DwUVuRwHOJTsEd3DRBGJhrr6cUow6j5B4EKLAGQ3E5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cpfjWCR5U2gnpcefkR9sDDvuueTJVTJpdsQu0AcEe/Rq+o36m1TQWvPENeLocmKuU4PYIok1ZKupaEqBLyN2crvc79xq2q0PySTR3K9b+6PwPV5Lyqa+hTWhJ3JzqySKM9lQ3JvZ70C1676XzT9r8c3zbIFTunHQ/lTTHhvUid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GualRUdx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TYIbJ1Fw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GualRUdx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TYIbJ1Fw"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE0beY1018026
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 14:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9aeg2Ak7/PdZfiAygJajCowLTFOpdaB3SSBCSFyjfA8=; b=GualRUdxu0DZJg+z
	KDrkpAl89LktmUDiWwfLFrLauV4tyH6C+gSrnlwigdswUQx4x7s0QpkbBAP+R3wV
	4P381tWJ+yYJ96i+FB/rB8QIeAkaCK3x2858Ubp35l1mX7RwWc9KMQ8ASMBlSwLZ
	/NL1CLSlUrVE+AogDuAO73jQuiI9OUs672d4EjsH0RiMdxBKZui0+ZlWaTfR4V7+
	HE4B58HFbZAlQirxzTntys1nFEsT8LBbcbPwHAxMXewpSXrh4MsKxls/ZDbipeFO
	1h6K2s4f43msfFq9Y6EZ1avC9tf/kKnlXvZgVQPBbm8oTk6umETc27zFIo9RCGts
	y5Gc3Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj08bp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 14:02:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso4315295a91.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787061730; x=1787666530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9aeg2Ak7/PdZfiAygJajCowLTFOpdaB3SSBCSFyjfA8=;
        b=TYIbJ1FwDYl3P/W8kEK5tWA/bw68KEXsPgSsqveuaPr87zk9k3qEfNiKuOdKIfMWsw
         YIy7fZyOhvMo79pVTlW9e3QtdOrw36V5PDZ28Ti+yIgUebHQTqzGt4lur5e4PNqvQpyD
         HO7bpyvfaY0vbIR+gBkpRd9kiwmeDWaM7qljFrXv58hij9IeGMHH1ZAEyM0UeVYWxKqV
         k0Y/Wyl6WEKn+SyYcuH/xcNKhCZOCnQgb0EGXa+rijUziaUjiLSwlLSz94NSrd7H+QL/
         ztlG2dDYWGDcue/qaUs2KMwAqOjODhMZaqKUe5Rlac5nTrDhFSJrT7NtRcyQeK+KmT3k
         HfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787061730; x=1787666530;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9aeg2Ak7/PdZfiAygJajCowLTFOpdaB3SSBCSFyjfA8=;
        b=BXQ+mYPZsVoCEv2srOdaJBxTWpkZt3GB53xdRL31H92G5GGOH6iQwOv3K++y8mXQTC
         O9pbDtf/tvlcWmQ+yv72rIJYzxBR3j3OPsNLTByEdtfUGrYngcc602DfMIy0B3MYSLa+
         IIUuf+pIre720asq8MyI/V4eYNSc8EQlGqNIQ2lFr/7YcPW6RmoS7XE0jUFztrz/Wf/e
         kWnR4L5mMhCqB9Osx0wfRsHm1vfSBeOjPrxHBg1eofHZb7UUj5HaAA4MHJn06aYVYVhv
         pp9kcLiO95+MMxoCzCGVz6NqKSX56TU+PH1f0LIVGCP1M3P2Y0fmfhXfTKqtkTJcMZQ/
         IrCg==
X-Forwarded-Encrypted: i=1; AHgh+RrTYKKq8jbdsdsspr+sX9NgJuTTI84OVIaEaUGdXCCzc8EAelgfkm5mapbd69Sk0esyQhDjGs81HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXCiBtJS0fyqCY+OyjSZdGbOMvroO+RnKok3P0shsJD0b/8pS
	5hym2zFA6HFaQUpErDBJNsop9uPMd3DmTDm4O6zg1WMFIr9jMtZRjpauCipOfx/kFb7F8nN3I10
	Huv/CwnBCNyXyRoEXhqC2hgFGcVs0i9H7lNrz8il3WIlhb0avQyYPDW8u00puGQ==
X-Gm-Gg: AR+sD11dGA7qdT7qcmEMo1lBOEiuyJBcsOCbbyKmusaxvGStMi013o9kOqjel96xUPU
	xfmFnnoE3Ajyr4vH3ICCedG+RriINNLYwf8S2x+2LvO0uhW3l21hHFu8MwrhExMWKE/BRS6yiFZ
	pZuuIlMbGYTz2Q4TXmbu7SdpVkH3lHYvzaqNny1TUK+EEmbIWxtzPEfic5XUwdzNFjTnTHSgB2a
	sNcuLSFgb9PXNG4JmlHk1Jl66nmFkS/J64BFQhK2+p9IAgtJMv/YlWqAJSo9B8dCEQM6isJ8ujH
	ZiIVGNk7giPPi/XwS5Eimwq/y/dAJ/mmCz1bw9j/7r9hozjsxnasSaIl024kqy0GrnVLszjwY+U
	nrlPTBI2g9d5caLV+i+bQ99C1HWcQ
X-Received: by 2002:a17:90b:4a4d:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3955a7dfc5cmr9381336a91.15.1787061730009;
        Tue, 18 Aug 2026 07:02:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4d:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3955a7dfc5cmr9380991a91.15.1787061728309;
        Tue, 18 Aug 2026 07:02:08 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e8csm18269895ad.2.2026.08.18.07.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 07:02:07 -0700 (PDT)
Message-ID: <3b1d40a0-1cc4-4974-ae1e-db5097147e05@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 22:02:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: acpi-cpufreq: fix P-state index mismatch
 in get_cur_freq_on_cpu()
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813090145.2450-1-lirongqing@baidu.com>
 <20260813090145.2450-3-lirongqing@baidu.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: zhongqiu.han@oss.qualcomm.com
In-Reply-To: <20260813090145.2450-3-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMyBTYWx0ZWRfX85Pmb4sI/euZ
 XrFxqW5xkPqCNz5NxgQzmZy/DgAvgti3QcYD98RvEkxpURCnivXaHz1vXt6O1uqcdx1r12x4oeO
 Wrb5LbjXjZAcPnQYpBVGMEDRbxUFeiA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMyBTYWx0ZWRfXzGyJ42d5Fuma
 EB0+fdpLGrWxm0qQtN5RDn8QurGEpsz+oNUGTxFmklYz6f2cdrXDMZprmbteTjPBHES+UWK7ucC
 niZ+v2GtXNLaifB7ZY39PPQd+8ktizrEnnV7FA5IsyNxb94J4B2cTAbbI7RjLOPxSa80Qc6QxXF
 Z4Zt/ZpSYWYgoHRVL1Ew/RVrsF0v8dJ1fmTL7sSmMATwN4Nd8pM3STOWe3ipKucfaMmS/HIsTRp
 9dTHldcnv4CBvAHGV8rzlfXSCBQviM7BX6C0HL5mZ4u7y2ufisy7OqRpKO5Du3tYgv2Z4ERNCc+
 xZUgysLui2u9zw+LG8tKHz7vQ2es3XLgiQqMJg/DzzWjgHXOZHk2cyfSxuvQva3wyG2aoy4BYgm
 n9OwsTStw6rH2demPvwv/C0qZZnscvKUMBQgA/XdPf1iD0wO6gzid5KKJ4Bk0Q5JTUupkwaek5j
 bS8T5HV2clOEJnN16aw==
X-Proofpoint-ORIG-GUID: slpj6zItAO8TMqpPZAXX4SKN7meHnbPQ
X-Proofpoint-GUID: slpj6zItAO8TMqpPZAXX4SKN7meHnbPQ
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a8465e2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=zuLzuavZAAAA:8 a=EUspDBNiAAAA:8 a=zAfyxCN1MwA0JvTlyxUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180103

On 8/13/2026 5:01 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> get_cur_freq_on_cpu() reads the cached frequency as
> policy->freq_table[to_perf_data(data)->state], mixing two different index
> spaces: perf->state indexes perf->states[], while policy->freq_table[] is
> built with duplicate frequencies removed and stores the original P-state
> index in freq_table[].driver_data.
> 
> Once any _PSS entry has been skipped the two arrays no longer line up, so
> the cached frequency used to detect a "BIOS changed frequency behind our
> back" event could be taken from the wrong table slot.

A further consequence of this index-space mismatch should be that,
depending on which entry is picked, the check either fails on every call
for P-states whose freq_table index differs from their _PSS index,
causing data->resume to force a redundant control-register rewrite on
every ->target(), or silently passes when the wrong slot happens to hold
the frequency the firmware actually moved the CPU to, causing
acpi_cpufreq_target() to short-circuit and leave the CPU running at a
frequency the core does not expect until a different P-state is
requested.

> 
> Look up the freq_table entry whose driver_data matches perf->state instead
> of indexing freq_table[] with perf->state directly.
> 
> Fixes: 8cee1eed8e78 ("cpufreq: ACPI: Remove freq_table from acpi_cpufreq_data")

The real Fixes tag should be e56a727b023d ("[CPUFREQ] Make acpi-cpufreq
more robust against BIOS freq changes behind our back.")

> Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/cpufreq/acpi-cpufreq.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 1abe9ab..61ede49c 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -353,6 +353,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
>   
>   static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>   {
> +	struct cpufreq_frequency_table *pos;
>   	struct acpi_cpufreq_data *data;
>   	struct cpufreq_policy *policy;
>   	unsigned int freq;
> @@ -368,7 +369,13 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>   	if (unlikely(!data || !policy->freq_table))
>   		return 0;
>   
> -	cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;

How about:
	struct acpi_processor_performance *perf = to_perf_data(data);
	...
	cached_freq = perf->states[perf->state].core_frequency * 1000;

get_cur_freq_on_cpu() is only called on ACPI_ADR_SPACE_FIXED_HARDWARE
platforms, and on such platforms perf->state is only assigned in the
following functions:

(1) acpi_cpufreq_target(): perf->state is then the index of the P-state
     last written to the hardware.
(2) acpi_cpufreq_fast_switch(): same as above (1).

(3) acpi_cpufreq_cpu_init(): this sets the initial value perf->state =
     0. In cpufreq_online(), after .init() has been called, .get() - i.e.
     get_cur_freq_on_cpu() - is called once.  The freq read at that point
     may be a leftover value from the hardware, but whether or not
     "if (freq != cached_freq)" holds, the only consequence is
     data->resume = 1, and data->resume has already been initialised to 1
     in .init() anyway.


> +	cached_freq = 0;
> +	cpufreq_for_each_entry(pos, policy->freq_table)
> +		if (pos->driver_data == to_perf_data(data)->state) {
> +			cached_freq = pos->frequency;
> +			break;
> +		}
> +
>   	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
>   	if (freq != cached_freq) {
>   		/*


-- 
Thx and BRs,
Zhongqiu Han

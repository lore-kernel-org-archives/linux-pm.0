Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BC43B3E2
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973652; cv=none; b=JEnJVvG+M6lCb3K5rKyW1P0paF8+QQsvRqWza9kwCFs2Wm0eeLoO08OyTq9cMCksBsJSx8R0TXuUQ05C8aPUT5lDir9FdK5i0r0QUYbzDRYztt8Z7JeQlkiPk93nsPYUdZrlBDFW8h6svTUADLQDyMXGTBE+kYadYqZ2QFToBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973652; c=relaxed/simple;
	bh=FGuszqknZFozF7pKzpAoA04EqrXSP2JnLU572u497H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=F51/SviqU9nEzVzusjkoBN35vmW1FpbPCofMhTlK+CmxDDCmhH8h3aSjYIo61KQ6ihJwU7SJjdAjZ5pPg1IOrU1Pwl3377xypu0SY4VZCPxOD7/PYAcao2LiU6S9O9sEYL50KZC7dcbqJWRvRBu/dixxEWTu7f/mpNI0r/t89hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ATMbm9u+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J1vo5uAA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ATMbm9u+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J1vo5uAA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD6KKR2431695
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iWD3BGVe7Jxn1EGjVKUV/jvwmRStEg8cJXdcbwX3Hvs=; b=ATMbm9u+4AcFkAJx
	MYzc3VNuFi7GZdikG+AkyOI8Ndw0fu1pqVPltKtmuZztI4kBCHn7EqdgFdtdQqMU
	SqOuE6U5JkiPsawIeAK+/Hu45Mc26wwP35XSvWOT0mCczVGlTqfaBIByNq3m2QzN
	Vqe1qRJ/rlxMcoIU0RpRCUHdi9ZSsrnT4mkZZzgdQgNUOSuYEeHQBudZVbtTOc6M
	beGGu0GeDwOP9bN459TGQlSBYiqZp/T7OIt0KLREd92fM6bpw9BYdBv9iCg164Fz
	DULWcfx/XRHweSEzzYUai9Mo5Y6rZkrXGBMOHJwJPtamyt2b8i01VgVAA06U9mmb
	Xy4Lwg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wrehegc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:34:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so3987570a91.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786973645; x=1787578445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWD3BGVe7Jxn1EGjVKUV/jvwmRStEg8cJXdcbwX3Hvs=;
        b=J1vo5uAAIK66ZZDJ76+jdFIzT+hvFGWRsTO8WgYEjEdYEq9CB32xZQRDqptn/NjFXb
         iTzl/KpexjpVTcFpX/3Sew4B89ulBIbgr/6WIGjmwfAgbzi25wkU79j43JcD4Fh9KK4f
         jTEJmJjxcbnFzHKlKGXw45AZ+yMB2QSrBrgeou1sQegIxgUDje16DMn3hs/06/zFX38h
         wifeY2WYNBQAHEYBJC/3/AoQRA771D5XP5SdXX2ZRx3uSji0ycBt7S9xbi2XiDfPd4mD
         8DCqt+FEE0IuiYlE0Tfpxe0+6CTKJhpEkrkSkbWZD4ZWGP0wY6z1iTNmN+tjcqcOX/uQ
         SalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786973645; x=1787578445;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWD3BGVe7Jxn1EGjVKUV/jvwmRStEg8cJXdcbwX3Hvs=;
        b=MFw/hsEUDx1Zv3N6yy3s2dpd94Z0ETtcLrEzd7Fkmz95zuV1DMgYCsQvjtDOUY1kdK
         6HVPdyYmGIwwPFM6wKAyf/55uVuPXRE2zjwcbWelIVKIb9pD2TldkMjrttcFx4nWTwpQ
         qdpiSXS6PzrOXvdcGPTsU/sS2+rZj8QyDblm9LWhs+B5NxR9d0dphfoJWSyVpPV1ZIPa
         fudVB5evd/iQWz2aH8ApeH8qxAGUPvWdjTjQTNo4tXUb2vbAgQNwwDm3a0PbYxxE4C4h
         J7Jk4tincppuxRYmZWCYepUhmc4i1WhTBEAMM/2rnPKZWGFWtT70lFmOFVD9+OnmjRPx
         CFfA==
X-Forwarded-Encrypted: i=1; AHgh+RqI+D51PsyOooiBFwAbMAKd+uKklJHFlxNElMVRfhMejBW85UxPgO79uvC1HQRudT3qSpQq/lSNsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQuGuVCEOGpZvaGf5tvktxzUhM0PqhsVBupKMe2Ppkt4BHbuJ
	SNNPD9Kxb84oCfy6koQHWrWvH+yBULMcVUzsDviJeDduCQ9j/VBe67LV1J84mTJjpRc2m+C9P79
	ijiKh9Fxx7KHVKsuVn/K3EVa5Xt9WCH+nTB+Ez+6G3gcrchhT516xv/k3FLMI5Q==
X-Gm-Gg: AR+sD13+uFDPOdwU9majGCd3EmeBJFOjZFl1JUQzN9wVu6roo7Idw3y5uX25Rvru40f
	w/rtwxJv6zJBhEGwtLkOyp4TPiIe5MVb6qH81PtB8iYLM7oCZG037WFEuBJ04SPQWqd0KnYfdau
	aH7H94ndKxiRcYAjmnZJXQetcPj6ni0BWxKgFD+rZFXYgfp7FJoBZNCIapUccKVQl9PCyo0NInx
	sHmkPRVOORgt6JDaYWDSD7tiyDB8qq9JotmWLONeCUTlysTcBkh5qimvekJYe65LSmp1cQSMvhs
	r9zPiU9zaWUD/mZAmRfampsMZ+T5xvoLEIIkKDrYE4CkSR+BSjJ+NCTYwLvgscrVwEVGMReDQRB
	L28oWBPFeRTuwOukJmpnPSZskr0zk6rBpRWOHLpD8muiYrKtKM/rQ4F6HIyNvol2DiD9F2kg=
X-Received: by 2002:a17:90b:2d92:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-3933babae61mr26190131a91.17.1786973644566;
        Mon, 17 Aug 2026 06:34:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2d92:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-3933babae61mr26190069a91.17.1786973643937;
        Mon, 17 Aug 2026 06:34:03 -0700 (PDT)
Received: from [10.133.33.95] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b1edb2sm5424828a91.0.2026.08.17.06.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:34:03 -0700 (PDT)
Message-ID: <a647d4a0-d713-4e73-8b16-b73dd3b35ce4@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 21:33:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq: acpi-cpufreq: fix P-state index mismatch
 in extract_io()
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813090145.2450-1-lirongqing@baidu.com>
 <20260813090145.2450-2-lirongqing@baidu.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: zhongqiu.han@oss.qualcomm.com
In-Reply-To: <20260813090145.2450-2-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FqI1OWrq c=1 sm=1 tr=0 ts=6a830dcd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zuLzuavZAAAA:8 a=B83gT7kL6Ddqc7TX8wIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: qcHuxbQSl92mk2OyFe39hgv0701ntiIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwMyBTYWx0ZWRfX8Sd1exBGwlBo
 T9AbPxXcG8mYh3gmG6706KTbpxJm3vIu4LIQguSGViv/5iXEVkghjiwe2WKk5IyJZDc6BznLZqD
 aqoOlLMlYhzL0ZlEGZyZbmkOV8oCR7wjnApyppbuaiGWkkVjJ0VYrt18xncjOlVNeQqSH63aGOk
 flSGk/7sdE8eZKjOLP5TvX+VO6/I1pxmXqMdFR8g1mNmuQ7Z2axkV/NpETxYYNWJigPnAsHM628
 J5mtADYeafkBfbrIK+Z0YMJx0m7IKQguCs6nXWrtsCvOqm/LBbEi7xBGMeDHsVedWXc9ThMUgsf
 Qwz6AJ92Ov2lEqrJ3j6PhiCgNm5LARIYg1bSE69DzTl719XAho6dbLcQvEYYdGz3Cf6TkHO5JJT
 6kD+IJ2levGq4kERJmTGKzEJUhc1YzWejxKYK4P7Ob9nBThB4ZXNzMGMtx1/JEJ3S56TVb3mUCc
 DMfdGH/nc2pn28twN1g==
X-Proofpoint-GUID: qcHuxbQSl92mk2OyFe39hgv0701ntiIt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwMyBTYWx0ZWRfX9GW2h9O3wpxP
 4NWKGDAUXxHzcP0wmMknBs0VsNPUXe0kbY1twadTGAHiNea52nycHGSPXWH3zgIkt961NKmDdoL
 N6oNsxq283YXNjub97NUDD8L0SezMdM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170103

On 8/13/2026 5:01 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When policy->freq_table is built in acpi_cpufreq_cpu_init(), entries
> with duplicate frequencies are skipped. The original P-state index for
> each remaining entry is stored in freq_table[].driver_data, so the index
> space of freq_table no longer matches perf->states[].
> 
> extract_io() walks perf->states[] with index i and uses the same i to
> index policy->freq_table[i]. This causes two problems when duplicate
> frequencies exist:
> 
>    - Returning the frequency of the wrong P-state
>    - Returning 0 from a zeroed tail entry, or even CPUFREQ_TABLE_END
>      (~1u) reported as 0xfffffffe kHz

AFAICT, It may be worth expanding the changelog to cover the
consequences described below , particularly the resulting divergence
between the hardware state and the cpufreq core's view of the current
frequency:

Furthermore, extract_io() is only reachable on ACPI_ADR_SPACE_SYSTEM_IO
platforms, where cpufreq_driver->get is not installed, so its only
caller in practice is check_freqs(), i.e. only when the
acpi_pstate_strict module parameter is set.

There, the mismatched lookup makes the frequency comparison fail even
though drv_write() has already switched the hardware to the requested
P-state.  So check_freqs() sleeps through all 100 iterations - at least
~1 ms of usleep_range() plus 100 cross-CPU calls and I/O port reads, all
with policy->rwsem held - and ->target_index() returns -EAGAIN. perf
->state is therefore left at its previous value while the hardware sits
at the new one.

The core then restores policy->cur to the old frequency, and
because __cpufreq_driver_target() returns early when the requested
frequency equals policy->cur, the driver is not called again for it - so
the control register is not rewritten and the CPU is left running at a
frequency the core does not know about.


> 
> Fix it by walking policy->freq_table with cpufreq_for_each_entry() and
> using perf->states[pos->driver_data].status, aligning with extract_msr().
> 
> Fixes: 8cee1eed8e78 ("cpufreq: ACPI: Remove freq_table from acpi_cpufreq_data")

The real tag should be fe27cb358835 ("[CPUFREQ][2/8] acpi:
reorganize code to make MSR support addition easier")

That commit added both the entry-skipping loop with the
freq_table[].index (now .driver_data) back-pointer, which is what makes
the two indices diverge, and the faulty lookup itself -- back then in a
function called extract_freq(). dde9f7ba60ad ("[CPUFREQ][3/8] acpi
cpufreq: Pull in MSR based transition support") merely renamed it to
extract_io().


> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/cpufreq/acpi-cpufreq.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 21639d9..1abe9ab 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -197,14 +197,13 @@ static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
>   {
>   	struct acpi_cpufreq_data *data = policy->driver_data;
>   	struct acpi_processor_performance *perf;
> -	int i;
> +	struct cpufreq_frequency_table *pos;
>   
>   	perf = to_perf_data(data);
>   
> -	for (i = 0; i < perf->state_count; i++) {
> -		if (value == perf->states[i].status)
> -			return policy->freq_table[i].frequency;
> -	}
> +	cpufreq_for_each_entry(pos, policy->freq_table)
> +		if (value == perf->states[pos->driver_data].status)
> +			return pos->frequency;
>   	return 0;
>   }
>   


-- 
Thx and BRs,
Zhongqiu Han

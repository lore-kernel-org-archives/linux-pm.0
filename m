Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6026738C
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402622; cv=none; b=Aq98j6oesHbvmsBaU3UDG1MCgbMxnIgV5IjD1dbMpaYFV+t7IToJ0s8ugo+ZIUkK4sWOfI/X49oFdntc+8snl5APNZdoV2IWQPSXYCVgm1ciUFCMTpV9vkbB4llVzcyR+VxgfzIvEaetiwWl2vCUOFoyzIkg0BSfLSRgQK/u57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402622; c=relaxed/simple;
	bh=67+Pfrh2nNBsYydPdLcLpAYHOKmhHl6XA85egym4ucI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ot4VNqeZlFXqyzsE+aSHaqP1Xt4yiANfF9XFgwiCiikPjg1Le5P9QPn+WmRRhyTMgsikHK3P0hWUk7N+bFS88tMCHlQvLF87EE04EH0xmt3ea0WKrRBYE9/00mFOBOg8uR9WgwzC6F9u3/fkrWmc+5Zg8ymeqjkP0GK7GoImpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3PGXWYB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hXYeFVwl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3PGXWYB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXYeFVwl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFdvqR820619
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 15:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3I9f/oCmWZHkzPRYTwNNkDO4Bnu8a5Tr268WwzovkyE=; b=k3PGXWYB55tW3FNh
	BC/BWT13PWuH2pstB3dCpnGpYwpHEK79opsL4cX9p9uS8brQ+Xcucbk/M7zWOdAj
	QfM56BmCzKozCehHXeXWMCzovUoCaum04ydhw3mjvicee21Y2FLLFFylYLpEMDFK
	XwlUuPgonKMCXBjpDUKHEedK970TuYoo/UjMDGw1gFLb7G/PCJb9ebAquVV52icN
	byJPo26OhXfJBgKvQeKe4qS5MWE018RyR3MJ2dIWs49NREeQUf1elMVgrb3bkX76
	HT8Ia45CII5IM1SqyymjEx2C5MPciwCBtmZgoNqRNcvOtS2LlFDbv5iXkV2CvDUV
	3IPxOA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0tspu67c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 15:50:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37c8fd4d4baso1756079a91.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782402620; x=1783007420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3I9f/oCmWZHkzPRYTwNNkDO4Bnu8a5Tr268WwzovkyE=;
        b=hXYeFVwlSiDAnoXxJ64qXiRBjAUEbh9L4ag/+OSWelVjeajum4RGEAUJwj75+YOYEU
         gX7tw64xokkxd5kSIKK4nhLWWr4UL1d1VV2GpeERY6ywm58gCnPgI8qQRt2mXMRePRdS
         EE3cuIRXBUpAcXUHuB76cXNaEEAJjdszjdAxGx6h+fcfguXHu5wANgz9imE24Ta56w5A
         HJZGNx2mYpEYMaL0OA2GYTL+/UgQh5VD/q7+1CL9WajyvYADgFpjHRRLEN4VrZnf/0lr
         +ho/MGeDIvR2l9EqdurzOPy1U3VWrabmpiiyUPeUofyENfPCK5n54n2qblhlsHLN0s7F
         VBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402620; x=1783007420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3I9f/oCmWZHkzPRYTwNNkDO4Bnu8a5Tr268WwzovkyE=;
        b=oQB1/yW6KRPj61KahI5lDEDVY5poBnNktfyXC+8kbvtjs7i4FXP8acN0ZdtJkfH8w0
         2EWKOfVO0JgPLu9RxMnggyLjexV2Gr+r3OHmfDLDez+7KxHcXbz2t3qGXupJ7K4GTBpv
         5dR+bTLAQ/4MufL2Lv2n47IxiPpzhD9ry0qGM5CEVZKq6fCwzeEUB/zuWUzf4wg7Ya7X
         w5FUZGqX7QGaIYTwuRhSD/8M4BGPD7XWguNb5lGa8oVD8nTPXkT16Q1fSNX1O1OuVIOM
         0c5bOfQFY/WE9sSGCFQ/MKmoECmz3moE2RIAbB2AJxoPkzsZwD7ENKFSMidtsStpNerO
         gX/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpj5to1OSMEzaobUDlzLxHIv0EC0c7gUaS4BJSIbM6k9xKJSL9cNGAGT08NrFwhLuiXZIhaY+7EOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ztRcYHPHTEmX5LokJe6QCZ/YAo1FiTsmcHIoYk+5xqhNosPv
	O3MSsDx9lx4Z0huF5tLaZF6vjIKg2oDaITVVL6ZsMuoO8Ft4QHLNP9gRKT2+ljokYHlaQ3KRWNO
	EsPU+EpKQLfP3+aua3hDZUiZgIIqnq/YX0NrIEb1UQMEp64jUU0LDqJAr7BpLxg==
X-Gm-Gg: AfdE7cnA/g1/U478uBTnUesMRxfLC2410asl+rSBPgBLOIODpQHSNg+83HD1zY8YD7k
	dQHzroWaS+b69rHcblq70NnEFQnKqsP5QNKCX/yQi+xO6/BvBDxBFpmfCMSRsc2ryN13o8gR+ye
	mXI59j/OP6Tbj7UnPmqvVmKIzF3CmzFjMOX9q5od1ZMk1wGRs6wpiW+knNodkuueV8YQEjWaJJp
	zYZVhCTV6NMcA9oonoBNQjdfgWdVBOGcLH2B5wmNDm31R+mFguzVOLsucDtTOPPL1vU2JTnYI34
	raieHfQR6srj/zgmWGYujjWeG1+aGoD7Y49iDvSrRQf8E4l1Rzos0anYTroXxFO+J4/n0vZ73Uk
	Ma8pSiba3mUQNf0KJ7P0+a0owCVYFSdkHI9GCN5RucXhBWqrnd82lLBzkCHTb0Dnm1La90281jX
	peMbMCT0s=
X-Received: by 2002:a17:90b:3f44:b0:37d:f45b:d050 with SMTP id 98e67ed59e1d1-37dfa2962afmr3067801a91.19.1782402619532;
        Thu, 25 Jun 2026 08:50:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3f44:b0:37d:f45b:d050 with SMTP id 98e67ed59e1d1-37dfa2962afmr3067739a91.19.1782402618666;
        Thu, 25 Jun 2026 08:50:18 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3b0ee6esm2278086a91.6.2026.06.25.08.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 08:50:17 -0700 (PDT)
Message-ID: <d05b97f9-140d-4937-8c83-de688e392d6e@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 23:50:07 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cpufreq: ACPI: Use IPI to update boost MSR in
 cpufreq_boost_down_prep()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, bp@alien8.de, tglx@kernel.org,
        x86@kernel.org, viresh.kumar@linaro.org, yosry@kernel.org,
        andrew.cooper3@citrix.com, ludloff@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, zhongqiu.han@oss.qualcomm.com
References: <20260618224527.1506419-1-jmattson@google.com>
 <20260618224527.1506419-4-jmattson@google.com>
 <CAJZ5v0jeJCN3Zu4uWoOYTYcu9o4BpkWLitNToGbPdwm8Tub=hg@mail.gmail.com>
 <a962064f-fcd5-4ad2-bc7d-4249ec8fa495@oss.qualcomm.com>
 <CAJZ5v0iJ=gLpjX2ZGhH7v0QQKROkoOto6R6-pOk=76ADrNWySw@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0iJ=gLpjX2ZGhH7v0QQKROkoOto6R6-pOk=76ADrNWySw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OL8XGyaB c=1 sm=1 tr=0 ts=6a3d4e3c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=HEZ3O-NoM5aavOxcrPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEzNiBTYWx0ZWRfX6g92IxZ0Cjqw
 JiaPfyeSpgWybInlCGByQClm/OpHw+qvTrXSqdd7ujoHId+k0ht39BxHwA/xe/jRZgR/q9/SMHY
 bxFmjoLpPDnvqdgUjK1JpWmoYFnSJ42WzO7GiPjYsRFPuS3NZkHHgKCBCKNlHmdp73nHPUzf69B
 AwGdnTqr1cQRmfXB3paJSbPtHg4Q5Bs4T4atWbbYeA9NvgzYODYcCyYULeYdG2GlGaGOZGFzYoA
 UVhlB4Z164prWnLGP2Jay8x+MNoXEtFvpyFREQuFVjmEnTMVOKsfiH81xEra62Ab2ElJICAALDY
 YfyX8UaBXISf/BQLSpvLYkUmor6fB5zlr+i7eRAUM9bYRYlkM2V/GfGMH7SRwB/gFWw6bkWX0h5
 eVxiSbBPakTRosF1v7J1w3ASRHF9n84v52MRF1zpLND0kecz5ZO+PYZLjr46b9GRnWYF3fY9s3t
 PBpBUU/3880XjkIuhCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEzNiBTYWx0ZWRfXw46OQ2InKkol
 pqQ5sgwNrd0zGPsPl3ESowiIqqiTjLo4RsBeM77oEQAtCm+FnY+QhgqF997c0l6GAcUUlxzFVkx
 sIdbE2uqkW178GWVI0ddiqrv50+eM38=
X-Proofpoint-ORIG-GUID: muz-PvLX00ERqlQoHh3KMnn1Bs-LQHFj
X-Proofpoint-GUID: muz-PvLX00ERqlQoHh3KMnn1Bs-LQHFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250136

On 6/24/2026 9:35 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 24, 2026 at 1:26 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
>>
>> On 6/23/2026 8:47 PM, Rafael J. Wysocki wrote:
>>> On Fri, Jun 19, 2026 at 12:45 AM Jim Mattson <jmattson@google.com> wrote:
>>>>
>>>> During driver exit or CPU hotplug, acpi_cpufreq_cpu_exit() calls
>>>> cpufreq_boost_down_prep() to re-enable boost on the target CPU.  However,
>>>> cpufreq_boost_down_prep() ignores the target CPU parameter and calls
>>>> boost_set_msr(1) locally. Since this runs in an unbound process context, it
>>>> updates the local CPU's MSR while leaving the target CPU's boost state
>>>> unchanged.
>>>>
>>>> On Intel platforms, the open-coded read-modify-write of
>>>> MSR_IA32_MISC_ENABLE in boost_set_msr() is vulnerable to preemption and
>>>> thread migration if executed in process context.
>>>>
>>>> Fix both issues by routing the MSR update through
>>>> smp_call_function_single() to execute boost_set_msr() synchronously on the
>>>> target CPU. This ensures the correct CPU is updated and that the RMW
>>>> sequence on Intel executes safely in IPI context with interrupts disabled.
>>>>
>>>> Fixes: a3605c46e0c0 ("cpufreq: acpi-cpufreq: drop rdmsr_on_cpus() usage")
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Closes: https://sashiko.dev/#/patchset/20260612215729.1532175-1-jmattson%40google.com
>>>> Assisted-by: Gemini:gemini-3.5-pro
>>>> Signed-off-by: Jim Mattson <jmattson@google.com>
>>>> ---
>>>>    drivers/cpufreq/acpi-cpufreq.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>>>> index 21639d9ac753..48d678812fd6 100644
>>>> --- a/drivers/cpufreq/acpi-cpufreq.c
>>>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>>>> @@ -528,10 +528,11 @@ static void free_acpi_perf_data(void)
>>>>    static int cpufreq_boost_down_prep(unsigned int cpu)
>>>>    {
>>>>           /*
>>>> -        * Clear the boost-disable bit on the CPU_DOWN path so that
>>>> -        * this cpu cannot block the remaining ones from boosting.
>>>> +        * Clear the boost-disable bit on the target CPU so that
>>>> +        * it cannot block the remaining ones from boosting.
>>>>            */
>>>> -       return boost_set_msr(1);
>>>> +       return smp_call_function_single(cpu, boost_set_msr_each,
>>>> +                                       (void *)1L, 1);
>>>
>>> While I have not investigated the history of this code, I'm wondering
>>> why cpufreq_boost_down_prep()  is a separate function and why it takes
>>> the CPU number argument.
>>>
>>> The only caller of it is acpi_cpufreq_cpu_exit() which could just do
>>>
>>> set_boost(policy, 1);
>>>
>>> instead of calling it (and might check if boost was supported at all
>>> for that matter).
>>
>>
>> 1) It seems that set_boost(policy, 1) would be a no-op here, since
>> policy->cpus appears to be empty by the time ->exit() is called.
> 
> All right, but this means that ->exit() is not quite suitable for this
> type of cleanup.
> 
>> acpi-cpufreq only implements ->exit (no ->offline), and ->exit() is
>> reached only when policy_is_inactive() (i.e. cpumask_empty
>> (policy->cpus)) is true. set_boost() does on_each_cpu_mask(policy->cpus,
>> ...), which on an empty mask runs nothing.
> 
> Arguably though, .offline() should take care of the boost cleanup for
> the CPU going offline.  .exit() is too late because it can't clean up
> CPUs that went offline before.
> 
>> 2) The patch's restore on only policy->cpu
>> (smp_call_function_single(policy->cpu, ...) will not fully cover shared
>> policies, and how much it covers seems to depend on the boost-disable
>> bit's scope (but that seems to be already discussed in the cover letter
>> and is probably a separate topic).
>>
>> Please feel free to correct me if I'm misunderstanding the scope of the
>> boost-disable bit:
>>
>> On driver unload the policy CPUs are removed from policy->cpus but seem
>> to stay hardware-online, so a stale disable bit on a non-last CPU might
>> still matter (those CPUs are presumably still running and may want to
>> boost). Abstractly:
>>
>> - if the bit is per-CPU independent: clearing policy->cpu seems to fix
>> only that CPU, and the other still-online CPUs in the policy may stay
>> disabled.
> 
> Yes.
> 
>> - if the bit is shared within a group (e.g. core/package), "disabled if
>> any member set": clearing policy->cpu maybe only covers its own group,
>> and other groups spanned by the policy could stay disabled.
> 
> Yes.
> 
> Thus it is better to clear it at offline time for the given CPU.


Hi Rafael,
Thanks for the clarification.

I agree. Just for discussion, two possible approaches come to mind:

Option 1 (structurally clean):
Introduce an optional per-CPU cpufreq_driver->set_boost_cpu(cpu, enable)
hook and call it from __cpufreq_offline() before cpumask_clear_cpu(),
but only on the unbind path (not on plain CPU hotplug-offline - clearing
it there maybe wrongly re-enable boost on a still-online sibling on
shared-scope HW). Roughly (rough sketch only):

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9ac753..5f298fbb0d8c 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -525,13 +525,10 @@ static void free_acpi_perf_data(void)
         free_percpu(acpi_perf_data);
  }

-static int cpufreq_boost_down_prep(unsigned int cpu)
+static void acpi_cpufreq_set_boost_cpu(unsigned int cpu, bool enable)
  {
-       /*
-        * Clear the boost-disable bit on the CPU_DOWN path so that
-        * this cpu cannot block the remaining ones from boosting.
-        */
-       return boost_set_msr(1);
+       smp_call_function_single(cpu, boost_set_msr_each,
+                                (void *)(long)enable, 1);
  }

  /*
@@ -951,7 +948,6 @@ static void acpi_cpufreq_cpu_exit(struct 
cpufreq_policy *policy)

         pr_debug("%s\n", __func__);

-       cpufreq_boost_down_prep(policy->cpu);
         policy->fast_switch_possible = false;
         policy->driver_data = NULL;
         acpi_processor_unregister_performance(data->acpi_perf_cpu);
@@ -986,6 +982,7 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
         .bios_limit     = acpi_processor_get_bios_limit,
         .init           = acpi_cpufreq_cpu_init,
         .exit           = acpi_cpufreq_cpu_exit,
+       .set_boost_cpu  = acpi_cpufreq_set_boost_cpu,
         .resume         = acpi_cpufreq_resume,
         .name           = "acpi-cpufreq",
         .attr           = acpi_cpufreq_attr,
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 507224c9ecd3..c4952ca3e8a5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1669,13 +1669,18 @@ static int cpufreq_add_dev(struct device *dev, 
struct subsys_interface *sif)
         return 0;
  }

-static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy 
*policy)
+static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy 
*policy,
+                             bool unbinding)
  {
         int ret;

         if (has_target())
                 cpufreq_stop_governor(policy);

+       if (unbinding && cpufreq_driver->set_boost_cpu &&
+           policy->boost_supported)
+               cpufreq_driver->set_boost_cpu(cpu, true);
+
         cpumask_clear_cpu(cpu, policy->cpus);

         if (!policy_is_inactive(policy)) {
@@ -1730,7 +1735,7 @@ static int cpufreq_offline(unsigned int cpu)

         guard(cpufreq_policy_write)(policy);

-       __cpufreq_offline(cpu, policy);
+       __cpufreq_offline(cpu, policy, false);

         return 0;
  }
@@ -1750,7 +1755,7 @@ static void cpufreq_remove_dev(struct device *dev, 
struct subsys_interface *sif)

         scoped_guard(cpufreq_policy_write, policy) {
                 if (cpu_online(cpu))
-                       __cpufreq_offline(cpu, policy);
+                       __cpufreq_offline(cpu, policy, true);

                 remove_cpu_dev_symlink(policy, cpu, dev);

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index ae9d1ce4f49c..c174b013dd76 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -413,6 +413,8 @@ struct cpufreq_driver {
         int             (*online)(struct cpufreq_policy *policy);
         int             (*offline)(struct cpufreq_policy *policy);
         void            (*exit)(struct cpufreq_policy *policy);
+       /* Optional */
+       void            (*set_boost_cpu)(unsigned int cpu, bool enable);
         int             (*suspend)(struct cpufreq_policy *policy);
         int             (*resume)(struct cpufreq_policy *policy);



Option 2 (lighter, but it is at odds with the direction discussed
above): stay in acpi-cpufreq's ->exit() and restore over
policy->related_cpus instead.




-- 
Thx and BRs,
Zhongqiu Han

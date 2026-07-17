Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32342F704
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301928; cv=none; b=kQ6d3/0nm626XNUMISVPfF9q/7mH2bi9eIC4lcscA/NN87FCYsETKYwEsyM1p3D4g4RxYU6O06Lh8chxAr0LzH6LXbn7p6z+Pz9YBzDek9fd1VesCSzrplbUzck75+/uoFzqLqkNLOBHdQkbEocbvR7C5Y7NfTPV56NCFNxvors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301928; c=relaxed/simple;
	bh=dF4QSDpQbg8cY3Wbyx7qfC68vsNAhnnPtOxMxUMhGMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOlg4qVR2y811dGZ8LMQGynmoKI8zUuCyd/M/dJ3lOPA+5N2yJdWuBYaohI4fC7kDS+ZdzEhai2WqBKVJrO24NQGqLVWL+Ci7NaXxE2Vs0Kaf9J2CHmr+hjV4AMlUN62jJwXd9O2/SBdWw2RsdIiX9f6RWqBp7zcMV9s4PLUFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c3wfa7v4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bNKb49am; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c3wfa7v4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bNKb49am"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HFD6vS2126585
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 15:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ZbOnrWj5uzZUGoBdPGYG8BqP6m7m+4qsG6z7fAhIpI=; b=c3wfa7v41zopAbLB
	IgMYvsb8y/reS19sMjsjnLDrfYNDfpoYx79EdT48GNPq5tFkkzgDajG61GbIV4gB
	ubckIRvYkYK1VP3gYW6Fr+oHvZBlBPC9rLxAh2bkMScfyK7EhJRNTkDaOKsVsGBE
	rZZMaK0dG9WaZMPr015ev668tvav2MhgearRQ6WpbX902yq/tVXS7QhuA1ullKMi
	n8NxklapAUcCZYqEAJ1RTQtQXpb63tZ0LO69+ikYULbXpDjWs+6RGTStuaEn6cBg
	vBeRouktVhd80c/li5EvX0quQMA5onUGQcMxSEefCttFWACr9r+GQthcrSUhY31/
	TH4wKg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug01n0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 15:25:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso9022540a12.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784301921; x=1784906721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZbOnrWj5uzZUGoBdPGYG8BqP6m7m+4qsG6z7fAhIpI=;
        b=bNKb49amI3a+rvh0O6SRA4oUQ5Rz7QpWqwMxVOOi18c+eQbke4WWbU8Q7NBPV6EgGK
         izXohN1Ip5dyYzb98RSG7dgO4EA9YcNIt+s802HWsrqurpxjFVfXsB1cgfSYdcnemxat
         85w2CWb8FclSBwXlZSfH/AJ3wGvFWlrEsHp46Tk7JkhRaGELt8U0G7vzDkfJ3P8deHKM
         lmfdcqP0AnQ7913uD3lyCszgMvgWt4QTqW11os68avR7Qeuq+1u8kuC9ZrINBZoPUJWn
         g/LmViFvhbGChV74a1+nJY24NrsUNXvlrQ5KOuOiYMnZUB9POKIBLlZaz2/dtVFRus+C
         8qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301921; x=1784906721;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZbOnrWj5uzZUGoBdPGYG8BqP6m7m+4qsG6z7fAhIpI=;
        b=YwE7c72NKC8R5NYvVw8ipKXes7GKPRpg2wL1AunuVftIzJcs5OMDPudygGeMmAI6Dj
         QulazVyzlLIwS26jjL/2IdmedFi7UuJCotnw/ifAEqEfjmirTee10d9XULBnYIuZPBlT
         OazDsTiwRoGxQodC/kwMa/W+0N9wkCJ9uD6xvqpYXL5IBU3w6bojkjxOn1qH1f98I3Iz
         nTDvR3OvI4/BuZsKlkUDgxfJVJ1YsSOS/fOqAD06DW1LxEVPS/5/eeHey2JiI8Bjbhi6
         Ov8V6jazJvychc5GBs1WZtQNs+PVzpnq2qnnutPkc4N+NiVzfDZ/BYpR94Bjx/REx9Uj
         5puw==
X-Forwarded-Encrypted: i=1; AHgh+RqetvnY8xV+GRV3QVr6VTabX7onnKPCV6ki0YjW/aXAyaXePzH7ruKnmPekjaocF3H78NjSM57DJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmx2Pdd2BO+0cfP0l8+GGRGcaCz96KMR+llkKL3cNjulUIYVp5
	l1+R2kSjjX3Fcj71V8P8jq3MdB/tx4mMeY4Nma5j0q+9MjV05pFnTCUl3AqoJhtaVWPpJdCuNQf
	2iuTELK9EDP3x/1ukMR+SRFIfXp3uHfLNDdktFJWzOy8iFkUn9DMvVyPfF6wdPjV9EBIydgn5
X-Gm-Gg: AfdE7cnHw9ju0H9NmYWDPOTuIPPV14LHoeTwIu2p9w2uZs7IMja3AT29zns0U4GXOP8
	JVn9J83LZzCuX/ofbiqF9TQyk9ISO/iiuX1kZgqiv2iFgdJGuPYyRtMYZisK8UUHhdktcs0eq74
	d4YKyog9+s5asQNyR7K/sSusCcOuzdTIxH5KeRnPW1m44Sz28L/gnP4UY17v7lXo6K+89z4zaMl
	Xtpl4AQ6oEjYxZaw7RPk1cyJ+ywz3XbYrGE+x0ugBEupA0RQ30NitjuCkFLW45ssKuOu+zab8YC
	wF+ZboPCJjLyDpw7cq2xqZw3VbRgfsxXEKu6FmTrnjomh3sf69m6eGMD3hQSUmh4+ZdTH2Qcxcz
	tZbPXLn9l6Os4+YW0WAaKPT0x9AHyVhcFK35LiIQP/o8bSjUY7u5BCQt44eys0lH8Zput/pQQ
X-Received: by 2002:a05:6a21:1404:b0:3c1:d78:6450 with SMTP id adf61e73a8af0-3c3ada37421mr3116113637.66.1784301920816;
        Fri, 17 Jul 2026 08:25:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:1404:b0:3c1:d78:6450 with SMTP id adf61e73a8af0-3c3ada37421mr3116052637.66.1784301920190;
        Fri, 17 Jul 2026 08:25:20 -0700 (PDT)
Received: from [10.133.33.171] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb334sm1046666a12.18.2026.07.17.08.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 08:25:19 -0700 (PDT)
Message-ID: <36d66d21-a1f1-4acb-8ed0-9dbc5c924abd@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 23:25:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cpufreq: ACPI: Use IPI to update boost MSR in
 cpufreq_boost_down_prep()
To: Jim Mattson <jmattson@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, bp@alien8.de, tglx@kernel.org,
        x86@kernel.org, viresh.kumar@linaro.org, yosry@kernel.org,
        andrew.cooper3@citrix.com, ludloff@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, zhongqiu.han@oss.qualcomm.com
References: <20260618224527.1506419-1-jmattson@google.com>
 <20260618224527.1506419-4-jmattson@google.com>
 <CAJZ5v0jeJCN3Zu4uWoOYTYcu9o4BpkWLitNToGbPdwm8Tub=hg@mail.gmail.com>
 <a962064f-fcd5-4ad2-bc7d-4249ec8fa495@oss.qualcomm.com>
 <CAJZ5v0iJ=gLpjX2ZGhH7v0QQKROkoOto6R6-pOk=76ADrNWySw@mail.gmail.com>
 <d05b97f9-140d-4937-8c83-de688e392d6e@oss.qualcomm.com>
 <CALMp9eR1_ud8-qi+iHHRmCYtrwU2vKE5PkQDPDS=7Rja5eKnQw@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <CALMp9eR1_ud8-qi+iHHRmCYtrwU2vKE5PkQDPDS=7Rja5eKnQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1NyBTYWx0ZWRfXx4l0DJsTKanY
 AsS3eGC/7LW+okcQLsAk3TT0TLAWo/KMAVQeTLBAW+e66bfyj0O3CZGMIxg92wJ7Q7EPKKdnIsB
 lOzZhnv4siqm2taHr62qD7atMC8jXvkETL4KBqIHAVRlrChS6b6Ltx3iwlVxP6TlPDd78FyabKL
 nr+oHa/khK0Vfro+BnqmK8HAQt1zX85moLgUPjYrqjjTJ6z0GvH1OdwhTQBlFgPWO1RD4YxBja0
 J5e1H7jSsDifnYZoV+RVvV43kS8T75q5Yf6U6HoxtReTPpeb5v3z+n8nq2JvwQ5vF6wpp8x03fl
 oByRhSuhKuLISlxVAuOU5OrKnZ8NYC5vRzv3Hx4oznY0l5e2wbHwSbbmTGIGUuXQJPEmaCy3qZt
 UqU8+g7f/t96TL5ZeTu819xKckSQZHb164dkiD0jZJVkq+Azx2jjq9UJ6S+LNk12/XPBX+PnMSk
 iUIoEkE5ERbSPDXCviA==
X-Proofpoint-GUID: bZiIG4MLmkfDfJjw8sEDY_0WD8NKCOzQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1NyBTYWx0ZWRfX0aNug7WNIuzN
 1viiI/RZv8UDCiyJ6kPCGeAlHX0BRgHm3X4eH7YSJDdO+5siaoJp9cSjP5Fcdw2VtDoCNvhm8y1
 Bl7B7HQ0viHWkWB1bu6PBH/Uy2MJfyU=
X-Proofpoint-ORIG-GUID: bZiIG4MLmkfDfJjw8sEDY_0WD8NKCOzQ
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5a4962 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=3f0GovzEkgs9o7ABDT4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170157

On 7/17/2026 3:11 AM, Jim Mattson wrote:
> On Thu, Jun 25, 2026 at 8:50 AM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
> 
>> Hi Rafael,
>> Thanks for the clarification.
>>
>> I agree. Just for discussion, two possible approaches come to mind:
>>
>> Option 1 (structurally clean):
>> Introduce an optional per-CPU cpufreq_driver->set_boost_cpu(cpu, enable)
>> hook and call it from __cpufreq_offline() before cpumask_clear_cpu(),
>> but only on the unbind path (not on plain CPU hotplug-offline - clearing
>> it there maybe wrongly re-enable boost on a still-online sibling on
>> shared-scope HW). Roughly (rough sketch only):
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 21639d9ac753..5f298fbb0d8c 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -525,13 +525,10 @@ static void free_acpi_perf_data(void)
>>           free_percpu(acpi_perf_data);
>>    }
>>
>> -static int cpufreq_boost_down_prep(unsigned int cpu)
>> +static void acpi_cpufreq_set_boost_cpu(unsigned int cpu, bool enable)
>>    {
>> -       /*
>> -        * Clear the boost-disable bit on the CPU_DOWN path so that
>> -        * this cpu cannot block the remaining ones from boosting.
>> -        */
>> -       return boost_set_msr(1);
>> +       smp_call_function_single(cpu, boost_set_msr_each,
>> +                                (void *)(long)enable, 1);
>>    }
>>
>>    /*
>> @@ -951,7 +948,6 @@ static void acpi_cpufreq_cpu_exit(struct
>> cpufreq_policy *policy)
>>
>>           pr_debug("%s\n", __func__);
>>
>> -       cpufreq_boost_down_prep(policy->cpu);
>>           policy->fast_switch_possible = false;
>>           policy->driver_data = NULL;
>>           acpi_processor_unregister_performance(data->acpi_perf_cpu);
>> @@ -986,6 +982,7 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
>>           .bios_limit     = acpi_processor_get_bios_limit,
>>           .init           = acpi_cpufreq_cpu_init,
>>           .exit           = acpi_cpufreq_cpu_exit,
>> +       .set_boost_cpu  = acpi_cpufreq_set_boost_cpu,
>>           .resume         = acpi_cpufreq_resume,
>>           .name           = "acpi-cpufreq",
>>           .attr           = acpi_cpufreq_attr,
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 507224c9ecd3..c4952ca3e8a5 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1669,13 +1669,18 @@ static int cpufreq_add_dev(struct device *dev,
>> struct subsys_interface *sif)
>>           return 0;
>>    }
>>
>> -static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy
>> *policy)
>> +static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy
>> *policy,
>> +                             bool unbinding)
>>    {
>>           int ret;
>>
>>           if (has_target())
>>                   cpufreq_stop_governor(policy);
>>
>> +       if (unbinding && cpufreq_driver->set_boost_cpu &&
>> +           policy->boost_supported)
>> +               cpufreq_driver->set_boost_cpu(cpu, true);
>> +
>>           cpumask_clear_cpu(cpu, policy->cpus);
>>
>>           if (!policy_is_inactive(policy)) {
>> @@ -1730,7 +1735,7 @@ static int cpufreq_offline(unsigned int cpu)
>>
>>           guard(cpufreq_policy_write)(policy);
>>
>> -       __cpufreq_offline(cpu, policy);
>> +       __cpufreq_offline(cpu, policy, false);
>>
>>           return 0;
>>    }
>> @@ -1750,7 +1755,7 @@ static void cpufreq_remove_dev(struct device *dev,
>> struct subsys_interface *sif)
>>
>>           scoped_guard(cpufreq_policy_write, policy) {
>>                   if (cpu_online(cpu))
>> -                       __cpufreq_offline(cpu, policy);
>> +                       __cpufreq_offline(cpu, policy, true);
>>
>>                   remove_cpu_dev_symlink(policy, cpu, dev);
>>
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index ae9d1ce4f49c..c174b013dd76 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -413,6 +413,8 @@ struct cpufreq_driver {
>>           int             (*online)(struct cpufreq_policy *policy);
>>           int             (*offline)(struct cpufreq_policy *policy);
>>           void            (*exit)(struct cpufreq_policy *policy);
>> +       /* Optional */
>> +       void            (*set_boost_cpu)(unsigned int cpu, bool enable);
>>           int             (*suspend)(struct cpufreq_policy *policy);
>>           int             (*resume)(struct cpufreq_policy *policy);
>>
>>
>>
>> Option 2 (lighter, but it is at odds with the direction discussed
>> above): stay in acpi-cpufreq's ->exit() and restore over
>> policy->related_cpus instead.
>>
>>
>>
>>
>> --
>> Thx and BRs,
>> Zhongqiu Han
> 
> While you negotiate the cleanup, should I remove this change from the series?

Thanks a lot Jim for the checking. Maybe Rafael or Viresh can help
comment on this.


Besides, one possible improvement over Option 1 is to leave the
`cpufreq_offline()` API unchanged, and instead move the set boost-bit
callback into `cpufreq_remove_dev()`. To avoid redundant IPIs, place it
after

     if (!cpumask_empty(policy->real_cpus))
         return;

and use `related_cpus` instead of `policy->cpus` (because `policy->cpus`
is emptied after `__cpufreq_offline()` is called).

Pseudo-code:

     scoped_guard(cpufreq_policy_write, policy) {
         if (cpu_online(cpu))
             __cpufreq_offline(cpu, policy);

             remove_cpu_dev_symlink(policy, cpu, dev);

             if (!cpumask_empty(policy->real_cpus))
                 return;

+           if (cpufreq_driver->set_boost_cpu
                 && policy->boost_supported)
+               cpufreq_driver->set_boost_cpu(policy->related_cpus);
+
         /*
          * Unregister cpufreq cooling once all the CPUs of the policy
          * are removed.
          */


-- 
Thx and BRs,
Zhongqiu Han

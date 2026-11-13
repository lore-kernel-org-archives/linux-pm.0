Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572558;
	b=tcCS7sd/OaNnil8iLS4oy1oHPtn4QTl7fTkoASSuHJvBjwje1QBSMamGUeEPM0x1n2XA
	 dWblhr+OOGNIoKrY7fOnDP2hA6QNQWlzV6Np3k+KjKqk38kas5Mr42TWxbmiex62bXBab
	 5hBa7Kmy8LrI+1v2pAvysxDWsKHkWOpnplsDnD5thL0CxRApnbVF9YCCyN7rXynSvaG4G
	 0y97oPtNL6/aIOk5bWyBed57gEs4/6FubOrD+tbdyAshmf5ZUB0jqiHw6eYndV5twG92r
	 rwj6M1QgxnjtLXVl7iJqaiqC5tLsxDD2dPPEpbEh24Gmcm0/LkH7xaxaq8DpQzLRInQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572558;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YAo1zLlVLhEKAZuXE48Hr4BJxq1QQre46sURKuvBtZU=;
	b=SJ6MY+fwUH1jLTSnWgwy3OspobpHrxOEMEJGRUe2r/50o9zMjdfkhPjFEANXS/yBxDnR
	 jFuqLdVd8ZVbuam+vJEDVHKQ7NE7TNTkucMFRh/GabJT3C8C5nDPKGiFtT74Ih05R2riL
	 svUISMhaPkcMbCUWcqy/qeZFpH/sHwUimA0p6yjnSdCFiCnUpUP+iQcgqOPf9YK8cTM9+
	 lPJzPsUl7EUrc3C8kulwEAjOn/7BtWkphXBOfXeIyTKFB0gWCg7prSCKaDouC1yfP0/DA
	 S3TrlaNv0J7L7wNVmJsDUvPxr+qBWP56NRlF8QcUaO8/5OoM4rbzYMntgMVANnWCnhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WIbCwbfA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5015A606A321;
	Fri, 13 Nov 2026 12:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5015A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WIbCwbfA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2C31476;
	Fri, 13 Nov 2026 04:22:33 -0800 (PST)
Received: from [10.0.130.226] (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C81883F673;
	Fri, 13 Nov 2026 04:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794572556; bh=yB5ajDPNptziBf+odg2BIJNAT+vLRPACZNNj0y93rgY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=WIbCwbfAZKuEZf5VjMgWhddgKK7MG5/woeeR99YjgyjLprk78IyhER8/0h6973w9m
	 XGw6Xw02GM5GenxoCwqPb1Ax+shBUUNFiUJYxrvwf/blUKNogqwTt4Z09zqKhBfzf7
	 WFcP8N5MeN58splei0WXW2oYqIgZe6sNTKU5wu/o=
Message-ID: <2b72fea4-b2ba-4ae5-91e8-d5830f024b2f@arm.com>
Date: Fri, 13 Nov 2026 12:22:32 +0000
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
Subject: Re: [PATCH] ACPI: CPPC: Scale EPP values to the register width
From: Christian Loehle <christian.loehle@arm.com>
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com,
 zhangpengjie2@huawei.com, Sumit Gupta <sumitg@nvidia.com>
References: <20261112131316.827708-1-christian.loehle@arm.com>
 <592580a1-ba88-4e22-b586-4aa2425f9760@arm.com>
 <CAJZ5v0gXjngKSxX0Ku2wccWj9+oDQ7YqS6ziFZXDzMgm5GjVzg@mail.gmail.com>
 <f8d23034-0d28-4726-829e-51cf687e5589@arm.com>
 <37efae02-1f49-45ff-9e51-5a6a921ed1d5@kernel.org>
 <4d9261e9-fc66-4197-b3ba-edcc98ffaaf7@arm.com>
Content-Language: en-US
In-Reply-To: <4d9261e9-fc66-4197-b3ba-edcc98ffaaf7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/26 17:19, Christian Loehle wrote:
> On 11/12/26 17:11, Mario Limonciello wrote:
>> On 11/12/26 08:05, Christian Loehle wrote:
>>> On 11/12/26 14:01, Rafael J. Wysocki (Intel) wrote:
>>>> On Thu, Nov 12, 2026 at 2:58 PM Christian Loehle
>>>> <christian.loehle@arm.com> wrote:
>>>>>
>>>>> On 11/12/26 13:13, Christian Loehle wrote:
>>>>>> The EPP sysfs interface uses 0-255, but ACPI permits 4-8 bit fields.
>>>>>> Writing 128 to a 4- or 6-bit SystemMemory field currently succeeds but
>>>>>> stores zero, selecting maximum performance.
>>>>>>
>>>>>> Scale writes to supported narrow EPP registers and normalize reads to
>>>>>> 0-255. Cover both EPP setters and cppc_get_perf() so saved firmware values
>>>>>> round-trip correctly.
>>>>>>
>>>>>> Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous selection")
>>>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>>>> ---
>>>>>>   .../ABI/testing/sysfs-devices-system-cpu      |  5 ++
>>>>>>   drivers/acpi/cppc_acpi.c                      | 46 +++++++++++++++++--
>>>>>>   2 files changed, 47 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>> index d219fc27a0c9..c63b5cfd993c 100644
>>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>> @@ -322,6 +322,11 @@ Description:     Energy performance preference
>>>>>>                performance increase/decrease and the result of the hardware's
>>>>>>                energy efficiency and performance optimization policies.
>>>>>>
>>>>>> +             For supported EPP registers narrower than eight bits, values are
>>>>>> +             scaled and rounded to the nearest hardware preference.
>>>>>> +             Reads use the same 0-255 scale and may differ from the requested
>>>>>> +             value due to the reduced precision.
>>>>>> +
>>>>>>                Writing to this file only has meaning when Autonomous Selection is
>>>>>>                enabled.
>>>>>>
>>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>>> index 11a9f9eb6b4a..10b52163eb56 100644
>>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>>> @@ -38,6 +38,7 @@
>>>>>>   #include <linux/iopoll.h>
>>>>>>   #include <linux/ktime.h>
>>>>>>   #include <linux/list.h>
>>>>>> +#include <linux/math64.h>
>>>>>>   #include <linux/mutex.h>
>>>>>>   #include <linux/rbtree.h>
>>>>>>   #include <linux/rwsem.h>
>>>>>> @@ -2841,6 +2842,25 @@ int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>>>>>>   }
>>>>>>   EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>>>>>
>>>>>> +/* Keep the EPP interface on an 8-bit scale, including firmware readback. */
>>>>>> +static u64 cppc_scale_epp(const struct cpc_register_resource *reg,
>>>>>> +                       u64 epp, bool to_reg)
>>>>>> +{
>>>>>> +     unsigned int width = reg->cpc_entry.reg.bit_width;
>>>>>> +     u32 max;
>>>>>> +
>>>>>> +     if (reg->type != ACPI_TYPE_BUFFER || width < 4 || width >= 8)
>>>>>> +             return epp;
>>>>>> +
>>>>>> +     max = BIT(width) - 1;
>>>>>> +     if (to_reg)
>>>>>> +             return DIV_ROUND_CLOSEST_ULL(epp * max,
>>>>>> +                                          CPPC_EPP_ENERGY_EFFICIENCY_PREF);
>>>>>> +
>>>>>> +     return DIV_ROUND_CLOSEST_ULL(epp * CPPC_EPP_ENERGY_EFFICIENCY_PREF,
>>>>>> +                                  max);
>>>>>> +}
>>>>>> +
>>>>>>   /**
>>>>>>    * cppc_get_epp_perf - Get the epp register value.
>>>>>>    * @cpunum: CPU from which to get epp preference value.
>>>>>> @@ -2850,7 +2870,15 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>>>>>    */
>>>>>>   int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>>>>>   {
>>>>>> -     return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>>>>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     ret = cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>>>>>> +     if (!ret)
>>>>>> +             *epp_perf = cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
>>>>>> +                                        *epp_perf, false);
>>>>>> +
>>>>>> +     return ret;
>>>>>>   }
>>>>>>   EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
>>>>>>
>>>>>> @@ -3150,6 +3178,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>>>        bool auto_sel_non_pcc;
>>>>>>        bool epp_pcc;
>>>>>>        bool epp_non_pcc;
>>>>>> +     u64 epp;
>>>>>>        int ret;
>>>>>>
>>>>>>        if (!cpc_desc) {
>>>>>> @@ -3159,6 +3188,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>>>
>>>>>>        auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>>>>>        epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>>>>> +     epp = cppc_scale_epp(epp_set_reg, perf_ctrls->energy_perf, true);
>>>>>>        if (!enable && auto_sel_reg->type == ACPI_TYPE_INTEGER &&
>>>>>>            auto_sel_reg->cpc_entry.int_value == 1)
>>>>>>                return -EOPNOTSUPP;
>>>>>> @@ -3177,7 +3207,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>>>                        return ret;
>>>>>>        }
>>>>>>        if (epp_non_pcc) {
>>>>>> -             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>>>>>> +             ret = cpc_write(cpu, epp_set_reg, epp);
>>>>>>                if (ret)
>>>>>>                        return ret;
>>>>>>        }
>>>>>> @@ -3205,7 +3235,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>>>                }
>>>>>>
>>>>>>                if (epp_pcc) {
>>>>>> -                     ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>>>>>> +                     ret = cpc_write(cpu, epp_set_reg, epp);
>>>>>>                        if (ret)
>>>>>>                                goto out_unlock;
>>>>>>                }
>>>>>> @@ -3235,9 +3265,17 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>>>>>    */
>>>>>>   int cppc_set_epp(int cpu, u64 epp_val)
>>>>>>   {
>>>>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>>>> +
>>>>>>        if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>>>>>>                return -EINVAL;
>>>>>>
>>>>>> +     if (!cpc_desc)
>>>>>> +             return -ENODEV;
>>>>>> +
>>>>>> +     epp_val = cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
>>>>>> +                              epp_val, true);
>>>>>> +
>>>>>>        return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>>>>>>   }
>>>>>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>>>>>> @@ -3496,7 +3534,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>>>>>                if (ret)
>>>>>>                        goto out_err;
>>>>>>        }
>>>>>> -     perf_ctrls->energy_perf = energy_perf;
>>>>>> +     perf_ctrls->energy_perf = cppc_scale_epp(energy_perf_reg, energy_perf, false);
>>>>>>
>>>>>>        if (CPC_SUPPORTED(auto_sel_reg)) {
>>>>>>                ret = cpc_read(cpu, auto_sel_reg, &auto_sel);
>>>>>
>>>>> +CC Sumit's actual email, sorry about that.
>>>>
>>>> So I'm assuming that this one is for Sumit to pick up and send again
>>>> along with a new version of
>>>>
>>>> https://lore.kernel.org/linux-acpi/20261112080442.4007723-1-sumitg@nvidia.com/
>>>>
>>>> Or please let me know if that is not the case.
>>>
>>> Yup, while it fixes an issue by itself technically, I don't think there
>>> are any affected platforms.
>>> I'm hoping that Sumit this (and the limit-write-at-init) patch as a series
>>> for all our convenience (and hopefully to get Sashiko to review them too).
>>> (I guess I should've mentioned that in the notes.)
>>>
>>> And sorry about ACPI/CPPC having such high traffic lately, I'm expecting once
>>> we've got the issues ironed out and the new features supported it'll be a
>>> lot more boring :)
>>
>> So the basic idea with this patch that the userspace interface is always 8 bit so higher level software will not need to know the lower level implementation detail at the expense of some granularity.
>>
>> Makes sense to me, but I'd like to know how realistic this hardware is going to be.  If it's purely hypothetical hardware; how about proposing to ASWG that this field must always be 8 bit?
> 
> Good point, IMO it's hypothetical hardware that hopefully doesn't and won't exist.
> I'll try to raise this through that channel as well.


Quick update on this, after proposing it, Souvik came back and made me aware that
we've already proposed this:
https://github.com/tianocore/edk2/issues/10838

I guess forget about $SUBJECT after all and I'll probe-fail <8bit and get the amd-pstate
handling correct.

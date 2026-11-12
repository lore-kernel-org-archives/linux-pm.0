Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503476;
	b=m+qHOGIhmAAcSqBG0wxMwzO+WRsEob6+Bv2+a2oI4/I4rT+1nAplRvsFZ9/OWdUy8AQZ
	 PvPyie7VXlTMB8qhSwmuuhzRWYICgJFOO9nKmqAvvR61KXBS9q4edte18Z8Zgw53K3fA6
	 kamH/NhRwgOGcevV5wvdrWDEB5v8Ndsw/oKsodRxAYLE4ec4tDrrPYphgZNSXhvFlZh8C
	 ymU0MhU7ErG9hOLdRiSpVwkCDjj3MCGJSBXBhzUk9KelgXLqIuwyA2d9g+ylnZExFU2d4
	 T17HsC3/bUxYdgbAHTsmnItkGOhiPcVF0N7uRKHYKX7r24BKu9CdVeF4jzrShN+cNsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503476;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CTvgbXSGLGIKG/Z6YrGHR/UoP+rDlUjo6crgPfZvI4c=;
	b=WKi3mU4vcsvpmkjwKqSrNBG4OYpmMX8cO8N6TEbaBn4sLmz52YBzA37TkBlkegerc6r/
	 3t4OPMeOLxx77UgoRmqE7flFIITNq0nCXvSM3sYb/MHnOgt5ovhjbalRr4pN67H+uYTz8
	 LcBVOSiRQpTWLxt27L9wNi1djcSyc5fgbNT4BUKn+hJCsU8/H3FZNOSZq7dFCQAvLdZGS
	 IIpcw/qFKPrhlEeCQscLSZdE23pAmwyGiNFBUMGTyAoMfPPr/7DniTllQT9Dj9oJ8RdZd
	 690WQExCMGneDKm228dOfb2cObIrKl4cXXBv2AvhL6OwnlOVPstQ8phIxx5zGPuwrQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPAYw4NT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D9606A330;
	Thu, 12 Nov 2026 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPAYw4NT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7694D1F000C4;
	Thu, 12 Nov 2026 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503476;
	bh=CTvgbXSGLGIKG/Z6YrGHR/UoP+rDlUjo6crgPfZvI4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aPAYw4NTFLRpCCStsTIDnnWFgzw4DlJ2VrYWkREoJJj4uHP9xlU0M9KUDbQrHOF/P
	 DF4DT68qHPTsTiYg8jhvC5Z+5jmuqKCjSGkR0YM9/objbeBBDedxXNxsjgN4aRu17r
	 HlCAmu2ifIWy5TSpoarHVBtM/K8hRWP4e6E+UJlElV4BUOI58V4rb8P1f3s0JjfxqQ
	 4BPSQuthlUbJ414kR+XLvxMOBE9raw6ItTjUO3ER2lR1xtZT1MPpt4dg0//BvMvxox
	 H514q9g/yIwYhv459cQQI15bt7bJKce2HymPn3tmCLZFWSBMot1/GkDWzoipOBrAC3
	 4RIegtusTmAjg==
Message-ID: <37efae02-1f49-45ff-9e51-5a6a921ed1d5@kernel.org>
Date: Thu, 12 Nov 2026 11:11:13 -0600
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
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com,
 zhangpengjie2@huawei.com, Sumit Gupta <sumitg@nvidia.com>
References: <20261112131316.827708-1-christian.loehle@arm.com>
 <592580a1-ba88-4e22-b586-4aa2425f9760@arm.com>
 <CAJZ5v0gXjngKSxX0Ku2wccWj9+oDQ7YqS6ziFZXDzMgm5GjVzg@mail.gmail.com>
 <f8d23034-0d28-4726-829e-51cf687e5589@arm.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <f8d23034-0d28-4726-829e-51cf687e5589@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/26 08:05, Christian Loehle wrote:
> On 11/12/26 14:01, Rafael J. Wysocki (Intel) wrote:
>> On Thu, Nov 12, 2026 at 2:58 PM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> On 11/12/26 13:13, Christian Loehle wrote:
>>>> The EPP sysfs interface uses 0-255, but ACPI permits 4-8 bit fields.
>>>> Writing 128 to a 4- or 6-bit SystemMemory field currently succeeds but
>>>> stores zero, selecting maximum performance.
>>>>
>>>> Scale writes to supported narrow EPP registers and normalize reads to
>>>> 0-255. Cover both EPP setters and cppc_get_perf() so saved firmware values
>>>> round-trip correctly.
>>>>
>>>> Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous selection")
>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>> ---
>>>>   .../ABI/testing/sysfs-devices-system-cpu      |  5 ++
>>>>   drivers/acpi/cppc_acpi.c                      | 46 +++++++++++++++++--
>>>>   2 files changed, 47 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> index d219fc27a0c9..c63b5cfd993c 100644
>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> @@ -322,6 +322,11 @@ Description:     Energy performance preference
>>>>                performance increase/decrease and the result of the hardware's
>>>>                energy efficiency and performance optimization policies.
>>>>
>>>> +             For supported EPP registers narrower than eight bits, values are
>>>> +             scaled and rounded to the nearest hardware preference.
>>>> +             Reads use the same 0-255 scale and may differ from the requested
>>>> +             value due to the reduced precision.
>>>> +
>>>>                Writing to this file only has meaning when Autonomous Selection is
>>>>                enabled.
>>>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index 11a9f9eb6b4a..10b52163eb56 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -38,6 +38,7 @@
>>>>   #include <linux/iopoll.h>
>>>>   #include <linux/ktime.h>
>>>>   #include <linux/list.h>
>>>> +#include <linux/math64.h>
>>>>   #include <linux/mutex.h>
>>>>   #include <linux/rbtree.h>
>>>>   #include <linux/rwsem.h>
>>>> @@ -2841,6 +2842,25 @@ int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>>>
>>>> +/* Keep the EPP interface on an 8-bit scale, including firmware readback. */
>>>> +static u64 cppc_scale_epp(const struct cpc_register_resource *reg,
>>>> +                       u64 epp, bool to_reg)
>>>> +{
>>>> +     unsigned int width = reg->cpc_entry.reg.bit_width;
>>>> +     u32 max;
>>>> +
>>>> +     if (reg->type != ACPI_TYPE_BUFFER || width < 4 || width >= 8)
>>>> +             return epp;
>>>> +
>>>> +     max = BIT(width) - 1;
>>>> +     if (to_reg)
>>>> +             return DIV_ROUND_CLOSEST_ULL(epp * max,
>>>> +                                          CPPC_EPP_ENERGY_EFFICIENCY_PREF);
>>>> +
>>>> +     return DIV_ROUND_CLOSEST_ULL(epp * CPPC_EPP_ENERGY_EFFICIENCY_PREF,
>>>> +                                  max);
>>>> +}
>>>> +
>>>>   /**
>>>>    * cppc_get_epp_perf - Get the epp register value.
>>>>    * @cpunum: CPU from which to get epp preference value.
>>>> @@ -2850,7 +2870,15 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>>>    */
>>>>   int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>>>   {
>>>> -     return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>>> +     int ret;
>>>> +
>>>> +     ret = cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>>>> +     if (!ret)
>>>> +             *epp_perf = cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
>>>> +                                        *epp_perf, false);
>>>> +
>>>> +     return ret;
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
>>>>
>>>> @@ -3150,6 +3178,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>        bool auto_sel_non_pcc;
>>>>        bool epp_pcc;
>>>>        bool epp_non_pcc;
>>>> +     u64 epp;
>>>>        int ret;
>>>>
>>>>        if (!cpc_desc) {
>>>> @@ -3159,6 +3188,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>
>>>>        auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>>>        epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>>> +     epp = cppc_scale_epp(epp_set_reg, perf_ctrls->energy_perf, true);
>>>>        if (!enable && auto_sel_reg->type == ACPI_TYPE_INTEGER &&
>>>>            auto_sel_reg->cpc_entry.int_value == 1)
>>>>                return -EOPNOTSUPP;
>>>> @@ -3177,7 +3207,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>                        return ret;
>>>>        }
>>>>        if (epp_non_pcc) {
>>>> -             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>>>> +             ret = cpc_write(cpu, epp_set_reg, epp);
>>>>                if (ret)
>>>>                        return ret;
>>>>        }
>>>> @@ -3205,7 +3235,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>                }
>>>>
>>>>                if (epp_pcc) {
>>>> -                     ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>>>> +                     ret = cpc_write(cpu, epp_set_reg, epp);
>>>>                        if (ret)
>>>>                                goto out_unlock;
>>>>                }
>>>> @@ -3235,9 +3265,17 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>>>    */
>>>>   int cppc_set_epp(int cpu, u64 epp_val)
>>>>   {
>>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>> +
>>>>        if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>>>>                return -EINVAL;
>>>>
>>>> +     if (!cpc_desc)
>>>> +             return -ENODEV;
>>>> +
>>>> +     epp_val = cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
>>>> +                              epp_val, true);
>>>> +
>>>>        return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>>>> @@ -3496,7 +3534,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>>>                if (ret)
>>>>                        goto out_err;
>>>>        }
>>>> -     perf_ctrls->energy_perf = energy_perf;
>>>> +     perf_ctrls->energy_perf = cppc_scale_epp(energy_perf_reg, energy_perf, false);
>>>>
>>>>        if (CPC_SUPPORTED(auto_sel_reg)) {
>>>>                ret = cpc_read(cpu, auto_sel_reg, &auto_sel);
>>>
>>> +CC Sumit's actual email, sorry about that.
>>
>> So I'm assuming that this one is for Sumit to pick up and send again
>> along with a new version of
>>
>> https://lore.kernel.org/linux-acpi/20261112080442.4007723-1-sumitg@nvidia.com/
>>
>> Or please let me know if that is not the case.
> 
> Yup, while it fixes an issue by itself technically, I don't think there
> are any affected platforms.
> I'm hoping that Sumit this (and the limit-write-at-init) patch as a series
> for all our convenience (and hopefully to get Sashiko to review them too).
> (I guess I should've mentioned that in the notes.)
> 
> And sorry about ACPI/CPPC having such high traffic lately, I'm expecting once
> we've got the issues ironed out and the new features supported it'll be a
> lot more boring :)

So the basic idea with this patch that the userspace interface is always 
8 bit so higher level software will not need to know the lower level 
implementation detail at the expense of some granularity.

Makes sense to me, but I'd like to know how realistic this hardware is 
going to be.  If it's purely hypothetical hardware; how about proposing 
to ASWG that this field must always be 8 bit?


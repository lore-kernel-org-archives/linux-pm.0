Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0580A45D5E3;
	Mon,  7 Sep 2026 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784635; cv=none; b=VGpaIMrp9G0YgcELWV0KBMOwj+X1kqZDSdZr65dhzvtj/0avl8T9uk2LmXqciHAh2LV0CLoLABAzf7RkPQCNwaq3Hri0cnK4PRUgj12+tuT2FA8qJDfyvag9LMWejG7lD3mKH9XSGp/1gIaUqwuMEsNJ9IbUqAmx+3fbTw9NnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784635; c=relaxed/simple;
	bh=HZnWP2wT1GFo49Qh0J5RHeBx1L13o4io8XkvhExMBZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2DmSHclNVMpU7vQ9CCR3OPOEu4Fgs1SdxkDERUlQjBPrpvpm1osCuPKX2bjhF6LA6YLw9CCoKKUREth/r0Po84D3VS09Qzwyzj/fk7drD4iddYlv+TCnQBwoxfyJRIOKq2kBfZbQoOdTDfn1EXbNuO1wrJxyn8kNQjjNheUd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RDtTGp1h; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RDtTGp1h"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7551476;
	Mon,  7 Sep 2026 05:37:09 -0700 (PDT)
Received: from [10.0.129.7] (unknown [10.0.129.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106B03F7D8;
	Mon,  7 Sep 2026 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788784633; bh=HZnWP2wT1GFo49Qh0J5RHeBx1L13o4io8XkvhExMBZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RDtTGp1hMgwYz145eYNN2/Cpq3Hjt3HQAst6eSjJTVFZGjb05IjbkT5X9F/Ve7rt4
	 6sw6gF/ienaXVbGGalyXSAkvMZKZbp223W9ouT3dhUxO2k5NxThRl3S27a+UMmIY/w
	 ZQXzpWd5UkmcvX0S68Dr2lnUCDuNVqulauH+4+dc=
Message-ID: <ffff3d56-74c7-4980-8831-0aa4fc192f83@arm.com>
Date: Mon, 7 Sep 2026 13:37:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/15] ACPI: CPPC: Clear Performance Limited without a
 stale read
To: Sumit Gupta <sumitg@nvidia.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, Sashiko <sashiko-bot@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260830115644.2056983-1-christian.loehle@arm.com>
 <20260830115644.2056983-16-christian.loehle@arm.com>
 <55a5c9fa-cfd3-4000-b3cc-52c343841c9f@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <55a5c9fa-cfd3-4000-b3cc-52c343841c9f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/7/26 11:33, Sumit Gupta wrote:
> Hi Christian,
> 
> Continuing the discussion from v4 [1].
> 
> 
> On 30/08/26 17:26, Christian Loehle wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> The Performance Limited status bits are sticky and write-zero-to-clear.
>> ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
>> accesses.
>>
>> cppc_set_perf_limited() currently reads the register, computes a new value,
>> and writes it in a separate transaction. If the platform reports another
>> excursion between those transactions, the stale write can clear that new
>> event.
>>
>> Write zero to the requested bits and one to the other defined status bits
>> directly. Keep reserved bits zero as required for hardware status registers
>> by ACPI 6.6 Section 4.6.1. This removes the stale read window.
>>
>> A partial SystemMemory field would still make the generic writer perform a
>> read-modify-write to preserve the containing access unit. The
>> per-descriptor spinlock cannot interlock that RMW with platform updates, so
>> reject clears of such a field. Keep the descriptor mapped and readable,
>> because reading the containing access unit once and extracting the field
>> does not require RMW.
>>
>> Classify a field as a writer during overlap validation only when its _CPC
>> semantics permit writes and its validated resource remains writable. This
>> allows partial Performance Limited fields whose clear path was disabled to
>> share an access unit with other read-only fields, while still rejecting an
>> actual writer in that access unit.
>>
>> Also reject another writable SystemMemory field sharing Performance
>> Limited's access unit. Its RMW could similarly replay stale status bits,
>> and an OSPM lock cannot serialize against the platform.
>>
>> Also reject 64-bit SystemMemory descriptions on 32-bit kernels, where
>> generic readq()/writeq() may be split into two 32-bit operations and cannot
>> provide the required portable interlocked access. A naturally aligned
>> full-width QWord remains supported on 64-bit kernels, where the
>> architecture provides a native 64-bit MMIO accessor.
>>
>> Retain any inaccessible Performance Limited descriptor whose conservative
>> physical range is still locatable, while marking both reads and writes
>> unsupported. This includes a QWord on a 32-bit kernel. Skip its mapping and
>> the flexible-address-space capability gate, because Linux will issue no
>> access, without hiding the asynchronous status range from
>> neighbouring-writer validation. Both the interval registry and pairwise
>> overlap test use the larger of the access unit and logical field span, so a
>> malformed field extending beyond its nominal access unit remains covered.
>>
>> Performance Limited status is not required for CPPC control. If firmware
>> describes it without even a locatable physical range, disable that status
>> register instead of rejecting the processor's otherwise usable _CPC
>> package. Report reads as unsupported rather than returning a synthetic
>> zero, and emit a single warning for each nonfatal fallback.
>>
>> Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 76 +++++++++++++++++++++++++++++-----------
>>   1 file changed, 56 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 25bccd4cfb34..a07440ed7f80 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -443,6 +443,22 @@ static int cpc_validate_sysmem_reg(struct cpc_desc *cpc_desc,
>>          if (!cpc_reg_access_aligned(gas, access_size))
>>                  goto invalid;
>>
>> +       if (reg_idx == PERF_LIMITED) {
>> +               if (access_width == 64 && !IS_ENABLED(CONFIG_64BIT)) {
>> +                       pr_warn("CPU%d: Performance Limited register cannot be accessed atomically; keeping its range reserved\n",
>> +                               cpc_desc->cpu_id);
>> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.read_unsupported = true;
>> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.write_unsupported = true;
>> +                       return 0;
>> +               }
>> +
>> +               if (gas->bit_offset || gas->bit_width != access_width) {
>> +                       pr_warn("CPU%d: Performance Limited register cannot be cleared safely; keeping it readable\n",
>> +                               cpc_desc->cpu_id);
>> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.write_unsupported = true;
>> +               }
>> +       }
> 
> 
> Agreed on the generic behavior. With Bit Width 2 the remaining bits are
> not part of the register, and the driver cannot treat them as reserved.
> 
> On the firmware option, I confirmed with the hardware team that
> bits 31:2 here are unimplemented. They read as zero, have no side
> effects when written, and are unused elsewhere.
> Future firmware can describe the register with Bit Width 32, but systems
> already shipped cannot be updated. For those I have a patch which widens
> the descriptor to the access width, so the clear becomes the single
> DWord write you describe. It is pasted below and same attached.

OK, good.
I'll start carrying a similar quirk like you proposed below on
"NVIDIA", "T41     ", affected_revision, ACPI_SIG_DSDT,
in the next version.

> 
> Testing with that applied uncovered a second issue.
> 
> The commit description says the status bits are write-zero-to-clear.
> I could not find where that is specified, have I missed something?
> ACPI spec describes the register as Read/Write and requires interlocked
> operations, which reads as an expectation of read-modify-write,
> but I found nothing defining what a written one does.

Ah right :/
Yeah that's really unfortunate then...

> 
> Here a written one sets the bit, and the hardware team confirmed the
> register is plain Read/Write on my test platform.
> Writing CPPC_PERF_LIMITED_MASK & ~bits_to_clear therefore sets the bit
> which is not being cleared, and Linux reports an excursion the platform
> never signalled:
> 
>  #cat /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
>  0
>  #echo 0x1 > /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
>  #cat /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
>  2
> 
> The read before the write avoided this, at the cost of the stale read
> race you describe. Clearing both bits would still need no read at all,
> because the value written is zero in either case.
> 
> How would you prefer to handle that?

Yes that's a good question.
I think we should just not support partial clear then.

Reading the spec and given that these are supposed to be short-term
excursions I wouldn't think that keeping the register as read-only makes
much sense, therefore just support full clear and document the race window.
I think dropping the stale read still makes sense, even if it widens the
window, it'll be there anyway.

But I'm happy for Rafael and you to chime in, too! 
Do you have any userspace actually caring about Performance Limited?
What would be the most sane behaviour?
and thanks for testing!

> [snip]

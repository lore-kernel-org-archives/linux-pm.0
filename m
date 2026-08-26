Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03595377ED9;
	Wed, 26 Aug 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755799; cv=none; b=FI5rUUWivV+I3k4bWT08eXCzrgaF5fRWXz3bDkZSoYm2VI08ankdU01LfHjSDvWO9Xy5g1rWe7nGJ4T8jjlmkZAmI9Rj7q26ifGHba0U8jJfqxncmTl8P8IbQz4qqB04cDOgv95NUWcwX9/Cw9SInL+VFg644OFArc+gOoYbW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755799; c=relaxed/simple;
	bh=Vq/2s6AdYn1Pn4WdJkXiT1GDw21jVxXMDQUY35ZN+68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQ92OntDQLLmTszpmsxQeWXm2F5VMMNjPUo7BKUGjF0Al0/3iPYToNzHdZWvD6hN5urNwXSvrSD5pHBhbu9OWnbYDo2CRMN6EaZqGOFBqzSRa1z9x1isbtYfRUHOqBKhD9Vx2pO/sGA2gb2PwworXGcZo43xWhq20h44+fo9cxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bQxfUSG4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bQxfUSG4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564F916F2;
	Wed, 26 Aug 2026 07:49:52 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB583F7D8;
	Wed, 26 Aug 2026 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787755796; bh=Vq/2s6AdYn1Pn4WdJkXiT1GDw21jVxXMDQUY35ZN+68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bQxfUSG40qLrZQvqQ4BNyk7AgtOtwIRKGXqjz5mh7Z/s+HrE6uKmblAaQbH3cYp+I
	 1/rOtb55cTCj3dpsOHazX2WvfwUFChN5GNgbzqpKUvIEt9vrkKeiei5GfP/G4Jn/BJ
	 ziReQTj9X80Df/awG1aOuf6nxtQOn3r9nejQoaQ0=
Message-ID: <d5f1ea9b-53b7-4db2-983a-b5be8e71a371@arm.com>
Date: Wed, 26 Aug 2026 15:49:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] ACPI: CPPC: Clear Performance Limited without a
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
References: <20260826063019.670240-1-christian.loehle@arm.com>
 <20260826063019.670240-16-christian.loehle@arm.com>
 <fd10b117-56c4-4a4d-be36-d083ad0fceae@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <fd10b117-56c4-4a4d-be36-d083ad0fceae@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/26 14:59, Sumit Gupta wrote:
> 
> On 26/08/26 12:00, Christian Loehle wrote:
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
>> Performance Limited status is not required for CPPC control. If firmware
>> describes it using an access which Linux cannot read safely, disable that
>> status register instead of rejecting the processor's otherwise usable _CPC
>> package. Report reads as unsupported rather than returning a synthetic
>> zero, and emit a single warning for each nonfatal fallback.
>>
>> Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
> 
> Performance Limited is readable but not clear-able on my test platform,
> with a warning on every CPU:
> 
>   ACPI CPPC: CPU0: Performance Limited register cannot be cleared safely; keeping it readable
> 
> This occurs with both _CPC revision 3 and revision 4.
> 
> Could clearing remain supported?
> cppc_set_perf_limited() now builds the W0C value without reading the
> register first. Here the field is 2 bits at Bit Offset 0 in a 32-bit
> access unit. If Section 4.6.1 allows bits 31:2 to be treated as
> reserved status bits, the value could be issued as a single 32-bit write
> with those bits zero. That avoids RMW.

Thanks. I agree that a single DWord write would avoid the RMW need but I
don't think we can safely infer that bits 31:2 are reserved.

Section 5.2.3.2 defines Register Bit Width as the size of the given
register, while Access Size only specifies the transaction size.
With Bit Width 2, Table 8.26 designates reserved bits only within that
described register, it does not make the remaining bits of the 32-bit
access unit part of Performance Limited. Those bits could contain
unrelated state which must (generally) be preserved.

> 
> A full-width description already writes zero to the reserved bits.
> Is the same treatment valid for bits outside the GAS Bit Width when
> Bit Offset is zero?
> 

The full-width case is different: Bit Width 32 makes bits 31:2 part of the
Performance Limited register, so Table 8.26 identifies them as reserved and
Section 4.6.1 permits writing zero.

Therefore I think the generic driver must keep a 2-bit/DWord descriptor
readable but not clearable. If this platform guarantees that bits 31:2
have no side effects, firmware should just describe the register with
Bit Width 32? Then the current code would clear it using one DWord write.

Does that make sense? Did I miss anything?

> Apart from this, cppc_cpufreq probes and basic frequency scaling work
> on this platform.
> 

Good to hear and thanks for testing!
(That being said, I'll drop your tags for v5 unfortunately as I have changes
in the middle of the series :/ )

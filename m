Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63B2F30;
	Thu,  6 Aug 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026318; cv=none; b=EmxZTz5O56ydWrvAD3tPhdUvV5qIgrXzvcZ/HB9akdXrOM9/wNPuJOdUWJTLgwQvaCumlU75bi7cwqGMdGda511VhO9hJLpaeSCMboxAHUsHInk0UyoFIHuPpHKevdB0vcSucIap7MFg/F+9HBUI8ZmrWA72a/m8sZ+irSSqH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026318; c=relaxed/simple;
	bh=n41D7CPfzQ0nKdjLa43P+AsHXKSgoqHzBama4K2Rkg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DF+lV1O0GfUmjvkRoBdbymP7q6LjKU4wGIsJ5LI8LP9umZS0DXN6A85q3J0QnnNC1N11XJ27AhThaaTDo/mwfZquSG0QyoMeaP+K5XenC6/7DQbL353Drjab90IFS/hASEbHpBckro4vARy9yOgQrJ+4Cw3bvriqjCNfZLVwHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vT5I0PFZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vT5I0PFZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38F4E153B;
	Thu,  6 Aug 2026 07:25:11 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9163E3F9A2;
	Thu,  6 Aug 2026 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786026315; bh=n41D7CPfzQ0nKdjLa43P+AsHXKSgoqHzBama4K2Rkg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vT5I0PFZETFFuMReGPnZ4ZnuHUB1rg6H28ObX42Ttc9TgtjsB0aZKa56mWN6ax6jR
	 4OaHc6qFYK+5DvKY/C2hCuhbgk1+L1HD3EU3QQosS2pj3KszoSrKH463dR5h05KGLl
	 lFC+cy1jGXWa4ipMPxHz3nH6F9wfcLUTH5GNKtaA=
Message-ID: <cba363cd-8e24-4638-b8c4-3e48d538bb2d@arm.com>
Date: Thu, 6 Aug 2026 15:25:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH 0/3] ACPI: CPPC: Reduce .target() callback
 overhead
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com
References: <20260803210527.1285229-1-christian.loehle@arm.com>
 <f48c36fe-446f-4f83-8d2d-0913aafc377e@arm.com>
 <4bae4fa9-b2fc-48e8-9f11-b3cf520e9c0d@arm.com>
 <CAJZ5v0hkE708Qn5rX26X9i1+tGgoYOYyBmoc0zUw4N7m=r8m3w@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hkE708Qn5rX26X9i1+tGgoYOYyBmoc0zUw4N7m=r8m3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/6/26 11:36, Rafael J. Wysocki (Intel) wrote:
> On Thu, Aug 6, 2026 at 12:05 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 8/3/26 23:28, Christian Loehle wrote:
>>> On 8/3/26 22:05, Christian Loehle wrote:
>>>> cppc-cpufreq reaches cppc_set_perf() from every target callback.  For
>>>> direct SystemMemory controls, that path currently does several steps
>>>> which are unnecessary once the immutable _CPC layout is known:
>>>>
>>>>   - a full-width write first reads the access unit and merges the value.
>>>>   - every write takes the descriptor's RMW lock, even when its access unit
>>>>     is not shared with another _CPC entry.
>>>>   - cppc_set_perf() evaluates the same three PCC predicates at each phase
>>>>     of the transaction.
>>>>
>>>> Remove those costs while retaining the existing conservative paths for
>>>> partial fields, overlapping or malformed access units, and PCC controls.
>>>>
>>>> The series was tested on Arm Power-Orion O6 and AmpereOne systems using
>>>> cppc-cpufreq and schedutil.  An rt-app task pinned to one CPU ran for
>>>> 500 us every 2 ms with uclamp.min=512, for 5000 periods per run.  schedutil
>>>> rate_limit_us was 1000.  cppc_cpufreq_fast_switch() latency was measured
>>>> for 100 ten-second runs.  Each sample is the mean callback latency within
>>>> one run, and the table reports the median and sample standard deviation
>>>> of those samples.
>>>>
>>>> Orion O6               median       stdev       callbacks
>>>> baseline               5703 ns      307 ns       188017
>>>> complete series        5023 ns      240 ns       188209
>>>> ==> 680 ns (11.9%) reduction
>>>>
>>>> AmpereOne              median       stdev
>>>> baseline               2090 ns      157 ns
>>>> complete series      1907.5 ns      140 ns
>>>> ==> 182.5 ns (8.7%) reduction
>>>>
>>>> The cumulative intermediate results on the Orion O6 attribute roughly half
>>>> of the gain to each of the first two patches: avoiding the read reduced
>>>> the median by 284 ns (5.0%), and avoiding the lock reduced it by another
>>>> 336 ns (6.2%).
>>>> Together they account for 620 ns of the 680 ns total reduction.
>>>>
>>>> With the same arm64 configuration and GCC 11.4, caching the PCC predicate
>>>> also reduces cppc_set_perf() from 1124 to 884 bytes.  The generated
>>>> function has 60 fewer instructions, 17 fewer loads and 20 fewer branches.
>>>>
>>>> This series is based on the CPPC fixes posted at (already queued):
>>>> https://lore.kernel.org/lkml/20260722093825.1030594-1-christian.loehle@arm.com/
>>>>
>>>> and the separately posted fix still under review:
>>>> https://lore.kernel.org/lkml/20260724104042.1481804-1-christian.loehle@arm.com/
>>>>
>>>> PS:
>>>> There's a final optimization that I actually wanted to make but decided to
>>>> split it out for now as it somewhat replicated Sumit's series:
>>>> Skipping redundant perf ctrl writes in cpufreq-cppc if registers are non-PCC
>>>> and !shared (because the values are unchanged, the
>>>> !autonomous-common-case), but that requires the driver to have a more
>>>> complex caching- and atomic-updating machinery in place, similar to
>>>> hotplug. As opposed to this series the optimization would be for the
>>>> microcontroller handling the CPPC requests, which may be shared across
>>>> many CPUs and therefore redundant requests can increase the dvfs
>>>> transition latency.
>>>> That patch will follow once Sumit's is queued:
>>>> https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
>>>>
>>>> [RESEND] for the new base-commit specifier below
>>>>
>>>> Christian Loehle (3):
>>>>   ACPI: CPPC: Avoid unnecessary reads for full-width writes
>>>>   ACPI: CPPC: Avoid locking standalone full-width registers
>>>>   ACPI: CPPC: Evaluate performance-control PCC use once
>>>>
>>>>  drivers/acpi/cppc_acpi.c | 135 +++++++++++++++++++++++++++++++--------
>>>>  include/acpi/cppc_acpi.h |   5 +-
>>>>  2 files changed, 113 insertions(+), 27 deletions(-)
>>>>
>>>>
>>>> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
>>>
>>> Nice, so that worked:
>>> https://sashiko.dev/#/patchset/20260803210527.1285229-1-christian.loehle@arm.com
>>> Seems no findings on $SUBJECT but the rest of the comments it has
>>> look legit to me? I'll go take another look tomorrow:
>>
>> So I have patches for these all and will post them in a minute.
>>
>>>
>>> 1. Using per-CPU cpc_desc->rmw_lock for SYSTEM_MEMORY CPPC control register that
>>> may be shared.
>>
>> The solution here sucks unfortunately.
>> Obviously expanding the per-CPU rmw_lock to per-policy is reasonable, but unfortunately
>> that doesn't prevent something like:
>> Policy 0 Desired: address X, bits 7:0,  access size 32
>> Policy 1 Desired: address X, bits 15:8, access size 32
>> which would be a compliant GAS description and would require a global lock for rmw.
>>
>> And of course even worse, now that Desired is write-only rmw isn't possible at all
>> anymore.
>> I'm leaning to just reject these edge-cases that hopefully don't actually exist
>> (and require _CPC rev4 to be full access-unit width)
>> Opinions?
> 
> Fail initialization on insane platform setups I'd say.
> 
> There's no promise that Linux will support compliant setups that are
> too much pain to deal with.

Ok done, I would delay posting until the your bleeding-edge hits linux-next, in the
hopes of being able to supply a valid base-commit for Sashiko.

Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3027603F;
	Mon,  3 Aug 2026 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790897; cv=none; b=ZgvfcnTPZokLgloGYh77M97suGOeA69ss4uuglYx0yGFn2rKVMMvOIRdEHatqy5cMUq6xEd+Tme5bEU2+EByeTmRxcV3MhsbTlkxupVbDilb8diIcK8HQlxrECQBba2jhKF/RhRz+7HdgdsKzfiBk6fedgg3zQi1lmv+golpyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790897; c=relaxed/simple;
	bh=Wo3UhosNuReXPuhyl8gkNEeXHL8AcQ9x7JT/3y2DbCk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GHer7ww/So9wkAy/31Z0jZMp7gn+mRq2pzgrMgcJfuA6TKquPVDMU76pVlDE4CPVWiooqndfdDHO6MDewdoDs7dhOW7YE0VthW2XaMoosnjei3eEahkUEoCS5dLwABQo5AFUQZU0nBM6kvQEMRpMjyrpFyyp5nU3nbsz4872gPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tTRGVtzx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tTRGVtzx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C12143D;
	Mon,  3 Aug 2026 14:01:30 -0700 (PDT)
Received: from [10.57.0.71] (unknown [10.57.0.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7AAB3F632;
	Mon,  3 Aug 2026 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785790894; bh=Wo3UhosNuReXPuhyl8gkNEeXHL8AcQ9x7JT/3y2DbCk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=tTRGVtzx13ytNZogM4Jcx1C+YXiauukr6oPkHy97N++MiYRnM+HM5jabRFiJ946UJ
	 O89DTq1U+qytxnlcmoJ8gN4wA1it4dAPcqtCrftlMjwLUCT4EP5MsY6NMqrEyNKik0
	 ybEd1d5fcjc+1Qlvxe4CJGDk+sfV1CKrHcMB2pM8=
Message-ID: <7a49c06c-a3e2-43d8-b0da-7b4962293429@arm.com>
Date: Mon, 3 Aug 2026 22:01:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: CPPC: Reduce .target() callback overhead
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20260724134251.1632824-1-christian.loehle@arm.com>
 <033eb158-936a-4f79-a134-80402fb018e8@arm.com>
 <CAJZ5v0jFvXKTO7MnC5GHYo85E6NwXQUXRDmmkq1i9BtSbQueAg@mail.gmail.com>
 <e672b3f1-1a43-4f20-a02c-384b283883c9@arm.com>
Content-Language: en-US
In-Reply-To: <e672b3f1-1a43-4f20-a02c-384b283883c9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/3/26 21:46, Christian Loehle wrote:
> On 8/3/26 15:54, Rafael J. Wysocki (Intel) wrote:
>> On Mon, Aug 3, 2026 at 4:07 PM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> On 7/24/26 14:42, Christian Loehle wrote:
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
>>>> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
>>>> prerequisite-patch-id: 4c1f4063800e3658717eb77e43af13dad52d55cc
>>>> prerequisite-patch-id: 5c40d9f099543123c9b904d18ce651e740fbefb8
>>>> prerequisite-patch-id: 7202391dca8f31f9eb8f6d59fc753b3ce665e103
>>>
>>>
>>> I was about the rebase and resend this series but noticed it still applies cleanly
>>> on 7.2-rc6 + ACPI: CPPC: Avoid Desired Performance reads on ACPI 6.6+
>>> https://lore.kernel.org/all/cover.1785749175.git.christian.loehle@arm.com/
>>>
>>> Any comments on this?
>>
>> Sashiko says that it couldn't apply this series:
>>
>> https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
>>
>> Would it apply on top of plain 7.2-rc6?  If so, can you please rebase
>> and resend it?  Or is it linux-next-only?
> 
> Strange, it still works for me, anything I'm missing?
> Anyway I can rebase on v7.2-rc6 and rebase, the desired_perf changes are unrelated,
> but here's my log FWIW:
> 
> # git checkout v7.2-rc6
> # git switch -c cloehle/cppc-target-optimizations-7.2-rc6-test
> # b4 am -c -o - 20260724134251.1632824-1-christian.loehle@arm.com | git am
> Grabbing thread from lore.kernel.org/all/20260724134251.1632824-1-christian.loehle@arm.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 6 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 0 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH 1/3] ACPI: CPPC: Avoid unnecessary reads for full-width writes
>   ✓ [PATCH 2/3] ACPI: CPPC: Avoid locking standalone full-width registers
>   ✓ [PATCH 3/3] ACPI: CPPC: Evaluate performance-control PCC use once
>   ---
>   ✓ Signed: DKIM/arm.com
> ---
> Total patches: 3
> ---
>  Link: https://lore.kernel.org/r/20260724134251.1632824-1-christian.loehle@arm.com
>  Base: using specified base-commit 1590cf0329716306e948a8fc29f1d3ee87d3989f
>        git checkout -b 20260724_christian_loehle_arm_com 1590cf0329716306e948a8fc29f1d3ee87d3989f
> Applying: ACPI: CPPC: Avoid unnecessary reads for full-width writes
> Applying: ACPI: CPPC: Avoid locking standalone full-width registers
> Applying: ACPI: CPPC: Evaluate performance-control PCC use once
> 
> # git log --oneline
> 86f53dfeddb6 (HEAD -> cloehle/cppc-target-optimizations-7.2-rc6-test) ACPI: CPPC: Evaluate performance-control PCC use once
> 61378f475006 ACPI: CPPC: Avoid locking standalone full-width registers
> 0c5b12480412 ACPI: CPPC: Avoid unnecessary reads for full-width writes
> 075b74841bd0 (tag: v7.2-rc6, origin/master, origin/HEAD) Linux 7.2-rc6
> 

Ah looks like sashiko doesn't understand prerequisite-patch-id yet:
https://github.com/sashiko-dev/sashiko/issues/49

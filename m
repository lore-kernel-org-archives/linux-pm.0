Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51A402B83;
	Thu, 26 Mar 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540561; cv=none; b=DszlEZe2ru/3jpqVqni7NuIMz+tyK1K59RIFLkj8s5EnStkzGtNcBm+ZP+mu8X9iHmpXtYZxC7dSB4x04FoZ512QBWLRqHSJzk1tkPMMqWOnB/dM3i5gV3EgJ9F5Hn4EhDFtt+j0xpVw9DgdPTSbU2Hm4LVddEvh4AUOfeMqmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540561; c=relaxed/simple;
	bh=80cTCxXGn1No0eH6ZZ6quKvW+16v7t/ztaonjs6oAeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMUAJKkM0N8sp7Bjz2ONZ7V6TEwr74Nltyvb/Eo3kGtUNHnZTTVXv71Ym6aIhzMAMe4i2mtg2msZB8fOVwas5z2yIlsCyjsbpLCjIm6miIMKjZn2TCxgP1WvYH5EEquz+HNwwYuyiVtZxZculQ3Wn6HAqB9Hs6qwNAELy5Y6sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a1i6PH8Q; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a1i6PH8Q"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 248CE14BF;
	Thu, 26 Mar 2026 08:55:53 -0700 (PDT)
Received: from [10.57.20.244] (unknown [10.57.20.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7293F641;
	Thu, 26 Mar 2026 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774540559; bh=80cTCxXGn1No0eH6ZZ6quKvW+16v7t/ztaonjs6oAeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a1i6PH8QwvqSOjIiHPnpAYxReZYLg2cM9/No1tAISMokRIV5es2lEIMTBM9eZfdQg
	 NKICkvXyRm1ZnjppiETJt3obB/rhI+r0nh+ZrRmHYedzBMiuy7CJBeKRvHuuXhuASc
	 pQiGbEe1z5GXgntWamEaf9fviWlfRiOu43lrMKZU=
Message-ID: <3a1ecb19-779a-418a-bc87-033d16905b46@arm.com>
Date: Thu, 26 Mar 2026 15:55:54 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC
 asymmetry
To: Andrea Righi <arighi@nvidia.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, dietmar.eggemann@arm.com,
 valentin.schneider@arm.com, mingo@redhat.com, rostedt@goodmis.org,
 segall@google.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 juri.lelli@redhat.com, kobak@nvidia.com, fabecassis@nvidia.com
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
 <d40e57e0-aeff-45fb-82c0-6cefc4f4899d@arm.com>
 <CAKfTPtA+rcVCLe5XOKwu+0bsc8_ZXc1TH4qrYo4x5tNwz9ZO5Q@mail.gmail.com>
 <7eccf54f-5a99-40ce-8fbc-b755b4e2d312@arm.com>
 <CAKfTPtAQynr=khJk4amqR2m9bV5gnfi_RMkZj=zs0=gpUFr44w@mail.gmail.com>
 <acU4ZIiGuiDvSL1b@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <acU4ZIiGuiDvSL1b@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 13:45, Andrea Righi wrote:
> On Thu, Mar 26, 2026 at 02:04:42PM +0100, Vincent Guittot wrote:
>> On Thu, 26 Mar 2026 at 10:24, Christian Loehle <christian.loehle@arm.com> wrote:
>>>
>>> On 3/26/26 08:24, Vincent Guittot wrote:
>>>> On Thu, 26 Mar 2026 at 09:16, Christian Loehle <christian.loehle@arm.com> wrote:
>>>>>
>>>>> On 3/26/26 07:53, Vincent Guittot wrote:
>>>>>> On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
>>>>>>>
>>>>>>> The scheduler currently handles CPU performance asymmetry via either:
>>>>>>>
>>>>>>> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
>>>>>>> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
>>>>>>>
>>>>>>> On arm64, capacity-aware scheduling is used for any detected capacity
>>>>>>> differences.
>>>>>>>
>>>>>>> Some systems expose small per-CPU performance differences via CPPC
>>>>>>> highest_perf (e.g. due to chip binning), resulting in slightly different
>>>>>>> capacities (<~5%). These differences are sufficient to trigger
>>>>>>> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
>>>>>>> symmetric.
>>>>>>>
>>>>>>> For such small deltas, capacity-aware scheduling is unnecessarily
>>>>>>> complex. A simpler priority-based approach, similar to x86 ITMT, is
>>>>>>> sufficient.
>>>>>>
>>>>>> I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
>>>>>> move forward.
>>>>>> t
>>>>>> 1st of all, do you target all kind of system or only SMT? It's not
>>>>>> clear in your cover letter
>>>>>
>>>>> AFAIK only Andrea has access to an unreleased asymmetric SMT system,
>>>>> I haven't done any tests on such a system (as the cover-letter mentions
>>>>> under RFT section).
>>>>>
>>>>>>
>>>>>> Moving on asym pack for !SMT doesn't make sense to me. If you don't
>>>>>> want EAS enabled, you can disable it with
>>>>>> /proc/sys/kernel/sched_energy_aware
>>>>>
>>>>> Sorry, what's EAS got to do with it? The system I care about here
>>>>> (primarily nvidia grace) has no EM.
>>>>
>>>> I tried to understand the end goal of this patch
>>>>
>>>> SD_ASYM_CPUCAPACITY works fine with !SMT system so why enabling
>>>> SD_ASYM_PACKING for <5% diff ?
>>>>
>>>> That doesn't make sense to me
>>> I don't know if "works fine" describes the situation accurately.
>>> I guess I should've included the context in the cover letter, but you
>>> are aware of them (you've replied to them anyway):
>>> https://lore.kernel.org/lkml/20260324005509.1134981-1-arighi@nvidia.com/
>>> https://lore.kernel.org/lkml/20260318092214.130908-1-arighi@nvidia.com/
>>>
>>> Andrea sees an improvement even when force-equalizing CPUs to remove
>>> SD_ASYM_CPUCAPACITY, so I'd argue it doesn't "work fine" on these platforms.
>>
>> IIUC this was for SMT systems not for !SMT ones but I might have
>> missed some emails in the thread.
> 
> Right, the issue I'm trying to solve is SD_ASYM_CPUCAPACITY + SMT. Removing
> SD_ASYM_CPUCAPACITY from the equation fixes my issue, because we fall back
> into the regular idle CPU selection policy, which avoids allocating both
> SMT siblings when possible.
> 
> Thanks,
> -Andrea

Could you also report how Grace baseline vs ASYM_PACKING works for your
benchmark? (or Vera nosmt)


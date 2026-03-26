Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F737311942;
	Thu, 26 Mar 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512993; cv=none; b=P81KH2Yg2BX1mPFMymxnIicuyMWm22KS//tRRtBcigmyhIktXHfv2uLNpGgNarzNgJwb5KyJFKRc4Z7Xe4b7DoDkpCg/Ug9Gxke4iNGhRneSoweWOthOreR8HO9rnZTmeMP0pkXYE0vzsJcs33Tp7g625YKgxd2ofJwp/S6hcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512993; c=relaxed/simple;
	bh=uSzdHzc7iNNAsVEdTCi8eeU1q1x62aXOmDMrHAnl+wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTH+Mfbg0L6eNUiYP4UKshQ2646VYloOwBe+qi4Xb3IL/Mv0uxjadGEd5hSbXWt3mQMdJeAbvSkaYAtO7p3FrDc7RVFf6Jd8vW+IsgoyHWQEaN1YTlBRfPiTGn7NekU8GeS752BJU3iX7hn5289KPiDzZy3qeLCgdnsNpBX+GBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TsF8lI7V; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TsF8lI7V"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E5A1AED;
	Thu, 26 Mar 2026 01:16:19 -0700 (PDT)
Received: from [10.57.83.185] (unknown [10.57.83.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 359203FB90;
	Thu, 26 Mar 2026 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774512984; bh=uSzdHzc7iNNAsVEdTCi8eeU1q1x62aXOmDMrHAnl+wY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TsF8lI7Vu7IC+xTC+glzsmcrsLI9DrHVChjUpXqFHWieQ7bnD5jspRMJgKNAugaiJ
	 /ZSth4IUv+10vxjeSbc4LFQXS1HNtJoRR7YyGGBKvG0dkTkfHuhTrN+NJp6yXW/IuD
	 h7MbXft30EHpJj2RwfaBM6eGQDhT10okk3HwIBs8=
Message-ID: <d40e57e0-aeff-45fb-82c0-6cefc4f4899d@arm.com>
Date: Thu, 26 Mar 2026 08:16:20 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC
 asymmetry
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: arighi@nvidia.com, peterz@infradead.org, dietmar.eggemann@arm.com,
 valentin.schneider@arm.com, mingo@redhat.com, rostedt@goodmis.org,
 segall@google.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 juri.lelli@redhat.com, kobak@nvidia.com, fabecassis@nvidia.com
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 07:53, Vincent Guittot wrote:
> On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
>>
>> The scheduler currently handles CPU performance asymmetry via either:
>>
>> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
>> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
>>
>> On arm64, capacity-aware scheduling is used for any detected capacity
>> differences.
>>
>> Some systems expose small per-CPU performance differences via CPPC
>> highest_perf (e.g. due to chip binning), resulting in slightly different
>> capacities (<~5%). These differences are sufficient to trigger
>> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
>> symmetric.
>>
>> For such small deltas, capacity-aware scheduling is unnecessarily
>> complex. A simpler priority-based approach, similar to x86 ITMT, is
>> sufficient.
> 
> I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
> move forward.
> t
> 1st of all, do you target all kind of system or only SMT? It's not
> clear in your cover letter

AFAIK only Andrea has access to an unreleased asymmetric SMT system,
I haven't done any tests on such a system (as the cover-letter mentions
under RFT section).

> 
> Moving on asym pack for !SMT doesn't make sense to me. If you don't
> want EAS enabled, you can disable it with
> /proc/sys/kernel/sched_energy_aware

Sorry, what's EAS got to do with it? The system I care about here
(primarily nvidia grace) has no EM.

> 
> For SMT system and small capacity difference, I would prefer that we
> look at supporting SMT in SD_ASYM_CPUCAPACITY. Starting with
> select_idle_capacity

This series is actually targeted for primarily the !SMT case, although
it may or may not be useful for some of the SMT woes, too!
(Again, I wouldn't know, I don't have such a system to test with)

>[snip]

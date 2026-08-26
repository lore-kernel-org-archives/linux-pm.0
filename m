Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA28B3B7770;
	Wed, 26 Aug 2026 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735240; cv=none; b=E4QOZRq4TtZjfhBiPRR0PhCIz0pJxYj5ntfcMtnAB48wyhoj6bKejKC2tZMMCAQ9ORx4O44+Rekx99sa2BVN43bvJe5iZS8I6M7B+sCs7HR565/sQgCLuqiFoZTVL+IN6nlZLMILrPw5zc1RODyFMfndqoEz3CKLOoxcx6mElRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735240; c=relaxed/simple;
	bh=iVxv0aeOkJqXzhbIw6liWm3Nz8+6mlu/NTd5a4uNkSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jd20EEClugNWfxPtgkrjxrGBUznWPf+4ePjvksHvm7LS26k+FLTKtG9uUmlDn9m6/FcSpMBchXuCO5aRqV9IPyYC/iiJs3LNEM4Zw19yWOu2+zJBaFFYrsZVWH3p6pRGDNQCYcLLBhuQv6mGB0iO3Uqebvb1kjh7pd2g32DEtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ig0v1IvS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ig0v1IvS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294C21684;
	Wed, 26 Aug 2026 02:07:14 -0700 (PDT)
Received: from [10.57.6.192] (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C0BA3F66F;
	Wed, 26 Aug 2026 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787735238; bh=iVxv0aeOkJqXzhbIw6liWm3Nz8+6mlu/NTd5a4uNkSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ig0v1IvS3kNb4YYEuyNqGnsrGuFpayp+JUIhH+nx6UTtlHE+Q/RFpIW57I9eDawme
	 W56zjLUuDf8mXW1k7jw8pgJpl+GMkKxyXxrjfuZ9ZBodNlvsPzrDhhLdLmLIiDAicw
	 SjTRWksmS42V2i39lBuSOrSxH0Pw/ZHEmxzZQG3s=
Message-ID: <146a49c4-5b2a-41db-90fd-6dd2028d2d53@arm.com>
Date: Wed, 26 Aug 2026 10:07:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.com, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260806200857.601152-1-sumitg@nvidia.com>
 <46d81167-1548-4b6a-b6cc-38542b2d093e@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <46d81167-1548-4b6a-b6cc-38542b2d093e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/26 22:20, Sumit Gupta wrote:
> 
> On 07/08/26 01:38, Sumit Gupta wrote:
>> This series keeps the CPPC cpufreq policy alive across CPU hotplug and
>> preserves the OSPM-set CPPC registers (Energy Performance Preference,
>> Autonomous Activity Window, Autonomous Selection - set via sysfs).
>>
>> Without online()/offline() callbacks, the core tears a policy down when
>> its last CPU goes offline and rebuilds it on the way back, re-reading the
>> CPPC capabilities each time. The values written to these registers can
>> be lost:
>>
>>   - Across CPU hotplug or suspend/resume: the platform may reset them
>>     while the CPU is offline.
>>   - On driver unload: the driver-written value is left in the register
>>     instead of returning to its pre-driver state.
>>
>> Handle these with:
>>
>>   - Patch 1: adds online()/offline() callbacks so the core keeps policy
>>     alive across CPU hotplug instead of tearing it down and rebuilding it.
>>   - Patch 2: makes the autonomous selection register helpers take a u64.
>>   - Patch 3: adds a table-driven mechanism that captures each register's
>>     firmware value at init(), restores it from offline(), and reapplies
>>     the OSPM-set value from online().
>>   - Patch 4: extends the same save/restore to system suspend/resume.
> 
> Gentle reminder.
> Could this be considered for queuing if nothing further needs addressing.

FWIW both sashiko findings look legit to me, the feedback counters one I
wouldn't consider that drastic, given that these counters are expected to
have 'fuzzy' readings anyhow, the second one is worse (losing sysfs settings
on cpu_online())


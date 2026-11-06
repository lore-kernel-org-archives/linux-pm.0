Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984380;
	b=qlfeT0YvqSlxHqxJlvnLV3C1kMHy69LyEQZHg45Gv/QcN2gCwODOYOTdRh40DpFv86a5
	 OTQrYUIqOmHY+LbV/o5nEP6N6Og2S95qs+QPuS7g8Kfzr5tn49mIXLiQZhunvxt/gTCHd
	 WdwW4deFGCEt8q+1K839Qb8YvPe4M88BthBerAqXNIY7Au0hdtZx6c82gWRBgZP9STpho
	 AFjsL3Rw7Y6LWRi7q1bLYNdGkRN3iq/EAlGpZ48Mdq8qGdZwlewj8/w70NQdklIYXik+m
	 u088SHuSr1CBLvfr2334UgkyoDss8oTOi22gA7hVh8LaqFYbk7xwSCKIkn5/my+2idg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984380;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TpTj9D+xEplpE+lH6Vyc84lnEW5VEG9Ul1qN0cpTuEU=;
	b=tdBJDF9AKxzfuuEcg9CLYLzAycqsr507FsbhR3UvQvjSSaFcD1rBwvWUuefH9aT+cqS0
	 hrESsech93C6uVOo5CDJPjYV5M4rMMu4cSb1GBBX89rbb2sTDMmSgAaAHjdItPxCZLWXQ
	 Zy+qgLwLTLSHli57SsDgrqOUqaDbRtEt/py/jgGR5iNTmRsk32/noLPQyQ1DrWL0hRCAF
	 QquX1euL8xfxK2XR3hxNmhZ3qH+SiFcg5MaSkvwgFvkI4mf6eBvbQa/xXDtZKW/cQ1sle
	 XrYeEatH7ZQN22kbvNiRgDPaXDl5PL7hxaTvpiEAcobTquFXOLV/ZpAhsF4jHRH9lAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WJagrXmP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C39606A329;
	Fri,  6 Nov 2026 16:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6C39606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WJagrXmP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F17ED15A1;
	Fri,  6 Nov 2026 08:59:35 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B8B53F673;
	Fri,  6 Nov 2026 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793984379; bh=XqRyXiRR2CbxV2R4ByG9xTFNWObHB3B9bQbd9GW01Z8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WJagrXmPzK8oqVSzFewSKf4S/R0uqNaMlJXpNZfos8ganCnWU0v2vcNjxOZfACkO3
	 AinCbJjhVeQizvpbN0JgJIch83gMuHrYHUZlM0Z3blXRzf22ZbKm2zTND2Q6N2eH0x
	 zxji1e5KcxQCxCX0M9DrJzwyzIvAh+fJrg3MNvRM=
Message-ID: <5089e131-c904-471e-a078-5df7cc664372@arm.com>
Date: Fri, 6 Nov 2026 16:59:07 +0000
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
Subject: Re: [PATCH v8 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf
 support
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 mario.limonciello@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20261030172745.2045743-1-sumitg@nvidia.com>
 <CAJZ5v0hDm=FMftFfxnzthRQXWzUqcm8SkAaxzVWZcsyQtNLj6g@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hDm=FMftFfxnzthRQXWzUqcm8SkAaxzVWZcsyQtNLj6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/26 16:08, Rafael J. Wysocki (Intel) wrote:
> Hi Sumit,
> 
> On Fri, Oct 30, 2026 at 6:28 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>> This series adds support for the OSPM Nominal Performance register
>> (ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.
>>
>> Unlike the read-only Nominal Performance register, OSPM Nominal
>> Performance is writable and lets OSPM request a nominal level below
>> the platform-reported nominal. The platform treats performance above
>> this level as boost and below as throttle.
>>
>>  - Patch 1: adds ACPI helpers to write the register and to check that
>>    the platform supports it.
>>
>>  - Patch 2: adds the per-policy ospm_nominal_freq attribute in kHz. The
>>    value is kept across CPU hotplug and suspend/resume. The register
>>    cannot be read back, so a read returns the last value written.
>>
>>  - Patch 3: uses the OSPM nominal as the maximum frequency while boost
>>    is off. Lowering the nominal creates a boost range on a platform
>>    that has none, and boost can then be enabled.
>>
>> This series applies on top of v7 of:
>>   cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>>   https://lore.kernel.org/lkml/20261030092416.1993889-1-sumitg@nvidia.com/
>>
>> v7 -> v8:
>>  - Rebase on Christian's CPPC fixes series.
>>  - Patch 1:
>>    - use cpc_is_writable() from that series and drop cpc_reg_writable().
>>    - add the register to the list of controls the driver writes.
>>    - take cpc_desc_lock in cppc_ospm_nominal_perf_supported(), so the
>>      descriptor cannot be removed during the check.
>>  - Patch 2:
>>    - make ospm_nominal_freq read-write. A read returns the last value
>>      written, or "<unset>" before the first write. (Christian, Mario)
>>    - keep saving the values in the store handler, not at init(), so
>>      the driver writes the register only after the OS sets it. (Pierre)
>>  - Patch 3:
>>    - document in the ABI file how the OSPM nominal sets cpuinfo_max_freq
>>      and caps scaling_max_freq.
>>
>> Sumit Gupta (3):
>>   ACPI: CPPC: Add ospm_nominal_perf support
>>   cpufreq: CPPC: Add ospm_nominal_freq attribute
>>   cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
>>
>>  .../ABI/testing/sysfs-devices-system-cpu      |  31 ++++
>>  drivers/acpi/cppc_acpi.c                      |  44 +++++
>>  drivers/cpufreq/cppc_cpufreq.c                | 173 +++++++++++++++++-
>>  include/acpi/cppc_acpi.h                      |  10 +
>>  4 files changed, 248 insertions(+), 10 deletions(-)
>>
>> v7: https://lore.kernel.org/lkml/20260807214837.863209-1-sumitg@nvidia.com/
>> v6: https://lore.kernel.org/lkml/20260717215330.2215058-1-sumitg@nvidia.com/
>> v5: https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
>> v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/
>> v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/
>> v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
>> v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/
>>
>> --
> 
> This would be good to go except that it doesn't apply for me on top of 7.4-rc1.
> 
> Can you please rebase it and resend, with Christian's tags included?
> 
> Thanks!

It's based on the hotplug/resume series, I guess Sumit could post them as a combined patchset

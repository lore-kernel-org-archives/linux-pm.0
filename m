Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF62499F20
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824619; cv=none; b=Qd18gwtZgEJ8BlfSwIllkw1jfy9W6mnJusa8KRl1Gsa7rCW94HYUNMJhRZO2COulZ3yMUBJnDuvnO6rQk0nmxlbaq8P8g7t8MQZsIMAyjfp8a+ohVD/zQWE96vZ1QvXfh4ciMPPzpds+mHyaLPCJM+TFNF55hTL0sjmfZTZXGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824619; c=relaxed/simple;
	bh=sa5Dltz9jKS1Hc/7BOWrugc65ShvmHZpD72JmQsEcq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpqxEV92pnhQcjDRx20NRLCcsr2cYapNXEx55HEHoJQPuf+e8+2GIEuYJZ9zAfKtnWV1UTj4JbP1SWLrAwLopaIulVgNV0z/lXNy8dBgOj+q21kiqD7SWYhwWMZvqzQvZKk8qMzQLcsqnY2vBdBpv15TsKkYU8jLd8SHQKNaC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QK+XYU/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QK+XYU/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F361F0089C;
	Mon, 12 Oct 2026 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791824618;
	bh=8WQBwopmBsWV4HMoqsZo59nooKNXRYmk7IATRwJ3ilo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QK+XYU/t/HetML9LxHjYVZ8EbZcf4seqYKAOaOUDX+MRksZ089wL8XpRo/CDtM0jx
	 CCeFwnT3RdcA9W2LNBlSl2Uj5+noicBJGa6bJKd4hPD6PS4uD2XoJTmWkanc7G6PB0
	 7PVeHQxznN1XcfPBSIdIcENW5mQWKVxUNklMQtVU/9FJ1qWYxRUwYSKOZQWbdH7l1F
	 Do94tw992RgtIN4Cau1WK3UhPS6b3n68rU71DPqZuvTZpnJI1PSHm1EsNDzOGBkxWI
	 4JRKMfoROAQONeRKqvZRQnmPELD5vHc58AuCVMv1gp3Ixb1odY2+tRx61tHV1veA8a
	 Y7oegwAu9wd8A==
Message-ID: <4e900c35-ccdd-4c86-a5bc-b31f3913c7b8@kernel.org>
Date: Mon, 12 Oct 2026 12:03:37 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] amd-pstate 7.4 content (10/4/26)
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
References: <4bc0e16b-f8a8-49a9-aaab-c7161ffdba89@kernel.org>
 <CAJZ5v0j5Um-NRcgax2ZRfN5NAj=W3ADSe-PiSiQ_sTda86_73g@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0j5Um-NRcgax2ZRfN5NAj=W3ADSe-PiSiQ_sTda86_73g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/26 07:31, Rafael J. Wysocki (Intel) wrote:
> On Sun, Oct 4, 2026 at 3:10 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> The following changes since commit c8663e0457e6e6c72006478f4b6da99060030ec1:
>>
>>     cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation
>> (2026-09-10 14:33:59 -0500)
>>
>> are available in the Git repository at:
>>
>>
>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
>> tags/amd-pstate-v7.4-2026-10-14
>>
>> for you to fetch changes up to 6b64d65c83688db2e58fbd9de7c74090f15271b7:
>>
>>     cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6
>> (2026-10-01 13:05:07 -0500)
>>
>> ----------------------------------------------------------------
>> amd-pstate content for 7.4 (10/4/26)
>>
>> * Fixups for a few bugs identified by Sashiko
>> * Initial support for maximum frequency capacity handling on Zen6 / client
>> * Updated EPP tunings for Zen6 / client
>>
>> ----------------------------------------------------------------
>> Mario Limonciello (7):
>>         cpufreq/amd-pstate: Fix TOCTOU when changing driver mode via sysfs
>>         ACPI: CPPC: Refactor boost ratio handling
>>         cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
>>         cpufreq/amd-pstate: Get Highest Freq for a CPU
>>         cpufreq: amd-pstate: Restore previous mode when changing driver
>> mode fails
>>         cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode
>> change
>>         cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6
>>
>> Vishal Badole (1):
>>         cpufreq: amd-pstate: Update Zen6 client EPP tuning values
>>
>> Wentao Guan (1):
>>         cpufreq/amd-pstate: Skip auto_sel write when it already matches
>> the mode
>>
>> Xueqin Luo (1):
>>         cpufreq/amd-pstate: Restore previous EPP if profile_name
>> allocation fails
>>
>>    arch/x86/kernel/acpi/cppc.c     | 166
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------
>>    drivers/cpufreq/acpi-cpufreq.c  |  17 ++++++++---------
>>    drivers/cpufreq/amd-pstate-ut.c |  54
>> +++++++++++++++++++++++++++++++++++++---------------
>>    drivers/cpufreq/amd-pstate.c    | 116
>> +++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
>>    drivers/cpufreq/amd-pstate.h    |  44
>> ++++++++++++++++++++++++++++++++++++++++++
>>    include/acpi/cppc_acpi.h        |  14 ++++++++++++--
>>    6 files changed, 264 insertions(+), 147 deletions(-)
> 
> Pulled and added to linux-pm.git/linux-next, but please see my
> resolution of the conflict with the acpi-cppc branch in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=71fb903c3dfe94af1a8c6b5df7705747d6ff7f4e
> 
> and let me know if it is correct.
> 
> Thanks!

I glanced through and agree with conflict resolution.

I'll do some tests as well with the linux-pm/linux-next branch and raise 
further patches on top of that if there are any problems.

Thanks!

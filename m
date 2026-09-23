Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E243744F
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143133; cv=none; b=cgIQNIUeRhc224Sd82Mt42S1174bIExMNNFEdRnHXbOylTU9zQL/DVXBAASsz+kl2MIB93lLONgGc93OoLe6Oi4/BawhqGcCK1QVPkwlKkhunpwpAjTsvXouMCCh2ZDRZBsCnkyJQhPqmK7NPDUAL6if49TBWUFLaSKT1kkNEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143133; c=relaxed/simple;
	bh=bjsW+evgoxtyC2kwD5ngm3ZGrGYe6bhP/oC6Xxo7dhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iI9K+9RLTcnuxVdasbqiCwcuK7my+uDRA0ZfbQxgqNN6VMvlcfIcxsHghB00UOOlLpvhYvgK8c6O3Hatcg9tu2fqcDZdN6uSSUNMLJik+CsJlIqCrPX6JV/hIaFK/P78U4QAgcocN2+XRXze+kMvCoesnISi/hrC5pkk1K1RJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=rfNSM4gc; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="rfNSM4gc"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hqR9F58Wkz1tD;
	Wed, 23 Sep 2026 07:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790143121; bh=oJHvayelPIincoQBlhkjSZyMOzAsNnkQN/uvUZ6pPhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rfNSM4gcX+5UYR4FaN22/hr1Vfah5/45b5t7+zlD6sxpPnE7Ug68mBn363bS+uw59
	 SOBQiHDml9uV4Xr4XIlGyfsevUJJc0mydv56ud0dlH0cFZT1IxtdQsNFaG60aMxslW
	 bO+CqPJt9NM/OnY55EPfjTC6bHF4a323cnskHz90=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hqR9D3lQgzBSY;
	Wed, 23 Sep 2026 07:58:40 +0200 (CEST)
Message-ID: <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
Date: Wed, 23 Sep 2026 07:58:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
From: Fourhundred Thecat <400thecat@ik.me>
In-Reply-To: <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: :2997a34c1a6c8c6:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

On 2026-09-22 16:47, Mario Limonciello wrote:
> 
> 
> On 9/22/26 08:43, Fourhundred Thecat wrote:
>> Hi,
>>
>> On a Lenovo ThinkPad P16s Gen 4 AMD (Ryzen AI 9 HX PRO 370, Strix 
>> Point), s2idle enters sleep normally but the machine can never be 
>> woken again and has to be force-powered-off. The trigger is the number 
>> of online logical CPUs: with all 24 threads online the failure is 100% 
>> reproducible, and limiting the kernel to 16 CPUs makes suspend/resume 
>> work reliably.
>>
>> This platform has no S3 at all, so s2idle is the only suspend mode 
>> available.
>>
>>
>> Hardware
>> --------
>>
>>    DMI product name    21RXS07D00
>>    DMI system version  ThinkPad P16s Gen 4 AMD
>>    BIOS                LENOVO R2XET40W (1.20), 05/26/2026
>>    CPU                 AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
>>    CPU family          26, microcode 0xb204037
>>    Topology            12 cores / 24 threads
>>                        4x Zen5  (core_id 0-3)
>>                        8x Zen5c (core_id 8-15)
>>
>>    ACPI: PM: (supports S0 S5)
>>    Low-power S0 idle used by default for system suspend
>>    /sys/power/mem_sleep -> [s2idle]      (no "deep"; DSDT has no _S3_)
>>
>>
>> Kernel
>> ------
>>
>>    6.18.51 x86_64, gcc (Debian 12.2.0-14+deb12u1) 12.2.0
>>    Custom monolithic build, no loadable module support.
>>
>>    Relevant config:
>>      CONFIG_NR_CPUS=32
>>      CONFIG_SUSPEND=y, CONFIG_ACPI_SLEEP=y
>>      CONFIG_AMD_PMC=y, CONFIG_AMD_PMF=y, CONFIG_PINCTRL_AMD=y
>>      CONFIG_DRM_AMDGPU=y, CONFIG_DRM_ACCEL_AMDXDNA=y
>>      CONFIG_THINKPAD_ACPI=y, CONFIG_ACPI_EC=y
>>
>>
>> Reproducer
>> ----------
>>
>>    # echo mem > /sys/power/state
>>
>> The system suspends cleanly. The ThinkPad power LED then shows the 
>> EC's slow breathing pattern, i.e. the ACPI LPS0 _DSM entry path ran 
>> and the EC considers the system asleep.
>>
>> It never wakes again. Tried, with no effect:
>>
>>    - opening the lid
>>    - any key on the internal keyboard
>>    - short press of the power button
>>    - clicking a USB mouse, with power/wakeup set to "enabled" on both
>>      the device (3-2) and its xHCI root hub (usb3)
>>
>> The machine is also not reachable over the network while in this 
>> state, so it is not a case of resuming with a dead display. The only 
>> recovery is a ~10 s power button hold.
>>
>> Wake sources are armed. From /proc/acpi/wakeup:
>>
>>    XHC1  S3  *enabled   pci:0000:c5:00.4
>>    XHC0  S3  *enabled   pci:0000:c7:00.0
>>    XHC3  S3  *enabled   pci:0000:c7:00.3
>>    XHC4  S3  *enabled   pci:0000:c7:00.4
>>    NHI0  S3  *enabled   pci:0000:c7:00.5
>>    NHI1  S3  *enabled   pci:0000:c7:00.6
>>    LID   S4  *enabled   platform:PNP0C0D:00
>>    SLPB  S3  *enabled   platform:PNP0C0E:00
>>
>> and platform/i8042/serio0 power/wakeup is "enabled".
>>
>>
>> Bisect
>> ------
>>
>> The regression was introduced by raising CONFIG_NR_CPUS:
>>
>>    CONFIG_NR_CPUS=16   suspend/resume works
>>    CONFIG_NR_CPUS=32   suspend enters, never wakes    (100% reproducible)
>>
>> Booting the *same* CONFIG_NR_CPUS=32 kernel with nr_cpus=16 on the 
>> command line also works. So the trigger is the number of online 
>> logical CPUs at suspend time, not anything else in the build.
>>
>> NR_CPUS=16 is of course wrong for this CPU -- it silently leaves 8 of 
>> the 24 threads unused -- so this is a workaround, not a fix.
>>
>> At nr_cpus=16 the kernel brings up every core's primary thread plus 
>> only the Zen5 SMT siblings:
>>
>>    cpu0-3     core_id 0-3     Zen5   primary threads
>>    cpu4-11    core_id 8-15    Zen5c  primary threads
>>    cpu12-15   core_id 0-3     Zen5   SMT siblings
>>    (absent)   core_id 8-15    Zen5c  SMT siblings
>>
>> The 8 CPUs that are absent in the working configuration are exactly 
>> the SMT siblings of the 8 Zen5c cores. I have not yet narrowed down 
>> whether the threshold is exactly 17 CPUs or specifically the Zen5c 
>> siblings; I can bisect nr_cpus= further if that is useful.
>>
>>
>> Ruled out
>> ---------
>>
>> None of these had any effect (still hangs with all 24 CPUs online):
>>
>>    initcall_blacklist=amd_pmf_driver_init
>>    initcall_blacklist=amdxdna_pci_driver_init
>>    runtime unbind of amdxdna, amd-pmf and tpm_tis before suspending
>>
>>
>> Possibly relevant
>> -----------------
>>
>> After a *successful* suspend/resume at nr_cpus=16:
>>
>>    /sys/power/suspend_stats/success         1
>>    /sys/power/suspend_stats/total_hw_sleep  0
>>    /sys/power/suspend_stats/last_hw_sleep   0
>>    /sys/power/suspend_stats/max_hw_sleep    18446744073709551615
>>
>> so no hardware sleep residency is recorded even in the configuration 
>> that works. It may be that the working case simply never reaches 
>> hardware s0i3, and that the failure appears only once the SoC does 
>> enter it. I could not confirm this: this build has CONFIG_DEBUG_FS=n 
>> and CONFIG_PM_DEBUG=n, so I have no 
>> /sys/kernel/debug/amd_pmc/s0ix_stats and no /sys/power/pm_test. I can 
>> rebuild with those enabled and re-run whatever you would like to see.
>>
>> Also, the 21RX series has no entry in the fwbug_list DMI table in 
>> drivers/platform/x86/amd/pmc/pmc-quirks.c; the Lenovo entries there 
>> stop at the 2021-era ThinkPads and some 2023 IdeaPads.
>>
>> Happy to run further tests, bisect nr_cpus= to the exact threshold, or 
>> provide full dmesg, ACPI tables or the kernel config.
>>
>> Thanks,
> 
> Try this patch.
> 
> https://lore.kernel.org/all/20260826171537.4167367-1-Vishal.Badole@amd.com/

I don't see how that patch is relevant to my issue or my kernel version 
6.18. There is no cluster code in lib/group_cpus.c and the patch cannot 
be applied.

My report is about the machine never leaving s2idle when more than 16 
CPUs are online.


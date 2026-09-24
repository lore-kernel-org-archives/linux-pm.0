Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8D374E7A
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228185; cv=none; b=igdUDCDxzEsv7zwJ45H8D20JP23zWsLXQp0XW8CzF+0EuTspsn1SbFpf67Lk85Z73fo6du8H5873LS0xKosh5IFifYILvNZGfuooUgr+V93viefwYNobseJLbmBvGZbeGf3zTyYDKogox78oxz0vi89FZ5baeXXNiD1JaJo10o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228185; c=relaxed/simple;
	bh=LNQ6/cxi1/RiLFN1o9CBtzzPi9Abau/Eed0WKkToToM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7WbrjOQCznQZIgXTg0uXVDYIMa6BDFEAV2//WX63Q9nWUyNwsiUqi43WFmrSrPBQ9ariGgSS2eZl0sBQg4ju6JX9DONjV327ynmJxQv3eUsWmzs59r3Xruh4YB82nEFOxTCPGK8Sbww0XoLtUrJGKL5F3YO2gpZwzoP468zafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=2E+gFHzX; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="2E+gFHzX"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hr2ct2bvszbZW
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 07:36:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790228174; bh=9Kyz/rTPJQ9RhsttYivOqfj/H4Czdnx83Wb1MtyABdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2E+gFHzX0/10BKmG5ZkjGMrtO9MbHodUxUvchSGUKWdNGj7EpxmWr7Utb6pbDjS0O
	 +pNPehGh223Fr7g+O34tTY6oYUr0kq+e6Df/I3q/HD6HFgC/lGWl3L2lgz/ttxL9vX
	 xIigYCQAPS5Ed+0G/pgQQD//oROE1Wp5n8BhXOGY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hr2cs1rLfz4TS;
	Thu, 24 Sep 2026 07:36:13 +0200 (CEST)
Message-ID: <da547f98-8bb0-ae1d-ded1-28fde8a64b46@ik.me>
Date: Thu, 24 Sep 2026 07:36:12 +0200
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
To: Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
 <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
 <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
 <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
 <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
 <60a5c26c-8fe2-477f-b576-2a18d8b6394d@amd.com>
 <fc70f3b0-6ac5-7ac9-dca8-595b65785718@ik.me>
 <b29e9341-70cb-4201-99fc-ef307dd10fa5@amd.com>
 <aab50dd0-5141-bded-0b58-0f01ae9621d5@ik.me>
 <c42ab776-6fa9-4e8e-acae-fa921a5ac108@amd.com>
 <0d1686e8-a50e-6f3b-2923-a0eca6ab4271@ik.me>
 <b6015026-fe8c-4823-ad39-c630350c0cc1@amd.com>
 <c58f84c7-bfe6-58db-cad5-6859e96a7daf@ik.me>
 <afb1949a-8465-cfc8-bddb-bc27783af223@ik.me>
 <8f06af84-c0fb-4d24-8868-bf16a1678b4a@amd.com>
Content-Language: en-US
From: Fourhundred Thecat <400thecat@ik.me>
In-Reply-To: <8f06af84-c0fb-4d24-8868-bf16a1678b4a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: :2997a34c1a6c8c6:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

On 2026-09-23 23:10, Mario Limonciello wrote:
> On 9/23/26 15:48, Fourhundred Thecat wrote:
>> the bug reproduces on 7.3-rc4.
>>
>> Built 7.3-rc4 from the torvalds snapshot, migrated my 6.18.51 config 
>> with make olddefconfig, IOMMU enabled, all 24 CPUs online, no IOMMU 
>> boot parameters. Same result: the machine suspends and never wakes, 
>> forced power off required.
>>
>> Both attempts recorded by the same script, neither produced a resume 
>> block:
>>
>>    === 2026-09-23T22:15:02 BEFORE
>>    cmdline:     (6.18.51, no iommu parameters)
>>    cpus online: 0-23
>>    iommu:       ivhd0
>>    ff_rt_clk:   0
>>    S0ix Entry Time: 0 / Exit Time: 0 / Residency Time: 0
>>    suspending with +30s alarm
>>
>>    === 2026-09-23T22:39:06 BEFORE
>>    cmdline:     (7.3.0-rc4, no iommu parameters)
>>    cpus online: 0-23
>>    iommu:       ivhd0
>>    ff_rt_clk:   0
>>    S0ix Entry Time: 0 / Exit Time: 0 / Residency Time: 0
>>    suspending with +30s alarm
>>
>> Both used a programmed RTC wakealarm at +30s and were left untouched 
>> for several minutes.
>>
>> Relevant details of the 7.3-rc4 build, so this is not a configuration 
>> difference:
>>
>>    CONFIG_AMD_IOMMU=y, CONFIG_IOMMU_PT=y, CONFIG_IOMMU_PT_AMDV1=y
>>    CONFIG_NR_CPUS=24, CONFIG_MODULES not set
>>    CONFIG_DEBUG_FS=y, CONFIG_PM_DEBUG=y, CONFIG_DYNAMIC_DEBUG=y
>>    CONFIG_AMD_MP2_STB=y, CONFIG_X86_MSR=y, CONFIG_DMIID=y
>>    CONFIG_LOG_BUF_SHIFT=20, CONFIG_RANDSTRUCT_NONE=y
>>    kernel is not tainted, builds with zero warnings
>>
>> Only 243 config lines differ between my 6.18.51 and 7.3-rc4 configs. 
>> Both commits you pointed me at are present in 7.3-rc4: rtc-cmos uses 
>> platform_get_irq_optional(), and iommu/amd carries the "No ACPI device 
>> matched UID" check. As on 6.18, that FW_BUG message does not appear 
>> here either.
>>
>> Two things worth noting about the 7.3 build specifically. The new 
>> IOMMU page table layer is in use (CONFIG_IOMMU_PT / IOMMU_PT_AMDV1 
>> replacing CONFIG_IOMMU_IO_PGTABLE), so that rework does not change the 
>> outcome. And AMD_PMF and DRM_ACCEL_AMDXDNA are not compiled into 
>> either kernel - DRM_ACCEL and AMD_SFH_HID are both off in my config - 
>> so neither driver is involved in any of these results at all, which is 
>> a stronger statement than the initcall_blacklist tests I reported 
>> earlier.
>>
>> Where that leaves things. With the IOMMU enabled and all 24 CPUs, on 
>> both 6.18.51 and 7.3-rc4:
>>
>>    lid switch, internal keyboard, power button, USB mouse with wakeup
>>    armed, and a programmed ACPI RTC alarm        all fail to wake
>>
>>    intremap=off, iommu=pt, amd_iommu_intr=legacy  all still hang
>>    pm_test freezer / devices / platform           all pass
>>    PC6 and CC6 enabled per amd-s2idle             yes
>>
>>    amd_iommu=off                                  wakes normally,
>>                                                   Last S0i3 Status 
>> Success,
>>                                                   13.3s residency,
>>                                                   pm_wakeup_irq 9
>>
>> Since it fails identically on 6.18 and 7.3 there is no working kernel 
>> version to bisect against. The only variable that changes the outcome 
>> is whether the IOMMU is enabled, and secondarily whether more than 16 
>> CPUs are brought up at boot.
> 
> To me this still feels like a BIOS bug.  I wouldn't discount the 
> possibility that think-lmi didn't apply a setting properly or something 
> like that.
> 
> Can you please try to manually go into your BIOS and reset BIOS default 
> settings?  Does it reproduce with IOMMU left on?

I did another test:

I bootet latest Debian live CD image before touching the BIOS, and it 
reproduces.

Debian live, kernel 7.1.12+deb14-amd64 #1 SMP PREEMPT_DYNAMIC Debian 
7.1.12-1 (2026-08-28). Stock distro kernel with modules, systemd and 
udev, every device driver bound, distro defaults throughout, nothing of 
mine involved except the BIOS settings. echo mem > /sys/power/state 
suspends and never wakes. Forced power off required, same as always.

So my custom kernel configuration is not the cause.

That now leaves three kernels reproducing it:

   6.18.51    my build, minimal config
   7.3-rc4    my build, migrated config
   7.1.12     stock Debian live image, distro config

I will do the BIOS defaults reset next, as you asked.




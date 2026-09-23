Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BF3F58C9
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195198; cv=none; b=iQ4nozGCeEIT2vvJRyk60Tnp1z6/q/IPaBSYvaf83V8W1Ltm4i0lStQr3vziBSXj5spPZ5gLjk+te3bUUCsDUyDgbXSAr7PJJbaHZPOppNyiqdWLtlc+86ceVjcOELxiftrsVKHw5CEofXJtZJIfYZTuemCYab1s+cq5ZYL05AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195198; c=relaxed/simple;
	bh=CAiXicpUK0zsvXmmn7zEgp459ktEYRqf9BYAy1cdfIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFSD1gzt2IwaTniW4v3k6vGpXZQW6GgDl/2TgA5TvfhA9tRAFeaXEgTm3+InQ1oSrP7QFlbYtCNY2cHOvhpogojVJOnbMLTsuBSGWqRdUpJwseTpiZJ14kJWnl5M468P5Ed3nmyy5bc1JwJ9psNRPwFkvHZbe1XwWjgvTSZwUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=NRBlsL7Z; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="NRBlsL7Z"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hqpQT2xFlzD7n;
	Wed, 23 Sep 2026 22:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790195185; bh=mt9OJQU0jMcomdfXNSgK3ZsEgSih5DchkUBTYKiKuek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NRBlsL7Z5R6/VVXRMbKyrL0YQMwQyguEwRsu0m65n3EAtLL5omODE9aZY0Hg9pjrS
	 MPaoJQ1xT1vIvlXGDO+9W/fGutlVk77DuPwdxhVf01faz3MG2rhvgV09fsBdhJdlzL
	 MJTK/NSpQNzAMCF4BHthTgBoopGDJ6w2sp1DMAgc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hqpQS0YQrzRrd;
	Wed, 23 Sep 2026 22:26:24 +0200 (CEST)
Message-ID: <c58f84c7-bfe6-58db-cad5-6859e96a7daf@ik.me>
Date: Wed, 23 Sep 2026 22:26:23 +0200
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
 <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
 <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
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
From: Fourhundred Thecat <400thecat@ik.me>
In-Reply-To: <b6015026-fe8c-4823-ad39-c630350c0cc1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: :2997a34c1a6c8c6:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

On 2026-09-23 21:20, Mario Limonciello wrote:
> 
> 
> On 9/23/26 14:13, Fourhundred Thecat wrote:
>> On 2026-09-23 20:57, Mario Limonciello wrote:
>>>
>>>
>>> On 9/23/26 13:39, Fourhundred Thecat wrote:
>>>> On 23/09/2026 20.25, Mario Limonciello wrote:
>>>>
>>>>>
>>>>> Can you please share your kernel log from this run as well?  It seems
>>>>> that your distro dmesg tool didn't pick it up in the tool run.
>>>>>
>>>>> And can I please see dmesg from a run with amd_iommu=on too.
>>>>>
>>>>>>    🚦 DMI data was not setup
>>>>>
>>>>> What is up with the missing data here?
>>>>>
>>>>> Does your BIOS offer anything to control D3 behavior for the storage?
>>>>>
>>>>> And this other point I mentioned: another useful data point will be
>>>>> whether this can reproduce on 7.3-rc4 with IOMMU enabled to rule out a
>>>>> backport issue.
>>>>
>>>>> Can you please share your kernel log from this run as well?
>>>>
>>>> Attached as dmesg-iommu-off.txt (full log, 1082 lines, 
>>>> amd_iommu=off, 24
>>>> CPUs, the cycle that succeeded). The suspend/resume portion:
>>>>
>>>>    PM: suspend entry (s2idle)
>>>>    Filesystems sync: 0.010 seconds
>>>>    Freezing user space processes
>>>>    Freezing user space processes completed (elapsed 0.001 seconds)
>>>>    OOM killer disabled.
>>>>    Freezing remaining freezable tasks
>>>>    Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
>>>>    PM: Triggering wakeup from IRQ 9
>>>>    ACPI: PM: Rearming ACPI SCI for wakeup
>>>>    amd_pmc: SMU idlemask s0i3: 0xffff9afd
>>>>    PM: Triggering wakeup from IRQ 9
>>>>    ACPI: PM: Rearming ACPI SCI for wakeup
>>>>    PM: Triggering wakeup from IRQ 9
>>>>    amd_pmc: SMU idlemask s0i3: 0xffff9abd
>>>>    ACPI: PM: Rearming ACPI SCI for wakeup
>>>>    amd_pmc: SMU idlemask s0i3: 0xffff9abd
>>>>    PM: Triggering wakeup from IRQ 9
>>>>    PM: Triggering wakeup from IRQ 7
>>>>    ACPI: PM: Wakeup after ACPI Notify sync
>>>>    OOM killer enabled.
>>>>    Restarting tasks: Starting
>>>>    Restarting tasks: Done
>>>>    PM: suspend exit
>>>>
>>>> For reference, IRQ 9 is the ACPI SCI and IRQ 7 is pinctrl_amd, so the
>>>> SCI fires and re-arms several times and the actual wake arrives through
>>>> the AMD GPIO controller.
>>>>
>>>>> And can I please see dmesg from a run with amd_iommu=on too.
>>>>
>>>> I cannot produce one. With the IOMMU enabled the machine never resumes,
>>>> so the ring buffer is lost to the forced power cycle. Streaming it out
>>>> does not work either: dmesg -w and sshd are both frozen by the freezer,
>>>> so over ssh the log stops at
>>>>
>>>>    PM: suspend entry (s2idle)
>>>>    Filesystems sync: 0.011 seconds
>>>>
>>>
>>> I don't need the full run, I'm looking for how it sets up differently.
>>>
>>> I am specifically expecting the message from 
>>> 51c33f333bbf7bdb6aa2a327e3a3e4bbb2591511 to come up and want to 
>>> confirm that.
>>>
>>>> and nothing after that ever leaves the machine. There is no serial port
>>>> on this laptop, and since it hangs rather than panics, pstore captures
>>>> nothing.
>>>>
>>>> What I can send instead is a full kernel log with the IOMMU enabled
>>>> using /sys/power/pm_test=platform, which runs the whole suspend path
>>>> including LPS0 _DSM entry and returns without entering the idle loop.
>>>> That gives you every device callback and the platform prepare with the
>>>> IOMMU active. I will send it in a follow-up unless you would rather 
>>>> have
>>>> something else.
>>>>
>>>>> Uh, the hardware does support a wakealarm.  You might have disabled it
>>>> in your kernel.
>>>>
>>>> I checked, and the relevant options are all enabled:
>>>>
>>>>    CONFIG_RTC_CLASS=y
>>>>    CONFIG_RTC_DRV_CMOS=y
>>>>    CONFIG_RTC_INTF_SYSFS=y
>>>>    CONFIG_RTC_INTF_DEV=y
>>>>    CONFIG_HPET=y
>>>>    CONFIG_HPET_TIMER=y
>>>>    CONFIG_HPET_EMULATE_RTC=y
>>>>
>>>> What happens at boot is:
>>>>
>>>>    hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>>>>    hpet0: 3 comparators, 32-bit 14.318180 MHz counter
>>>>    clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
>>>> max_idle_ns: 133484873504 ns
>>>>    rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
>>>>    rtc_cmos PNP0B00:00: RTC can wake from S4
>>>>    rtc_cmos PNP0B00:00: registered as rtc0
>>>>
>>>> and /proc/driver/rtc reports HPET_emulated: no.
>>>>
>>>> As far as I can follow it, HPET is registered as a clocksource only and
>>>> legacy replacement is never enabled, so is_hpet_enabled()
>>>> (is_hpet_capable() && hpet_legacy_int_enabled) is false. That makes
>>>> use_acpi_alarm_quirks() return at its "if (!is_hpet_enabled()) return;"
>>>> check, so use_acpi_alarm stays false, and use_hpet_alarm() is false 
>>>> too.
>>>> ACPI does not give PNP0B00 an interrupt resource, so
>>>> is_valid_irq(rtc_irq) fails and cmos_do_probe() takes the else branch
>>>> that does clear_bit(RTC_FEATURE_ALARM, ...), which is why there is no
>>>> wakealarm attribute.
>>>
>>> I think you're missing commit e9f850ba66cdf6b77fb4f005e46c4b605c4de434.
>>>
>>>>
>>>>>   🚦 DMI data was not setup
>>>>> What is up with the missing data here?
>>>>
>>>> CONFIG_DMIID is not set in my config, so /sys/class/dmi/id does not
>>>> exist. DMI itself is scanned normally:
>>>>
>>>>    DMI: LENOVO 21RXS07D00/21RXS07D00, BIOS R2XET40W (1.20 ) 05/26/2026
>>>>
>>>> so dmi_check_system() quirks do apply. I will enable CONFIG_DMIID in 
>>>> the
>>>> next build so the tool stops reporting it.
>>>>
>>>>> Does your BIOS offer anything to control D3 behavior for the storage?
>>>>
>>>> No. I dumped all 96 attributes exposed by think-lmi and there is 
>>>> nothing
>>>> for storage power management or D3. The only storage related entries 
>>>> are
>>>> HardDiskPasswordControl and BlockSIDAuthentication, both access control
>>>> rather than power.
>>>
>>> I don't know for sure if Think LMI will export all BIOS options in 
>>> the BIOS GUI.
>>>
>>>>
>>>>> whether this can reproduce on 7.3-rc4 with IOMMU enabled to rule out a
>>>> backport issue
>>>>
>>>> i will try to test 7.3-rc4  as you suggest
>>>
>>> OK.
>>
>>  > I am specifically expecting the message from 51c33f333bbf to come 
>> up and want to confirm that.
>>
>> That commit is in my tree, but the message does not appear. Booted 
>> with the IOMMU enabled, 24 CPUs, no IOMMU parameters, the only thing 
>> matching is the unrelated generic ACPI one:
>>
>>    dmesg | grep -iE 'FW_BUG|Firmware Bug|matched UID|MSFT0201|acpihid'
>>    AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
>>    ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>>    platform MSFT0201:00: Adding to iommu group 0
>>
>> No "No ACPI device matched UID, but N device(s) matched HID." The UIDs 
>> agree on this machine:
>>
>>    IVRS:  hid:MSFT0201, uid:1, rdevid:0x60
>>    ACPI:  MSFT0201:00, _UID = 1, path \_SB_.MHSP
>>
>> so get_acpihid_device_id() matches on the first pass and fw_bug is 
>> never set. Same device path as in your commit, but this BIOS appears 
>> to have consistent UIDs.
>>
>> The full AMD-Vi block for this boot:
>>
>>    ACPI: IVRS 0x000000006B1BF000 0001F6 (v02 LENOVO TP-R2X   00001200 
>> PTEC 00000002)
>>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID00, rdevid:0xa0
>>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID01, rdevid:0xa0
>>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID02, rdevid:0xa0
>>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID03, rdevid:0x98
>>    AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
>>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID04, rdevid:0x98
>>    AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x10
>>    pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
>>    AMD-Vi: Extended features (0x246577efa2254afa, 0x10): PPR NX GT [5] 
>> IA GA PC GA_vAPIC
>>    AMD-Vi: Interrupt remapping enabled
>>    AMD-Vi: Virtual APIC enabled
>>
>> One thing that may be worth your attention anyway: MSFT0201:00 is the 
>> only ACPI HID device in any IOMMU group on this system, alone in group 
>> 0. It is not the TPM - tpm0 is MSFT0101:00. So the single non-PCI 
>> device the IOMMU manages here is Pluton.
>>
> 
> Got it.  Then this is likely not a Pluton/TPM related issue as it 
> originally seemed as the BIOS has that UID aligned.
> 
>> For what it is worth, when I tested with PlutonSecurityProcessor set 
>> to Disable earlier in this thread the machine still failed to wake, 
>> though I did not check at the time whether MSFT0201 was still present 
>> in the IVRS in that configuration. I can re-run that combination and 
>> capture the IVRS block if it would help.
>>
>>  > I think you're missing commit e9f850ba66cd.
>>

e9f850ba66cd works, thank you. With it applied I get 
/sys/class/rtc/rtc0/wakealarm and the -ENXIO message is gone:

   rtc_cmos PNP0B00:00: RTC can wake from S4
   rtc_cmos PNP0B00:00: registered as rtc0
   rtc_cmos PNP0B00:00: alarms up to one month, y3k, 114 bytes nvram
   8: ... IO-APIC 8-edge rtc0

With amd_iommu=off and all 24 CPUs I now get fully unattended timed cycles:

   pm_wakeup_irq:        9
   Last S0i3 Status:     Success
   Time (in us) to S0i3: 430540
   Residency Time:       13282379
   last_hw_sleep:        13282379
   ff_rt_clk:            incremented on each cycle

One small platform note in case it is useful to you: IRQ 8 never fires 
on this machine while the system is running. If I arm an alarm and poll, 
the alarm counts down and expires exactly on schedule but the IRQ 8 
counter stays at zero:

   t=0   arming +8       irq8=0
   t=1-7 wakealarm=1790194169   irq8=0
   t=8   wakealarm=''           irq8=0
   t=15  wakealarm=''           irq8=0

Identical with the IOMMU on and off, so it is not an interrupt remapping 
effect. The wake itself comes through the ACPI fixed-feature RTC event 
rather than IRQ 8, which is why it works anyway: ff_rt_clk increments 
and pm_wakeup_irq reports 9. IRQ 8 does register a single count at 
resume time.

Now the part that matters. With the IOMMU enabled and all 24 CPUs, the 
same timed suspend does not wake. Recorded before the cycle:

   === 2026-09-23T22:15:02 BEFORE
   cmdline:     (no iommu parameters)
   cpus online: 0-23
   iommu:       ivhd0
   ff_rt_clk:   0
   S0ix Entry Time: 0
   S0ix Exit Time: 0
   Residency Time: 0
   suspending with +30s alarm

Nothing was written after that. The machine never resumed and needed a 
forced power off.

So with the IOMMU enabled, every independent wake mechanism on this 
machine has now been tried and none of them work:

   lid switch (PNP0C0D)                          no wake
   internal keyboard (i8042, via AMD GPIO)       no wake
   power button (ACPI fixed feature)             no wake
   USB mouse, wakeup armed on device and hub     no wake
   ACPI fixed-feature RTC alarm                  no wake

The last one seems the most pointed to me. The RTC alarm wakes the 
machine through the ACPI SCI on IRQ 9, and that is exactly the path that 
works when amd_iommu=off - pm_wakeup_irq reports 9 on every successful 
cycle. With the IOMMU enabled the same mechanism produces nothing at 
all, and ff_rt_clk stays at 0 across the attempt.

Still to come: the 7.3-rc4 test, and a manual walk through BIOS setup 
looking for storage link power or D3 controls that think-lmi does not 
export.


Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67D4195B5
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186579; cv=none; b=uWHEdieqSWWu9lLJ2yU4hGUqradjkOXKNnm6qVzLp2t62xnUqptU1duZfWNXjN2R1RPBVZo38EnY6FXAHNMeE8TNs+3cGrGbYDIHW6DABUACTfgUCqNLOSl+vP14VCWJIjcNBIdf3CzFnh5J4D/psG6z8Yhx44FL7ZEBQidq4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186579; c=relaxed/simple;
	bh=6Fhn3LcQSxel8168MWC8Ii845PzchB1YkEcncVa+0WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXqjwdW3HmJu05npGGJj0aAuXMVzuPVjRbBN/K6NvzHbNWO2Xs8qbNW6mvmeTiMCTZC5+J+DGTo310rNmxS0rv4Bu3mUOlx4GXAFRe1dv5m2eK+nL+eNhBPI82j7GIL+Pau2jBQEGWYId670yYagbeht6kCxqM6p9Yq0sEPt+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=W+i+ky7x; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="W+i+ky7x"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hqlDk40jsz9bK;
	Wed, 23 Sep 2026 20:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790186566; bh=Xp+aUCQ7XOEO9uwGvASiw1/bdlUL2Rm4MvXX255jhi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W+i+ky7xSG698Nc5AIJWAu+VIWCkBuAGM3lU8DPmGVJYnyPclby6qTQrZEt0pSHFM
	 PbQONcMwEdsJgMe3dx0HxZMP1v13fXlOUjdPzAmKs0ynCAmrHRlSLDI4ijBlsKh9qx
	 0oybAe8UESRjbPD9Ka2bZ8RDbb9MNYIhhfmbIJDI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hqlDj2Bktzgg1;
	Wed, 23 Sep 2026 20:02:45 +0200 (CEST)
Message-ID: <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
Date: Wed, 23 Sep 2026 20:02:44 +0200
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
From: Fourhundred Thecat <400thecat@ik.me>
In-Reply-To: <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: :2997a34c1a6c8c6:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

On 2026-09-23 18:59, Mario Limonciello wrote:
> 
> 
> On 9/23/26 11:54, Fourhundred Thecat wrote:
>> On 2026-09-23 18:41, Mario Limonciello wrote:
>>>
>>>
>>> On 9/23/26 11:37, Fourhundred Thecat wrote:
>>>> On 2026-09-23 18:20, Mario Limonciello wrote:
>>>>>
>>>>>
>>>>> On 9/23/26 11:15, Mario Limonciello wrote:
>>>>>>
>>>>>>
>>>>>> On 9/23/26 11:12, Fourhundred Thecat wrote:
>>>>>>> On 2026-09-23 16:36, Mario Limonciello wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Some other thoughts that might be the root cause based on other 
>>>>>>>> historical issues.
>>>>>>>>
>>>>>>>> 1) Have you changed TPM policy or Pluton policy in BIOS setup? 
>>>>>>>> What did you change it from and to.
>>>>>>>> 2) Have you enabled a storage security password?  If you disable 
>>>>>>>> it does it help this issue?
>>>>>>>> 3) Do you have WWAN in your device?  If you disable it does it 
>>>>>>>> help?
>>>>>>>> 4) Does booting with `amd_iommu=off` help?
>>>>>>>
>>>>>>> 4) amd_iommu=off
>>>>>>>
>>>>>>> Yes, that fixes it. With amd_iommu=off and all 24 CPUs online, 
>>>>>>> suspend/ resume works reliably.
>>>>>>>
>>>>>>> So this is not really a CPU count problem. nr_cpus=16 was only 
>>>>>>> masking an IOMMU interaction. But narrowing it further was 
>>>>>>> surprising: neither of the IOMMU's two functions is responsible 
>>>>>>> on its own. All of the following were run with all 24 CPUs 
>>>>>>> online, and I verified in each case that the parameter actually 
>>>>>>> took effect:
>>>>>>>
>>>>>>>    amd_iommu=off            IOMMU off entirely WAKES
>>>>>>>    intremap=off             IR off, DMA remapping on no wake
>>>>>>>    iommu=pt                 DMA passthrough, IR on no wake
>>>>>>>    amd_iommu_intr=legacy    legacy GA mode, IR on, DMA on no wake
>>>>>>>
>>>>>>> Verification for each:
>>>>>>>
>>>>>>>    intremap=off           /proc/interrupts went from 58 IR- lines 
>>>>>>> to 0,
>>>>>>>                           and irq 1 (i8042) is no longer IR-IO-APIC.
>>>>>>>                           iommu still enabled, domain type 
>>>>>>> Translated.
>>>>>>>    iommu=pt               "iommu: Default domain type: 
>>>>>>> Passthrough (set via
>>>>>>>                           kernel command line)", all 40 PCI 
>>>>>>> devices in
>>>>>>>                           identity domains, IR still on (58 IR- 
>>>>>>> lines).
>>>>>>>    amd_iommu_intr=legacy  "AMD-Vi: Virtual APIC enabled" no 
>>>>>>> longer printed,
>>>>>>>                           only "AMD-Vi: Interrupt remapping 
>>>>>>> enabled".
>>>>>>>
>>>>>>> So only disabling the IOMMU outright helps. Turning off interrupt 
>>>>>>> remapping alone, bypassing DMA translation alone, or dropping out 
>>>>>>> of vAPIC/GA mode all still hang.
>>>>>>>
>>>>>>> The CPU dependency is still there on top of that. With the IOMMU 
>>>>>>> enabled, nr_cpus=16 works and 24 CPUs hangs. Offlining cpu16-23 
>>>>>>> by hotplug after booting with all 24 does not help; the CPUs have 
>>>>>>> to never be brought up. cpu16-23 here are the second SMT thread 
>>>>>>> of the eight Zen5c cores (APIC ids 17,19..31).
>>>>>>>
>>>>>>> Both conditions appear to be required: the IOMMU enabled, and 
>>>>>>> more than 16 CPUs brought up at boot. Either one alone is fine.
>>>>>>>
>>>>>>>
>>>>>>> 1) TPM / Pluton policy
>>>>>>>
>>>>>>> Current values:
>>>>>>>
>>>>>>>    TpmSelection            = DiscreteTPM2.0   (possible: 
>>>>>>> DiscreteTPM2.0;PlutonTPM2.0)
>>>>>>>    PlutonSecurityProcessor = Disable
>>>>>>>    SecurityChip            = Enable
>>>>>>>
>>>>>>> The TPM that binds is a discrete STMicro part, tpm0 -> STM0925:00.
>>>>>>>
>>>>>>> I did change this. As I recall I disabled Microsoft Pluton, which 
>>>>>>> moves the TPM selection off the PlutonTPM2.0 default onto the 
>>>>>>> discrete part, so Enable -> Disable for Pluton and PlutonTPM2.0 
>>>>>>> -> DiscreteTPM2.0 for the selection. I will confirm the exact 
>>>>>>> original values in setup. I have not yet tested whether restoring 
>>>>>>> the Pluton default changes the behaviour, since the IOMMU result 
>>>>>>> looked more promising.
>>>>>>>
>>>>>>>
>>>>>>> 2) Storage security password
>>>>>>>
>>>>>>> None enrolled. HardDiskPasswordControl=Disable, and the HDD, 
>>>>>>> NVMe, Admin, System and Power-on authentication slots all report 
>>>>>>> is_enabled=0. BlockSIDAuthentication=Enable is the only non- 
>>>>>>> default setting in that area. Nothing to disable, so nothing to 
>>>>>>> test.
>>>>>>>
>>>>>>>
>>>>>>> 3) WWAN
>>>>>>>
>>>>>>> Yes: Quectel [1eac:1007] at 0000:c4:00.0, attached over MHI, 
>>>>>>> exposing wwan0. Its power/wakeup is enabled. Not yet tested with 
>>>>>>> WirelessWANAccess disabled in BIOS.
>>>>>>>
>>>>>>>
>>>>>>> so please suggest which test I should do next, now that we have 
>>>>>>> more info
>>>>>>
>>>>>> Of your above the most likely cause is PlutonSecurityProcessor = 
>>>>>> Disable.  Please try to re-enable that and then try with IOMMU 
>>>>>> enabled.
>>>>>
>>>>> BTW - what version of amd-s2idle didn't flag this?  I am surprised, 
>>>>> we had a check for this that /should/ have failed prerequisites.
>>>>
>>>> Tested, and it does not help.
>>>>
>>>>    PlutonSecurityProcessor  Disable -> Enable
>>>>    TpmSelection             DiscreteTPM2.0 -> PlutonTPM2.0
>>>>    SecurityChip             Enable -> Active
>>>>
>>>> With those set, IOMMU enabled, no IOMMU boot parameters and all 24 
>>>> CPUs online, the machine still does not wake.
>>>
>>> That's interesting.  We'll have to see what the report shows if it's 
>>> not the Pluton setting.
>>>
>>>>
>>>> Worth noting what that test also covers: with Pluton selected the 
>>>> TPM presents through the CRB interface (MSFT0101:00, status=15), and 
>>>> this kernel has CONFIG_TCG_CRB=n. So during that suspend Linux had 
>>>> no TPM driver bound at all -- no /sys/class/tpm, no /dev/tpm0, and 
>>>> the discrete STM0925 was gone from the platform bus. Previously 
>>>> tpm_tis was bound to STM0925:00. So this rules out the tpm_tis 
>>>> driver as a factor as well as the Pluton policy.
>>>>
>>>> Current state of what is ruled out, all with the IOMMU enabled and 
>>>> 24 CPUs online:
>>>>
>>>>    amd_pmf                  initcall_blacklist=amd_pmf_driver_init 
>>>> no wake
>>>>    amdxdna (NPU) initcall_blacklist=amdxdna_pci_driver_init no wake
>>>>    TPM driver               no driver bound at all (Pluton/CRB, no 
>>>> CONFIG_TCG_CRB)  no wake
>>>>    Pluton policy            Pluton enabled, PlutonTPM2.0 no wake
>>>>    interrupt remapping      intremap=off (verified: 0 IR- lines) no 
>>>> wake
>>>>    DMA remapping            iommu=pt (verified: Passthrough, 
>>>> identity) no wake
>>>>    vAPIC / GA mode          amd_iommu_intr=legacy (verified) no wake
>>>>
>>>> The only two things that let it wake are amd_iommu=off with all 24 
>>>> CPUs, or the IOMMU enabled with nr_cpus=16. Offlining cpu16-23 by 
>>>> hotplug after booting with all 24 does not work; they have to never 
>>>> be brought up.
>>>
>>> No.  nr_cpus=16 wasn't a pass.  Don't treat it as such.  You didn't 
>>> get to HW sleep.  Let's please not conflate changing NR CPUs.  Let's 
>>> figure out what's wrong with all CPUs enabled and IOMMU enabled, and 
>>> then peel it back if you need to turn off CPUs.
>>>
>>>>
>>>> I am rebuilding now with CONFIG_DEBUG_FS, CONFIG_PM_DEBUG, 
>>>> CONFIG_DYNAMIC_DEBUG and CONFIG_AMD_MP2_STB so I can run amd-s2idle 
>>>> and send you the report from the working nr_cpus=16 configuration.
>>>
>>> So you didn't run it yet?  I thought you said it failed.
>>>
>>
>>  > No.  nr_cpus=16 wasn't a pass.  Don't treat it as such.  You didn't 
>> get
>>  > to HW sleep.  Let's please not conflate changing NR CPUs.
>>
>> Agreed, I will drop it from the framing.
>>
>> That does leave a gap in my own data which I should close: I never 
>> measured whether amd_iommu=off reaches hardware sleep either. I only 
>> recorded total_hw_sleep=0 for the nr_cpus=16 case and did not check 
>> the counter after an amd_iommu=off resume. If that is also 0 then 
>> nothing on this machine has ever reached s0i3, and the wake failure is 
>> a second- order effect rather than the thing to chase. I will measure it.
>>
>> I would also like to confirm the counter is meaningful here before 
>> drawing conclusions from it. max_hw_sleep reads 18446744073709551615, 
>> which looks like an unpopulated value, so total_hw_sleep=0 may be a 
>> reporting gap rather than a real zero. With CONFIG_DEBUG_FS and 
>> CONFIG_AMD_MP2_STB in the new build I can read /sys/kernel/debug/ 
>> amd_pmc/s0ix_stats directly instead of inferring it from suspend_stats.
> 
> I don't care about max_hw_sleep.  It's a hardcoded value.
> 
> https://docs.kernel.org/admin-guide/abi-testing.html#abi-sys-power-suspend-stats-max-hw-sleep
> 
>>
>>  > So you didn't run it yet?  I thought you said it failed.
>>
>> Correct, I have not run amd-s2idle yet. 
> 
> 
> That should have been your first debugging step.

Rebuilt with CONFIG_DEBUG_FS, CONFIG_PM_DEBUG, CONFIG_DYNAMIC_DEBUG, 
CONFIG_AMD_MP2_STB, CONFIG_X86_MSR and a larger log buffer, and removed 
CONFIG_RANDSTRUCT so the kernel is no longer tainted. Prerequisites now 
pass. Run below is with all 24 CPUs online, IOMMU enabled, no IOMMU boot 
parameters.

amd-s2idle prerequisites:

   AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M (family 1a model 24)
   DMI data was not setup
   Debian GNU/Linux 12 (bookworm)
   Kernel 6.18.51
   Battery BAT0 (SMP 5B11H56412) is operating at 102.35% of design
   ASPM policy set to 'default'
   GPIO driver `pinctrl_amd` available
   PMC driver `amd_pmc` loaded (Program 11 Firmware 93.23.0)
   PCIe hotplug driver `pciehp` loaded
   USB3 driver `xhci_hcd` bound to 0000:c5:00.4, 0000:c7:00.0, 
0000:c7:00.3, 0000:c7:00.4
   USB4 driver `thunderbolt` bound to 0000:c7:00.5, 0000:c7:00.6
   System is configured for s2idle
   GPU driver `amdgpu` bound to 0000:c5:00.0
   PC6 and CC6 enabled
   SMT enabled
   IOMMU properly configured
   ACPI FADT supports Low-power S0 idle
   Logs are provided via dmesg, timestamps may not be accurate over 
multiple cycles
   LPS0 _DSM enabled
   WLAN driver `mt7925e` bound to 0000:c2:00.0
   No RTC device found, please manually wake system

Two notes on the remaining warnings. The DMI one is a false positive 
here: this kernel has CONFIG_DMIID=n so /sys/class/dmi/id does not 
exist, but DMI itself is scanned normally ("DMI: LENOVO 
21RXS07D00/21RXS07D00, BIOS R2XET40W (1.20 ) 05/26/2026") and 
dmi_check_system() quirks do apply. The RTC one is real: this machine 
reports "rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found", so 
RTC_FEATURE_ALARM is cleared and there is no wakealarm to program. 
use_acpi_alarm_quirks() should match here (AMD, BIOS year 2026, HPET 
enabled) but the feature bit is cleared purely on IRQ absence, so it 
cannot take effect.

I cannot give you a report file for the failing configuration, because 
the tool writes it after resume and the machine never resumes. The 
kernel log also cannot be captured past the freezer: dmesg -w over ssh 
stops as soon as user space is frozen. All I get is:

   PM: suspend entry (s2idle)
   Filesystems sync: 0.011 seconds

There is no serial port on this machine and no panic, so pstore captures 
nothing either.

What is more useful is a /sys/power/pm_test bisect, all with 24 CPUs and 
the IOMMU enabled:

   freezer     pass
   devices     pass, every device callback returned 0, resume of devices 
complete after 206.186 msecs
   platform    pass, resume of devices complete after 261.566 msecs

processors and core are rejected for s2idle ("PM: Unsupported test mode 
for suspend to idle, please choose none/freezer/devices/platform"), so 
platform is the deepest available.

platform covers the ACPI platform prepare including LPS0 _DSM entry and 
returns before entering the idle loop. So the entire software suspend 
path is clean: freezing, every device suspend/resume callback, and the 
platform prepare all work. The only step not covered by pm_test is 
entering and exiting hardware s0i3, and that is where it hangs.

Combined with "PC6 and CC6 enabled" passing, the cores are able to reach 
the required C-state. And amd_iommu=off with the same 24 CPUs makes the 
machine wake normally, while intremap=off, iommu=pt and 
amd_iommu_intr=legacy all still hang.

Baseline before the failing suspend, from debugfs:

   /sys/kernel/debug/amd_pmc/s0ix_stats
     S0ix Entry Time: 0
     S0ix Exit Time: 0
     Residency Time: 0
   /sys/kernel/debug/amd_pmc/smu_fw_info
     Table Version: 0
     Hint Count: 0
     Last S0i3 Status: Unknown/Fail

I will boot amd_iommu=off next and send the same counters plus a full 
amd-s2idle report from a cycle that actually resumes, so you can see 
whether that configuration reaches hardware sleep or is simply failing 
to get there in a way that happens to stay recoverable.


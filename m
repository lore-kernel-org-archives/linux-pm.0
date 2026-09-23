Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014054A7D0
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181468; cv=none; b=KMGZAa4rVcqmq1anP+Ulofe29vdsC4GO6gSfU6cQ4gAxWobLpoMaWgKHDDVP62XSFBKnHUQvTaUKngIkpm6x2SZ+3jHGkhwQZ7oqdwC/1FYEdUe3hvaToXQfBBQSQev5VpJOJwS73plxJ+Mr21D0s4DNy31EAOhZZ4+2AFbLB/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181468; c=relaxed/simple;
	bh=DvOBvmf3i9d0qazlC+gSfDsS6HTLcH4jFpLzfJhbyak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iwm65rcUkldMZcuBoR/UtsMInbWS2+Uk5AJgp5DAEU0aoMgA1X5OPP7wO7n7hS18Pu9zzDfrpe6aL8s3x1ThpEjGnRfihrrIloSQIRK4UYDVA1t1fipmQ04vPFAQvuLYoutm+3ujtVjZoYq9z4fzyrfkHadzqT1yk5bipr5B4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=qzWr+Psd; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="qzWr+Psd"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hqjLN2p2nzS5Z;
	Wed, 23 Sep 2026 18:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790181452; bh=WzYrD6M9e+6T9ByAAb5pPZdEdxbdhl/mlZLEk1jdN34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qzWr+PsdsvqdfxkfHFufA+7nrLK7t6jhHbnfqY+K2sXlrUgB2sCJYmaDTkkRul7Vp
	 /Pfjp+yY9pp8Px2LHt6a3YFX8AHSQr5pn7ox1DI+GPSNugXGiOeUAzK9f6X1C2CSWG
	 qizRODcIlhJJ3m/uUZ0VXi5cdXtvycWKrE03YKBg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hqjLL6MZYzJXJ;
	Wed, 23 Sep 2026 18:37:30 +0200 (CEST)
Message-ID: <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
Date: Wed, 23 Sep 2026 18:37:29 +0200
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
 <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
 <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
 <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
Content-Language: en-US
From: Fourhundred Thecat <400thecat@ik.me>
In-Reply-To: <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: :2997a34c1a6c8c6:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

On 2026-09-23 18:20, Mario Limonciello wrote:
> 
> 
> On 9/23/26 11:15, Mario Limonciello wrote:
>>
>>
>> On 9/23/26 11:12, Fourhundred Thecat wrote:
>>> On 2026-09-23 16:36, Mario Limonciello wrote:
>>>>
>>>>
>>>> Some other thoughts that might be the root cause based on other 
>>>> historical issues.
>>>>
>>>> 1) Have you changed TPM policy or Pluton policy in BIOS setup?  What 
>>>> did you change it from and to.
>>>> 2) Have you enabled a storage security password?  If you disable it 
>>>> does it help this issue?
>>>> 3) Do you have WWAN in your device?  If you disable it does it help?
>>>> 4) Does booting with `amd_iommu=off` help?
>>>
>>> 4) amd_iommu=off
>>>
>>> Yes, that fixes it. With amd_iommu=off and all 24 CPUs online, 
>>> suspend/ resume works reliably.
>>>
>>> So this is not really a CPU count problem. nr_cpus=16 was only 
>>> masking an IOMMU interaction. But narrowing it further was 
>>> surprising: neither of the IOMMU's two functions is responsible on 
>>> its own. All of the following were run with all 24 CPUs online, and I 
>>> verified in each case that the parameter actually took effect:
>>>
>>>    amd_iommu=off            IOMMU off entirely                     WAKES
>>>    intremap=off             IR off, DMA remapping on               no 
>>> wake
>>>    iommu=pt                 DMA passthrough, IR on                 no 
>>> wake
>>>    amd_iommu_intr=legacy    legacy GA mode, IR on, DMA on          no 
>>> wake
>>>
>>> Verification for each:
>>>
>>>    intremap=off           /proc/interrupts went from 58 IR- lines to 0,
>>>                           and irq 1 (i8042) is no longer IR-IO-APIC.
>>>                           iommu still enabled, domain type Translated.
>>>    iommu=pt               "iommu: Default domain type: Passthrough 
>>> (set via
>>>                           kernel command line)", all 40 PCI devices in
>>>                           identity domains, IR still on (58 IR- lines).
>>>    amd_iommu_intr=legacy  "AMD-Vi: Virtual APIC enabled" no longer 
>>> printed,
>>>                           only "AMD-Vi: Interrupt remapping enabled".
>>>
>>> So only disabling the IOMMU outright helps. Turning off interrupt 
>>> remapping alone, bypassing DMA translation alone, or dropping out of 
>>> vAPIC/GA mode all still hang.
>>>
>>> The CPU dependency is still there on top of that. With the IOMMU 
>>> enabled, nr_cpus=16 works and 24 CPUs hangs. Offlining cpu16-23 by 
>>> hotplug after booting with all 24 does not help; the CPUs have to 
>>> never be brought up. cpu16-23 here are the second SMT thread of the 
>>> eight Zen5c cores (APIC ids 17,19..31).
>>>
>>> Both conditions appear to be required: the IOMMU enabled, and more 
>>> than 16 CPUs brought up at boot. Either one alone is fine.
>>>
>>>
>>> 1) TPM / Pluton policy
>>>
>>> Current values:
>>>
>>>    TpmSelection            = DiscreteTPM2.0   (possible: 
>>> DiscreteTPM2.0;PlutonTPM2.0)
>>>    PlutonSecurityProcessor = Disable
>>>    SecurityChip            = Enable
>>>
>>> The TPM that binds is a discrete STMicro part, tpm0 -> STM0925:00.
>>>
>>> I did change this. As I recall I disabled Microsoft Pluton, which 
>>> moves the TPM selection off the PlutonTPM2.0 default onto the 
>>> discrete part, so Enable -> Disable for Pluton and PlutonTPM2.0 -> 
>>> DiscreteTPM2.0 for the selection. I will confirm the exact original 
>>> values in setup. I have not yet tested whether restoring the Pluton 
>>> default changes the behaviour, since the IOMMU result looked more 
>>> promising.
>>>
>>>
>>> 2) Storage security password
>>>
>>> None enrolled. HardDiskPasswordControl=Disable, and the HDD, NVMe, 
>>> Admin, System and Power-on authentication slots all report 
>>> is_enabled=0. BlockSIDAuthentication=Enable is the only non-default 
>>> setting in that area. Nothing to disable, so nothing to test.
>>>
>>>
>>> 3) WWAN
>>>
>>> Yes: Quectel [1eac:1007] at 0000:c4:00.0, attached over MHI, exposing 
>>> wwan0. Its power/wakeup is enabled. Not yet tested with 
>>> WirelessWANAccess disabled in BIOS.
>>>
>>>
>>> so please suggest which test I should do next, now that we have more 
>>> info
>>
>> Of your above the most likely cause is PlutonSecurityProcessor = 
>> Disable.  Please try to re-enable that and then try with IOMMU enabled.
> 
> BTW - what version of amd-s2idle didn't flag this?  I am surprised, we 
> had a check for this that /should/ have failed prerequisites.

Tested, and it does not help.

   PlutonSecurityProcessor  Disable -> Enable
   TpmSelection             DiscreteTPM2.0 -> PlutonTPM2.0
   SecurityChip             Enable -> Active

With those set, IOMMU enabled, no IOMMU boot parameters and all 24 CPUs 
online, the machine still does not wake.

Worth noting what that test also covers: with Pluton selected the TPM 
presents through the CRB interface (MSFT0101:00, status=15), and this 
kernel has CONFIG_TCG_CRB=n. So during that suspend Linux had no TPM 
driver bound at all -- no /sys/class/tpm, no /dev/tpm0, and the discrete 
STM0925 was gone from the platform bus. Previously tpm_tis was bound to 
STM0925:00. So this rules out the tpm_tis driver as a factor as well as 
the Pluton policy.

Current state of what is ruled out, all with the IOMMU enabled and 24 
CPUs online:

   amd_pmf                  initcall_blacklist=amd_pmf_driver_init 
no wake
   amdxdna (NPU)            initcall_blacklist=amdxdna_pci_driver_init 
no wake
   TPM driver               no driver bound at all (Pluton/CRB, no 
CONFIG_TCG_CRB)  no wake
   Pluton policy            Pluton enabled, PlutonTPM2.0 
no wake
   interrupt remapping      intremap=off (verified: 0 IR- lines) 
no wake
   DMA remapping            iommu=pt (verified: Passthrough, identity) 
no wake
   vAPIC / GA mode          amd_iommu_intr=legacy (verified) 
no wake

The only two things that let it wake are amd_iommu=off with all 24 CPUs, 
or the IOMMU enabled with nr_cpus=16. Offlining cpu16-23 by hotplug 
after booting with all 24 does not work; they have to never be brought up.

I am rebuilding now with CONFIG_DEBUG_FS, CONFIG_PM_DEBUG, 
CONFIG_DYNAMIC_DEBUG and CONFIG_AMD_MP2_STB so I can run amd-s2idle and 
send you the report from the working nr_cpus=16 configuration.


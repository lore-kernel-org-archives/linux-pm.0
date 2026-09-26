Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E63254B03
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396027; cv=none; b=mYyTITfibiMEiN/hy7vpBvPHUAPz8yMT0d6sZxx38EHR3mNO/R/FQQYOUtKAajaFNUUUhQRoN6krxlDdfZdXTakfHfbxbbJRSxuZm4zBg/u1585SKblgjXoKmWH5sVcXzfMCMa2zltvJTFcPAIKwJriFJmevhJsdBzR3DBFXIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396027; c=relaxed/simple;
	bh=dZTixQQwFD5sG1UHiJiGYRYfvrxCW8KwqDULWaS0RZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ustQuLudn5o2HNLQGmp3/kuIosKxJ+rOqci/opLma+6IahMYa+7VfMj+yOdHflOL/5XZNJs2Ibq6KdGonZKJLSvPGr62Rl2wlW1LQH7uwmKrb5D+WjgxED7boEp15onr4KSxG8O2t1PJw4l5hox2UOrr9Vnrcn7pc5geRiRPzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=p1u2J4GV; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="p1u2J4GV"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hsDhZ74v2zS4l;
	Sat, 26 Sep 2026 06:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790396014; bh=bY1UkuqzRv8r8dxuJWff4KeFA+qBT8ziWq7lBmDh/fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p1u2J4GVrfMOuX2hqObW6X0oG4k8H7FqLrVfMSI3ZQq3nsxUYvwV1U2IdDx+P4CqH
	 9fhFq60UUbWk+Sulc1s2WAMJAOsgyeKOfcO5dFf9JMvOJmBZVoE1T716+Hf0HI1o/v
	 Te9W3qWI9RlPTLBNZrZBhc2hF2Qpu6cPNTDdoW3I=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hsDhY4jK6zjxw;
	Sat, 26 Sep 2026 06:13:33 +0200 (CEST)
Message-ID: <66bbe070-36d9-d854-f0ba-a350634713db@ik.me>
Date: Sat, 26 Sep 2026 06:13:33 +0200
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
 <3a080b50-6396-bf8f-2e70-011b85c15fe2@ik.me>
 <b2e13400-d1b7-4a9f-b7bc-a2d1dc7a4912@amd.com>
From: Fourhundred Thecat <400thecat@ik.me>
In-Reply-To: <b2e13400-d1b7-4a9f-b7bc-a2d1dc7a4912@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: :2997a34c1a6c8c6:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

On 2026-09-25 15:30, Mario Limonciello wrote:
> 
> 
> On 9/25/26 02:05, Fourhundred Thecat wrote:
>> resolved by resetting BIOS to factory defaults
>>
>> after that, I tried painstakingly to enable/disable one by one
>>
>> The cause is two BIOS settings, and the reason it took so long to find 
>> is that they are independently sufficient:
>>
>>    AmdVt (AMD virtualization)        Disable  -> breaks s2idle wake
>>    PlutonSecurityProcessor           Disable  -> breaks s2idle wake
>>
>> Either one alone is enough. Both must be enabled for the machine to 
>> resume. The full matrix, all with the IOMMU enabled and 24 CPUs online:
>>
>>    AmdVt      Pluton     result
>>    Enable     Disable    no wake
>>    Disable    Enable     no wake
>>    Disable    Disable    no wake
>>    Enable     Enable     wakes normally
>>
>> I had both disabled.
>> It also explains the confusing bisect: when I tested AmdVt=Enable with 
>> everything else at my settings it still hung, and when I tested 
>> Pluton=Enable with everything else at my settings it still hung, so I 
>> eliminated both. Each test only showed the setting was not necessary; 
>> neither showed it was not sufficient. With two independent triggers 
>> those observations are both true at once and single-setting 
>> elimination gives nothing.
>>
>> So amd_iommu=off and nr_cpus=16 were both masking this rather than 
>> telling us anything about the kernel.
> 
> Well this is a great outcome.  Would you mind opening a pull request to 
> amd-debug-tools and adding a case to this to test for this issue?  That 
> would help anyone else that encounters this in the future and save us 
> effort drilling down again.
> 
> You should be able to add a new check that verified the value of these 
> BIOS settings using the think-lmi driver sysfs interface.
> My thought on the logic would be something like this:
> 
> 1) Check whether think-lmi directory exists, skip the check if it doesn't.
> 2) Check whether both of those attributes exist.  If they don't, skip 
> the check.
> 3) Check the values of both of those attributes.  If there is a failure 
> report it.  If it's a pass report it.
> 
> It can generally apply to all Lenovo systems that offer these settings 
> then (It's more likely a "generic" BIOS bug).
> 
>>
>> this is clearly a Lenovo BIOS bug. should this be reported to them ?
> 
> Before you report this to them, can you diff some acpidumps from the two 
> changes that break things?
> 
> I would have "expected" that turning off this AmdVt BIOS option stopped 
> the IVRS table from being created, but that seems not to be the case.
> 
> I just wonder if we should be keying off anything else in Linux for this 
> case to avoid the issue.

Captured acpidumps for all three configurations. Your hunch was right 
that the IVRS table is still created with AmdVt disabled, but it is not 
identical - and the difference looks like the actual mechanism.

Summary, all with the IOMMU enabled and 24 CPUs online:

   config          IVinfo      IVRS len   IVMDs   MSFT0201 in IVRS 
MSFT0201 ACPI dev   SSDTs
   both enabled    0x00203043  0x216      3       yes                yes 
                 29
   AmdVt off       0x00203041  0x1F6      2       yes                yes 
                 29
   Pluton off      0x00203043  0x216      3       yes                NO 
                 28

AmdVt off changes two things. The IVinfo word loses bit 0x2, the 
DmaRemap bit you already parse at offset 36. And the table is 32 bytes 
shorter because one IVMD disappears:

   both enabled:
     IVMD DeviceId=0060 Flags=07 Start=0x7D900000 Len=0x100000
     IVMD DeviceId=C507 Flags=08 Start=0x6B400000 Len=0x20000
     IVMD DeviceId=C100 Flags=08 Start=0x6B1F5000 Len=0x28000

   AmdVt off:
     IVMD DeviceId=C507 Flags=08 Start=0x6B400000 Len=0x20000
     IVMD DeviceId=C100 Flags=08 Start=0x6B1F5000 Len=0x28000

DeviceId 0x0060 is MSFT0201:

   AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60

and Flags 0x07 is unity mapped with read and write. So disabling AMD 
virtualization removes Pluton's unity mapped DMA region from IVRS, while 
the device is still declared in IVRS, still present as an ACPI device, 
and still attached to iommu group 0:

   platform MSFT0201:00: Adding to iommu group 0

That would leave Pluton's DMA translated with nothing mapped for it, 
which fits every observation: it only breaks with the IOMMU enabled, 
amd_iommu=off is the only thing that fixes it, and neither intremap=off 
nor iommu=pt helps, since iommu=pt gives other devices identity domains 
but the IVMD is how firmware asks for one for this device specifically.

Pluton off is a different failure. The IVRS is byte identical to the 
working case, IVMD 0060 included, but one SSDT is gone and with it the 
MSFT0201 ACPI device. Your existing check already catches that case 
correctly:

   found_iommu=True  found_acpi=False
   -> IOMMU is misconfigured: missing MSFT0201 ACPI device

The AmdVt case is the one that slips through. In check_iommu():

   if not found_ivrs_dmar and not found_ivrs_msft0201:

with AmdVt off, found_ivrs_dmar is False because bit 0x2 is cleared, but 
found_ivrs_msft0201 is True, so the and makes it pass and the tool 
reports "IOMMU properly configured" on a machine that cannot be woken.

So to answer your question about keying off something else: yes, and I 
think the signal is "IVRS declares an ACPI HID device but provides no 
IVMD covering its device id". That needs no vendor attributes and no DMI 
matching. The device id sits 3 bytes before the HID string in the type 
0xF0 entry, and IVMDs are subtable types 0x20/0x21/0x22 with the device 
id at entry offset 4:

   devid = struct.unpack_from("<H", data, data.find(b"MSFT0201") - 3)[0]
   off = 48
   while off + 4 <= len(data):
       length = struct.unpack_from("<H", data, off + 2)[0]
       if length == 0:
           break
       if data[off] in (0x20, 0x21, 0x22):
           if struct.unpack_from("<H", data, off + 4)[0] == devid:
               mapped = True
               break
       off += length

I checked this against all three dumps: it reports mapped for 
both-enabled and Pluton-off, and unmapped for AmdVt-off. Note that it 
would contradict test_check_iommu_no_dma_protection_BUT_msft0201, which 
currently asserts that MSFT0201 in IVRS is an acceptable substitute for 
pre-boot DMA protection, so whether to change that semantic is your call.

I am happy to send you the three acpidumps, with the extracted and 
disassembled tables and a record of the BIOS settings each was taken under.

Beyond that I have to stop here. This has taken the better part of a 
week, a lot of forced power cycles, and around $700 in LLM tokens 
working through it, and I am out of time and energy to take it further. 
The machine works now with AMD virtualization and Pluton enabled, which 
is a perfectly acceptable outcome for me.

Everything I found is in this thread, and I hope the IVRS observation is 
useful to you or to whoever picks it up. Thanks for the help getting 
here - the amd-s2idle tool, the pointer to e9f850ba66cd, and the 
suggestion to reset the BIOS were all what moved it forward.



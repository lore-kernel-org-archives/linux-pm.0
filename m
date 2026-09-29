Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE382C11CF
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660588; cv=none; b=qDcBmoBC/mi/Gbs4nl2R1nn7b7iMoECXXWMKU5Fh4zI44jKjSDTGfpjbtinFxkTlI9+p40UbEkst4eMn8pLbwchPPWPyHiq1Wryw5r0FqVDvxZFoICj/86VEVeH0i3+Tn7ucd1KvykmIl/6pyKCUhRh1e6qm4H1uY9tWouQNR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660588; c=relaxed/simple;
	bh=QO1bAAXGza0YRcAMcJ9FO0AfkSi4REdp9rC2//JuW0Q=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=qQm4ZfNIjK1azMNvBMg4y3eehp1dbDxzPg8CDFx3rIYTFO7obiEkuhSyAagFBHXcR5xpVDL4Wu3WeRptxIPM+fBiryptrMgnTDXaKh0dSl+lLea0QzAOuCdRQoSSxA6mXCU8twjkxMoAATNHMbHy6jGuiCUeS4JE4JggDYM7ktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=JZwUhXKZ; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="JZwUhXKZ"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hv6XP3KhYzFF1;
	Tue, 29 Sep 2026 07:43:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790660581; bh=dvETfYJflINewuQWUq1MdW8eCadeWiiL+WvPn9S6R2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JZwUhXKZ08Zzer2L72LDe6QNy8y+ZhIKNSc7abYn6zqkE9g3ZID9vT8U4nwp7F1No
	 CAYxPt817r5SEc09W/F5QuyMa2WWKerq+26kD3slFE+qydEew6BHOqJyV08Jxpvxcq
	 PNpdcKhY4WNdZBfvr40Otsv2WrVlODX/UmMaCmUY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hv6XN0dlfzg6L;
	Tue, 29 Sep 2026 07:43:00 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------wyBJ01OzDf0yGDNEeeuf2asw"
Message-ID: <cbcb15b6-b576-a6be-f190-9014ec02a805@ik.me>
Date: Tue, 29 Sep 2026 07:43:01 +0200
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
To: Mario Limonciello <superm1@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
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
 <66bbe070-36d9-d854-f0ba-a350634713db@ik.me>
 <049f2564-3ef2-433e-9206-be44b7885d7b@gmail.com>
Content-Language: en-US
From: Fourhundred Thecat <400thecat@ik.me>
In-Reply-To: <049f2564-3ef2-433e-9206-be44b7885d7b@gmail.com>
Feedback-ID: :a4f77f7b9345814:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

This is a multi-part message in MIME format.
--------------wyBJ01OzDf0yGDNEeeuf2asw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-26 20:29, Mario Limonciello wrote:
>> Captured acpidumps for all three configurations. Your hunch was right 
>> that the IVRS table is still created with AmdVt disabled, but it is 
>> not identical - and the difference looks like the actual mechanism.
> 
> OK.  That makes a lot of sense for this issue now.
> 
>>
>> Summary, all with the IOMMU enabled and 24 CPUs online:
>>
>>    config          IVinfo      IVRS len   IVMDs   MSFT0201 in IVRS 
>> MSFT0201 ACPI dev   SSDTs
>>    both enabled    0x00203043  0x216      3       yes                
>> yes                  29
>>    AmdVt off       0x00203041  0x1F6      2       yes                
>> yes                  29
>>    Pluton off      0x00203043  0x216      3       yes                
>> NO                  28
>>
>> AmdVt off changes two things. The IVinfo word loses bit 0x2, the 
>> DmaRemap bit you already parse at offset 36. And the table is 32 bytes 
>> shorter because one IVMD disappears:
>>
>>    both enabled:
>>      IVMD DeviceId=0060 Flags=07 Start=0x7D900000 Len=0x100000
>>      IVMD DeviceId=C507 Flags=08 Start=0x6B400000 Len=0x20000
>>      IVMD DeviceId=C100 Flags=08 Start=0x6B1F5000 Len=0x28000
>>
>>    AmdVt off:
>>      IVMD DeviceId=C507 Flags=08 Start=0x6B400000 Len=0x20000
>>      IVMD DeviceId=C100 Flags=08 Start=0x6B1F5000 Len=0x28000
>>
>> DeviceId 0x0060 is MSFT0201:
>>
>>    AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
>>
>> and Flags 0x07 is unity mapped with read and write. So disabling AMD 
>> virtualization removes Pluton's unity mapped DMA region from IVRS, 
>> while the device is still declared in IVRS, still present as an ACPI 
>> device, and still attached to iommu group 0:
>>
>>    platform MSFT0201:00: Adding to iommu group 0
>>
>> That would leave Pluton's DMA translated with nothing mapped for it, 
>> which fits every observation: it only breaks with the IOMMU enabled, 
>> amd_iommu=off is the only thing that fixes it, and neither 
>> intremap=off nor iommu=pt helps, since iommu=pt gives other devices 
>> identity domains but the IVMD is how firmware asks for one for this 
>> device specifically.
>>
>> Pluton off is a different failure. The IVRS is byte identical to the 
>> working case, IVMD 0060 included, but one SSDT is gone and with it the 
>> MSFT0201 ACPI device. Your existing check already catches that case 
>> correctly:
>>
>>    found_iommu=True  found_acpi=False
>>    -> IOMMU is misconfigured: missing MSFT0201 ACPI device
>>
>> The AmdVt case is the one that slips through. In check_iommu():
>>
>>    if not found_ivrs_dmar and not found_ivrs_msft0201:
>>
>> with AmdVt off, found_ivrs_dmar is False because bit 0x2 is cleared, 
>> but found_ivrs_msft0201 is True, so the and makes it pass and the tool 
>> reports "IOMMU properly configured" on a machine that cannot be woken.
>>
>> So to answer your question about keying off something else: yes, and I 
>> think the signal is "IVRS declares an ACPI HID device but provides no 
>> IVMD covering its device id". That needs no vendor attributes and no 
>> DMI matching. The device id sits 3 bytes before the HID string in the 
>> type 0xF0 entry, and IVMDs are subtable types 0x20/0x21/0x22 with the 
>> device id at entry offset 4:
>>
>>    devid = struct.unpack_from("<H", data, data.find(b"MSFT0201") - 3)[0]
>>    off = 48
>>    while off + 4 <= len(data):
>>        length = struct.unpack_from("<H", data, off + 2)[0]
>>        if length == 0:
>>            break
>>        if data[off] in (0x20, 0x21, 0x22):
>>            if struct.unpack_from("<H", data, off + 4)[0] == devid:
>>                mapped = True
>>                break
>>        off += length
>>
>> I checked this against all three dumps: it reports mapped for both- 
>> enabled and Pluton-off, and unmapped for AmdVt-off. Note that it would 
>> contradict test_check_iommu_no_dma_protection_BUT_msft0201, which 
>> currently asserts that MSFT0201 in IVRS is an acceptable substitute 
>> for pre-boot DMA protection, so whether to change that semantic is 
>> your call.
>>
>> I am happy to send you the three acpidumps, with the extracted and 
>> disassembled tables and a record of the BIOS settings each was taken 
>> under.
>>
>> Beyond that I have to stop here. This has taken the better part of a 
>> week, a lot of forced power cycles, and around $700 in LLM tokens 
>> working through it, and I am out of time and energy to take it 
>> further. The machine works now with AMD virtualization and Pluton 
>> enabled, which is a perfectly acceptable outcome for me.
>>
>> Everything I found is in this thread, and I hope the IVRS observation 
>> is useful to you or to whoever picks it up. Thanks for the help 
>> getting here - the amd-s2idle tool, the pointer to e9f850ba66cd, and 
>> the suggestion to reset the BIOS were all what moved it forward.
>>
>>
> I've opened up a PR that should hopefully adjust the tool against your 
> failure cases.  Would you be able to confirm this against your system?

I am not able to test anything anymore. I have erased the debugging 
setup that I had on my laptop, and reinstalled it clean. I no longer 
have the claude history and the debugging tools. And I cannot do it 
without claude (nothing we did made any sense to me)

> https://github.com/superm1/amd-debug-tools/pull/58
> 
> If it doesn't work, can you please send me the acpidumps and I'll adjust.

but hopefully you can make sense of the attached  acpidumps

thank you,
--------------wyBJ01OzDf0yGDNEeeuf2asw
Content-Type: application/x-xz; name="ivrs-only.tar.xz"
Content-Disposition: attachment; filename="ivrs-only.tar.xz"
Content-Transfer-Encoding: base64

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
p+axxGf7AgAAAAAEWVo=

--------------wyBJ01OzDf0yGDNEeeuf2asw--

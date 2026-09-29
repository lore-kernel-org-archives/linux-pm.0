Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD13F1052
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661458; cv=none; b=WNR8xuxoA1Mbe1I0J8Y3XMi11H0bkRRcobj1t42ucgdTBy6sSeofD+TWcai1vih6hsYVtETlx/mmbJuQUvOPVMcQ63niYqNb4mXzWBsidL4tb0mUcfSl3L/tk1DR0wxekmtJmtmFgzocXItTi+V7Avebfn/usH6w+I6BqkEFz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661458; c=relaxed/simple;
	bh=6azpNqFRekD9LpLaNdDoW7yNrn/I6/u0TnD7cSz6ynw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YlPwtZOfPwb3sJ1NGyNO23Z4BmrTF6m5oaXZR/fUf+ZsOe025bgHt3Ebu2Znk9GbFIwn1j3ZFpNo3wjjunTpjpRL/CDjQQlMS9XC4m2GhN4o5wNA5QXDjDSzQxNJOwueVb16QKe8f7RB5Nd2xZ4wqhjB2LlL3PVdAtKxkVPgwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=uNFF5+GX; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="uNFF5+GX"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hv6s25NQMzTH8;
	Tue, 29 Sep 2026 07:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790661446; bh=kPTBk2j5EWQ6HuwaBvGytrSlKKAowUQKET1MpG8OJOE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uNFF5+GXqwGatxu6V3L9diNjCwnTkEgvnW4Nc4txyAR1hZ7xeQLtO41fbDOIKt3Gr
	 fxolYq/8aqrMnfViiNmypMsYwRaxeqtdkhD8kj2Br83amgvDQTk2t7OUXSB68fwWx9
	 7XLBGpeovcz5PpfCH9exfCMrSWVxoQrFEa9f0KWI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hv6s12YqtzTHf;
	Tue, 29 Sep 2026 07:57:25 +0200 (CEST)
Message-ID: <edd73c8b-904e-077a-6e77-0348f4ca5aa7@ik.me>
Date: Tue, 29 Sep 2026 07:57:26 +0200
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
From: Fourhundred Thecat <400thecat@ik.me>
To: Mario Limonciello <superm1@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
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
 <cbcb15b6-b576-a6be-f190-9014ec02a805@ik.me>
In-Reply-To: <cbcb15b6-b576-a6be-f190-9014ec02a805@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: :a4f77f7b9345814:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

On 2026-09-29 07:43, Fourhundred Thecat wrote:
> On 2026-09-26 20:29, Mario Limonciello wrote:
>>> Captured acpidumps for all three configurations. Your hunch was right 
>>> that the IVRS table is still created with AmdVt disabled, but it is 
>>> not identical - and the difference looks like the actual mechanism.
>>
>> OK.  That makes a lot of sense for this issue now.
>>
>>>
>>> Summary, all with the IOMMU enabled and 24 CPUs online:
>>>
>>>    config          IVinfo      IVRS len   IVMDs   MSFT0201 in IVRS 
>>> MSFT0201 ACPI dev   SSDTs
>>>    both enabled    0x00203043  0x216      3       yes yes 
>>>                  29
>>>    AmdVt off       0x00203041  0x1F6      2       yes yes 
>>>                  29
>>>    Pluton off      0x00203043  0x216      3       yes NO 
>>>                  28
>>>
>>> AmdVt off changes two things. The IVinfo word loses bit 0x2, the 
>>> DmaRemap bit you already parse at offset 36. And the table is 32 
>>> bytes shorter because one IVMD disappears:
>>>
>>>    both enabled:
>>>      IVMD DeviceId=0060 Flags=07 Start=0x7D900000 Len=0x100000
>>>      IVMD DeviceId=C507 Flags=08 Start=0x6B400000 Len=0x20000
>>>      IVMD DeviceId=C100 Flags=08 Start=0x6B1F5000 Len=0x28000
>>>
>>>    AmdVt off:
>>>      IVMD DeviceId=C507 Flags=08 Start=0x6B400000 Len=0x20000
>>>      IVMD DeviceId=C100 Flags=08 Start=0x6B1F5000 Len=0x28000
>>>
>>> DeviceId 0x0060 is MSFT0201:
>>>
>>>    AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
>>>
>>> and Flags 0x07 is unity mapped with read and write. So disabling AMD 
>>> virtualization removes Pluton's unity mapped DMA region from IVRS, 
>>> while the device is still declared in IVRS, still present as an ACPI 
>>> device, and still attached to iommu group 0:
>>>
>>>    platform MSFT0201:00: Adding to iommu group 0
>>>
>>> That would leave Pluton's DMA translated with nothing mapped for it, 
>>> which fits every observation: it only breaks with the IOMMU enabled, 
>>> amd_iommu=off is the only thing that fixes it, and neither 
>>> intremap=off nor iommu=pt helps, since iommu=pt gives other devices 
>>> identity domains but the IVMD is how firmware asks for one for this 
>>> device specifically.
>>>
>>> Pluton off is a different failure. The IVRS is byte identical to the 
>>> working case, IVMD 0060 included, but one SSDT is gone and with it 
>>> the MSFT0201 ACPI device. Your existing check already catches that 
>>> case correctly:
>>>
>>>    found_iommu=True  found_acpi=False
>>>    -> IOMMU is misconfigured: missing MSFT0201 ACPI device
>>>
>>> The AmdVt case is the one that slips through. In check_iommu():
>>>
>>>    if not found_ivrs_dmar and not found_ivrs_msft0201:
>>>
>>> with AmdVt off, found_ivrs_dmar is False because bit 0x2 is cleared, 
>>> but found_ivrs_msft0201 is True, so the and makes it pass and the 
>>> tool reports "IOMMU properly configured" on a machine that cannot be 
>>> woken.
>>>
>>> So to answer your question about keying off something else: yes, and 
>>> I think the signal is "IVRS declares an ACPI HID device but provides 
>>> no IVMD covering its device id". That needs no vendor attributes and 
>>> no DMI matching. The device id sits 3 bytes before the HID string in 
>>> the type 0xF0 entry, and IVMDs are subtable types 0x20/0x21/0x22 with 
>>> the device id at entry offset 4:
>>>
>>>    devid = struct.unpack_from("<H", data, data.find(b"MSFT0201") - 3)[0]
>>>    off = 48
>>>    while off + 4 <= len(data):
>>>        length = struct.unpack_from("<H", data, off + 2)[0]
>>>        if length == 0:
>>>            break
>>>        if data[off] in (0x20, 0x21, 0x22):
>>>            if struct.unpack_from("<H", data, off + 4)[0] == devid:
>>>                mapped = True
>>>                break
>>>        off += length
>>>
>>> I checked this against all three dumps: it reports mapped for both- 
>>> enabled and Pluton-off, and unmapped for AmdVt-off. Note that it 
>>> would contradict test_check_iommu_no_dma_protection_BUT_msft0201, 
>>> which currently asserts that MSFT0201 in IVRS is an acceptable 
>>> substitute for pre-boot DMA protection, so whether to change that 
>>> semantic is your call.
>>>
>>> I am happy to send you the three acpidumps, with the extracted and 
>>> disassembled tables and a record of the BIOS settings each was taken 
>>> under.
>>>
>>> Beyond that I have to stop here. This has taken the better part of a 
>>> week, a lot of forced power cycles, and around $700 in LLM tokens 
>>> working through it, and I am out of time and energy to take it 
>>> further. The machine works now with AMD virtualization and Pluton 
>>> enabled, which is a perfectly acceptable outcome for me.
>>>
>>> Everything I found is in this thread, and I hope the IVRS observation 
>>> is useful to you or to whoever picks it up. Thanks for the help 
>>> getting here - the amd-s2idle tool, the pointer to e9f850ba66cd, and 
>>> the suggestion to reset the BIOS were all what moved it forward.
>>>
>>>
>> I've opened up a PR that should hopefully adjust the tool against your 
>> failure cases.  Would you be able to confirm this against your system?
> 
> I am not able to test anything anymore. I have erased the debugging 
> setup that I had on my laptop, and reinstalled it clean. I no longer 
> have the claude history and the debugging tools. And I cannot do it 
> without claude (nothing we did made any sense to me)
> 
>> https://github.com/superm1/amd-debug-tools/pull/58
>>
>> If it doesn't work, can you please send me the acpidumps and I'll adjust.
> 
> but hopefully you can make sense of the attached  acpidumps
> 
> thank you,

looks like my previous email bounced because .tar.xz attachment
so I have uploaded the file here:

https://www.swisstransfer.com/dl/01a0ebbb-a094-725c-b9f1-8a8ba0d1da11

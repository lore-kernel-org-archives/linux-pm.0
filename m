Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD137C934
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447392; cv=none; b=d+2BrduwOtjSumqkbyUi5RK1yt07bDaeP58S16poLb7JncXF7BN1oL3gkJgrLcpMsDKkUgv1uzgl94ALFjQskHHRwKgaRJiy8bjKYC+eoVtSWPXnjp/hx6pL79p/JZEYcyF4blCk4b6UDoHSKdfJ8H5o9IxjSx6DC35rrmOJWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447392; c=relaxed/simple;
	bh=GYYkxdsqA9IOszTyIJpe5/gKgcitrLgq+lC0i609rOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0sQLp9duoL5ZmSn0SB3G6qTzb+1HX/mO+owQ6D+IQQya5bGfg4ZTNLPD8e7HCKZOnnLqqr3uh2hI7MXGylS9vlFkMYGJcPYr+gYNbdcpfTpyZ1FQlrZzpWaXakMSYt6k/CFrocKaxKjEqk5x+BFpHmAvfaRp9zPS7OWRpkhBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6g2DD/6; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6g2DD/6"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4678d3e490bso2091866fac.1
        for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790447388; x=1791052188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfzsmIxXLWNZ4YNn3nfLndjooAshaJxKXBcH7abjIWk=;
        b=U6g2DD/6wQV0/2neHMks0htv6Tf0n4ASV5xICBKRqzYezKCvcABGT8AE+DDpyVf2Lq
         URcRhN4FKJp8p+D4VA2/HI64OPJbfOkMGXVFpdPb3Wz9gU2QvyDeMaiZ5ik6mc41oGl3
         HbOhjc9Hzvhk1NN6HkO+Vxhwbf2WDArWIofzfrOauqSpBvy/QTyhLqOUsNOWgDeYMw4G
         UaHilzr2mY3zg9XQJl19m9KBdClfROKSZBZsOOEva4hOdlh6RHzifNlkG0cgHFqxKQGP
         Sgmi6NFnOrKTHb2eTGRe6OtsGzJoMdLvPsXOg4Kgf0HUearB2hhHjePZOmo4hfaJnAn1
         pGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447388; x=1791052188;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rfzsmIxXLWNZ4YNn3nfLndjooAshaJxKXBcH7abjIWk=;
        b=ChXa3QVQ+9QjEY9QW+M/UnXOU42PyrnB77zLYxnnDbTyGhOR+oHHhldbvr82mF/nj8
         QhlSUkolOWWt33J/3hNvLeQGvxP8shgiVEWcRqSMZV93cX4IkKc5zmb7+0+gVsRDDhi9
         tiMYx6hZznIukxEyP8Q4jkrnBNwpK1z71OmbMBYcQxoWsUndM8mJHLWAakevugFa0/wh
         LJEMiK2RGACe6Hlc2tZglpTx2H4AxQcDFlAu1ORMu9oBupGoLkBqqiEJtT7cKhPBFymM
         xMWE/zEout29525aC9ryRBBf/64b2fqkQtIsb2/+Y8mIC9g2JhLQAKTmjmQ5mc0zF21L
         9PXw==
X-Gm-Message-State: AFq9FYLwy+cDmYX2JOOyQCHIKGOdi4YXpwuFlrpBnNquyewAuYtS0o2w
	Y4hv9KcKeEeAr1lagMurSNzW3xKXEMVJ9RitTZqtjvH9K5E6n+MNbVsv
X-Gm-Gg: AYBFou3qTiugvnHS3UBfNeaMI9rUY8qFbZWO5eXqf6tEPoEM8OE/wHlbtY4sFG9JLeM
	X5Eb474OecWHjnnSgdwUxe99SKearwspK9ivcS1aEm+vt5i00r2zcr1yE3tI0Unb89pSo554tdG
	HF5BFI3eMPTJfdLklysCz1GG2Kgpyx4I08irKQtqWkvnbPrl2O8Du1V41UijWnnmgDoxN5rtnz9
	d891NydxsEq5A7TML+qCtZnXP/ys7zzDnQa0E37Kj2fmby+N7ykGHbDHEgFRMmsvvd9TW/LAdaW
	FjSoL8WeD+gjuqZ2TGZcGcdu0ng5CeS5kncplTJQxYld14QpIyVWm78s1LCMLBnp2+1C2apMrHz
	+ypDMOqvrjOCP2Y2o8W8bWwv+4+eHyaCD9abnE/VKO7I5qL0y+eCEkTT2PDVhPtzdi1CR0XSOOF
	tI1cH4He/d/TNh9rXws/EoBHcJNaIlg9EBdM3UCLoiWp8t7Vi5VIpP3XEvkDqiDJ2a89BPkstHy
	HskO+9r0a666phYsM0JNdsixFMixnZI6aS08CJ55o+mY5D1bj4gEHW08fgE7q0EMuN/RqXW5X/6
	O34IdFmpbGjNaesACzc8gteX2bLIAqOINSzzHkW2jBuk+RZec3cuOaKcSSk=
X-Received: by 2002:a05:6870:2417:b0:462:e12e:c561 with SMTP id 586e51a60fabf-491e9301751mr6610599fac.4.1790447388417;
        Sat, 26 Sep 2026 11:29:48 -0700 (PDT)
Received: from ?IPV6:2603:80a0:3900:aa00:abba:f323:b886:8886? ([2603:80a0:3900:aa00:abba:f323:b886:8886])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49335c784a1sm4808792fac.10.2026.09.26.11.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 11:29:46 -0700 (PDT)
Message-ID: <049f2564-3ef2-433e-9206-be44b7885d7b@gmail.com>
Date: Sat, 26 Sep 2026 13:29:43 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
To: Fourhundred Thecat <400thecat@ik.me>,
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
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
 <66bbe070-36d9-d854-f0ba-a350634713db@ik.me>
Content-Language: en-US
From: Mario Limonciello <superm1@gmail.com>
Autocrypt: addr=superm1@gmail.com; keydata=
 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
In-Reply-To: <66bbe070-36d9-d854-f0ba-a350634713db@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Captured acpidumps for all three configurations. Your hunch was right 
> that the IVRS table is still created with AmdVt disabled, but it is not 
> identical - and the difference looks like the actual mechanism.

OK.  That makes a lot of sense for this issue now.

> 
> Summary, all with the IOMMU enabled and 24 CPUs online:
> 
>    config          IVinfo      IVRS len   IVMDs   MSFT0201 in IVRS 
> MSFT0201 ACPI dev   SSDTs
>    both enabled    0x00203043  0x216      3       yes                yes 
>                  29
>    AmdVt off       0x00203041  0x1F6      2       yes                yes 
>                  29
>    Pluton off      0x00203043  0x216      3       yes                NO 
>                  28
> 
> AmdVt off changes two things. The IVinfo word loses bit 0x2, the 
> DmaRemap bit you already parse at offset 36. And the table is 32 bytes 
> shorter because one IVMD disappears:
> 
>    both enabled:
>      IVMD DeviceId=0060 Flags=07 Start=0x7D900000 Len=0x100000
>      IVMD DeviceId=C507 Flags=08 Start=0x6B400000 Len=0x20000
>      IVMD DeviceId=C100 Flags=08 Start=0x6B1F5000 Len=0x28000
> 
>    AmdVt off:
>      IVMD DeviceId=C507 Flags=08 Start=0x6B400000 Len=0x20000
>      IVMD DeviceId=C100 Flags=08 Start=0x6B1F5000 Len=0x28000
> 
> DeviceId 0x0060 is MSFT0201:
> 
>    AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
> 
> and Flags 0x07 is unity mapped with read and write. So disabling AMD 
> virtualization removes Pluton's unity mapped DMA region from IVRS, while 
> the device is still declared in IVRS, still present as an ACPI device, 
> and still attached to iommu group 0:
> 
>    platform MSFT0201:00: Adding to iommu group 0
> 
> That would leave Pluton's DMA translated with nothing mapped for it, 
> which fits every observation: it only breaks with the IOMMU enabled, 
> amd_iommu=off is the only thing that fixes it, and neither intremap=off 
> nor iommu=pt helps, since iommu=pt gives other devices identity domains 
> but the IVMD is how firmware asks for one for this device specifically.
> 
> Pluton off is a different failure. The IVRS is byte identical to the 
> working case, IVMD 0060 included, but one SSDT is gone and with it the 
> MSFT0201 ACPI device. Your existing check already catches that case 
> correctly:
> 
>    found_iommu=True  found_acpi=False
>    -> IOMMU is misconfigured: missing MSFT0201 ACPI device
> 
> The AmdVt case is the one that slips through. In check_iommu():
> 
>    if not found_ivrs_dmar and not found_ivrs_msft0201:
> 
> with AmdVt off, found_ivrs_dmar is False because bit 0x2 is cleared, but 
> found_ivrs_msft0201 is True, so the and makes it pass and the tool 
> reports "IOMMU properly configured" on a machine that cannot be woken.
> 
> So to answer your question about keying off something else: yes, and I 
> think the signal is "IVRS declares an ACPI HID device but provides no 
> IVMD covering its device id". That needs no vendor attributes and no DMI 
> matching. The device id sits 3 bytes before the HID string in the type 
> 0xF0 entry, and IVMDs are subtable types 0x20/0x21/0x22 with the device 
> id at entry offset 4:
> 
>    devid = struct.unpack_from("<H", data, data.find(b"MSFT0201") - 3)[0]
>    off = 48
>    while off + 4 <= len(data):
>        length = struct.unpack_from("<H", data, off + 2)[0]
>        if length == 0:
>            break
>        if data[off] in (0x20, 0x21, 0x22):
>            if struct.unpack_from("<H", data, off + 4)[0] == devid:
>                mapped = True
>                break
>        off += length
> 
> I checked this against all three dumps: it reports mapped for both- 
> enabled and Pluton-off, and unmapped for AmdVt-off. Note that it would 
> contradict test_check_iommu_no_dma_protection_BUT_msft0201, which 
> currently asserts that MSFT0201 in IVRS is an acceptable substitute for 
> pre-boot DMA protection, so whether to change that semantic is your call.
> 
> I am happy to send you the three acpidumps, with the extracted and 
> disassembled tables and a record of the BIOS settings each was taken under.
> 
> Beyond that I have to stop here. This has taken the better part of a 
> week, a lot of forced power cycles, and around $700 in LLM tokens 
> working through it, and I am out of time and energy to take it further. 
> The machine works now with AMD virtualization and Pluton enabled, which 
> is a perfectly acceptable outcome for me.
> 
> Everything I found is in this thread, and I hope the IVRS observation is 
> useful to you or to whoever picks it up. Thanks for the help getting 
> here - the amd-s2idle tool, the pointer to e9f850ba66cd, and the 
> suggestion to reset the BIOS were all what moved it forward.
> 
> 
I've opened up a PR that should hopefully adjust the tool against your 
failure cases.  Would you be able to confirm this against your system?

https://github.com/superm1/amd-debug-tools/pull/58

If it doesn't work, can you please send me the acpidumps and I'll adjust.

From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH] x86, arm64, acpi: Handle lapic/x2apic entries in MADT
Date: Tue, 8 Sep 2015 16:44:48 +0200
Message-ID: <55EEF460.2010104@semihalf.com>
References: <55DDB45D.2030901@arm.com>
 <1440611369-26314-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1440611369-26314-2-git-send-email-lukasz.anaczkowski@intel.com>
 <55E55BA8.5090102@linaro.org>
 <C1C2579D7BE026428F81F41198ADB1723786A47E@irsmsx110.ger.corp.intel.com>
 <55E5A9EE.3030704@linaro.org>
 <C1C2579D7BE026428F81F41198ADB172378A783A@irsmsx110.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34045 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbbIHOox (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 10:44:53 -0400
Received: by laeb10 with SMTP id b10so71571092lae.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2015 07:44:51 -0700 (PDT)
In-Reply-To: <C1C2579D7BE026428F81F41198ADB172378A783A@irsmsx110.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>

On 07.09.2015 16:04, Anaczkowski, Lukasz wrote:
>
> From: Tomasz Nowicki [mailto:tomasz.nowicki@linaro.org]
> Sent: Tuesday, September 1, 2015 3:37 PM
>> On 01.09.2015 14:07, Anaczkowski, Lukasz wrote:
>>> From: Tomasz Nowicki [mailto:tomasz.nowicki@linaro.org]
>>> Sent: Tuesday, September 1, 2015 10:03 AM
>>>>
>>>>> To fix this, each LAPIC/X2APIC entry from MADT table needs to be
>>>>> handled at the same time when processing it, thus adding
>>>>> acpi_subtable_proc structure which stores
>>>>> () ACPI table id
>>>>> () handler that processes table
>>>>> () counter how many items has been processed and passing it to
>>>>> acpi_table_parse_entries().
>>>
>>>> Why can't you leave the parsing code as is and create ApicId sorted list while parsing LAPIC/X2APIC? You could call acpi_register_lapic() after all... Do I miss something ?
>>>
>>> Just to make sure I understand correctly - you suggest to replace
>>> calls to acpi_register_lapic() with a code that builds an APIC ID list while parsing LAPIC/X2APIC, and after parsing is done, go thru the list and call acpi_register_lapic() on each APIC ID, correct?
>>>
>>
>> Yes, does it work for you?
>
> Hi Tomasz, sorry for late response, I was distracted by other things.
>
> So, I see two options to build the list:
>
> (a) use APIC ID as the table index
> (b) always append APIC ID to the end of table, in the order that BIOS lists them
>
> Also, my goal is to end up with enumeration like this (assuming there's 72 cores, 4 hyper threads each, total 288 logical CPUs):
>
> APIC ID  ->    Logical ID
> 0              ->     0
> 1              ->     72
> 2              ->     144
> 3              ->     216
> 4              ->     1
> 5              ->     73
> 6              ->     145
> 7              ->     217
> 8              ->     2
> ...
> 284         ->      71
> 285         ->      143
> 286         ->      215
> 287         ->      287
>
> Note that n,n+1,n+2,n+3 APIC IDs share same physical core, while being separated by core count in logical listing (e.g. 0,72,144,216 share same physical core).
>
> Now, ACPI spec specifies how APIC IDs should be listed:
> (1) Boot processor is listed first
> (2) For multi-threaded processors, BIOS should list the first logical processor of each of the individual multi-threaded processors in MADT before listing any of the second logical processors.
> (3) APIC IDs < 0xFF should be listed in APIC subtable, APIC IDs >= 0xFF should be listed in X2APIC subtable
>
> Keeping in mind above, BIOS lists APIC IDs as:
>
> APIC (0,4,8, .., 252)
> X2APIC (256,260,264, .. 284)
> APIC (1,5,9,...,253)
> X2API (257,261,265, 285)
> etc

OK got it, your patches make sense then.

Tomasz

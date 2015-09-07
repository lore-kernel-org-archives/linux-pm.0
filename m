From: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>
Subject: RE: [PATCH] x86, arm64, acpi: Handle lapic/x2apic entries in MADT
Date: Mon, 7 Sep 2015 14:04:07 +0000
Message-ID: <C1C2579D7BE026428F81F41198ADB172378A783A@irsmsx110.ger.corp.intel.com>
References: <55DDB45D.2030901@arm.com>
 <1440611369-26314-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1440611369-26314-2-git-send-email-lukasz.anaczkowski@intel.com>
 <55E55BA8.5090102@linaro.org>
 <C1C2579D7BE026428F81F41198ADB1723786A47E@irsmsx110.ger.corp.intel.com>
 <55E5A9EE.3030704@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55E5A9EE.3030704@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-pm@vger.kernel.org


From: Tomasz Nowicki [mailto:tomasz.nowicki@linaro.org] 
Sent: Tuesday, September 1, 2015 3:37 PM
> On 01.09.2015 14:07, Anaczkowski, Lukasz wrote:
>> From: Tomasz Nowicki [mailto:tomasz.nowicki@linaro.org]
>> Sent: Tuesday, September 1, 2015 10:03 AM
>>>
>>>> To fix this, each LAPIC/X2APIC entry from MADT table needs to be 
>>>> handled at the same time when processing it, thus adding 
>>>> acpi_subtable_proc structure which stores
>>>> () ACPI table id
>>>> () handler that processes table
>>>> () counter how many items has been processed and passing it to 
>>>> acpi_table_parse_entries().
>>
>>> Why can't you leave the parsing code as is and create ApicId sorted list while parsing LAPIC/X2APIC? You could call acpi_register_lapic() after all... Do I miss something ?
>>
>> Just to make sure I understand correctly - you suggest to replace 
>> calls to acpi_register_lapic() with a code that builds an APIC ID list while parsing LAPIC/X2APIC, and after parsing is done, go thru the list and call acpi_register_lapic() on each APIC ID, correct?
>>
>
> Yes, does it work for you?

Hi Tomasz, sorry for late response, I was distracted by other things.

So, I see two options to build the list: 

(a) use APIC ID as the table index
(b) always append APIC ID to the end of table, in the order that BIOS lists them

Also, my goal is to end up with enumeration like this (assuming there's 72 cores, 4 hyper threads each, total 288 logical CPUs):

APIC ID  ->    Logical ID
0              ->     0
1              ->     72
2              ->     144
3              ->     216
4              ->     1
5              ->     73
6              ->     145
7              ->     217
8              ->     2
...
284         ->      71
285         ->      143
286         ->      215
287         ->      287

Note that n,n+1,n+2,n+3 APIC IDs share same physical core, while being separated by core count in logical listing (e.g. 0,72,144,216 share same physical core).

Now, ACPI spec specifies how APIC IDs should be listed:
(1) Boot processor is listed first
(2) For multi-threaded processors, BIOS should list the first logical processor of each of the individual multi-threaded processors in MADT before listing any of the second logical processors.
(3) APIC IDs < 0xFF should be listed in APIC subtable, APIC IDs >= 0xFF should be listed in X2APIC subtable

Keeping in mind above, BIOS lists APIC IDs as:

APIC (0,4,8, .., 252)
X2APIC (256,260,264, .. 284) 
APIC (1,5,9,...,253)
X2API (257,261,265, 285)
etc

so in the end (2) rule is followed.

So, when (a) indexing is selected, mapping will be like:
APIC ID   -> Logical ID
0               ->    0
1               ->    1
2               ->    2
3               ->    3
...
287               ->    287

If (b) indexing is selected, mapping is like:
APIC ID     ->    Logical ID
0                 ->     0
1                 ->     63
2                 ->     126
3                 ->     189
4                 ->     1
5                 ->     64
...
284            ->     256
285            ->     266
286            ->     276
287            ->     286

Why? Because first APIC entries will be in the list (since this is the first parser to run), and just then X2APIC entries will be in the list.

So, long story short, unless you see other simple option on how to build the list of APIC IDs, I'm sorry to say that this approach will not work.

Cheers,
Lukasz

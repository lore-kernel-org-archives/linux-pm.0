From: chenyu5 <yu.c.chen@intel.com>
Subject: Re: [RFC PATCH] PM / hibernate: make sure each resuming page is in
 current memory zones
Date: Thu, 23 Jul 2015 13:42:35 +0800
Message-ID: <55B07ECB.9070200@intel.com>
References: <1435679668-13806-1-git-send-email-yu.c.chen@intel.com> <1613617.2K941pjbyO@vostro.rjw.lan> <55ADA040.7050408@intel.com> <2662645.fpATfiHLLF@vostro.rjw.lan> <36DF59CE26D8EE47B0655C516E9CE6402FC8C2@SHSMSX101.ccr.corp.intel.com> <20150723053432.GI23137@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17261 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbbGWFja (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Jul 2015 01:39:30 -0400
In-Reply-To: <20150723053432.GI23137@linux-rxt1.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Tian, YeX" <yex.tian@intel.com>

On 2015=E5=B9=B407=E6=9C=8823=E6=97=A5 13:34, joeyli wrote:
> Hi Chen Yu,
>
> On Wed, Jul 22, 2015 at 08:58:11AM +0000, Chen, Yu C wrote:
>>
>>
>>> -----Original Message-----
>>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>>> Sent: Wednesday, July 22, 2015 9:04 AM
>>> To: Chen, Yu C
>>> Cc: linux-pm@vger.kernel.org; Wysocki, Rafael J; joeyli; Tian, YeX
>>> Subject: Re: [RFC PATCH] PM / hibernate: make sure each resuming pa=
ge is
>>> in current memory zones
>>>
>>> On Tuesday, July 21, 2015 09:28:32 AM chenyu5 wrote:
>>>> On 2015=E5=B9=B407=E6=9C=8816=E6=97=A5 08:30, Rafael J. Wysocki wr=
ote:
>>>>> On Monday, July 06, 2015 04:37:39 PM joeyli wrote:
>>>>>> Hi Chen Yu,
>>>>>>
>>>>>> On Thu, Jul 02, 2015 at 04:00:42PM +0800, chenyu5 wrote:
>>>>>>> Hi, Joey
>>>>>>> thanks for your reply,
>>>>>>>
>>>>>>> On 2015=E5=B9=B407=E6=9C=8802=E6=97=A5 14:19, joeyli wrote:
>>>>>>>> Hi Chen Yu,
>>>>>>>>
>>>>>>>> On Tue, Jun 30, 2015 at 11:54:28PM +0800, Chen Yu wrote:
>>>>>>>>> Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e=
820
>>>>>>>>> reserved
>>>>>>>>> regions") was reverted, because this patch makes resume from
>>>>>>>>> hibernation on Lenovo x230 unreliable. But reverting may brin=
g
>>>>>>>>> back the kernel exception firstly reported in former patch. I=
n
>>>>>>>>> general, there are three problems in current code when resumi=
ng
>>> from hibernation:
>>>>>>>>>
>>>>>>>>> 1.Resuming page may also be in second kernel's e820 reserved
>>> region.
>>>>>>>>> BIOS-e820: [mem 0x0000000069d4f000-0x0000000069e12fff]
>>> reserved
>>>>>>>>> this causes kernel exception described in Commit 84c91b7ae07c
>>>>>>>>> ("PM / hibernate: avoid unsafe pages in e820 reserved regions=
")
>>>>>>>>>
>>>>>>>>> 2.If Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages=
 in
>>>>>>>>> e820 reserved regions") is applied to fix problem 1, and if
>>>>>>>>> E820_RESERVED_KERN regions causes some regions at e820 table
>>> not
>>>>>>>>> page aligned, e820_mark_nosave_regions will misjudgment the
>>>>>>>>> non-page aligned space to be "hole" space and add to nosave
>>> regions, this causes resuming failed.
>>>>>>>>> Refer to https://bugzilla.kernel.org/show_bug.cgi?id=3D96111 =
for
>>> detail.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sorry for I am not fully understand why checking pfn_valid cou=
ld
>>>>>>>> avoid the above 2. issue?
>>>>>>>>
>>>>>>> [Yu] According to e820_mark_nosave_regions, two kinds of e820
>>>>>>> regions will be regarded as nosave:
>>>>>>> a.e820.map holes between each e820entry b.e820entry with
>>>>>>> (!E820_RAM && !E820_RESERVED_KERN) dmesg in
>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D96111
>>>>>>> shows that:
>>>>>>>
>>>>>>> BIOS-e820: [mem 0x000000005baff000-0x00000000d684ffff] usable
>>>>>>> reserve setup_data: [mem 0x000000009d3e0018-0x000000009d3f0057]
>>>>>>> usable
>>>>>>> PM: Registered nosave memory: [mem 0x9d3e0000-0x9d3e0fff]
>>>>>>>
>>>>>>> e820 map was changed by situation a, but it should not be added=
 to
>>>>>>> nosave list, right?
>>>>>>>
>>>>>>> and according to saveable_page, only pages in the zone will be =
saved:
>>>>>>> if (page_zone(page_ !=3D zone)
>>>>>>> 	return NULL;
>>>>>>>
>>>>>>> The function of is_valid_orig_page in this patch treats setup_d=
ata
>>>>>>> as valid page, so I think this workaround issue 2.
>>>>>>>
>>>>>>>
>>>>>>>> Per my understood should waiting Yinghai Lu's patches for kill=
ing
>>>>>>>> E820_RESERVED_KERN to avoid the aligned problem.
>>>>>>> [Yu] yes, it is a graceful solution, but I don't see that in 4.=
1?
>>>>>>> And we encountered problem 3 in our testing enviroment, so I wr=
ote
>>>>>>> a patch to deal with it first.
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks a lot!
>>>>>>>> Joey Lee
>>>>>>>>
>>>>>>
>>>>>> Thanks for your explanation, then your patch makes sense to me.
>>>>>>
>>>>>> Please feel free to add tag:
>>>>>>
>>>>>> Reviewed-by: Lee, Chun-Yi <joeyli.kernel@gmail.com>
>>>>>
>>>>> Patch queued up for 4.3, thanks!
>>>>>
>>>> Hi Rafeal,
>>>> Please help drop this patch for now, QA has found some problems wi=
th
>>>> this patch applied, we're working on it now. Sorry for inconvenien=
ce.
>>>
>>> Dropping, thanks for the heads up!
>>>
>> Hi,Rafeal, Joey
>> I've sent out another patch, it is based on Joey's
>> original patch, and it treats any adjacent E820_RAM/E820_RESERVED_KE=
RN regions as
>> one. In this way,  non-page-aligned setup_data address would not be =
added
>> to nosave regions, thus workaround the hibernation failor mentiones =
in
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D96111
>>
>> V1 patch has a problem that, NOT every page in page zone has a valid=
 mapping address , thus
>> accessing these pages would cause problem. So I rewrite this path an=
d send out another V2 version.
>> Thanks for your time.
>>
>>   Yu
>>>
>
> Thanks for your work on this patch, but the E820_RESERVED_KERN will b=
e removed
> anyhow. So I prefer waiting Yinghai Lu's patch for killing E820_RESER=
VED_KERN.
>
OK. I'll wait for Yinghai's patch and yours.
Thanks.

Yu
>
> Regards
> Joey Lee
>


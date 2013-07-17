From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Wed, 17 Jul 2013 10:33:06 +0530
Message-ID: <51E6258A.3050105@linux.vnet.ibm.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <51DF307B.7060307@linux.vnet.ibm.com> <51E56382.3020609@gmx.de> <2829832.mz5UcF7ZkY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:60456 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3GQFGw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 01:06:52 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 17 Jul 2013 14:56:36 +1000
In-Reply-To: <2829832.mz5UcF7ZkY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, viresh.kumar@linaro.org, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/17/2013 03:02 AM, Rafael J. Wysocki wrote:
> On Tuesday, July 16, 2013 05:15:14 PM Toralf F=C3=B6rster wrote:
>> On 07/12/2013 12:23 AM, Srivatsa S. Bhat wrote:
>>> On 07/12/2013 04:03 AM, Rafael J. Wysocki wrote:
>>>> On Friday, July 12, 2013 03:45:17 AM Srivatsa S. Bhat wrote:
>>>>>
>>>>> Hi,
>>>>
>>>> Hi,
>>>>
>>>>> Commit a66b2e (cpufreq: Preserve sysfs files across suspend/resum=
e) caused
>>>>> some subtle regressions in the cpufreq subsystem during suspend/r=
esume.
>>>>> This patchset is aimed at rectifying those problems, by fixing th=
e regression
>>>>> as well as achieving the original goal of that commit in a proper=
 way.
>>>>>
>>>>> Patch 1 reverts the above commit, and is CC'ed to stable.
>>>>>
>>>>> Patches 2 - 5 reorganize the code and have no functional impact, =
and can go
>>>>> in as general cleanups as well. This reorganization builds a base=
 that the
>>>>> rest of the patches will make use of.
>>>>>
>>>>> Patch 6 and 7 add a mechanism to perform light-weight init/tear-d=
own of CPUs
>>>>> in the cpufreq subsystem and finally patch 8 uses it to preserve =
sysfs files
>>>>> across suspend/resume.
>>>>>
>>>>> All the patches apply on current mainline.
>>>>>
>>>>>
>>>>> Robert, Durgadoss, it would be great if you could try it out and =
see if it works
>>>>> well for your usecase. I tested it locally and cpufreq related fi=
les did retain
>>>>> their permissions across suspend/resume. Let me know if it works =
fine in your
>>>>> setup too.
>>>>>
>>>>> And I'd of course appreciate to hear from Dirk, Tianyu and Toralf=
 to know
>>>>> whether their systems work fine after:
>>>>> a. applying only the first commit (this is what gets backported t=
o stable)
>>>>> b. applying all the commits
>>>>>
>>>>> (Note: I had to use Michael's fix[1] to avoid CPU hotplug deadloc=
k while
>>>>> testing this patchset. Though that patch also touches cpufreq sub=
system, it
>>>>> doesn't affect this patchset in any way and there is absolutely n=
o dependency
>>>>> between the two in terms of code. That fix just makes basic CPU h=
otplug work
>>>>> without locking up on current mainline).
>>>>>
>>>>> [1]. https://lkml.org/lkml/2013/7/10/611
>>>>>
>>>>>
>>>>> Thank you very much!
>>>>
>>>> Thanks Srivatsa!
>>>>
>>>> I'm going to take [1/8] for 3.11 and queue up the rest for 3.12 if=
 people don't
>>>> hate them.  This way we'll have some more testing coverage before =
they reach
>>>> the mainline hopefully.
>>>>
>>
>> On 07/16/2013 01:25 AM, Rafael J. Wysocki wrote:> On Monday, July 15=
, 2013 07:38:02 PM Toralf F=C3=B6rster wrote:
>>> Sorry, I have no idea what 1#8 means.
>>
>> sry - here again with full quote of the email :
>>
>> I applied patch [1/8] on top of v3.11-rc1-8-g47188d3 passes two s2ra=
m/wakeup
>> cycles fine and crashed the system at the 3rd attempt / one times ju=
st at
>> the 4th (blinking power led, no sysrq, ...).
>>
>> Applying patch 1-8 on top of that tree differs in that way that it
>> crashes now the system even at the 1st attempt or at least at the 2n=
d
>>
>> My hardware is a ThinkPad T420 with latest BIOS and a 32 bit stable
>> Gentoo Linux - FWIW .config attached.
>=20
> I think you'll need the fixes first, basically [1/8] from this series=
 and
> this: https://patchwork.kernel.org/patch/2827512/ .
>=20
> Please try to run with these two things applied only and see how that=
 goes.
>=20

In addition to what Rafael suggested above, also try running your kerne=
l
with cpufreq completely turned off (CONFIG_CPU_FREQ=3Dn). My patches to=
uch only
cpufreq, so this experiment will tell us if your suspend/resume issues =
are
really related to cpufreq or not. If turning off cpufreq also breaks yo=
ur
suspend/resume, then a fresh git-bisect might be the only way to go.
=20
Regards,
Srivatsa S. Bhat


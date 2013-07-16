From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Tue, 16 Jul 2013 17:15:14 +0200
Message-ID: <51E56382.3020609@gmx.de>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <6515593.XAmN11qlGF@vostro.rjw.lan> <51DF307B.7060307@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51DF307B.7060307@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, viresh.kumar@linaro.org, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/12/2013 12:23 AM, Srivatsa S. Bhat wrote:
> On 07/12/2013 04:03 AM, Rafael J. Wysocki wrote:
>> On Friday, July 12, 2013 03:45:17 AM Srivatsa S. Bhat wrote:
>>>
>>> Hi,
>>
>> Hi,
>>
>>> Commit a66b2e (cpufreq: Preserve sysfs files across suspend/resume)=
 caused
>>> some subtle regressions in the cpufreq subsystem during suspend/res=
ume.
>>> This patchset is aimed at rectifying those problems, by fixing the =
regression
>>> as well as achieving the original goal of that commit in a proper w=
ay.
>>>
>>> Patch 1 reverts the above commit, and is CC'ed to stable.
>>>
>>> Patches 2 - 5 reorganize the code and have no functional impact, an=
d can go
>>> in as general cleanups as well. This reorganization builds a base t=
hat the
>>> rest of the patches will make use of.
>>>
>>> Patch 6 and 7 add a mechanism to perform light-weight init/tear-dow=
n of CPUs
>>> in the cpufreq subsystem and finally patch 8 uses it to preserve sy=
sfs files
>>> across suspend/resume.
>>>
>>> All the patches apply on current mainline.
>>>
>>>
>>> Robert, Durgadoss, it would be great if you could try it out and se=
e if it works
>>> well for your usecase. I tested it locally and cpufreq related file=
s did retain
>>> their permissions across suspend/resume. Let me know if it works fi=
ne in your
>>> setup too.
>>>
>>> And I'd of course appreciate to hear from Dirk, Tianyu and Toralf t=
o know
>>> whether their systems work fine after:
>>> a. applying only the first commit (this is what gets backported to =
stable)
>>> b. applying all the commits
>>>
>>> (Note: I had to use Michael's fix[1] to avoid CPU hotplug deadlock =
while
>>> testing this patchset. Though that patch also touches cpufreq subsy=
stem, it
>>> doesn't affect this patchset in any way and there is absolutely no =
dependency
>>> between the two in terms of code. That fix just makes basic CPU hot=
plug work
>>> without locking up on current mainline).
>>>
>>> [1]. https://lkml.org/lkml/2013/7/10/611
>>>
>>>
>>> Thank you very much!
>>
>> Thanks Srivatsa!
>>
>> I'm going to take [1/8] for 3.11 and queue up the rest for 3.12 if p=
eople don't
>> hate them.  This way we'll have some more testing coverage before th=
ey reach
>> the mainline hopefully.
>>

On 07/16/2013 01:25 AM, Rafael J. Wysocki wrote:> On Monday, July 15, 2=
013 07:38:02 PM Toralf F=C3=B6rster wrote:
> Sorry, I have no idea what 1#8 means.

sry - here again with full quote of the email :

I applied patch [1/8] on top of v3.11-rc1-8-g47188d3 passes two s2ram/w=
akeup
cycles fine and crashed the system at the 3rd attempt / one times just =
at
the 4th (blinking power led, no sysrq, ...).

Applying patch 1-8 on top of that tree differs in that way that it
crashes now the system even at the 1st attempt or at least at the 2nd

My hardware is a ThinkPad T420 with latest BIOS and a 32 bit stable
Gentoo Linux - FWIW .config attached.

>=20
> Sounds great! Thanks a lot Rafael!
> =20
> Regards,
> Srivatsa S. Bhat
>=20
>=20


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

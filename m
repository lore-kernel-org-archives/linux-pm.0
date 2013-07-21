From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Sun, 21 Jul 2013 14:13:42 +0530
Message-ID: <51EB9F3E.70608@linux.vnet.ibm.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <51DF307B.7060307@linux.vnet.ibm.com> <51E56382.3020609@gmx.de> <2829832.mz5UcF7ZkY@vostro.rjw.lan> <51E6B7F7.6020901@gmx.de> <51E6BD0E.1020101@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:45393 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab3GUIrb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jul 2013 04:47:31 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sun, 21 Jul 2013 18:44:30 +1000
In-Reply-To: <51E6BD0E.1020101@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, viresh.kumar@linaro.org
Cc: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/17/2013 09:19 PM, Srivatsa S. Bhat wrote:
> On 07/17/2013 08:57 PM, Toralf F=C3=B6rster wrote:
>> On 07/16/2013 11:32 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, July 16, 2013 05:15:14 PM Toralf F=C3=B6rster wrote:
[...]
>>>> sry - here again with full quote of the email :
>>>>
>>>> I applied patch [1/8] on top of v3.11-rc1-8-g47188d3 passes two s2=
ram/wakeup
>>>> cycles fine and crashed the system at the 3rd attempt / one times =
just at
>>>> the 4th (blinking power led, no sysrq, ...).
>>>>
>>>> Applying patch 1-8 on top of that tree differs in that way that it
>>>> crashes now the system even at the 1st attempt or at least at the =
2nd
>>>>
>>>> My hardware is a ThinkPad T420 with latest BIOS and a 32 bit stabl=
e
>>>> Gentoo Linux - FWIW .config attached.
>>>
>>> I think you'll need the fixes first, basically [1/8] from this seri=
es and
>>> this: https://patchwork.kernel.org/patch/2827512/ .
>>>
>>> Please try to run with these two things applied only and see how th=
at goes.
>>>
>>> Thanks,
>>> Rafael
>>>
>>>
>> That was it.
>>
>> Applying https://patchwork.kernel.org/patch/2827512/ and then patch
>> [1/8] on top of v3.11-rc1-8-g47188d3 works fine and solved the repor=
ted
>> issue.
>>
>> Furthermore applying patches 2-8 works too - suspend/wakeup works fi=
ne
>> and frequencies are scaled right after wakeup at the T420.
>>
>=20
> Phew! Finally :-)
>=20
> Thank you for all your testing efforts!
>=20

Rafael, Viresh, any thoughts on picking up patches 2-8 from this series
for 3.12?

=46rom the discussions on this thread so far, there are no pending issu=
es:
Toralf verified that these patches work fine on his system, as he menti=
oned
above, and Tianyu Lan independently tested this patchset and found no
issues with them. Also, Viresh analyzed the refcounting used in the pat=
ches
and we came to the conclusion that there is no problem with them either=
=2E

=20
Regards,
Srivatsa S. Bhat



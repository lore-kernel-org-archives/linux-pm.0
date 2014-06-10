From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 3/7] cpufreq: intel_pstate: Add debugfs file stats
Date: Tue, 10 Jun 2014 20:45:34 +0300
Message-ID: <5397443E.3070208@semaphore.gr>
References: <53962072.6010702@semaphore.gr> <53972883.7070707@gmail.com> <53973078.6040907@semaphore.gr> <53973ABE.300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:57634 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751983AbaFJRph (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 13:45:37 -0400
In-Reply-To: <53973ABE.300@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 10/06/2014 08:05 =CE=BC=CE=BC, Dirk Brandewie wrote:
> On 06/10/2014 09:21 AM, Stratos Karafotis wrote:
>> On 10/06/2014 06:47 =CE=BC=CE=BC, Dirk Brandewie wrote:
>>> On 06/09/2014 02:00 PM, Stratos Karafotis wrote:
>>>> Add stats file in debugfs under driver's parent directory
>>>> (pstate_snb) which counts the time in nsecs per requested
>>>> P state and the number of times the specific state
>>>> was requested.
>>>>
>>>> The file presents the statistics per logical CPU in the
>>>> following format. The time is displayed in msecs:
>>>>
>>>
>>> NAK
>>>
>>> This adds significantly to the memory footprint to gather informati=
on
>>> that is available by post processing the perf tracepoint informatio=
n.
>>> The increase isn't horrible on single socket desktop processor mach=
ines
>>> but gets big with server class machines.  One vendor I have talked =
to considers
>>> a machine with 1024 cpus to be a SMALL machine.
>>>
>>
>> If I am not wrong the sizeof pstate_stat is 20B. On my CPU with 20 P=
 states, we
>> need 400B per logical CPU (3200B total in my desktop) plus 64B for s=
tats pointers.
>>
>> In your example this would need about 400KB - 500KB?
>> Is it too much for 1024 a CPUs system?
>=20
> For something that will likely not be used IMO yes.
>=20
>>
>> I think it's a useful piece of info that we can have it directly wit=
hout
>> post processing tracepoint.
>> Is it acceptable to conditionally compile it with a new CONFIG optio=
n?
>=20
>=20
> I can see where the information could be useful but the set of people
> that would find it useful is very small.  Having information about re=
sidency=20
> since boot is interesting but just barely.  This file will encourage =
people
> to build tools/scripts that rely on this file and they will complain =
bitterly
> if/when it changes or goes away so you would be creating a defacto AB=
I in
> debugfs.
>=20
>=20
> This functionality will *not* be supportable in up coming processors =
where HWP
> is being used.  See section 14.4 of the current SDM vol. 3=20
> http://www.intel.com/content/dam/www/public/us/en/documents/manuals/6=
4-ia-32-architectures-software-developer-system-programming-manual-3253=
84.pdf
>=20

I will drop this patch in v2.
Thanks a lot for your comments and your time!

Stratos


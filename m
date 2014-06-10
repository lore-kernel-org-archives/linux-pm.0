From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: intel_pstate: Add debugfs file stats
Date: Tue, 10 Jun 2014 10:05:02 -0700
Message-ID: <53973ABE.300@gmail.com>
References: <53962072.6010702@semaphore.gr> <53972883.7070707@gmail.com> <53973078.6040907@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:51255 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaFJRFF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 13:05:05 -0400
In-Reply-To: <53973078.6040907@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: dirk.brandewie@gmail.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 06/10/2014 09:21 AM, Stratos Karafotis wrote:
> On 10/06/2014 06:47 =CE=BC=CE=BC, Dirk Brandewie wrote:
>> On 06/09/2014 02:00 PM, Stratos Karafotis wrote:
>>> Add stats file in debugfs under driver's parent directory
>>> (pstate_snb) which counts the time in nsecs per requested
>>> P state and the number of times the specific state
>>> was requested.
>>>
>>> The file presents the statistics per logical CPU in the
>>> following format. The time is displayed in msecs:
>>>
>>
>> NAK
>>
>> This adds significantly to the memory footprint to gather informatio=
n
>> that is available by post processing the perf tracepoint information=
=2E
>> The increase isn't horrible on single socket desktop processor machi=
nes
>> but gets big with server class machines.  One vendor I have talked t=
o considers
>> a machine with 1024 cpus to be a SMALL machine.
>>
>=20
> If I am not wrong the sizeof pstate_stat is 20B. On my CPU with 20 P =
states, we
> need 400B per logical CPU (3200B total in my desktop) plus 64B for st=
ats pointers.
>=20
> In your example this would need about 400KB - 500KB?
> Is it too much for 1024 a CPUs system?

=46or something that will likely not be used IMO yes.

>=20
> I think it's a useful piece of info that we can have it directly with=
out
> post processing tracepoint.
> Is it acceptable to conditionally compile it with a new CONFIG option=
?


I can see where the information could be useful but the set of people
that would find it useful is very small.  Having information about resi=
dency=20
since boot is interesting but just barely.  This file will encourage pe=
ople
to build tools/scripts that rely on this file and they will complain bi=
tterly
if/when it changes or goes away so you would be creating a defacto ABI =
in
debugfs.


This functionality will *not* be supportable in up coming processors wh=
ere HWP
is being used.  See section 14.4 of the current SDM vol. 3=20
http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-=
ia-32-architectures-software-developer-system-programming-manual-325384=
=2Epdf


>=20
>=20
> Thanks,
> Stratos
>=20


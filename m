From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Wed, 11 Jun 2014 00:35:25 +0300
Message-ID: <53977A1D.9010202@semaphore.gr>
References: <5396208F.6070400@semaphore.gr> <1875587.zmLYOIAyby@vostro.rjw.lan> <53977251.2090804@semaphore.gr> <1894836.tjrHdJ7Duz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:58383 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753830AbaFJVf3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 17:35:29 -0400
In-Reply-To: <1894836.tjrHdJ7Duz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, dirk.j.brandewie@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 11/06/2014 12:38 =CF=80=CE=BC, Rafael J. Wysocki wrote:
> On Wednesday, June 11, 2014 12:02:09 AM Stratos Karafotis wrote:
>> On 10/06/2014 11:43 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
>>> On Tuesday, June 10, 2014 11:14:53 PM Stratos Karafotis wrote:
>>>> On 10/06/2014 11:17 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
>>>>> On Tuesday, June 10, 2014 10:26:44 AM Dirk Brandewie wrote:
>>>>>> On 06/10/2014 08:31 AM, Rafael J. Wysocki wrote:
>>>>>>> On Tuesday, June 10, 2014 08:12:48 AM Dirk Brandewie wrote:
>>>>>>>> On 06/09/2014 02:01 PM, Stratos Karafotis wrote:
>>>>>>>>> Remove unnecessary blank lines.
>>>>>>>>> Remove unnecessary parentheses.
>>>>>>>>> Remove unnecessary braces.
>>>>>>>>> Put the code in one line where possible.
>>>>>>>>> Add blank lines after variable declarations.
>>>>>>>>> Alignment to open parenthesis.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't have an issue with this patch in general but I would r=
ather
>>>>>>>> the cleanup be done when there is a functional change in the g=
iven
>>>>>>>> hunk of code otherwise you are setting up a fence for stable/b=
ackporters
>>>>>>>> of functional changes in the future.
>>>>>>>
>>>>>>> I actually prefer separate cleanups so as to avoid doing multip=
le things
>>>>>>> in one patch.
>>>>>>>
>>>>>>> Rafael
>>>>>>>
>>>>>> I don't have strong feelings either way I was just trying to be =
kind
>>>>>> to the maintainers of distro kernels.
>>>>>
>>>>> And mixing fixes with cleanups in one patch doesn't do any good t=
o them.
>>>>>
>>>>> Trust me, I used to work for a distro. :-)
>>>>>
>>>>
>>>> So, should I proceed and split the patch or drop it? :)
>>>
>>> I'm not sure why you'd want to split it?
>>
>> Forgive me, but I'm totally confused. I asked because you mentioned =
that
>> you prefer separate cleanups.
>=20
> That was in a reply to Dirk who suggested doing cleanups along with
> fixes (or at least I understood what he said this way).
>=20
> I tried to explain why I didn't think that this was a good idea.
>=20
>> So, my question was if you want me to separate this patch into more =
(one
>> per change) or entirely drop it (because it would cause problems to =
backporters
>> or maintainers).
>=20
> Cleanups are generally OK, but it's better to do one kind of a cleanu=
p
> per patch.  Like whitespace fixes in one patch, cleanup of expression=
s in
> another.
>=20

OK, thanks for the clarification! I will do it in separate patches.

>>
>>> That said you're changing things that are intentional.  For example=
,
>>> the
>>>
>>> 	if (acpi_disabled
>>> 	    || ...)
>>>
>>> is.  And the result of (a * 100) / b may generally be different fro=
m
>>> a * 100 / b for integers (if the division is carried out first).
>>
>> I thought that (a * 100) / b is always equivalent to a * 100 / b.
>=20
> I'm not actually sure if that's guaranteed by C standards.  It surely
> wasn't some time ago (when there was no formal C standard).
>

I think it is, according to C precedence table.
But, anyway my motivation to the specific cleanup was the different sty=
le
in the same block code:

        limits.min_perf_pct =3D (policy->min * 100) / policy->cpuinfo.m=
ax_freq;
	...
        limits.max_policy_pct =3D policy->max * 100 / policy->cpuinfo.m=
ax_freq;

Thanks again!
Stratos

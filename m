From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Wed, 11 Jun 2014 00:02:09 +0300
Message-ID: <53977251.2090804@semaphore.gr>
References: <5396208F.6070400@semaphore.gr> <5753346.hxK14sqO5y@vostro.rjw.lan> <5397673D.8010200@semaphore.gr> <1875587.zmLYOIAyby@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:58261 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752940AbaFJVCN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 17:02:13 -0400
In-Reply-To: <1875587.zmLYOIAyby@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, dirk.j.brandewie@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 10/06/2014 11:43 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
> On Tuesday, June 10, 2014 11:14:53 PM Stratos Karafotis wrote:
>> On 10/06/2014 11:17 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
>>> On Tuesday, June 10, 2014 10:26:44 AM Dirk Brandewie wrote:
>>>> On 06/10/2014 08:31 AM, Rafael J. Wysocki wrote:
>>>>> On Tuesday, June 10, 2014 08:12:48 AM Dirk Brandewie wrote:
>>>>>> On 06/09/2014 02:01 PM, Stratos Karafotis wrote:
>>>>>>> Remove unnecessary blank lines.
>>>>>>> Remove unnecessary parentheses.
>>>>>>> Remove unnecessary braces.
>>>>>>> Put the code in one line where possible.
>>>>>>> Add blank lines after variable declarations.
>>>>>>> Alignment to open parenthesis.
>>>>>>>
>>>>>>
>>>>>> I don't have an issue with this patch in general but I would rat=
her
>>>>>> the cleanup be done when there is a functional change in the giv=
en
>>>>>> hunk of code otherwise you are setting up a fence for stable/bac=
kporters
>>>>>> of functional changes in the future.
>>>>>
>>>>> I actually prefer separate cleanups so as to avoid doing multiple=
 things
>>>>> in one patch.
>>>>>
>>>>> Rafael
>>>>>
>>>> I don't have strong feelings either way I was just trying to be ki=
nd
>>>> to the maintainers of distro kernels.
>>>
>>> And mixing fixes with cleanups in one patch doesn't do any good to =
them.
>>>
>>> Trust me, I used to work for a distro. :-)
>>>
>>
>> So, should I proceed and split the patch or drop it? :)
>=20
> I'm not sure why you'd want to split it?

=46orgive me, but I'm totally confused. I asked because you mentioned t=
hat
you prefer separate cleanups.
So, my question was if you want me to separate this patch into more (on=
e
per change) or entirely drop it (because it would cause problems to bac=
kporters
or maintainers).

> That said you're changing things that are intentional.  For example,
> the
>=20
> 	if (acpi_disabled
> 	    || ...)
>=20
> is.  And the result of (a * 100) / b may generally be different from
> a * 100 / b for integers (if the division is carried out first).

I thought that (a * 100) / b is always equivalent to a * 100 / b.


Stratos


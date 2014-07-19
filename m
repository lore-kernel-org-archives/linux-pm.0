From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 00/11] intel_pstate updates
Date: Sun, 20 Jul 2014 01:05:10 +0300
Message-ID: <53CAEB96.3050400@semaphore.gr>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com> <3522584.qtcX0qT22E@vostro.rjw.lan> <53CADCC2.503@semaphore.gr> <2674303.gCTh0s6JEA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:37320 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755756AbaGSWFN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jul 2014 18:05:13 -0400
In-Reply-To: <2674303.gCTh0s6JEA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: dirk.brandewie@gmail.com, linux-pm@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

On 20/07/2014 12:54 =CF=80=CE=BC, Rafael J. Wysocki wrote:
> On Sunday, July 20, 2014 12:01:54 AM Stratos Karafotis wrote:
>> On 19/07/2014 11:31 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
>>> On Friday, July 18, 2014 08:37:16 AM dirk.brandewie@gmail.com wrote=
:
>>>> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
>>>>
>>>> These patches have been in the development branch used by Stratos,
>>>> Doug and myself for a long time.  I had hoped to batch them up wit=
h
>>>> other functional changes that are under development but those chan=
ges
>>>> are still under active discussion and there is no reason to hold t=
hese
>>>> changes up.
>>>>
>>>> Based on v3.16-rc5 commit 1795cd9b3a91d4b5473c97f491d63892442212ab
>>>>
>>>> Stratos Karafotis (11):
>>>>   cpufreq: intel_pstate: Make intel_pstate_kobject and debugfs_par=
ent
>>>>     locals
>>>>   cpufreq: intel_pstate: Remove unnecessary type casting in div_s6=
4()
>>>>     call
>>>>   cpufreq: intel_pstate: Add missing blank lines after declaration=
s
>>>>   cpufreq: intel_pstate: Fit code in a single line where possible
>>>>   cpufreq: intel_pstate: Cleanup parentheses
>>>>   cpufreq: intel_pstate: Remove unnecessary intermediate variable
>>>>     sample_time
>>>>   cpufreq: intel_pstate: Align multiple lines to open parenthesis
>>>>   cpufreq: intel_pstate: Disable interrupts during MSRs reading
>>>>   cpufreq: intel_pstate: Simplify P state adjustment logic.
>>>>   cpufreq: intel_pstate: Remove core_pct rounding
>>>>   cpufreq: intel_pstate: Keep values in aperf/mperf in full precis=
ion
>>>
>>> [11/11] appears to be the same as the patch marked [9/17] which I g=
uess
>>> was posted by mistake.  Other than that, looks good.  Queued up for=
 3.17,
>>> thanks!
>>
>> The only difference between them is the last 2 lines in changelog.
>> [11/11] is the correct one.
>> The final code in bleeding-edge is, of course, correct.
>>
>> I'm sorry that I didn't notice this earlier.
>=20
> No big deal.
>=20
> I fixed up the changelog in my tree internally, will propagate to lin=
ux-pm
> with the next push.

Thank you!

Stratos



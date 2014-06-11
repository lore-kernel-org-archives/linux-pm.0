From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 14:40:02 -0700
Message-ID: <00b401cf85bd$b4851f10$1d8f5d30$@net>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr><009b01cf857a$d5032090$7f0961b0$@net><539862DB.9060905@semaphore.gr><00a001cf8586$24eb5c70$6ec21550$@net> <CAJZ5v0hEFp8sQH3iB6SUeVVEmdYA6ZK1kvc9NM+7sbS-LTW6nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta5.telus.net ([209.171.16.78]:38274 "EHLO cmta5.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbaFKVkH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 17:40:07 -0400
In-Reply-To: <CAJZ5v0hEFp8sQH3iB6SUeVVEmdYA6ZK1kvc9NM+7sbS-LTW6nQ@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Stratos Karafotis' <stratosk@semaphore.gr>, linux-pm@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com



-----Original Message-----
=46rom: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of R=
afael J. Wysocki
Sent: June-11-2014 11:29
To: Doug Smythies
Cc: Stratos Karafotis; linux-pm@vger.kernel.org; Linux Kernel Mailing L=
ist; Rafael J. Wysocki; viresh.kumar@linaro.org; dirk.j.brandewie@intel=
=2Ecom
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct

On 2014.06.11 11:29 Rafael J. Wysocki wrote:
> On Wed, Jun 11, 2014 at 5:02 PM, Doug Smythies <dsmythies@telus.net> =
wrote:
>> On 2104.06.11 07:08 Stratos Karafotis wrote:
>>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>>
>>> No.
>>>
>>> The intent was only ever to round properly the pseudo floating poin=
t result of the divide.
>>> It was much more important (ugh, well 4 times more) when FRACBITS w=
as still 6, which also got changed to 8 in a recent patch.
>>>
>>
>> Are you sure?
>>
>> Yes.
>>
>>> This rounding was very recently added.
>>> As far as I can understand, I don't see the meaning of this roundin=
g, as is.
>>> Even if FRAC_BITS was 6, I think it would have almost no improvemen=
t in
>>> calculations.
>>
>> Note: I had not seen this e-mail when I wrote a few minutes ago:
>>
>> You may be correct.
>> If Dirk agrees, I will re-analyse the entire driver for rounding eff=
ects soon.

> Well, can you please do it if that's not a problem?

Yes, of course, but it is a matter of priorities. All I meant by the ab=
ove comment was that we might be able to forget about the remainder and=
 just do a mindless divide, but leaving it as it is now does no harm in=
 the meantime.

Myself, I consider the issue of excessive deferred timer times to be a =
much higher priority (see my on-list e-mail from Monday). Correct me if=
 I am wrong.
Even without the "excessive" part, and for a 250 Hz kernel, the current=
 kick in point can be hit routinely, unduly biasing the CPU frequency d=
ownwards.
A random example (250 Hz kernel): 23% load at 25 Hertz load / sleep fre=
quency for 300 total seconds.

Duration histrogram:

Occurrences duration (seconds)
     16 0.044
     39 0.024
     45 0.028
     46 0.016
     48 0.032
     61 0.036
    166 0.012
    198 0.020
   7166 0.040

Where you can see that the majority of the time the duration is such th=
at the code will force the CPU frequency downwards. It runs at minimum =
pstate instead of maximum pstate where it should be.

=2E.. Doug



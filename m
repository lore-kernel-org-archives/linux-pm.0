From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 23:45:13 +0200
Message-ID: <CAJZ5v0jPPkWCZBCTKazNJsK8m4aNB-1C6GKtUOmOUt+v_CV+WQ@mail.gmail.com>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr>
	<009b01cf857a$d5032090$7f0961b0$@net>
	<539862DB.9060905@semaphore.gr>
	<00a001cf8586$24eb5c70$6ec21550$@net>
	<CAJZ5v0hEFp8sQH3iB6SUeVVEmdYA6ZK1kvc9NM+7sbS-LTW6nQ@mail.gmail.com>
	<00b401cf85bd$b4851f10$1d8f5d30$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00b401cf85bd$b4851f10$1d8f5d30$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stratos Karafotis <stratosk@semaphore.gr>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 11, 2014 at 11:40 PM, Doug Smythies <dsmythies@telus.net> w=
rote:
>
>
> -----Original Message-----
> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of R=
afael J. Wysocki
> Sent: June-11-2014 11:29
> To: Doug Smythies
> Cc: Stratos Karafotis; linux-pm@vger.kernel.org; Linux Kernel Mailing=
 List; Rafael J. Wysocki; viresh.kumar@linaro.org; dirk.j.brandewie@int=
el.com
> Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
>
> On 2014.06.11 11:29 Rafael J. Wysocki wrote:
>> On Wed, Jun 11, 2014 at 5:02 PM, Doug Smythies <dsmythies@telus.net>=
 wrote:
>>> On 2104.06.11 07:08 Stratos Karafotis wrote:
>>>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>>>
>>>> No.
>>>>
>>>> The intent was only ever to round properly the pseudo floating poi=
nt result of the divide.
>>>> It was much more important (ugh, well 4 times more) when FRACBITS =
was still 6, which also got changed to 8 in a recent patch.
>>>>
>>>
>>> Are you sure?
>>>
>>> Yes.
>>>
>>>> This rounding was very recently added.
>>>> As far as I can understand, I don't see the meaning of this roundi=
ng, as is.
>>>> Even if FRAC_BITS was 6, I think it would have almost no improveme=
nt in
>>>> calculations.
>>>
>>> Note: I had not seen this e-mail when I wrote a few minutes ago:
>>>
>>> You may be correct.
>>> If Dirk agrees, I will re-analyse the entire driver for rounding ef=
fects soon.
>
>> Well, can you please do it if that's not a problem?
>
> Yes, of course, but it is a matter of priorities. All I meant by the =
above comment was that we might be able to forget about the remainder a=
nd just do a mindless divide, but leaving it as it is now does no harm =
in the meantime.
>
> Myself, I consider the issue of excessive deferred timer times to be =
a much higher priority (see my on-list e-mail from Monday). Correct me =
if I am wrong.
> Even without the "excessive" part, and for a 250 Hz kernel, the curre=
nt kick in point can be hit routinely, unduly biasing the CPU frequency=
 downwards.
> A random example (250 Hz kernel): 23% load at 25 Hertz load / sleep f=
requency for 300 total seconds.
>
> Duration histrogram:
>
> Occurrences duration (seconds)
>      16 0.044
>      39 0.024
>      45 0.028
>      46 0.016
>      48 0.032
>      61 0.036
>     166 0.012
>     198 0.020
>    7166 0.040
>
> Where you can see that the majority of the time the duration is such =
that the code will force the CPU frequency downwards. It runs at minimu=
m pstate instead of maximum pstate where it should be.

I see.

What would you suggest to do to address this problem, then?

Rafael

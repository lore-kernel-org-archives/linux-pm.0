From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Fri, 13 Jun 2014 20:39:27 +0300
Message-ID: <539B374F.30303@semaphore.gr>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <00b301cf85ba$40fe4290$c2fac7b0$@net> <5399BACF.6060201@semaphore.gr> <1815178.vjJU51ubGD@vostro.rjw.lan> <001e01cf86d3$ab314cb0$0193e610$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:37341 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752075AbaFMRjb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 13:39:31 -0400
In-Reply-To: <001e01cf86d3$ab314cb0$0193e610$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 13/06/2014 09:49 =CF=80=CE=BC, Doug Smythies wrote:
> On 2014.06.12 13:03 Rafael J. Wysocki wrote:
>> On Thursday, June 12, 2014 05:35:59 PM Stratos Karafotis wrote:
>>> On 12/06/2014 12:15 =CF=80=CE=BC, Doug Smythies wrote:
>>>>
>>>>
>>>> On 2014.06.11 13:20 Stratos Karafotis wrote:
>>>>> On 11/06/2014 06:02 =CE=BC=CE=BC, Doug Smythies wrote:
>>>>>>
>>>>>> On 2104.06.11 07:08 Stratos Karafotis wrote:
>>>>>>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>>>>>>
>>>>>>> No.
>>>>>
>>>>>>> The intent was only ever to round properly the pseudo floating =
point result of the divide.
>>>>>>> It was much more important (ugh, well 4 times more) when FRACBI=
TS was still 6, which also got changed to 8 in a recent patch.
>>>>>>>
>>>>>>
>>>>>> Are you sure?
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>> This rounding was very recently added.
>>>>>>> As far as I can understand, I don't see the meaning of this rou=
nding, as is.
>>>>>>> Even if FRAC_BITS was 6, I think it would have almost no improv=
ement in
>>>>>>> calculations.
>>>>>>
>>>>>> Note: I had not seen this e-mail when I wrote a few minutes ago:
>>>>>>
>>>>>> You may be correct.
>>>>>> If Dirk agrees, I will re-analyse the entire driver for rounding=
 effects soon.
>>>>>> When FRACBITS was 6 there were subtle cases where the driver wou=
ld get stuck, and not make a final pstate change, with the default PID =
gains.
>>>>>> Other things have changed, and the analysis needs to be re-done.
>>>>>>
>>>>
>>>>> Could you please elaborate a little bit more what we need these 2=
 lines below?
>>>>>
>>>>>        if ((rem << 1) >=3D int_tofp(sample->mperf))
>>>>>                core_pct +=3D 1;
>>>>>
>>>>> Because nothing is mentioned for them in commit's changelog.
>>>>> Do we need to round core_pct or not?
>>>>> Because if we try to round it, I think this patch should work.
>>>>
>>>> As mentioned originally, they are there just to round the pseudo f=
loating number, not the integer portion only.
>>>> Let us bring back the very numbers you originally gave and work th=
rough it.
>>>>
>>>> aperf =3D 5024
>>>> mperf =3D 10619
>>>>
>>>> core_pct =3D 47.31142292%
>>>> or 47 and 79.724267 256ths
>>>> or to the closest kept fractional part 47 and 80 256ths
>>>> or 12112 as a pseudo float.
>>>> The maximum error with this rounding will be 1 part in 512 and sym=
metric instead of the 1 part in 256 always in one direction without.
>>>>
>>>> Now if FRACBITS was still 6:
>>>> core_pct =3D 47.31142292%
>>>> or 47 and 19.931 64ths
>>>> or to the closest kept fractional part 47 and 20 64ths
>>>> or 3028 as a pseudo float.
>>>> The maximum error with this rounding will be 1 part in 128 and sym=
metric instead of the 1 part in 64 (1.6% !!!) always in one direction w=
ithout.
>>>>
>>>> Hope this helps.
>>>>
>>>
>>> Yes, it helps. Thanks a lot!
>>>
>>> But please note that the maximum error without this rounding will b=
e 1.6% _only_
>>> in fractional part. In the real number it will be much smaller:
>=20
> Fair comment. Thanks.
>=20
>>>
>>> 47.19 instead of 47.20
>>>
>>> And using FRAC_BITS 8:
>>>
>>> 47.79 instead of 47.80
>>>
>=20
> I really wouldn't write it that way, as I find it misleading. It is r=
eally 47 and 19 256ths...
> Anyway, I think we all understand.
>=20
>>> This is a 0.0002% difference. I can't see how this is can affect th=
e calculations
>>> even with FRAC_BITS 6.
>=20
> O.K. The solution is overkill and div_u64 could have been used instea=
d of div_u64_rem.
> On my list, it is the lowest of priorities.
>=20
>>>
>>> Another thing is that this algorithm generally is used to round to =
the
>>> nearest integer. I'm not sure if it's valid to apply it for the rou=
nding of
>>> the fractional part of fixed point number.
>=20
> I'm not sure how to reply, a pseudo floating point number is just an =
integer.
>=20
>> Depending on the original reason, it may or may not be.
>=20
> The original reason for that overall code patch was to address the po=
ssible overflow of the math, which (as far I know and have tested) it d=
oes.
> I think we have gone down a bit of rat hole here in terms of the deta=
il.
>=20

Hi Doug,

I'm sorry if I pushed it too far.
But sometimes many small details could make the difference.
At least we finally agreed to something! :-)

Thanks for your time and for your comments!
Stratos



P.S. Talking about small details and with a sense of humor (I hope)
I present some roughly estimates about the tiny change (the 2-3 lines
removal).

Let's assume that this code needs 100 CPU cycles to run.

In a full active core, at a sampling rate 10ms, the code runs
8,640,000 times/day and if we suppose that the core will be 90%
of the day inactive, it needs 86,400,000 CPU cycles/day.

If the CPU runs in a typical 2GHz freq the code will need
0.0432 secs to be executed (per day). With a 15W avg power
consumption we need 0,648 Joules/day per core.

In a typical quad core PC we need 2.592 Joules/day or
946,08 Joules/year.

I read that there are 2 billion PCs in the planet.
Assuming that 1.5% of them running Linux and 50% of them
will use this driver, the code will run on 30,000,000 PCs.

So, we need:
14,191,200,000 Joules/year =3D 3,942 KWh

And:
3,942 KWh * 2.3 =3D 9,066 lb CO2 =3D 4,112 Kg CO2

Thus, removing these 2 lines we will reduce the global CO2 emissions
by 4,112 Kg! :-)




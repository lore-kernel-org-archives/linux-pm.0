From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Fri, 13 Jun 2014 19:56:52 +0300
Message-ID: <539B2D54.6070108@semaphore.gr>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <00b301cf85ba$40fe4290$c2fac7b0$@net> <5399BACF.6060201@semaphore.gr> <1815178.vjJU51ubGD@vostro.rjw.lan> <539B0147.8020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:36909 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753490AbaFMQ44 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 12:56:56 -0400
In-Reply-To: <539B0147.8020407@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>
Cc: viresh.kumar@linaro.org, dirk.j.brandewie@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 13/06/2014 04:48 =CE=BC=CE=BC, Dirk Brandewie wrote:
> On 06/12/2014 01:03 PM, Rafael J. Wysocki wrote:
>> On Thursday, June 12, 2014 05:35:59 PM Stratos Karafotis wrote:
>>> On 12/06/2014 12:15 =CF=80=CE=BC, Doug Smythies wrote:
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Stratos Karafotis [mailto:stratosk@semaphore.gr]
>>>> Sent: June-11-2014 13:20
>>>> To: Doug Smythies
>>>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; rjw@rj=
wysocki.net; viresh.kumar@linaro.org; dirk.j.brandewie@intel.com
>>>> Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_p=
ct
>>>>
>>>> On 2014.06.11 13:20 Stratos Karafotis wrote:
>>>>> On 11/06/2014 06:02 =CE=BC=CE=BC, Doug Smythies wrote:
>>>>>>
>>>>>> On 2104.06.11 07:08 Stratos Karafotis wrote:
>>>>>>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>>>>>>
>>>>>>> No.
>>>>>>
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
>=20
> Sorry for being MIA on this thread I have been up to my eyeballs.
>=20
>>>>>         if ((rem << 1) >=3D int_tofp(sample->mperf))
>>>>>                 core_pct +=3D 1;
>=20
> The rounding should have been
>        core_pct +=3D (1 << (FRAC_BITS-1));
> Since core_pct is is in fixeded point notation at this point. Adding =
=2E5 to
> core_pct to round up.
>=20
> As Stratos pointed out the the current code only adds 1/256 to core_p=
ct
>=20
> Since core_pct_busy stays in fixed point through out the rest of the
> calculations ans we only do the rounding when the PID is returning an
> int I think we can safely remove these two lines.
>=20

Please let me know if you want me to send a new patch for this (after t=
he merge
window). Or will you or Doug handle this?


>> Depending on the original reason, it may or may not be.
>>
>> In theory, it may help reduce numerical drift resulting from roundin=
g always in
>> one direction only, but I'm not really sure if that matters here.
>>
>> Doug seems to have carried out full analysis, though.
>>
>> Rafael
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
>=20

Thank you all, for your comments!

Stratos

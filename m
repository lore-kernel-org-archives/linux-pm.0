From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Thu, 12 Jun 2014 23:49:46 -0700
Message-ID: <001e01cf86d3$ab314cb0$0193e610$@net>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <00b301cf85ba$40fe4290$c2fac7b0$@net> <5399BACF.6060201@semaphore.gr> <1815178.vjJU51ubGD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:48891 "EHLO cmta17.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbaFMGts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 02:49:48 -0400
In-Reply-To: <1815178.vjJU51ubGD@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: viresh.kumar@linaro.org, dirk.j.brandewie@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2014.06.12 13:03 Rafael J. Wysocki wrote:
> On Thursday, June 12, 2014 05:35:59 PM Stratos Karafotis wrote:
>> On 12/06/2014 12:15 =CF=80=CE=BC, Doug Smythies wrote:
>>>=20
>>>=20
>>> On 2014.06.11 13:20 Stratos Karafotis wrote:
>>>> On 11/06/2014 06:02 =CE=BC=CE=BC, Doug Smythies wrote:
>>>>>
>>>>> On 2104.06.11 07:08 Stratos Karafotis wrote:
>>>>>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>>>>>
>>>>>> No.
> >>>
>>>>>> The intent was only ever to round properly the pseudo floating p=
oint result of the divide.
>>>>>> It was much more important (ugh, well 4 times more) when FRACBIT=
S was still 6, which also got changed to 8 in a recent patch.
>>>>>>
>>>>>
>>>>> Are you sure?
>>>>>
>>>>> Yes.
>>>>>
>>>>>> This rounding was very recently added.
>>>>>> As far as I can understand, I don't see the meaning of this roun=
ding, as is.
>>>>>> Even if FRAC_BITS was 6, I think it would have almost no improve=
ment in
>>>>>> calculations.
>>>>>
>>>>> Note: I had not seen this e-mail when I wrote a few minutes ago:
>>>>>
>>>>> You may be correct.
>>>>> If Dirk agrees, I will re-analyse the entire driver for rounding =
effects soon.
>>>>> When FRACBITS was 6 there were subtle cases where the driver woul=
d get stuck, and not make a final pstate change, with the default PID g=
ains.
>>>>> Other things have changed, and the analysis needs to be re-done.
>>>>>
>>>=20
>>>> Could you please elaborate a little bit more what we need these 2 =
lines below?
>>>>
>>>>        if ((rem << 1) >=3D int_tofp(sample->mperf))
>>>>                core_pct +=3D 1;
>>>>
>>>> Because nothing is mentioned for them in commit's changelog.
>>>> Do we need to round core_pct or not?
>>>> Because if we try to round it, I think this patch should work.
>>>=20
>>> As mentioned originally, they are there just to round the pseudo fl=
oating number, not the integer portion only.
>>> Let us bring back the very numbers you originally gave and work thr=
ough it.
>>>=20
>>> aperf =3D 5024
>>> mperf =3D 10619
>>>=20
>>> core_pct =3D 47.31142292%
>>> or 47 and 79.724267 256ths
>>> or to the closest kept fractional part 47 and 80 256ths
>>> or 12112 as a pseudo float.
>>> The maximum error with this rounding will be 1 part in 512 and symm=
etric instead of the 1 part in 256 always in one direction without.
>>>=20
>>> Now if FRACBITS was still 6:
>>> core_pct =3D 47.31142292%
>>> or 47 and 19.931 64ths
>>> or to the closest kept fractional part 47 and 20 64ths
>>> or 3028 as a pseudo float.
>>> The maximum error with this rounding will be 1 part in 128 and symm=
etric instead of the 1 part in 64 (1.6% !!!) always in one direction wi=
thout.
>>>=20
>>> Hope this helps.
>>>=20
>>
>> Yes, it helps. Thanks a lot!
>>=20
>> But please note that the maximum error without this rounding will be=
 1.6% _only_
>> in fractional part. In the real number it will be much smaller:

=46air comment. Thanks.

>>
>> 47.19 instead of 47.20
>>=20
>> And using FRAC_BITS 8:
>>=20
>> 47.79 instead of 47.80
>>=20

I really wouldn't write it that way, as I find it misleading. It is rea=
lly 47 and 19 256ths...
Anyway, I think we all understand.

>> This is a 0.0002% difference. I can't see how this is can affect the=
 calculations
>> even with FRAC_BITS 6.

O.K. The solution is overkill and div_u64 could have been used instead =
of div_u64_rem.
On my list, it is the lowest of priorities.

>>=20
>> Another thing is that this algorithm generally is used to round to t=
he
>> nearest integer. I'm not sure if it's valid to apply it for the roun=
ding of
>> the fractional part of fixed point number.

I'm not sure how to reply, a pseudo floating point number is just an in=
teger.

> Depending on the original reason, it may or may not be.

The original reason for that overall code patch was to address the poss=
ible overflow of the math, which (as far I know and have tested) it doe=
s.
I think we have gone down a bit of rat hole here in terms of the detail=
=2E

=2E.. Doug



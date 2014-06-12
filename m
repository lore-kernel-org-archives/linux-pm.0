From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Thu, 12 Jun 2014 17:35:59 +0300
Message-ID: <5399BACF.6060201@semaphore.gr>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <009b01cf857a$d5032090$7f0961b0$@net> <539862DB.9060905@semaphore.gr> <00a001cf8586$24eb5c70$6ec21550$@net> <5398BA0B.7070903@semaphore.gr> <00b301cf85ba$40fe4290$c2fac7b0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:34552 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752874AbaFLOgD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jun 2014 10:36:03 -0400
In-Reply-To: <00b301cf85ba$40fe4290$c2fac7b0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/06/2014 12:15 =CF=80=CE=BC, Doug Smythies wrote:
>=20
>=20
> -----Original Message-----
> From: Stratos Karafotis [mailto:stratosk@semaphore.gr]=20
> Sent: June-11-2014 13:20
> To: Doug Smythies
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; rjw@rjwys=
ocki.net; viresh.kumar@linaro.org; dirk.j.brandewie@intel.com
> Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
>=20
> On 2014.06.11 13:20 Stratos Karafotis wrote:
>> On 11/06/2014 06:02 =CE=BC=CE=BC, Doug Smythies wrote:
>>>
>>> On 2104.06.11 07:08 Stratos Karafotis wrote:
>>>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>>>
>>>> No.
>>>
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
>>> When FRACBITS was 6 there were subtle cases where the driver would =
get stuck, and not make a final pstate change, with the default PID gai=
ns.
>>> Other things have changed, and the analysis needs to be re-done.
>>>
>=20
>> Could you please elaborate a little bit more what we need these 2 li=
nes below?
>>
>>        if ((rem << 1) >=3D int_tofp(sample->mperf))
>>                core_pct +=3D 1;
>>
>> Because nothing is mentioned for them in commit's changelog.
>> Do we need to round core_pct or not?
>> Because if we try to round it, I think this patch should work.
>=20
> As mentioned originally, they are there just to round the pseudo floa=
ting number, not the integer portion only.
> Let us bring back the very numbers you originally gave and work throu=
gh it.
>=20
> aperf =3D 5024
> mperf =3D 10619
>=20
> core_pct =3D 47.31142292%
> or 47 and 79.724267 256ths
> or to the closest kept fractional part 47 and 80 256ths
> or 12112 as a pseudo float.
> The maximum error with this rounding will be 1 part in 512 and symmet=
ric instead of the 1 part in 256 always in one direction without.
>=20
> Now if FRACBITS was still 6:
> core_pct =3D 47.31142292%
> or 47 and 19.931 64ths
> or to the closest kept fractional part 47 and 20 64ths
> or 3028 as a pseudo float.
> The maximum error with this rounding will be 1 part in 128 and symmet=
ric instead of the 1 part in 64 (1.6% !!!) always in one direction with=
out.
>=20
> Hope this helps.
>=20

Yes, it helps. Thanks a lot!

But please note that the maximum error without this rounding will be 1.=
6% _only_
in fractional part. In the real number it will be much smaller:

47.19 instead of 47.20

And using FRAC_BITS 8:

47.79 instead of 47.80

This is a 0.0002% difference. I can't see how this is can affect the ca=
lculations
even with FRAC_BITS 6.

Another thing is that this algorithm generally is used to round to the
nearest integer. I'm not sure if it's valid to apply it for the roundin=
g of
the fractional part of fixed point number.

Please see below the algorithm (with numbers of the specific example pr=
esented
as real):

aperf =3D 5024
mperf =3D 10619

aperf * 100 / mperf =3D 47.31142292

core_pct =3D 47
rem =3D 3307

if (3307 * 2) >=3D 10619
	core_pct =3D core_pct + 0.004

The original algorithm adds 1 to the quotient to round the integer part=
 of the
division. In the specific example we add 0.004 to round the fractional =
part.

=46ortunately, as you mentioned, this does not change the final calcula=
tion
considering that we do _not_ want an integer rounding.

IMHO, If we need integer rounding we also need this patch, otherwise
we can safely remove this rounding.


Thanks,
Stratos





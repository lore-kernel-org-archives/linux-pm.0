From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 14:15:19 -0700
Message-ID: <00b301cf85ba$40fe4290$c2fac7b0$@net>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <009b01cf857a$d5032090$7f0961b0$@net> <539862DB.9060905@semaphore.gr> <00a001cf8586$24eb5c70$6ec21550$@net> <5398BA0B.7070903@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta4.telus.net ([209.171.16.77]:39838 "EHLO cmta4.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbaFKVPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 17:15:24 -0400
In-Reply-To: <5398BA0B.7070903@semaphore.gr>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com



-----Original Message-----
=46rom: Stratos Karafotis [mailto:stratosk@semaphore.gr]=20
Sent: June-11-2014 13:20
To: Doug Smythies
Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; rjw@rjwysoc=
ki.net; viresh.kumar@linaro.org; dirk.j.brandewie@intel.com
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct

On 2014.06.11 13:20 Stratos Karafotis wrote:
> On 11/06/2014 06:02 =CE=BC=CE=BC, Doug Smythies wrote:
>>=20
>> On 2104.06.11 07:08 Stratos Karafotis wrote:
>>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>>
>>> No.
>>
>>> The intent was only ever to round properly the pseudo floating poin=
t result of the divide.
>>> It was much more important (ugh, well 4 times more) when FRACBITS w=
as still 6, which also got changed to 8 in a recent patch.
>>>
>>=20
>> Are you sure?
>>=20
>> Yes.
>>=20
>>> This rounding was very recently added.
>>> As far as I can understand, I don't see the meaning of this roundin=
g, as is.
>>> Even if FRAC_BITS was 6, I think it would have almost no improvemen=
t in
>>> calculations.
>>=20
>> Note: I had not seen this e-mail when I wrote a few minutes ago:
>>=20
>> You may be correct.
>> If Dirk agrees, I will re-analyse the entire driver for rounding eff=
ects soon.
>> When FRACBITS was 6 there were subtle cases where the driver would g=
et stuck, and not make a final pstate change, with the default PID gain=
s.
>> Other things have changed, and the analysis needs to be re-done.
>>=20

> Could you please elaborate a little bit more what we need these 2 lin=
es below?
>
>        if ((rem << 1) >=3D int_tofp(sample->mperf))
>                core_pct +=3D 1;
>
> Because nothing is mentioned for them in commit's changelog.
> Do we need to round core_pct or not?
> Because if we try to round it, I think this patch should work.

As mentioned originally, they are there just to round the pseudo floati=
ng number, not the integer portion only.
Let us bring back the very numbers you originally gave and work through=
 it.

aperf =3D 5024
mperf =3D 10619

core_pct =3D 47.31142292%
or 47 and 79.724267 256ths
or to the closest kept fractional part 47 and 80 256ths
or 12112 as a pseudo float.
The maximum error with this rounding will be 1 part in 512 and symmetri=
c instead of the 1 part in 256 always in one direction without.

Now if FRACBITS was still 6:
core_pct =3D 47.31142292%
or 47 and 19.931 64ths
or to the closest kept fractional part 47 and 20 64ths
or 3028 as a pseudo float.
The maximum error with this rounding will be 1 part in 128 and symmetri=
c instead of the 1 part in 64 (1.6% !!!) always in one direction withou=
t.

Hope this helps.

=2E.. Doug



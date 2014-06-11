From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 23:20:27 +0300
Message-ID: <5398BA0B.7070903@semaphore.gr>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <009b01cf857a$d5032090$7f0961b0$@net> <539862DB.9060905@semaphore.gr> <00a001cf8586$24eb5c70$6ec21550$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:32910 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751328AbaFKUUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 16:20:30 -0400
In-Reply-To: <00a001cf8586$24eb5c70$6ec21550$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com

On 11/06/2014 06:02 =CE=BC=CE=BC, Doug Smythies wrote:
>=20
> On 2104.06.11 07:08 Stratos Karafotis wrote:
>> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>>
>> No.
>>
>> The intent was only ever to round properly the pseudo floating point=
 result of the divide.
>> It was much more important (ugh, well 4 times more) when FRACBITS wa=
s still 6, which also got changed to 8 in a recent patch.
>>
>=20
> Are you sure?
>=20
> Yes.
>=20
>> This rounding was very recently added.
>> As far as I can understand, I don't see the meaning of this rounding=
, as is.
>> Even if FRAC_BITS was 6, I think it would have almost no improvement=
 in
>> calculations.
>=20
> Note: I had not seen this e-mail when I wrote a few minutes ago:
>=20
> You may be correct.
> If Dirk agrees, I will re-analyse the entire driver for rounding effe=
cts soon.
> When FRACBITS was 6 there were subtle cases where the driver would ge=
t stuck, and not make a final pstate change, with the default PID gains=
=2E
> Other things have changed, and the analysis needs to be re-done.
>=20

Could you please elaborate a little bit more what we need these 2 lines=
 below?

        if ((rem << 1) >=3D int_tofp(sample->mperf))
                core_pct +=3D 1;

Because nothing is mentioned for them in commit's changelog.
Do we need to round core_pct or not?
Because if we try to round it, I think this patch should work.

Thanks,
Stratos



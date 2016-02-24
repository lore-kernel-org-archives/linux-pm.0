From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness is scaled
Date: Wed, 24 Feb 2016 17:19:48 +0100
Message-ID: <9E20D36B-1323-41AA-969F-3D2DD5021701@linux.intel.com>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net> <E45553FF-63B3-4E5B-92A0-B5B00353F6F8@linux.intel.com> <001501d16b33$ff61d200$fe257600$@net>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001501d16b33$ff61d200$fe257600$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Mel Gorman <mgorman@techsingularity.net>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Matt Fleming <matt@codeblueprint.co.uk>, Mike Galbraith <umgwanakikbuti@gmail.com>, Linux-PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Doug


> On Feb 19, 2016, at 5:38 PM, Doug Smythies <dsmythies@telus.net> wrot=
e:
>=20
> Hi Steph,
>=20
> On 2016.02.19 03:12 Stephane Gasparini wrote:
>>=20
>> The issue you are reporting looks like one we improved on android by=
 using=20
>> the average pstate instead of using the last requested pstate
>>=20
>> We know that this is improving the ffmpeg encoding performance when =
using the
>> load algorithm.
>>=20
>> see patch attached
>>=20
>> This patch is only applied on get_target_pstate_use_cpu_load however=
 you can give
>> it a try on get_target_pstate_use_performance
>=20
> Yes, that type of patch works on the load based approach.
> I=E2=80=99m not talking about using average p-state in the scaled_bus=
y computation.

I=E2=80=99m talking adding the output of the PID (the number of pstate =
to ad or subtract)
to the average pstate rather than adding this to the current p-sate.

The current p-state is in some situation not reflecting the reality as =
the=20
current p-state can be imposed by a "linked CPU". This is the case when=
 you have a
thread migration on "linked CPU" that was not loaded. Its current P-Sta=
te will be low
while its average p-state will reflect the activity of the "linked CPU"=
=2E

I will not claim this is a perfect solution, but this combined to the t=
opology=20
awareness of the scheduler is helping to take better decision.

> However, I do not think it works on the performance based approach. W=
hy not?
> Well, and if I understand correctly, follow the math and you end up w=
ith:
>=20
> scaled_busy =3D 100%
>=20
> scaled_busy =3D (aperf * 100% / mperf) * (max_pstate / * ((aperf * ma=
x_pstate) / mperf))
>=20
> ... Doug
>=20
>=20
=E2=80=94
Steph

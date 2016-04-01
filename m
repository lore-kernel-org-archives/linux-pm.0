From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Fri, 1 Apr 2016 08:20:17 -0700
Message-ID: <002101d18c2a$10fd0ef0$32f72cd0$@net>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com> <2727017.UmaUvtBLeX@vostro.rjw.lan> <CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com> <3623107.tlAuqH4F7s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3623107.tlAuqH4F7s@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, =?UTF-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 2016.04.01 05:40 Rafael J. Wysocki wrote:
> On Friday, April 01, 2016 11:20:42 AM J=C3=B6rg Otte wrote:
>> 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>>> On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
>>>> 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>>>>> On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:

>>=20
>> here they are.
>>=20

> First of all, the sampling mechanics works as expected
> in the failing case, which is the most important thing
> I wanted to know.

Yes, but that might be part of the problem, as for some CPUs
there is never a long duration, and thus the long duration
check never kicks in driving the target pstate down.

> The core_busy column is clearly suspicious and it
> looks like CPUs 2 and 3 never really go idle.

This has been observed several times before [1].
Due to beat frequencies between desktop type frame rates
and such, the worst manifestation of the issue seems to be
for 300 Hz kernels, but Ubuntu uses uses 250 Hz.

Oh look, J=C3=B6rg is using 300 Hz!!

$ grep CONFIG_HZ .config_jorg
# CONFIG_HZ_PERIODIC is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=3Dy
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D300

> I guess we'll need to find out
> why they don't go idle to get to the bottom of this, but it firmly fa=
lls into
> the weird stuff territory already.

I'm compiling a 300 Hz kernel now, also with "# CONFIG_NO_HZ is not set=
",
but I have never been able to re-create these type of findings before.

I have also tried several other things in an attempt re-create J=C3=B6r=
g's
Case, so far without success.

References:
[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D93521
In particular:
https://bugzilla.kernel.org/show_bug.cgi?id=3D93521#c35
https://bugzilla.kernel.org/show_bug.cgi?id=3D93521#c42
https://bugzilla.kernel.org/show_bug.cgi?id=3D93521#c77

=2E.. Doug

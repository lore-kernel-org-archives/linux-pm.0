From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness is scaled
Date: Thu, 25 Feb 2016 11:51:18 -0800
Message-ID: <002601d17005$e6369820$b2a3c860$@net>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net> <E45553FF-63B3-4E5B-92A0-B5B00353F6F8@linux.intel.com> <001501d16b33$ff61d200$fe257600$@net> <9E20D36B-1323-41AA-969F-3D2DD5021701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta11.telus.net ([209.171.16.84]:43805 "EHLO cmta11.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933629AbcBYTvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 14:51:22 -0500
In-Reply-To: <9E20D36B-1323-41AA-969F-3D2DD5021701@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>
Cc: 'Mel Gorman' <mgorman@techsingularity.net>, 'Rafael Wysocki' <rjw@rjwysocki.net>, 'Ingo Molnar' <mingo@kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Matt Fleming' <matt@codeblueprint.co.uk>, 'Mike Galbraith' <umgwanakikbuti@gmail.com>, 'Linux-PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

Hi Steph,

On 2016.02.24 08:20 Stephane Gasparini wrote:
>> On Feb 19, 2016, at 5:38 PM, Doug Smythies <dsmythies@telus.net> wro=
te:=20
>>> On 2016.02.19 03:12 Stephane Gasparini wrote:
>>>=20
>>> The issue you are reporting looks like one we improved on android b=
y using=20
>>> the average pstate instead of using the last requested pstate
>>>=20
>>> We know that this is improving the ffmpeg encoding performance when=
 using the
>>> load algorithm.
>>>=20
>>> see patch attached
>>>=20
>>> This patch is only applied on get_target_pstate_use_cpu_load howeve=
r you can give
>>> it a try on get_target_pstate_use_performance
>>=20
>> Yes, that type of patch works on the load based approach.
>
> I=E2=80=99m not talking about using average p-state in the scaled_bus=
y computation.
> I=E2=80=99m talking adding the output of the PID (the number of pstat=
e to ad or subtract)
> to the average pstate rather than adding this to the current p-sate.

=46or the situation we are dealing with here, that would actually make =
it worse,
wouldn't it?

Let's work through a real very low load example from the Mel V2 patch w=
here
the target pstate is increased whereas it should have been decreased:

Mel patch version 2 (12X hold off added to rjw 3 patch v10 set added to=
 kernel 4.5-rc4):

CPU: 3
Core busy: 105
Scaled busy: 143
Old pstate: 25
New pstate: 34
mperf: 52039
aperf: 55097
tsc: 335265689
freq: 3599750 KHz
Load: 0.02%
Duration (mS): 98.293

New pstate =3D old pstate + (scaled_busy-setpoint) * p_gain
           =3D 25 + (143 - 97) * 0.2
           =3D 34 (as above)

Ave pstate =3D max_pstate * aperf / mperf
           =3D 34 * 55097 / 52039
           =3D 36

Steph average pstate method added to the above:
New pstate =3D ave pstate + (scaled_busy-setpoint) * p_gain
           =3D 36 + (143 - 97) * 0.2
           =3D 45 (before clamping)

Now, just for completeness show the no Mel patch math:
Scaled busy =3D Core busy * max_pstate / old pstate * sample time / dur=
ation
            =3D 105 * 34 / 25 * 10 / 98.293
            =3D 14.53
New pstate =3D old pstate + (scaled_busy-setpoint) * p_gain
            =3D 25 + (14.53 - 97) * .2
            =3D 8.5
            =3D 16 clamped minimum

Regardless, I coded the average pstate method and observe little
difference between it and the Mel V2 patch with limited testing.

=2E.. Doug



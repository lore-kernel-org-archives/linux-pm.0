From: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Wed, 16 Dec 2015 10:49:53 +0100
Message-ID: <18D9CFC2-27D2-4ECA-B155-75C240C2888E@linux.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com> <8633351.YrHIUtRzE5@skinner> <2402797.hEhmBtxRMB@vostro.rjw.lan> <48DF4267-671B-40E2-8C95-CCF5795F8B26@linux.intel.com> <001c01d136bc$a4a78a90$edf69fb0$@net> <566FEBB8.5090008@linux.intel.com> <003a01d13791$1edfbce0$5c9f36a0$@net>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50039 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933999AbbLPJt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 04:49:57 -0500
In-Reply-To: <003a01d13791$1edfbce0$5c9f36a0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Philippe Longepe <philippe.longepe@linux.intel.com>, Thomas Renninger <trenn@suse.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>


=E2=80=94
Steph




> On Dec 16, 2015, at 12:34 AM, Doug Smythies <dsmythies@telus.net> wro=
te:
>=20
> On 2015.12.15 02:30 Philippe Longepe wrote:
>> On 14/12/2015 23:13, Doug Smythies wrote:
>>> On 2015.12.14 08:15 Stephane Gasparini wrote:
>>>=20
>> In the table sent by stephane, "performance" meant "original algorit=
hm"=20
>> based on average pstate (aperf/mperf).
>=20
> Oh.
>=20
>> On Atoms, a setpoint of 60 is not too high. With higher setpoints we=
'll=20
>> not be able to reach meet some performance KPIs
>=20
> Define =E2=80=9CKPI"

Key Performance Indicator, basically a test that we have to reach certa=
in
performance or power criteria

>=20
>> (some frames are dropped mainly for gaming use cases). However, we a=
re=20
>> working on a more power conservative algorithm).
>=20
> I do not think the issue / challenge is specific to Atom.

Well I agree that this would also be beneficials to Laptop for instance=
=2E
However the "load based" algorithm is behind the existing =E2=80=9Cpowe=
rsave=E2=80=9D=20
intel states in regards of performance for database I/O type tests.

>=20
>>>=20
>>> I think that a more comparable test would be a 50% (or whatever) lo=
ad
>>> calibrated to a nominal CPU frequency (I use the max non-turbo CPU
>>> frequency, but it can be anything.) Meaning that the once the fixed
>>> packet of work is done, the CPU can go idle sooner or later, depend=
ing
>>> on the CPU frequency.
>> Are you using an existing tool for doing that or did you developed y=
our=20
>> own tool ?
>=20
> While he would not recognize it now, I mainly use a simple program th=
at
> Peter Zijlstra gave me a few years ago, consume.c. However, I added f=
ixed
> work packet mode, to satisfy a need for something more representative=
 of
> real world periodic workflows.
>=20
> I'll send it to you off-list.
>=20
> On 2015.12.15 05:07 Stephane Gasparini wrote:
>=20
>> Well you misunderstood the power numbers I guess
>> e.g. if you watch a movie for 1h30, it will last 1h30 not matter wha=
t is the=20
>> average power, so the lower is the average power the better it is.
>=20
> O.K. I didn=E2=80=99t know all of those tests had to run for whatever=
 time.
> But for the performance list of tests, there is no energy information=
=2E
> I'm just saying that it might matter for some, as in ffmpeg example I=
 gave.
>=20
>> Here are the detail for Application install
>>=20
>> Intel PState    Intel PState   =20
>> Performance     CPU Load     =20
>> =E2=89=85 799 mW (28 s)	=E2=89=85 383 mW (34 s)
>> =E2=89=85 29 mW/s	=E2=89=85 11 mW/s
>=20
> Wouldn't the correct terminology be 22.4 Joules and 13.0 Joules
> to do the job?
> Or 42% energy saved at a cost of 21% extra time.
>=20
> Anyway, you made your point.

We=E2=80=99ll try to provide all metrics (perf, J and mW) for the new m=
easures.

>=20
> ... Doug
>=20
>=20


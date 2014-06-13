From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Fri, 13 Jun 2014 07:36:21 -0700
Message-ID: <002201cf8714$d933cca0$8b9b65e0$@net>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <00b301cf85ba$40fe4290$c2fac7b0$@net> <5399BACF.6060201@semaphore.gr> <1815178.vjJU51ubGD@vostro.rjw.lan> <539B0147.8020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta8.telus.net ([209.171.16.81]:34371 "EHLO cmta8.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbaFMOgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 10:36:23 -0400
In-Reply-To: <539B0147.8020407@gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Dirk Brandewie' <dirk.brandewie@gmail.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: viresh.kumar@linaro.org, dirk.j.brandewie@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


On 2014.06.12 06:49 Dirk Brandewie wrote:
> On 06/12/2014 01:03 PM, Rafael J. Wysocki wrote:
>> On Thursday, June 12, 2014 05:35:59 PM Stratos Karafotis wrote:
>>> On 12/06/2014 12:15 =CF=80=CE=BC, Doug Smythies wrote:

>>>>> Could you please elaborate a little bit more what we need these 2=
 lines below?
>>>>>

> Sorry for being MIA on this thread I have been up to my eyeballs.

>>>>         if ((rem << 1) >=3D int_tofp(sample->mperf))
>>>>                 core_pct +=3D 1;

> The rounding should have been
>        core_pct +=3D (1 << (FRAC_BITS-1));
> Since core_pct is is in fixeded point notation at this point. Adding =
=2E5 to
> core_pct to round up.

> As Stratos pointed out the the current code only adds 1/256 to core_p=
ct

> Since core_pct_busy stays in fixed point through out the rest of the
> calculations ans we only do the rounding when the PID is returning an
> int I think we can safely remove these two lines.

Absolutely, no.

That code was doing exactly what I wanted it to do.
But, as and I have already admitted, it was overkill, and yes the entir=
e thing
can be changed to use div_64 instead.

We do not want to add 1/2 to core percent here at this spot.
You would just be bringing back the arbitrary and incorrect biasing
of core_pct upwards that used to be there in two spots before.

You would add 1/2 when you want to convert to an integer, not before (a=
nd we don't right now, for the call to trace_pstate_sample).

=2E.. Doug



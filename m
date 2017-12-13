From: Andy Tang <andy.tang@nxp.com>
Subject: RE: Ask for help on governor
Date: Wed, 13 Dec 2017 06:22:20 +0000
Message-ID: <HE1PR0402MB28285FD45E5E6B72C4C1068DF3350@HE1PR0402MB2828.eurprd04.prod.outlook.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net>
 <20171213061759.GT25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-he1eur01on0044.outbound.protection.outlook.com ([104.47.0.44]:8735
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751018AbdLMGWX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 01:22:23 -0500
In-Reply-To: <20171213061759.GT25177@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>

Hi,

Thanks you all for help.=20
Anyway I found the root cause myself.

It was caused by commit: 00bfe05889e91b5112893b001e4a47b0a0f8bdd7.

In this commit, the part of code is as below:
+       if (policy_dbs->idle_periods < UINT_MAX) {
+               unsigned int freq_steps =3D policy_dbs->idle_periods * freq=
_step;
+
+               if (requested_freq > freq_steps)
+                       requested_freq -=3D freq_steps;
+               else
+                       requested_freq =3D policy->min;
+
+               policy_dbs->idle_periods =3D UINT_MAX;
+       }

On my platform, there are 3 frequency available which are: 1600Mhz, 800Mhz,=
 400Mhz.
Freq_steps is 80Mhz.
Due to this code, the requested_freq is always 480Mhz. Since we want 800Mhz=
 as next target frequency, the cpu frequency can't be changed.

Please work out a patch to fix this.

This issue exists on all our LS* platforms.

Regards,
Andy

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Wednesday, December 13, 2017 2:18 PM
> To: Doug Smythies <dsmythies@telus.net>
> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; Andy Tang
> <andy.tang@nxp.com>; 'Rafael J. Wysocki' <rjw@rjwysocki.net>; 'Linux PM'
> <linux-pm@vger.kernel.org>
> Subject: Re: Ask for help on governor
>=20
> On 12-12-17, 19:10, Doug Smythies wrote:
> > Thanks for the suggestion. It was so very close, the problem commit is
> > the very next one, aa7519af450d.
> >
> > Bisect result:
> >
> > aa7519af450d3c62a057aece24877c34562fa25a is the first bad commit
> > commit aa7519af450d3c62a057aece24877c34562fa25a
> > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > Date:   Wed Jul 19 15:42:42 2017 +0530
> >
> >     cpufreq: Use transition_delay_us for legacy governors as well
> >
> >     The policy->transition_delay_us field is used only by the schedutil
> >     governor currently, and this field describes how fast the driver wa=
nts
> >     the cpufreq governor to change CPUs frequency. It should rather be =
a
> >     common thing across all governors, as it doesn't have any schedutil
> >     dependency here.
> >
> >     Create a new helper cpufreq_policy_transition_delay_us() to get the
> >     transition delay across all governors.
> >
> >     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> What has changed for intel-pstate after this patch ?
>=20
> sampling_rate for conservative and ondemand is 500 us now, which was
> 20000 us earlier. So we reevaluate load very frequently now, but in case =
load
> isn't over 80% then we wouldn't increase the frequency.
>=20
> @Doug/Andy: Can you please try following:
>=20
> - Checkout 4.14 or mainline (the broken kernels).
> - Set governor to conservative.
> - Monitor /sys/devices/system/cpu/cpufreq/policy*/stats/total_trans (to
> check if
>   frequency is getting changed or not).
> - Run some dummy load, I did this:
>=20
>   perf bench sched messaging --pipe --thread --group 8
>=20
> This should result in frequency updates, so its not that we aren't changi=
ng
> frequency at all now with conservative.
>=20
> Then do this:
>=20
> echo 20000 > /sys/devices/system/cpu/cpufreq/conservative/sampling_rate
>=20
> and this should take you back to the original behavior which was there pr=
e-
> 4.14.
>=20
> @Andy: What's your hardware and cpufreq driver ? intel-pstate? As I am no=
t
> sure why things will change for any other driver than intel-pstate.
>=20
> I am not really sure what's the right way forward here now.
>=20
> --
> viresh

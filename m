From: Andy Tang <andy.tang@nxp.com>
Subject: RE: Ask for help on governor
Date: Fri, 15 Dec 2017 01:56:03 +0000
Message-ID: <HE1PR0402MB2828268A242D3132E3A560F6F30B0@HE1PR0402MB2828.eurprd04.prod.outlook.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net>
 <20171213061759.GT25177@vireshk-i7> P0QweRTHbuQ9TP0R1eouYx
 <000701d37479$e0570320$a1050960$@net> PJTJeNt3QC2CsPJTOebNwi
 <001f01d37544$5889d410$099d7c30$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:41323
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754792AbdLOB4G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Dec 2017 20:56:06 -0500
In-Reply-To: <001f01d37544$5889d410$099d7c30$@net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Doug Smythies [mailto:dsmythies@telus.net]
> Sent: Friday, December 15, 2017 9:31 AM
> To: Andy Tang <andy.tang@nxp.com>; 'Viresh Kumar'
> <viresh.kumar@linaro.org>; 'Stratos Karafotis' <stratosk@semaphore.gr>
> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
> <rjw@rjwysocki.net>; 'Linux PM' <linux-pm@vger.kernel.org>
> Subject: RE: Ask for help on governor
>=20
> On 2017.12.13 18:42 Andy Tang wrote:
> > On 2017.12.14 09:21 Doug wrote:
> >>
> >> diff --git a/drivers/cpufreq/cpufreq_governor.c
> >> b/drivers/cpufreq/cpufreq_governor.c
> >> index 58d4f4e..3493ca7 100644
> >> --- a/drivers/cpufreq/cpufreq_governor.c
> >> +++ b/drivers/cpufreq/cpufreq_governor.c
> >> @@ -222,6 +222,7 @@ unsigned int dbs_update(struct cpufreq_policy
> >> *policy)
> >>                         max_load =3D load;
> >>         }
> >>
> >> +       idle_periods =3D 0;
> >
> > With this line added, conservative governor works well.
> >
> > Ondemand governor still can't work well.
>=20
> Your original message said:
>=20
> On 12-12-17, 02:46, Andy Tang wrote:
> > I run into a question that conservative governor can't work while
> ondemand governor works well.
>=20
> So, for my part of it, I never looked at ondemand.
Sorry for the misleading. Actually I observed two issues:
1. conservative governor can't increase cpu frequency even the load is high=
 than 90%
2. CPU load can't be calculated correctly when sampling_rate is 1000 for bo=
th conservative and ondemand governor. At first I thought ondemand governor=
 worked well. Actually I did not test it thoroughly. Ondemand governor can =
work only when cpu load is calculated correct.

>=20
> > As I mentioned in earlier email, load varies from different sampling_ra=
te.
>=20
> Because that e-mail was html, a lot of people didn't get it, and it also =
is not in
> the archives. Anyway:
>=20
> On 2017.12.12 23:24 Andy wrote:
>=20
> > I also found sampling_rate affects the CPU load dramatically.
> >			sample rate
> >			100000	10000	1000
> > actual cpu load	1%		1%	1%
> > cpu report load	1%		20%	40-100%
> >
> > So we can know that when sample_rate is higher than 10000us, cpufreq
> can not calculate the load correctly.
>=20
> Can you tell us more details about how you did this test and how you know
> your data is correct?
> In particular, what is your work/sleep frequency for your 1% load.
> In my experience the work/sleep frequency has always been a very
> important consideration with these tests.
> What is the tick rate of your kernel? Myself, I wouldn't expect a 1000 uS=
ec
> sample period to work properly.
My tick rate is 250Hz.  And Yes, cpu load can't be calculated correctly.
We really should set sampling_rate a proper values as default if there are =
some sample rate don't work properly. We don't want to calculate a workable=
 sampling_rate according to the tick rate manually.
=20
That's odd too that you wouldn't expect a 1000 Usec sample period to work p=
roperly but set this value as default, even worse, you allow to set a lower=
 value to it.

Is it better if we set a low limit of  sample period?=20

Regards,
Andy
=20
>=20
> I used turbostat to verify my tests, and yes, on demand does start to
> misbehave if the sampling period is short relative to the tick period (ji=
ffy
> time), otherwise it was fine.
>=20
> ... Doug
>=20

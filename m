From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/4] cpufreq: introduce cpufreq_driver_might_sleep
Date: Mon, 29 Jun 2015 11:39:44 -0500
Message-ID: <20150629163944.GA32758@saruman.tx.rr.com>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
 <1435362824-26734-3-git-send-email-mturquette@linaro.org>
 <20150627004831.GB19347@saruman.tx.rr.com>
 <20150629162621.9112.4040@quantum>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46948 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513AbbF2Qkc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Jun 2015 12:40:32 -0400
Content-Disposition: inline
In-Reply-To: <20150629162621.9112.4040@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: balbi@ti.com, peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl, "Rafael J. Wysocki" <rafael@kernel.org>

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 29, 2015 at 09:26:21AM -0700, Michael Turquette wrote:
> Quoting Felipe Balbi (2015-06-26 17:48:31)
> > Hi,
> >=20
> > On Fri, Jun 26, 2015 at 04:53:42PM -0700, Michael Turquette wrote:
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 28e59a4..e5296c0 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -112,6 +112,12 @@ bool have_governor_per_policy(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(have_governor_per_policy);
> > > =20
> > > +bool cpufreq_driver_might_sleep(void)
> > > +{
> > > +     return !(cpufreq_driver->flags & CPUFREQ_DRIVER_WILL_NOT_SLEEP);
> > > +}
> > > +EXPORT_SYMBOL_GPL(cpufreq_driver_might_sleep);
> > > +
> > >  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *poli=
cy)
> > >  {
> > >       if (have_governor_per_policy())
> > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > index 2ee4888..1f2c9a1 100644
> > > --- a/include/linux/cpufreq.h
> > > +++ b/include/linux/cpufreq.h
> > > @@ -157,6 +157,7 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall=
, int io_busy);
> > >  int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int c=
pu);
> > >  int cpufreq_update_policy(unsigned int cpu);
> > >  bool have_governor_per_policy(void);
> > > +bool cpufreq_driver_might_sleep(void);
> > >  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *poli=
cy);
> > >  #else
> > >  static inline unsigned int cpufreq_get(unsigned int cpu)
> > > @@ -314,6 +315,14 @@ struct cpufreq_driver {
> > >   */
> > >  #define CPUFREQ_NEED_INITIAL_FREQ_CHECK      (1 << 5)
> > > =20
> > > +/*
> > > + * Set by drivers that will never block or sleep during their freque=
ncy
> > > + * transition. Used to indicate when it is safe to call cpufreq_driv=
er_target
> > > + * from non-interruptable context. Drivers must opt-in to this flag,=
 as the
> > > + * safe default is that they might sleep.
> > > + */
> > > +#define CPUFREQ_DRIVER_WILL_NOT_SLEEP        (1 << 6)
> >=20
> > don't you need to update current drivers and pass this flag where
> > necessary ?
>=20
> Felipe,
>=20
> Thanks for the review.
>=20
> Setting the flag can be done, but it is an opt-in feature. First, none
> of the legacy cpufreq governors would actually make use of this flag.
> Everything they do is in process context. The first potential user of it
> is in patch #3.
>=20
> Secondly, the governor in patch #3 will work without this flag set for a
> cpufreq driver. It will just defer the dvfs transition to a kthread
> instead of performing it in the hot path of the scheduler.
>=20
> Finally, the only hardware I am aware of that can make use of this flag
> is Intel hardware. I know nothing about it and am happy for someone more
> knowledgeable than myself submit a patch enabling this flag for that
> architecture.

the follow-up question would be: then why introduce the flag at all ?
:-p

--=20
balbi

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVkXTQAAoJEIaOsuA1yqRERWAP/A5k4Hhy5902XTiDnGHdMZHW
ztLPGDk02X8hpV+qoQ2zNDnP7PxBVYXwUj9cdiDNossUF5qdPcbCpEGg8FNJLfe5
m8Nd1QMyc/J4j4AjmQjkpZiepQ0QwutfsE2whdTvX4aU4Q7AVp2ZEtnPgjuBSol7
qP8qbLQ70C6g0Sh/Etpm1x8c6SvzL2+zv3bzL5cH9V6sghNjdAXIGJlwvEQxlyf3
i0icsrmjzjMyekCePLN4NL07q1A3DPBQy5WsuTDaWKpjBmM4IE5zL0gV/sYrZLQ8
6gbH/hpFeehOZueqKbfuIq1lqrHW3MvnBazOiRcZSc5OmKbRluMUcIeA4QoCzxcP
GHRQlZjkGfFCZM6DH7hqAvfMahPgQz53JKyELANaz4/MM5u6Q2jFlLrLr2Rtzqhx
kuxIhrw4WLYfrhUelSNpJwC49k1PsV0w4qxaYoAYjaE5urC3TmKfMxnTyqbALF4r
yQlHNA5Z2Cy+y6Mkhjybv6UYE0IT7SOucEMegAp4lq5Zyh5N/Kl2LqWPFCGr1nic
Bdl7xAo79SgESOdOOy58U8DP4AAOk6iCXItlNtPRVeXRl/zbg/beHmTcbVGOCi0O
5VpkhDn7K2WTM/Cb2ZsArngq13a8CWgWIXI6u+7Ufc+R6kkAbiAgIr/gYaXRjXal
kyfCn7OqsbZzgu9cRFjh
=Ajji
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/4] cpufreq: introduce cpufreq_driver_might_sleep
Date: Mon, 29 Jun 2015 12:03:23 -0500
Message-ID: <20150629170323.GC32758@saruman.tx.rr.com>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
 <1435362824-26734-3-git-send-email-mturquette@linaro.org>
 <20150627004831.GB19347@saruman.tx.rr.com>
 <20150629162621.9112.4040@quantum>
 <20150629163944.GA32758@saruman.tx.rr.com>
 <CAEG3pNCDWeOhRDZNQfH4QHj3KWUM829C8C0=CULns3gJwy57sQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEG3pNCDWeOhRDZNQfH4QHj3KWUM829C8C0=CULns3gJwy57sQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: balbi@ti.com, peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten Rasmussen <Morten.Rasmussen@arm.com>, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Amit Kucheria <amit.kucheria@linaro.org>, Juri Lelli <juri.lelli@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 29, 2015 at 09:56:55AM -0700, Michael Turquette wrote:
> > > > > @@ -112,6 +112,12 @@ bool have_governor_per_policy(void)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(have_governor_per_policy);
> > > > >
> > > > > +bool cpufreq_driver_might_sleep(void)
> > > > > +{
> > > > > +     return !(cpufreq_driver->flags & CPUFREQ_DRIVER_WILL_NOT_SL=
EEP);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(cpufreq_driver_might_sleep);
> > > > > +
> > > > >  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *=
policy)
> > > > >  {
> > > > >       if (have_governor_per_policy())
> > > > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > > > index 2ee4888..1f2c9a1 100644
> > > > > --- a/include/linux/cpufreq.h
> > > > > +++ b/include/linux/cpufreq.h
> > > > > @@ -157,6 +157,7 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *=
wall, int io_busy);
> > > > >  int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned i=
nt cpu);
> > > > >  int cpufreq_update_policy(unsigned int cpu);
> > > > >  bool have_governor_per_policy(void);
> > > > > +bool cpufreq_driver_might_sleep(void);
> > > > >  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *=
policy);
> > > > >  #else
> > > > >  static inline unsigned int cpufreq_get(unsigned int cpu)
> > > > > @@ -314,6 +315,14 @@ struct cpufreq_driver {
> > > > >   */
> > > > >  #define CPUFREQ_NEED_INITIAL_FREQ_CHECK      (1 << 5)
> > > > >
> > > > > +/*
> > > > > + * Set by drivers that will never block or sleep during their fr=
equency
> > > > > + * transition. Used to indicate when it is safe to call cpufreq_=
driver_target
> > > > > + * from non-interruptable context. Drivers must opt-in to this f=
lag, as the
> > > > > + * safe default is that they might sleep.
> > > > > + */
> > > > > +#define CPUFREQ_DRIVER_WILL_NOT_SLEEP        (1 << 6)
> > > >
> > > > don't you need to update current drivers and pass this flag where
> > > > necessary ?
> > >
> > > Felipe,
> > >
> > > Thanks for the review.
> > >
> > > Setting the flag can be done, but it is an opt-in feature. First, none
> > > of the legacy cpufreq governors would actually make use of this flag.
> > > Everything they do is in process context. The first potential user of=
 it
> > > is in patch #3.
> > >
> > > Secondly, the governor in patch #3 will work without this flag set fo=
r a
> > > cpufreq driver. It will just defer the dvfs transition to a kthread
> > > instead of performing it in the hot path of the scheduler.
> > >
> > > Finally, the only hardware I am aware of that can make use of this fl=
ag
> > > is Intel hardware. I know nothing about it and am happy for someone m=
ore
> > > knowledgeable than myself submit a patch enabling this flag for that
> > > architecture.
> >
> > the follow-up question would be: then why introduce the flag at all ?
> > :-p
>=20
> I included it at Rafael's request:
>=20
> http://lkml.kernel.org/r/<49407954.UBSF2FlX46@vostro.rjw.lan>

Fair enough, just think it might be an unused code path for a while,
since the flag isn't enabled anywhere :-s

--=20
balbi

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVkXpbAAoJEIaOsuA1yqRExgUQALKZ1ZTmi2rfTgYkEVqFVBsR
mgAFYljBha3WMXkFknbcx/dtWP/MzJk8rG0nhK3ZreFFfBUXcUEbfxRzUrmSYbrh
kHVwEmN5X9md3E2eFe85C5F1Rc/8PvRRG1mLuXBFs9KckLMEejVGFGuP2mS4xb6n
Z4+pEZX25Vqn9DfKcenfPYA9JWNrLn0iLw4moNvJq2fF/4dRCFL+FnuaSGFlmP7A
jutNSJZFX+3Q2qiTKuZcp8qNA/RyuX05efKgeg3g4mVJrnun8WHEr3k/ovlKtG8j
JFokCg1B/r5UvssuUfHi/T1lfF57pXztMbO3cDovrWADACzoPY+0iS3vNWnyIn76
Ad3/EB84oNRAIbFNWQqfIdpE4Er3xHUstcFqRAyIeChsvcuE/iQqHaCdLC52dU0f
HDHeRTBj5/4Kxw1Z2vAvzPI3hedz1SGIWS27cLxiEs+viFqYizXUN2sC+biUG0qo
SapbMkmNTtWa0aiLHs5U2VCFqnH8HQYaj+uDkXfxxj1e3LYIexSxbjt1ChKm2quw
maldgI94ZCVtwl/LkEID6Yr/A0kUkUzxPZoX4pDvK3AnpY1vESj5PUNYWcjRRRXa
sxgoVkPeRxIXlkHZWKcJq7C/2rzoW7S+kaLYaAVb3WaLSBBRT83MhwWWtmIsUtXt
T+c/B8249A/3fz+sYWAm
=qL7X
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

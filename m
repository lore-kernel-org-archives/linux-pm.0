From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] cpufreq: exynos: allow modular build
Date: Fri, 30 Jan 2015 17:51:24 -0400
Message-ID: <20150130215118.GA14374@developer.amazonguestwifi.org>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <1642077.OrkdxhO2uI@wuerfel>
 <20150129222150.GA29837@developer.amazonguestwifi.org>
 <5048920.rXbXJT1FvO@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5048920.rXbXJT1FvO@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 10:24:12PM +0100, Arnd Bergmann wrote:
> On Thursday 29 January 2015 18:21:51 Eduardo Valentin wrote:
> > Hello Arnd and Viresh,
> >=20
> > On Thu, Jan 29, 2015 at 01:42:32PM +0100, Arnd Bergmann wrote:
> > > On Thursday 29 January 2015 15:40:15 Viresh Kumar wrote:
> > > >  obj-$(CONFIG_ARCH_DAVINCI)             +=3D davinci-cpufreq.o
> > > >  obj-$(CONFIG_UX500_SOC_DB8500)         +=3D dbx500-cpufreq.o
> > > > -obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)       +=3D exynos-cpufreq.o
> > > > -obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   +=3D exynos4210-cpufreq.o
> > > > -obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   +=3D exynos4x12-cpufreq.o
> > > > -obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   +=3D exynos5250-cpufreq.o
> > > > +obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   +=3D exynos-cpufreq.o exyno=
s4210-cpufreq.o
> > > > +obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   +=3D exynos-cpufreq.o exyno=
s4x12-cpufreq.o
> > > > +obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   +=3D exynos-cpufreq.o exyno=
s5250-cpufreq.o
> > > >=20
> > >=20
> > > I'd have to try it, but this might fail if one of the three drivers
> > > is built-in and another one is a module.
> > >=20
> > > 	Arnd
> >=20
> > Let me make one step back here. The original issue is, now this exynos
> > cpufreq driver depends on of thermal; but of thermal can be built as
> > module, while this cpufreq driver cannot. Original proposal is to allow
> > module build in the exynos cpufreq driver.
> >=20
> > On the original proposal, my concern is that the driver code does not
> > have separated modules, but one single module platform driver,  which u=
ses functions from
> > other c files. On top of that, the patch originally allows four
> > (independent) modules builds. Although the children drivers still
> > selects the core part, we would still need to change the original patch
> > to add module dependency too.
> >=20
> > So, my proposal was to, in order to allow module builds on this cpufreq
> > driver, we also need to properly construct the driver into a single
> > module, instead of several modules. The issue with my patch was the fact
> > that it was allowing platforms that do not use that driver, to select it
> > by default. And eventually this may cause a unusable module being loaded
> > into those systems.
> >=20
> > Well, trying harder here in the same approach. The diff bellow is based
> > on Arnd's original patch and on Viresh's amendment, except that the core
> > part is now dependent on all the supported platforms, instead of
> > ARCH_EXYNOS. This way, it wont load in platforms that are not supposed
> > to be loaded. The user will be able to build the support for all
> > platforms, or select which platforms he/she wants (as originally),
> > except that now it can be a module, instead.
> >=20
> > I believe now by default it will still keep the driver only on those
> > configs that expect it to be on. And it won't compile/load on platforms
> > that it is not supposed to. It brings closer a config that is dependent=
 on this
> > driver, so it looks better in the menuconfig.
> >=20
> > Let me know if I missed something (feel free to amend to your patch):
>=20
> Yes, I think your refined approach works and is better than my
> original patch, thanks a lot for giving it more thought!
>=20
> One tiny problem:
>=20
> > @@ -90,6 +84,20 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
> > =20
> >  	  If in doubt, say N.
> > =20
> > +config ARM_EXYNOS5440_CPUFREQ
> > +	bool "SAMSUNG EXYNOS5440"
> > +	depends on SOC_EXYNOS5440
> > +	depends on HAVE_CLK && OF
> > +	select PM_OPP
> > +	default y
> > +	help
> > +	  This adds the CPUFreq driver for Samsung EXYNOS5440
> > +	  SoC. The nature of exynos5440 clock controller is
> > +	  different than previous exynos controllers so not using
> > +	  the common exynos framework.
> > +
> > +	  If in doubt, say N.
>=20
> I believe this one also has to be tristate, for the same reason.
>=20

I agree with you that it is better if we make it tristate. So, on my
side, I have no concerns changing it to tristate.

However, the exynos5440 cpufreq driver does not depend on of thermal as
of today, and therefore, I did not touch this driver for this matter.
Meaning, if it is not causing troubles, no need to mess with it.

But I can add this change. No issues, on my side.

> > =20
> > -#ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
> > +#if IS_ENABLED(CONFIG_ARM_EXYNOS4210_CPUFREQ)
> >  extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
> >  #else
> >  static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *inf=
o)
> > @@ -61,7 +61,7 @@ static inline int exynos4210_cpufreq_init(struct exyn=
os_dvfs_info *info)
> >  	return -EOPNOTSUPP;
> >  }
> >  #endif
> > -#ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
> > +#if IS_ENABLED(CONFIG_ARM_EXYNOS4X12_CPUFREQ)
> >  extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
> >  #else
> >  static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *inf=
o)
> > @@ -69,7 +69,7 @@ static inline int exynos4x12_cpufreq_init(struct exyn=
os_dvfs_info *info)
> >  	return -EOPNOTSUPP;
> >  }
> >  #endif
> > -#ifdef CONFIG_ARM_EXYNOS5250_CPUFREQ
> > +#if IS_ENABLED(CONFIG_ARM_EXYNOS5250_CPUFREQ)
> >  extern int exynos5250_cpufreq_init(struct exynos_dvfs_info *);
> >  #else
> >  static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *inf=
o)
>=20
> This change is ok, but not needed, because the three extra symbols are st=
ill
> bool. I would leave that change out, but I also don't mind it.

Indeed.

>=20
> With the change to make ARM_EXYNOS5440_CPUFREQ tristate:
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I will repost this patch with the minor amendments. Now, we only need
an ack from cpufreq folks.

BR,

Eduardo Valentin

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUy/zOAAoJEMLUO4d9pOJWe50IAI59AqCXvrx4sIoYHkHsOyNQ
fcyEZBQqGXJdiQtjNyJFqMNo6k+iQvFYzvr5JdW1gElm5Bris1f+MuCeyI3/cd9m
K/4A9t2CiCE1q5zW0zwLPSJE8tk+6sZCWIGcipc+NIbL86sscBfJy4O7OL+5viCK
chQCrPwTksQsFJrE4VMO3b8s/SjpDf7VUbvK7htoJ3ol/he+CDzNmmwkj2Yy3K4N
nhFFe3lAju93ceqxacEpGWDoi413Nie4EwoLkOdfdZKxuY7CwHvmUjql5yyPskL/
XKuB9DRMaAr2OAFdxxAL+ipx7Q0WROP+MGEUn8M+7C/NYXoQGri28NV33Av1U+I=
=meVh
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

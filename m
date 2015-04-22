From: Josh Cartwright <joshc-acOepvfBmUk@public.gmane.org>
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Wed, 22 Apr 2015 09:33:52 -0500
Message-ID: <20150422143352.GJ27115@jcartwri.amer.corp.natinst.com>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
 <20150420141719.GF27115@jcartwri.amer.corp.natinst.com>
 <CALx668W6nJkYR325BhxOXMF1z=i7mkYbh3pyBFDNoZC9NZ0dVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4849070886169862113=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CALx668W6nJkYR325BhxOXMF1z=i7mkYbh3pyBFDNoZC9NZ0dVw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chen Fan <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--===============4849070886169862113==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 11:11:34AM +0800, Pi-Cheng Chen wrote:
[..]
> >> +config ARM_MT8173_CPUFREQ
> >> +     bool "Mediatek MT8173 CPUFreq support"
> >> +     depends on ARCH_MEDIATEK && REGULATOR
> >
> > I think you want to 'select REGULATOR' here; because REGULATOR isn't
> > a user-visible option.
>=20
> I am not sure but I need it to be "depends on" as other SoC cpufreq
> drivers. Please check
> ARM_S3C2416_CPUFREQ_VCORESCALE in drivers/cpufreq/Kconfig.arm
> By the way, I would like to know more details about the visibility of
> these configurable
> options, would you kindly point me out some documents about it?

Paul pointed out that I was wrong, so I'll defer to him.  My knowledge
has likely been outdated.

[..]
> >> +/* OPP table for LITTLE cores of MT8173 */
> >> +struct mtk_cpu_opp mt8173_l_opp[] =3D {
> >
> > static const?
>=20
> Yes. I miss "static" here. But I need those two array to be non-const
> so that I could
> fix up the exact voltage values by querying the supported voltages of
> regulators.
> Please check the mt8173_cpufreq_cpu_opp_fixup() function below.

Indeed.  Thanks.

[..]
> >> +static int mtk_cpufreq_voltage_trace(struct cpu_dvfs_info *info,
> >> +                                  struct mtk_cpu_opp *opp)
> >> +{
> >> +     struct regulator *proc_reg =3D info->proc_reg;
> >> +     struct regulator *sram_reg =3D info->sram_reg;
> >> +     int old_vproc, new_vproc, old_vsram, new_vsram, vsram, vproc, re=
t;
> >> +
> >> +     old_vproc =3D regulator_get_voltage(proc_reg);
> >> +     old_vsram =3D regulator_get_voltage(sram_reg);
> >> +
> >> +     new_vproc =3D opp->vproc;
> >> +     new_vsram =3D opp->vsram;
> >> +
> >> +     /*
> >> +      * In the case the voltage is going to be scaled up, Vsram and V=
proc
> >> +      * need to be scaled up step by step. In each step, Vsram needs =
to be
> >> +      * set to (Vproc + 200mV) first, then Vproc is set to (Vsram - 1=
00mV).
> >> +      * Repeat the step until Vsram and Vproc are set to target volta=
ge.
> >> +      */
> >> +     if (old_vproc < new_vproc) {
> >> +next_up_step:
> >> +             old_vsram =3D regulator_get_voltage(sram_reg);
> >> +
> >> +             vsram =3D (new_vsram - old_vproc < MAX_VOLT_SHIFT) ?
> >> +                     new_vsram : old_vproc + MAX_VOLT_SHIFT;
> >> +             vsram =3D get_regulator_voltage_floor(sram_reg, vsram);
> >> +
> >> +             ret =3D regulator_set_voltage(sram_reg, vsram, vsram);
> >> +             if (ret)
> >> +                     return ret;
> >> +
> >> +             vproc =3D (new_vsram =3D=3D vsram) ?
> >> +                     new_vproc : vsram - MIN_VOLT_SHIFT;
> >> +             vproc =3D get_regulator_voltage_ceil(proc_reg, vproc);
> >> +
> >> +             ret =3D regulator_set_voltage(proc_reg, vproc, vproc);
> >> +             if (ret) {
> >> +                     regulator_set_voltage(sram_reg, old_vsram, old_v=
sram);
> >> +                     return ret;
> >> +             }
> >> +
> >> +             if (new_vproc =3D=3D vproc && new_vsram =3D=3D vsram)
> >> +                     return 0;
> >> +
> >> +             old_vproc =3D vproc;
> >> +             goto next_up_step;
> >
> > Perhaps a naive question: but, is this the correct place to do this?  I
> > would expect this stepping behavior to be implemented in the driver
> > controlling the regulator you are consuming.  It seems strange to do it
> > here.
>=20
> This was already discussed in the last round of this series of patches.
> Please check the discussion[1]. Any suggestion would be welcomed.
> Thanks.

Interesting, thanks.  Sorry for rehashing already-covered territory!

  Josh

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVN7FJAAoJEKp7ZBKwQFArnV4IAKNBOH7QabPrJpHVqNQcAgFP
yUalVICfm1deZ8eodT7T2J6+AVO9lmBrPYusKYeEoc54SsC0DNOSGcNSClJIRag3
Afu9LHCurNe8Vqz8SGpq+/uD3vewwmP2plXXxK59wdT8jDLd1h0MgfAkkadOJjmz
OZ3v2nTSE30zSq2lgh7SqLjjfoj+tM6nMmiUnhK+XyiZgS3/hnj4GnoGE+d5qH5L
xcQx8vrNAFFQLGPBX516T/aId4V3dbtDFBWwJvII0qA9Co8cRqao9MhylOSB2JZu
/ELxDt2dkwdLQZraAyejz5F2EJ0+vzrNT18hWTwqETjG4aDomRIhb2nydarRmjI=
=O6Ib
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--


--===============4849070886169862113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============4849070886169862113==--

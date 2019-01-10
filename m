From: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 3/4] cpufreq: s5pv210: Defer probe if getting regulators fail
Date: Thu, 10 Jan 2019 09:03:34 +0100
Message-ID: <CAKpie0RE=F04JB+_G2K4P4d-5OLB8mvK8P0Q-+DKjwxj7aeA_w@mail.gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com> <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk, rjw@rjwysocki.net, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "moderated list:SAMSUNG SOC CLOCK DRIVERS" <linux-samsung-soc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

czw., 10 sty 2019 o 08:01 Viresh Kumar <viresh.kumar@linaro.org> napisa=C5=
=82(a):
>
> On 08-01-19, 21:05, Pawe=C5=82 Chmiel wrote:
> > There is possibility, that when probing driver, regulators are not yet
> > initialized. In this case we should return EPROBE_DEFER and wait till
> > they're initialized, since they're required currently for cpufreq drive=
r
> > to work. Also move regulator initialization code at beginning of probe,
> > so we can defer as fast as posibble.
> >
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  drivers/cpufreq/s5pv210-cpufreq.c | 33 +++++++++++++++++++------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv21=
0-cpufreq.c
> > index f51697f1e0b3..2d0e4dc7ede7 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -594,6 +594,26 @@ static int s5pv210_cpufreq_probe(struct platform_d=
evice *pdev)
> >        * this whole driver as soon as S5PV210 gets migrated to use
> >        * cpufreq-dt driver.
> >        */
> > +     arm_regulator =3D regulator_get(NULL, "vddarm");
> > +     if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER) {
> > +             pr_dbg("vddarm regulator not ready, defer\n");
> > +             return -EPROBE_DEFER;
> > +     } else if (IS_ERR(arm_regulator)) {
> > +             pr_err("failed to get regulator vddarm\n");
> > +             return PTR_ERR(arm_regulator);
> > +     }
>
> The only difference between the two cases is pr_dbg vs pr_err, its
> ugly that we have to add special code for that :(
>
> Maybe write it as:
>
>         if (IS_ERR(arm_regulator)) {
>                 if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER)
>                         pr_dbg...
>                 else
>                         pr_err
>                 return PTR_ERR(arm_regulator);
>         }
>
> > +
> > +     int_regulator =3D regulator_get(NULL, "vddint");
> > +     if (PTR_ERR(int_regulator =3D=3D -EPROBE_DEFER) {
>
> Does this even compile ?
Looks like i broke it after testing (where it was working fine - was
able to change freq and gov),
and didn't catch this before sending patch for review :/.
Sorry, this (and first issue) will be fixed in v2.

Thanks for review
>
> > +             regulator_put(arm_regulator);
> > +             pr_dbg("vddint regulator not ready, defer\n");
> > +             return -EPROBE_DEFER;
> > +     } else if (IS_ERR(int_regulator)) {
> > +             regulator_put(arm_regulator);
> > +             pr_err("failed to get regulator vddint\n");
> > +             return PTR_ERR(int_regulator);
> > +     }
> > +
> >       np =3D of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock=
");
> >       if (!np) {
> >               pr_err("%s: failed to find clock controller DT node\n",
> > @@ -633,19 +653,6 @@ static int s5pv210_cpufreq_probe(struct platform_d=
evice *pdev)
> >               }
> >       }
> >
> > -     arm_regulator =3D regulator_get(NULL, "vddarm");
> > -     if (IS_ERR(arm_regulator)) {
> > -             pr_err("failed to get regulator vddarm\n");
> > -             return PTR_ERR(arm_regulator);
> > -     }
> > -
> > -     int_regulator =3D regulator_get(NULL, "vddint");
> > -     if (IS_ERR(int_regulator)) {
> > -             pr_err("failed to get regulator vddint\n");
> > -             regulator_put(arm_regulator);
> > -             return PTR_ERR(int_regulator);
> > -     }
> > -
> >       register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
> >
> >       return cpufreq_register_driver(&s5pv210_driver);
> > --
> > 2.17.1
>
> --
> viresh

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 11/16] cpufreq: dt: Pass regulator name to the OPP core
Date: Wed, 18 Jul 2018 09:09:53 +0200
Message-ID: <CAMuHMdU=FNhWh_oroBZb8NkUr_fsvUvYxBHH6=KErqU9_Xi4ZQ@mail.gmail.com>
References: <cover.1454992186.git.viresh.kumar@linaro.org> <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
 <CAMuHMdXgE3oOVdYFy3kzmOv4FXvjU4rC39gUDUtMNJCdB__2AA@mail.gmail.com> <20180718055029.rdo427kozpwqm2bc@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718055029.rdo427kozpwqm2bc@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, Jul 18, 2018 at 7:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-07-18, 09:46, Geert Uytterhoeven wrote:
> > CC device-tree folks
> >
> > Replying to an old email, because that's the most accurate reference I
> > could find.
> >
> > On Tue, Feb 9, 2016 at 6:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > OPP core can handle the regulators by itself, and but it needs to know
> > > the name of the regulator to fetch. Add support for that.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq-dt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > > index 4c9f8a828f6f..2af75f8088bb 100644
> > > --- a/drivers/cpufreq/cpufreq-dt.c
> > > +++ b/drivers/cpufreq/cpufreq-dt.c
> >
> > > @@ -119,6 +120,30 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
> > >         return ret;
> > >  }
> > >
> > > +/*
> > > + * An earlier version of opp-v1 bindings used to name the regulator
> > > + * "cpu0-supply", we still need to handle that for backwards compatibility.
> > > + */
> > > +static const char *find_supply_name(struct device *dev, struct device_node *np)
> > > +{
> > > +       struct property *pp;
> > > +       int cpu = dev->id;
> > > +
> > > +       /* Try "cpu0" for older DTs */
> > > +       if (!cpu) {
> > > +               pp = of_find_property(np, "cpu0-supply", NULL);
> > > +               if (pp)
> > > +                       return "cpu0";
> > > +       }
> > > +
> > > +       pp = of_find_property(np, "cpu-supply", NULL);
> > > +       if (pp)
> > > +               return "cpu";
> >
> > Despite the existence of lots of users of these properties, I couldn't find
> > both the "earlier version" and the "current version" of the opp-v1 bindings
> > documenting the "cpu0-supply" and "cpu-supply" properties?
>
> They are part of the device nodes and don't fall under the
> jurisdiction of OPP tables and so aren't defined there. We rely on the
> "<name>-supply" property from the regulator bindings for the devices.
>
> > Even for opp-v2, they are not documented in
> > Documentation/devicetree/bindings/opp/opp.txt, but cpu-supply is used in
> > the examples?
>
> Same reasoning here as well.

Right, they are part of the cpu nodes, not of the operating-points properties
(which are part of the cpu nodes) or the opp_table nodes (for v2).

> > Can you please document these properties?
>
> I don't think we need to, do we ?

IMHO they should be documented somewhere, with a link to
Documentation/devicetree/bindings/regulator/regulator.txt.
How else can a DTS writer know he/she needs them?
Without cpu-supply (and clock!) properties, cpufreq can't work.

Candidates:
  - Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
    This has operating points without clocks nor cpu-supply, but with
    clock-latency (for which clock? ;-)
  - Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
    Again, operating points without clocks nor cpu-supply, but with
    clock-latency.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

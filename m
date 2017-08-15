From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 07/10] cpufreq: dt: Add support for some new Allwinner SoCs
Date: Tue, 15 Aug 2017 14:25:58 +0200
Message-ID: <4537884.Ku45nQGoFt@aspire.rjw.lan>
References: <20170723102749.17323-1-icenowy@aosc.io> <2436327.OLdY8skjMP@aspire.rjw.lan> <CAGb2v640an6X75PTbNTnMqhnEREekX97uJZ4sFsfqTAgcDinQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAGb2v640an6X75PTbNTnMqhnEREekX97uJZ4sFsfqTAgcDinQg@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Icenowy Zheng <icenowy@aosc.io>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 15, 2017 7:42:19 AM CEST Chen-Yu Tsai wrote:
> On Mon, Jul 24, 2017 at 7:46 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, July 24, 2017 02:23:49 PM Viresh Kumar wrote:
> >> On 23-07-17, 18:27, Icenowy Zheng wrote:
> >> > Some new Allwinner SoCs get supported in the kernel after the
> >> > compatibles are added to cpufreq-dt-platdev driver.
> >> >
> >> > Add their compatible strings in the cpufreq-dt-platdev driver.
> >> >
> >> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> > ---
> >> >  drivers/cpufreq/cpufreq-dt-platdev.c | 6 ++++++
> >> >  1 file changed, 6 insertions(+)
> >> >
> >> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> >> > index 2eb40d46d357..c3851453e84a 100644
> >> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> >> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> >> > @@ -24,7 +24,11 @@ static const struct of_device_id machines[] __initconst = {
> >> >     { .compatible = "allwinner,sun8i-a23", },
> >> >     { .compatible = "allwinner,sun8i-a33", },
> >> >     { .compatible = "allwinner,sun8i-a83t", },
> >> > +   { .compatible = "allwinner,sun8i-h2-plus", },
> >> >     { .compatible = "allwinner,sun8i-h3", },
> >> > +   { .compatible = "allwinner,sun8i-v3s", },
> >> > +   { .compatible = "allwinner,sun50i-a64", },
> >> > +   { .compatible = "allwinner,sun50i-h5", },
> >> >
> >> >     { .compatible = "apm,xgene-shadowcat", },
> >> >
> >> > @@ -43,6 +47,8 @@ static const struct of_device_id machines[] __initconst = {
> >> >     { .compatible = "marvell,pxa250", },
> >> >     { .compatible = "marvell,pxa270", },
> >> >
> >> > +   { .compatible = "nextthing,gr8", },
> >> > +
> >> >     { .compatible = "samsung,exynos3250", },
> >> >     { .compatible = "samsung,exynos4210", },
> >> >     { .compatible = "samsung,exynos4212", },
> >>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>
> >>
> >
> > OK
> >
> > I'm assuming this will go in via arm-soc along with the rest of the series.
> 
> The rest of the series, except for the clk patches I've already taken,
> doesn't seem to be going anywhere just yet. Is there a cpufreq or pm tree
> this can be merged through?

You mean this particular patch or the whole series?

If the former, then yes, there is.

Thanks,
Rafael


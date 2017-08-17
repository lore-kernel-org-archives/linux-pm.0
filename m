From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 07/10] cpufreq: dt: Add support for some new
 Allwinner SoCs
Date: Fri, 18 Aug 2017 01:03:19 +0800
Message-ID: <CAGb2v65rP_+qCvW5vJuwGxB8ebQZD462M3naPMxJ_8LeA0YMww@mail.gmail.com>
References: <20170723102749.17323-1-icenowy@aosc.io> <2436327.OLdY8skjMP@aspire.rjw.lan>
 <CAGb2v640an6X75PTbNTnMqhnEREekX97uJZ4sFsfqTAgcDinQg@mail.gmail.com>
 <4537884.Ku45nQGoFt@aspire.rjw.lan> <CAGb2v67zenaLQaK+df_oN1BebH_7LhTOtSr6dGyaLPN-k3fZow@mail.gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBB4EY27GAKGQEX66GGUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v67zenaLQaK+df_oN1BebH_7LhTOtSr6dGyaLPN-k3fZow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 15, 2017 at 8:39 PM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> On Tue, Aug 15, 2017 at 8:25 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>> On Tuesday, August 15, 2017 7:42:19 AM CEST Chen-Yu Tsai wrote:
>>> On Mon, Jul 24, 2017 at 7:46 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>>> > On Monday, July 24, 2017 02:23:49 PM Viresh Kumar wrote:
>>> >> On 23-07-17, 18:27, Icenowy Zheng wrote:
>>> >> > Some new Allwinner SoCs get supported in the kernel after the
>>> >> > compatibles are added to cpufreq-dt-platdev driver.
>>> >> >
>>> >> > Add their compatible strings in the cpufreq-dt-platdev driver.
>>> >> >
>>> >> > Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>>> >> > Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> >> > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>>> >> > ---
>>> >> >  drivers/cpufreq/cpufreq-dt-platdev.c | 6 ++++++
>>> >> >  1 file changed, 6 insertions(+)
>>> >> >
>>> >> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>>> >> > index 2eb40d46d357..c3851453e84a 100644
>>> >> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>>> >> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>>> >> > @@ -24,7 +24,11 @@ static const struct of_device_id machines[] __initconst = {
>>> >> >     { .compatible = "allwinner,sun8i-a23", },
>>> >> >     { .compatible = "allwinner,sun8i-a33", },
>>> >> >     { .compatible = "allwinner,sun8i-a83t", },
>>> >> > +   { .compatible = "allwinner,sun8i-h2-plus", },
>>> >> >     { .compatible = "allwinner,sun8i-h3", },
>>> >> > +   { .compatible = "allwinner,sun8i-v3s", },
>>> >> > +   { .compatible = "allwinner,sun50i-a64", },
>>> >> > +   { .compatible = "allwinner,sun50i-h5", },
>>> >> >
>>> >> >     { .compatible = "apm,xgene-shadowcat", },
>>> >> >
>>> >> > @@ -43,6 +47,8 @@ static const struct of_device_id machines[] __initconst = {
>>> >> >     { .compatible = "marvell,pxa250", },
>>> >> >     { .compatible = "marvell,pxa270", },
>>> >> >
>>> >> > +   { .compatible = "nextthing,gr8", },
>>> >> > +
>>> >> >     { .compatible = "samsung,exynos3250", },
>>> >> >     { .compatible = "samsung,exynos4210", },
>>> >> >     { .compatible = "samsung,exynos4212", },
>>> >>
>>> >> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> >>
>>> >>
>>> >
>>> > OK
>>> >
>>> > I'm assuming this will go in via arm-soc along with the rest of the series.
>>>
>>> The rest of the series, except for the clk patches I've already taken,
>>> doesn't seem to be going anywhere just yet. Is there a cpufreq or pm tree
>>> this can be merged through?
>>
>> You mean this particular patch or the whole series?
>>
>> If the former, then yes, there is.
>
> Just this patch. As I mentioned the rest of the series still needs some
> work, and likely won't make it in this cycle. If you could take this
> through the tree it would normally go through, avoiding any conflicts,
> that'd be great.

This patch has been obsoleted by Viresh's "cpufreq: dt-platdev:
Automatically create cpufreq device with OPP v2" patch.

ChenYu

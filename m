From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/1] ARM: EXYNOS: Add default latency values for Device and Power Domain
Date: Mon, 11 Nov 2013 15:15:43 +0100
Message-ID: <1462328.Ohojb4XpRs@flatron>
References: <1383892025-14759-1-git-send-email-sachin.kamat@linaro.org> <9546263.JaCWNRjo5C@flatron> <CAKew6eUrtw7bTqo8tWD4JCwvCM0jRowSj=v4=dnqc5krPLpRWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKew6eUrtw7bTqo8tWD4JCwvCM0jRowSj=v4=dnqc5krPLpRWg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yadwinder Singh Brar <yadi.brar01@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, prathyush.k@samsung.com, Prasanna Kumar <prasanna.ps@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday 11 of November 2013 23:11:41 Yadwinder Singh Brar wrote:
> >> +};
> >> +
> >>  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
> >>  {
> >>       struct exynos_pm_domain *pd;
> >> @@ -83,7 +94,7 @@ static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
> >>       dev_dbg(dev, "adding to power domain %s\n", pd->pd.name);
> >>
> >>       while (1) {
> >> -             ret = pm_genpd_add_device(&pd->pd, dev);
> >> +             ret = __pm_genpd_add_device(&pd->pd, dev, &dev_latencies);
> >
> > The double underscore prefix scares me a bit. Is this function really
> > supposed to be used like this?
> >
> 
> Moreover, it also seems little bit odd in the first place, to pass
> dev_latencies(QoS timing parameters) when we are not using/providing
> any governor for the genpd. QoS timing parameters have to be provided
> to be used by governor. In our case since we are not using/providing
> any governor yet, so it seems odd to provide QoS timing parameters. It
> seems, here core pd code is giving unnecessary warning in our case,
> since we are not providing governor(not interested in QoS). So IMO
> warning should be fixed instead of just suppressing it by giving some
> big values of timing parameters.
> 

Yes, that would be probably much better option than providing some random
values that do not have any rationale behind them.

Rafael, could you comment on this?

Best regards,
Tomasz

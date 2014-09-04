From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 14/15] PM / Domains: Remove default_stop_ok() API
Date: Thu, 04 Sep 2014 21:49:29 +0200
Message-ID: <6302495.FUvz9FPcau@vostro.rjw.lan>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org> <1409741551-16437-15-git-send-email-ulf.hansson@linaro.org> <CAMuHMdUEfAdpUgEtOQfdG1gbZjVo3bfAAmhm0-miFGbQ8ckHgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUEfAdpUgEtOQfdG1gbZjVo3bfAAmhm0-miFGbQ8ckHgA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kevin Hilman <khilman@linaro.org>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 03, 2014 03:15:59 PM Geert Uytterhoeven wrote:
> Hi Ulf,
> 
> On Wed, Sep 3, 2014 at 12:52 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > --- a/drivers/base/power/domain_governor.c
> > +++ b/drivers/base/power/domain_governor.c
> 
> > @@ -229,10 +229,7 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
> >
> >  #else /* !CONFIG_PM_RUNTIME */
> >
> > -bool default_stop_ok(struct device *dev)
> > -{
> > -       return false;
> > -}
> > +static inline bool default_stop_ok(struct device *dev) { return false; }
> 
> The "inline" doesn't make much sense here.

But then it doesn't hurt either I suppose?

Anyway, Ulf, are you going to update this patch?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4 13/16] soc: tegra: pmc: Add generic PM domain support
Date: Fri, 15 Jan 2016 11:01:12 +0100
Message-ID: <1452852072.3694.86.camel@pengutronix.de>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
	 <1449241037-22193-14-git-send-email-jonathanh@nvidia.com>
	 <20160114143932.GE23082@ulmo> <5698BF00.6090102@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5698BF00.6090102-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, den 15.01.2016, 09:42 +0000 schrieb Jon Hunter:
> On 14/01/16 14:39, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Fri, Dec 04, 2015 at 02:57:14PM +0000, Jon Hunter wrote:
> > [...]
> >> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> > [...]
> >> +static int tegra_powergate_power_down(struct tegra_powergate *pg,
> >> +				      bool enable_clocks)
> >> +{
> >> +	int err;
> >> +
> >> +	if (enable_clocks) {
> >> +		err = tegra_powergate_enable_clocks(pg);
> >> +		if (err)
> >> +			return err;
> >> +
> >> +		usleep_range(10, 20);
> >> +	}
> >> +
> >> +	err = tegra_powergate_reset_assert(pg);
> >> +	if (err)
> >> +		goto err_reset;
> >> +
> >> +	usleep_range(10, 20);
> >> +
> >> +	tegra_powergate_disable_clocks(pg);
> > 
> > There's no guarantee that all clocks are actually disabled at this
> > point. Will the power down and subsequent power up sequences still
> > work properly in such cases? If not perhaps we should add some way
> > of checking for that case here (WARN_ON?) to make sure we can fix
> > up all drivers to release their clock enable references.
> 
> The problem is that there is no easy way to check the status of a clock
> and whether it is enabled. Yes clk-provider.h does provide a
> __clk_is_enabled() API but I don't think that this is meant to be used
> here. May be we need a clk API for disabling a clock that will WARN if
> the clock is not disabled?
> 
I can't find any hint in the TRM that disabling the clocks is required
for clamping/powergating.

All occurrences of those clock requirements are in regard to a
synchronous reset propagation. So there is no requirement that the
clocks need to be _disabled_ at a certain time, but actually they just
need to be _enabled_ whenever the PMC is trying to drive the resets in
any way.

Obviously the power savings might be higher when the peripheral drivers
properly disable any unused clocks in suspend, but that can be solved on
a case by case basis I think.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

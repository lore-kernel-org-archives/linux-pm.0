From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Change prototype for the ->attach_dev() callback
Date: Thu, 06 Nov 2014 01:54:36 +0100
Message-ID: <6900237.LSPrkZ5QMk@vostro.rjw.lan>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org> <3267963.fqUYb7m9Rv@vostro.rjw.lan> <7hsihx1bvo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <7hsihx1bvo.fsf@deeprootsystems.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 05, 2014 03:11:23 PM Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > On Wednesday, November 05, 2014 02:43:31 PM Kevin Hilman wrote:
> >> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> >> 
> >> > On Thu, Oct 30, 2014 at 01:38:30PM -0700, Kevin Hilman wrote:
> >> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> >> >> 
> >> >> > On Thursday, October 30, 2014 01:02:49 PM Ulf Hansson wrote:
> >> >> >> Convert the prototype to return and int. This is just an initial step,
> >> >> >> needed to support error handling.
> >> >> >> 
> >> >> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> >> 
> >> >> Acked-by: Kevin Hilman <khilman@linaro.org>
> >> >> 
> >> >> >> 
> >> >> >> This patch is intended as fix for 3.18 rc[n]. Why?
> >> >> >> 
> >> >> >> There are other SOC specific patches around that adds genpd support and which
> >> >> >> implements the ->attach_dev() callback. To prevent having an "atomic" patch
> >> >> >> during the next release cycle, let's change the prototype now instead.
> >> >> >> 
> >> >> >> Further patches will add the actual error handling in genpd and these can then
> >> >> >> be reviewed and tested thoroughly.
> >> >> >
> >> >> > So we have no users of ->attach_dev at the moment, right?
> >> >> 
> >> >> Not in mainline, but there are a couple getting ready to hit -next, so
> >> >> we wanted to fix this before they arrive so that adding the error
> >> >> handling will be easier.
> >> >
> >> > BTW, while we are at it, can we also pass the domain itself to
> >> > attach_dev() and detach_dev()? If anything it helps with debugging (you
> >> > can print domain name from the callbacks).
> >> 
> >> Agreed, and it makes it match the other callbacks (power_off, power_on)
> >> which currently take struct generic_pm_domain *domain.  
> >> 
> >> Updated version of $SUBJECT patch below.
> >
> > The subject and changelog need to be updated too IMO.
> >
> 
> Right.  Here you go.

I've replaced the Ulf's original with this one, thanks!

> ----- >8 ------
> From c18a6bf3121979c4102ba4f7edb3ac41e3921fc6 Mon Sep 17 00:00:00 2001
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Thu, 30 Oct 2014 13:02:49 +0100
> Subject: [PATCH] PM / Domains: Change prototype for the attach and detach
>  callbacks
> 
> Convert the prototypes to return an int in order to support error
> handling in these callbacks.
> 
> Also, as suggested by Dmitry Torokhov, pass the domain pointer for use
> inside the callbacks, and so that they match the existing
> power_on/power_off callbacks which currently take the domain pointer.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> [khilman: added domain as parameter to callbacks, as suggested by Dmitry]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>  drivers/base/power/domain.c | 4 ++--
>  include/linux/pm_domain.h   | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 40bc2f4072cc..b520687046d4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1437,7 +1437,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  	spin_unlock_irq(&dev->power.lock);
>  
>  	if (genpd->attach_dev)
> -		genpd->attach_dev(dev);
> +		genpd->attach_dev(genpd, dev);
>  
>  	mutex_lock(&gpd_data->lock);
>  	gpd_data->base.dev = dev;
> @@ -1499,7 +1499,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  	genpd->max_off_time_changed = true;
>  
>  	if (genpd->detach_dev)
> -		genpd->detach_dev(dev);
> +		genpd->detach_dev(genpd, dev);
>  
>  	spin_lock_irq(&dev->power.lock);
>  
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 73e938b7e937..b3ed7766a291 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -72,8 +72,10 @@ struct generic_pm_domain {
>  	bool max_off_time_changed;
>  	bool cached_power_down_ok;
>  	struct gpd_cpuidle_data *cpuidle_data;
> -	void (*attach_dev)(struct device *dev);
> -	void (*detach_dev)(struct device *dev);
> +	int (*attach_dev)(struct generic_pm_domain *domain,
> +			  struct device *dev);
> +	void (*detach_dev)(struct generic_pm_domain *domain,
> +			   struct device *dev);
>  };
>  
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

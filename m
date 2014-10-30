From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
Date: Thu, 30 Oct 2014 13:28:36 +0100
Message-ID: <20141030122836.GA4012@amd>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu 2014-10-30 13:02:49, Ulf Hansson wrote:
> Convert the prototype to return and int. This is just an initial step,
> needed to support error handling.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>


> ---
> 
> This patch is intended as fix for 3.18 rc[n]. Why?
> 
> There are other SOC specific patches around that adds genpd support and which
> implements the ->attach_dev() callback. To prevent having an "atomic" patch
> during the next release cycle, let's change the prototype now instead.
> 
> Further patches will add the actual error handling in genpd and these can then
> be reviewed and tested thoroughly.
> 
> ---
>  include/linux/pm_domain.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 73e938b..d44f071 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -72,7 +72,7 @@ struct generic_pm_domain {
>  	bool max_off_time_changed;
>  	bool cached_power_down_ok;
>  	struct gpd_cpuidle_data *cpuidle_data;
> -	void (*attach_dev)(struct device *dev);
> +	int (*attach_dev)(struct device *dev);
>  	void (*detach_dev)(struct device *dev);
>  };
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

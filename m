From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/8] PM / domains: Protect reading loop over list of
 domains
Date: Fri, 9 Jun 2017 18:16:49 +0200
Message-ID: <20170609161649.g5wjn24tm2opyq3h@kozik-lap>
References: <20170609160853.31789-1-krzk@kernel.org>
 <20170609160853.31789-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170609160853.31789-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 09, 2017 at 06:08:47PM +0200, Krzysztof Kozlowski wrote:
> The pm_genpd_present() iterates over list of domains so grabbing a
> gpd_list_lock mutex is necessary before calling it.  Otherwise we could
> end up in iterating over and modifying the list at the same time.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/base/power/domain.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2e8d0f423507..2a6935dc0164 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1099,8 +1099,13 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
>  	struct generic_pm_domain *genpd;
>  
>  	genpd = dev_to_genpd(dev);
> -	if (!pm_genpd_present(genpd))
> +
> +	mutex_lock(&gpd_list_lock);
> +	if (!pm_genpd_present(genpd)) {
> +		mutex_unlock(&gpd_list_lock);
>  		return;
> +	}
> +	mutex_unlock(&gpd_list_lock);

Eh, I might be too fast as this is not executed on my platform.  The
genpd_syscore_switch() seems to be called by clocksource_suspend() which
is called by syscore ops. Should be safe but actually not tested.

Someone with SH hardware is needed...

Best regards,
Krzysztof

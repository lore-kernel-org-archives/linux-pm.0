From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: If an OF node is found but no device probed yet, defer.
Date: Wed, 11 Mar 2015 23:08:11 +0100
Message-ID: <6516096.HanqZ05BXy@vostro.rjw.lan>
References: <1426087648-3862-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426087648-3862-1-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

More CCes.

On Wednesday, March 11, 2015 08:27:28 AM Eric Anholt wrote:
> If we've declared a power domain in the OF, and the OF node is found
> but the requested domain hasn't been registered on it yet, then we
> probably have just tried to probe before the power domain driver has.
> Defer our device's probe until it shows up.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Kevin, Ulf, any chance to have a look at this, please?

> ---
> 
> I ran into this when turning my ad-hoc code for BCM2835 (Raspberry Pi)
> USB poweron support in the DWC2 controller to an OF-based power domain
> declaration.
> 
> drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ba4abbe..2b93c98 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2064,7 +2064,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>  struct generic_pm_domain *of_genpd_get_from_provider(
>  					struct of_phandle_args *genpdspec)
>  {
> -	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
> +	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
>  	struct of_genpd_provider *provider;
>  
>  	mutex_lock(&of_genpd_mutex);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

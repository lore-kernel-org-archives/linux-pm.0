From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] PM / Domains: Make pm_genpd_{add,remove}_subdomain() available to modules
Date: Mon, 05 Oct 2015 22:55:55 +0200
Message-ID: <6374611.5Nvbqg0Ugs@vostro.rjw.lan>
References: <1443727374-1539-1-git-send-email-sboyd@codeaurora.org> <1443727374-1539-2-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1443727374-1539-2-git-send-email-sboyd@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Rajendra Nayak <rnayak@codeaurora.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 01, 2015 12:22:53 PM Stephen Boyd wrote:
> Export these symbols so they can be used in loadable kernel
> modules.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
>  drivers/base/power/domain.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cf4950d92937..9b0f5a06a82b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1348,6 +1348,7 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
>  
>  /**
>   * pm_genpd_remove_subdomain - Remove a subdomain from an I/O PM domain.
> @@ -1395,6 +1396,7 @@ out:
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
>  
>  /* Default device callbacks for generic PM domains. */

This is fine by me, please feel free to add my ACK to it.

Thanks,
Rafael


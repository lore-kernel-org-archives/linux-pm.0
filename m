From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] PM / Domains: Enable
 genpd_dev_pm_attach_by_id|name() for single PM domain
Date: Mon, 22 Apr 2019 14:01:03 +0530
Message-ID: <20190422083103.xnuvmap5zgbdyk4v@vireshk-i7>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-4-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 18-04-19, 12:27, Ulf Hansson wrote:
> If a call to dev_pm_domain_attach() succeeds to attach a device to its
> single PM domain, the important point is to prevent following calls to
> dev_pm_domain_attach_by_name|id() to fail. This is managed by checking the
> dev->pm_domain pointer and then return -EEXIST, rather than continue
> calling genpd_dev_pm_attach_by_id|name().
> 
> For this reason, let's enable genpd_dev_pm_attach_by_id|name() to be used
> for also single PM domains. This simplifies for future users to solely make
> use of dev_pm_domain_attach_by_id|name() rather than having to combine it
> with dev_pm_domain_attach().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 801f31c87d16..1b026704a8fc 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2512,10 +2512,10 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	if (!dev->of_node)
>  		return NULL;
>  
> -	/* Deal only with devices using multiple PM domains. */
> +	/* Verify that the index is within a valid range. */
>  	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
>  						 "#power-domain-cells");
> -	if (num_domains < 2 || index >= num_domains)
> +	if (index >= num_domains)
>  		return NULL;
>  
>  	/* Allocate and register device on the genpd bus. */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] PM / Domains: Don't kfree() the virtual device in
 the error path
Date: Mon, 22 Apr 2019 13:57:50 +0530
Message-ID: <20190422082750.vha36l3pgwkpfnn5@vireshk-i7>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-2-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-2-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 18-04-19, 12:27, Ulf Hansson wrote:
> It's not correct to call kfree(dev) when device_register(dev) has failed.
> Fix this by calling put_device(dev) instead.
> 
> Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ecac03dcc9b2..7fec69aebf46 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2528,7 +2528,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  
>  	ret = device_register(virt_dev);
>  	if (ret) {
> -		kfree(virt_dev);
> +		put_device(virt_dev);
>  		return ERR_PTR(ret);
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

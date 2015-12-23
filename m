From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/scpi: fix handling return value of
 topology_physical_package_id
Date: Wed, 23 Dec 2015 16:11:06 +0530
Message-ID: <20151223104105.GB3455@ubuntu>
References: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:SYSTEM CONTROL & POWER INTERFACE (SCPI) Message..." <linux-arm-kernel@lists.infradead.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 23-12-15, 11:37, Andrzej Hajda wrote:
> The function can return negative values, so its result should
> be assigned to signed variable.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 2c3b16f..de5e89b 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -31,7 +31,7 @@ static struct scpi_ops *scpi_ops;
>  
>  static struct scpi_dvfs_info *scpi_get_dvfs_info(struct device *cpu_dev)
>  {
> -	u8 domain = topology_physical_package_id(cpu_dev->id);
> +	int domain = topology_physical_package_id(cpu_dev->id);
>  
>  	if (domain < 0)
>  		return ERR_PTR(-EINVAL);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

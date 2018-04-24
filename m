From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 6/6] devfreq: rk3399_dmc: register devfreq notification
 to dmc driver.
Date: Tue, 24 Apr 2018 13:08:37 +0900
Message-ID: <5ADEADC5.8000201@samsung.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104130epcas2p4c40667908eb5aecbc80d7c19e4710065@epcas2p4.samsung.com>
        <20180419104019.24406-7-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180419104019.24406-7-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Lin Huang <hl@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>, Jeffy Chen <jeffy.chen@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 04월 19일 19:40, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> Because dmc may also access the PMU_BUS_IDLE_REQ register, we need to
> ensure that the pd driver and the dmc driver will not access at this
> register at the same time.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/rk3399_dmc.c      | 47 +----------------------
>  drivers/soc/rockchip/pm_domains.c | 31 +++++++++++++++
>  include/soc/rockchip/rk3399_dmc.h | 63 +++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+), 45 deletions(-)
>  create mode 100644 include/soc/rockchip/rk3399_dmc.h
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 5bfca028eaaf..a1f320634d69 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -27,51 +27,7 @@
>  #include <linux/suspend.h>
>  
>  #include <soc/rockchip/rockchip_sip.h>
> -
> -struct dram_timing {
> -	unsigned int ddr3_speed_bin;
> -	unsigned int pd_idle;
> -	unsigned int sr_idle;
> -	unsigned int sr_mc_gate_idle;
> -	unsigned int srpd_lite_idle;
> -	unsigned int standby_idle;
> -	unsigned int auto_pd_dis_freq;
> -	unsigned int dram_dll_dis_freq;
> -	unsigned int phy_dll_dis_freq;
> -	unsigned int ddr3_odt_dis_freq;
> -	unsigned int ddr3_drv;
> -	unsigned int ddr3_odt;
> -	unsigned int phy_ddr3_ca_drv;
> -	unsigned int phy_ddr3_dq_drv;
> -	unsigned int phy_ddr3_odt;
> -	unsigned int lpddr3_odt_dis_freq;
> -	unsigned int lpddr3_drv;
> -	unsigned int lpddr3_odt;
> -	unsigned int phy_lpddr3_ca_drv;
> -	unsigned int phy_lpddr3_dq_drv;
> -	unsigned int phy_lpddr3_odt;
> -	unsigned int lpddr4_odt_dis_freq;
> -	unsigned int lpddr4_drv;
> -	unsigned int lpddr4_dq_odt;
> -	unsigned int lpddr4_ca_odt;
> -	unsigned int phy_lpddr4_ca_drv;
> -	unsigned int phy_lpddr4_ck_cs_drv;
> -	unsigned int phy_lpddr4_dq_drv;
> -	unsigned int phy_lpddr4_odt;
> -};
> -
> -struct rk3399_dmcfreq {
> -	struct device *dev;
> -	struct devfreq *devfreq;
> -	struct devfreq_simple_ondemand_data ondemand_data;
> -	struct clk *dmc_clk;
> -	struct devfreq_event_dev *edev;
> -	struct mutex lock;
> -	struct dram_timing timing;
> -	struct regulator *vdd_center;
> -	unsigned long rate, target_rate;
> -	unsigned long volt, target_volt;
> -};
> +#include <soc/rockchip/rk3399_dmc.h>
>  
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  				 u32 flags)
> @@ -394,6 +350,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  	data->dev = dev;
>  	platform_set_drvdata(pdev, data);
> +	pd_register_notify_to_dmc(data->devfreq);
>  
>  	return 0;
>  }
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index 53efc386b1ad..7acc836e7eb7 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -8,6 +8,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/devfreq.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/err.h>
> @@ -76,9 +77,13 @@ struct rockchip_pmu {
>  	const struct rockchip_pmu_info *info;
>  	struct mutex mutex; /* mutex lock for pmu */
>  	struct genpd_onecell_data genpd_data;
> +	struct devfreq *devfreq;
> +	struct notifier_block dmc_nb;
>  	struct generic_pm_domain *domains[];
>  };
>  
> +static struct rockchip_pmu *dmc_pmu;
> +
>  #define to_rockchip_pd(gpd) container_of(gpd, struct rockchip_pm_domain, genpd)
>  
>  #define DOMAIN(pwr, status, req, idle, ack, wakeup)	\
> @@ -601,6 +606,30 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  	return error;
>  }
>  
> +static int dmc_notify(struct notifier_block *nb, unsigned long event,
> +		      void *data)
> +{
> +	if (event == DEVFREQ_PRECHANGE)
> +		mutex_lock(&dmc_pmu->mutex);
> +	else if (event == DEVFREQ_POSTCHANGE)
> +		mutex_unlock(&dmc_pmu->mutex);
> +
> +	return NOTIFY_OK;
> +}
> +
> +int pd_register_notify_to_dmc(struct devfreq *devfreq)
> +{
> +	if (!dmc_pmu)
> +		return -EPROBE_DEFER;
> +
> +	dmc_pmu->devfreq = devfreq;
> +	dmc_pmu->dmc_nb.notifier_call = dmc_notify;
> +	devfreq_register_notifier(dmc_pmu->devfreq, &dmc_pmu->dmc_nb,
> +				  DEVFREQ_TRANSITION_NOTIFIER);
> +	return 0;
> +}
> +EXPORT_SYMBOL(pd_register_notify_to_dmc);

I think that it is not proper to define the nonstandard function
for only specific device driver. Maybe, It makes the code more complicated.
Between linux kernel frameworks, we have to use the defined function
by linux kernel frameworks.

If drivers/soc/rockchip/pm_domains.c is able to get the devfreq instance
through devicetree, the exported function is not necessary. Sorry for that
I'm not sure the alternative.

[snip]

> diff --git a/include/soc/rockchip/rk3399_dmc.h b/include/soc/rockchip/rk3399_dmc.h
> new file mode 100644
> index 000000000000..7ccdfff1a154
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_dmc.h
> @@ -0,0 +1,63 @@

[snip]

> +
> +int pd_register_notify_to_dmc(struct devfreq *devfreq);
> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

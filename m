From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 04/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
Date: Wed, 22 Jul 2015 18:03:33 -0700
Message-ID: <55B03D65.8040207@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-5-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1437549069-29655-5-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 07/22/2015 12:11 AM, Rajendra Nayak wrote:
> With CONFIG_PM disabled, turn the devices clocks on during
> driver binding to the device, and turn them off when the
> driver is unbound from the device.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>   drivers/clk/qcom/gdsc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 3125809..9ddd2f8 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -16,6 +16,7 @@
>   #include <linux/jiffies.h>
>   #include <linux/pm_clock.h>
>   #include <linux/slab.h>
> +#include <linux/platform_device.h>

#include <linux/clk.h>?

>   #include "gdsc.h"
>   
>   #define PWR_ON_MASK		BIT(31)
> @@ -200,3 +201,61 @@ void gdsc_unregister(struct device *dev)
>   {
>   	of_genpd_del_provider(dev->of_node);
>   }
> +
> +#ifndef CONFIG_PM
> +static void enable_clock(struct device *dev, const char *con_id)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get(dev, con_id);
> +	if (!IS_ERR(clk)) {
> +		clk_prepare_enable(clk);
> +		clk_put(clk);
> +	}
> +}
> +
> +static void disable_clock(struct device *dev, const char *con_id)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get(dev, con_id);
> +	if (!IS_ERR(clk)) {
> +		clk_disable_unprepare(clk);
> +		clk_put(clk);
> +	}
> +}

Is there a reason why this whole patch isn't generic code? I recall some 
discussion but I forgot now and there isn't any mention of why this 
isn't generic code in the commit text.

> +
> +static int clk_notify(struct notifier_block *nb, unsigned long action,
> +		      void *data)
> +{
> +	int sz;
> +	struct device *dev = data;
> +	char **con_id, *con_ids[] = { "core", "iface", NULL };

This again?

> +
> +	if (!of_find_property(dev->of_node, "power-domains", &sz))
> +		return 0;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_BIND_DRIVER:
> +		for (con_id = con_ids; *con_id; con_id++)
> +			enable_clock(dev, *con_id);
> +		break;
> +	case BUS_NOTIFY_UNBOUND_DRIVER:
> +		for (con_id = con_ids; *con_id; con_id++)
> +			disable_clock(dev, *con_id);
> +		break;
> +	}
> +	return 0;
> +}
> +
> +struct notifier_block nb = {

static?

> +	.notifier_call = clk_notify,
> +};
> +
> +int qcom_pm_runtime_init(void)

static? __init?

> +{
> +	bus_register_notifier(&platform_bus_type, &nb);
> +	return 0;

return bus_register_notifier()?

> +}
> +core_initcall(qcom_pm_runtime_init);
> +#endif


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

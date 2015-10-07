From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] thermal: mediatek: Add cpu power cooling model.
Date: Wed, 7 Oct 2015 16:57:45 +0100
Message-ID: <20151007155745.GD28981@leverpostej>
References: <1444220561-26139-1-git-send-email-dawei.chien@mediatek.com>
 <1444220561-26139-2-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444220561-26139-2-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 07, 2015 at 08:22:40PM +0800, Dawei Chien wrote:
> From: "Dawei.Chien" <dawei.chien@mediatek.com>
> 
> This power model is base on Intelligent Power Allocation (IPA) technical,
> requires that the operating-points of the CPUs are registered using the
> kernel's opp library and the `cpufreq_frequency_table` is assigned to the
> `struct device` of the cpu MT8173.
> 
> Signed-off-by: Dawei.Chien <dawei.chien@mediatek.com>
> ---
> This patch is base on
> https://patchwork.kernel.org/patch/7034601/
> ---
>  drivers/cpufreq/mt8173-cpufreq.c |   97 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 86 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 49caed2..9233ec5 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -28,7 +28,8 @@
>  #define MAX_VOLT_SHIFT		(200000)
>  #define MAX_VOLT_LIMIT		(1150000)
>  #define VOLT_TOL		(10000)
> -
> +#define CAPACITANCE_CA53	(263)
> +#define CAPACITANCE_CA57	(530)
>  /*
>   * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
>   * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
> @@ -51,6 +52,72 @@ struct mtk_cpu_dvfs_info {
>  	bool need_voltage_tracking;
>  };
>  
> +struct mtk_cpu_static_power {
> +	unsigned long voltage;
> +	unsigned int power;
> +};
> +
> +/* measured by WA program. */
> +static const struct mtk_cpu_static_power mtk_ca53_static_power[] = {
> +	{859000, 43},
> +	{908000, 52},
> +	{983000, 86},
> +	{1009000, 123},
> +	{1028000, 138},
> +	{1083000, 172},
> +	{1109000, 180},
> +	{1125000, 192},
> +};
> +
> +/* measured by WA program. */
> +static const struct mtk_cpu_static_power mtk_ca57_static_power[] = {
> +	{828000, 72},
> +	{867000, 90},
> +	{927000, 156},
> +	{968000, 181},
> +	{1007000, 298},
> +	{1049000, 435},
> +	{1089000, 533},
> +	{1125000, 533},
> +};

This should be described in the DT, rather than necessitating tonnes of
these tables in the kernel.

Mark.

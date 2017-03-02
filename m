From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] cpufreq: mt8173: Add support for MT8176 and MT817x
 compatibles
Date: Thu, 2 Mar 2017 16:09:57 +0530
Message-ID: <20170302103957.GB13760@vireshk-i7>
References: <20170302103626.69195-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170302103626.69195-1-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yidi Lin <yidi.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 02-03-17, 18:36, Daniel Kurtz wrote:
> The Mediatek MT8173 is just on of several SOCs from the same MT817x family,

s/on/one

> including the 6-core (4-little/2-big) MT8176.
> 
> The mt8173-cpufreq driver supports all of these SOCs, however, machines
> using them may use a different machine compatible.
> 
> Since this driver checks explicitly for the machine compatible string, add
> support for the whole family.
> 
> Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> This patch is based on the compatibles added by the MT8176 series:
> 
>  https://patchwork.kernel.org/patch/9573209/
>  https://patchwork.kernel.org/patch/9573213/
> 
>  drivers/cpufreq/mt8173-cpufreq.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index ab25b1235a5e..07f7aac56f31 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -573,13 +573,34 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
>  	.probe		= mt8173_cpufreq_probe,
>  };
>  
> +/* List of machine compatible strings supported by this driver */
> +static const char *mt8173_cpufreq_machines[] = {
> +	"mediatek,mt817x",
> +	"mediatek,mt8173",
> +	"mediatek,mt8176",
> +};
> +
> +static int mt8173_cpufreq_is_compatible(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mt8173_cpufreq_machines); i++)
> +		if (of_machine_is_compatible(mt8173_cpufreq_machines[i]))
> +			return 0;
> +
> +	return -ENODEV;
> +}
> +
>  static int mt8173_cpufreq_driver_init(void)
>  {
>  	struct platform_device *pdev;
>  	int err;
>  
> -	if (!of_machine_is_compatible("mediatek,mt8173"))
> -		return -ENODEV;
> +	err = mt8173_cpufreq_is_compatible();

Use of_match_node() instead (hint: cpufreq-dt-platdev.c)

> +	if (err) {
> +		pr_err("Machine is not compatible with 'mediatek,mt8173'\n");
> +		return err;
> +	}
>  
>  	err = platform_driver_register(&mt8173_cpufreq_platdrv);
>  	if (err)

-- 
viresh

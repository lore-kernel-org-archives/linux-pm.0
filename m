From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 12/19] cpufreq: tegra124: extend to support Tegra210
Date: Tue, 4 Dec 2018 14:22:26 +0300
Message-ID: <c4f34e85-052b-f3a3-a6ea-715d1971335c@gmail.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-13-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181204092548.3038-13-josephl@nvidia.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04.12.2018 12:25, Joseph Lo wrote:
> Tegra210 uses the same methodology as Tegra124 for CPUFreq controlling
> that based on DFLL clock. So extending this driver to support Tegra210.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 448d00763d00..1af955fb715c 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -159,7 +159,8 @@ static int __init tegra_cpufreq_init(void)
>  	int ret;
>  	struct platform_device *pdev;
>  
> -	if (!of_machine_is_compatible("nvidia,tegra124"))
> +	if (!(of_machine_is_compatible("nvidia,tegra124") ||
> +		of_machine_is_compatible("nvidia,tegra210")))
>  		return -ENODEV;
>  
>  	/*
> 

Seems that's not enough, you also need to blacklist "nvidia,tegra210" in the drivers/cpufreq/cpufreq-dt-platdev.c

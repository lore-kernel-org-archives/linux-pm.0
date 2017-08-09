From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: add support of cpufreq to MT7622
 SoC
Date: Wed, 9 Aug 2017 19:56:33 +0530
Message-ID: <20170809142633.GD29383@vireshk-i7>
References: <cover.1502272372.git.sean.wang@mediatek.com>
 <8d96863368adb8a0435de9739e458035e6a6233b.1502272372.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8d96863368adb8a0435de9739e458035e6a6233b.1502272372.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, matthias.bgg@gmail.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-08-17, 18:12, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MT7622 is a 64-bit ARMv8 based dual-core SoC (2 * Cortex-A53) with a
> single cluster. The hardware is also compatible with the current driver,
> so add MT7622 as one of the compatible string list.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 9fa9291..18c4bd9 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -574,6 +574,7 @@ static struct platform_driver mtk_cpufreq_platdrv = {
>  /* List of machines supported by this driver */
>  static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>  	{ .compatible = "mediatek,mt2701", },
> +	{ .compatible = "mediatek,mt7622", },
>  	{ .compatible = "mediatek,mt7623", },
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

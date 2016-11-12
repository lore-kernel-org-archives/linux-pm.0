From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 2/3] thermal: hisilicon: fix for dependency
Date: Sat, 12 Nov 2016 20:05:34 +0800
Message-ID: <20161112120534.GC23848@leoy-linaro>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
 <1472633417-9330-3-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1472633417-9330-3-git-send-email-leo.yan@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <treding@nvidia.com>, Riku Voipio <riku.voipio@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Guodong Xu <guodong.xu@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Rui, Eduardo,

On Wed, Aug 31, 2016 at 04:50:16PM +0800, Leo Yan wrote:
> The thermal driver is standalone driver which is used to enable
> thermal sensors, so it can be used with any cooling device and
> should not bind with CPU cooling device driver.
> 
> This original patch is suggested by Amit Kucheria; so it's to
> polish the dependency in Kconfig, and remove the dependency with
> CPU_THERMAL.

Could you help review this patch? Or need me resend this patch? Sorry
I have not tracked this patches well before, this is one missed
patch for 96board Hikey.

Thanks,
Leo Yan

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/thermal/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2d702ca..91ebab3 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -177,8 +177,10 @@ config THERMAL_EMULATION
>  
>  config HISI_THERMAL
>  	tristate "Hisilicon thermal driver"
> -	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
> +	depends on ARCH_HISI || COMPILE_TEST
>  	depends on HAS_IOMEM
> +	depends on OF
> +	default y
>  	help
>  	  Enable this to plug hisilicon's thermal sensor driver into the Linux
>  	  thermal framework. cpufreq is used as the cooling device to throttle
> -- 
> 1.9.1
> 

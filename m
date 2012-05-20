From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: DAVINCI: cpuidle - remove ops
Date: Sun, 20 May 2012 15:49:40 +0530
Message-ID: <4FB8C53C.1020301@ti.com>
References: <1336639485-26955-1-git-send-email-daniel.lezcano@linaro.org>
	<1336639485-26955-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1336639485-26955-3-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On 5/10/2012 2:14 PM, Daniel Lezcano wrote:
> This patch removes the ops usage because we have the index
> passed as parameter to the idle function and we can determine
> if we do WFI or memory retention.
> 
> The benefit of this cleanup is the removal of:
>  * the ops
>  * the statedata usage because we want to get rid of it in all the drivers
>  * extra structure definition
>  * extra functions definition
>  * pointless macro definition BIT(0)

This macro was not pointless in the original code. This comment seems to
suggest so.

> 
> It also benefits the readability.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/mach-davinci/cpuidle.c |   81 +++++++++++++--------------------------
>  1 files changed, 27 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
> index f0f179c..61f4e52 100644
> --- a/arch/arm/mach-davinci/cpuidle.c
> +++ b/arch/arm/mach-davinci/cpuidle.c
> @@ -25,35 +25,46 @@
>  
>  #define DAVINCI_CPUIDLE_MAX_STATES	2
>  
> -struct davinci_ops {
> -	void (*enter) (u32 flags);
> -	void (*exit) (u32 flags);
> -	u32 flags;
> -};
> +static bool ddr2_pwdn = false;

This zero initialization is not required. In fact this throws a
checkpatch error.

> +
> +static void __iomem *ddr2_reg_base;
> +
> +static void davinci_save_ddr_power(int enter, bool pdown)
> +{
> +	u32 val;
> +
> +	val = __raw_readl(ddr2_reg_base + DDR2_SDRCR_OFFSET);
> +
> +	if (enter) {
> +		if (pdown)
> +			val |= DDR2_SRPD_BIT;
> +		else
> +			val &= ~DDR2_SRPD_BIT;
> +		val |= DDR2_LPMODEN_BIT;
> +	} else {
> +		val &= ~(DDR2_SRPD_BIT | DDR2_LPMODEN_BIT);
> +	}
> +
> +	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);

Can you please use readl/writel instead of the __raw variants. I know
this is carried from original code, but we need to git rid of it with
cleanups like this.

Thanks,
Sekhar

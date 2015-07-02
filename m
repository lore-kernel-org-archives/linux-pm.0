From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v3 3/4] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos5250
Date: Thu, 2 Jul 2015 13:15:21 +0200
Message-ID: <CABxcv==_B_e6Tm6vGG9kPPqyL97RTsHUv6oH19xd8ZkecgyA_Q@mail.gmail.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
 <1435756238-845-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435756238-845-4-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-clk@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 1, 2015 at 3:10 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> The new CPU clock type allows the use of generic CPUfreq driver.
> Switch Exynos5250 to using generic cpufreq driver.
>
> Changes by Bartlomiej:
> - split Exynos5250 support from the original patch
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 5f8ddcd..4015ec3 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -226,6 +226,7 @@ static void __init exynos_init_irq(void)
>
>  static const struct of_device_id exynos_cpufreq_matches[] = {
>         { .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
> +       { .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
>         { /* sentinel */ }
>  };

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

and on an Exynos5250 Snow Chromebook:

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier

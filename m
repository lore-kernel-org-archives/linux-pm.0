From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 4/7] mfd: intel_soc_pmic_bxtwc: remove second level
 irq for gpio device
Date: Wed, 12 Apr 2017 12:46:07 +0100
Message-ID: <20170412114607.siidnbxlaivdmxur@dell>
References: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <50fd2e28a661a0b62f7d270a511a354d56d19bda.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50fd2e28a661a0b62f7d270a511a354d56d19bda.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, andy@infradead.org, hdegoede@redhat.com, linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Apr 2017, sathyanarayanan.kuppuswamy@linux.intel.com wrote:

> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently all PMIC GPIO domain irqs are consumed by the same
> device(bxt_wcove_gpio), so there is no need to export them as
> separate interrupts. We can just export only the first level
> GPIO irq(BXTWC_GPIO_LVL1_IRQ) as an irq resource and let the
> GPIO device driver(bxt_wcove_gpio) handle the GPIO sub domain
> irqs based on status value of GPIO level2 interrupt status
> register. Also, just using only the first level irq will eliminate
> the bug involved in requesting only the second level irq and not
> explicitly enable the first level irq. For more info on this
> issue please read the details at,
> 
> https://lkml.org/lkml/2017/2/27/148
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index c08d514..dc8af1d 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -88,8 +88,6 @@ enum bxtwc_irqs_level2 {
>  	BXTWC_USBC_IRQ,
>  	BXTWC_CHGR0_IRQ,
>  	BXTWC_CHGR1_IRQ,
> -	BXTWC_GPIO0_IRQ,
> -	BXTWC_GPIO1_IRQ,
>  	BXTWC_CRIT_IRQ,
>  };
>  
> @@ -115,8 +113,6 @@ static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
>  	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 2, BIT(5)),
>  	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 2, 0x1f),
>  	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 3, 0x1f),
> -	REGMAP_IRQ_REG(BXTWC_GPIO0_IRQ, 4, 0xff),
> -	REGMAP_IRQ_REG(BXTWC_GPIO1_IRQ, 5, 0x3f),
>  	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 6, 0x03),
>  };
>  
> @@ -152,8 +148,7 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
>  };
>  
>  static struct resource gpio_resources[] = {
> -	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO0_IRQ, "GPIO0"),
> -	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO1_IRQ, "GPIO1"),
> +	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO_LVL1_IRQ, "GPIO"),
>  };
>  
>  static struct resource adc_resources[] = {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

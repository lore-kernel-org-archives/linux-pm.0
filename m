From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 2/7] mfd: intel_soc_pmic_bxtwc: remove thermal second
 level irqs
Date: Wed, 12 Apr 2017 12:45:40 +0100
Message-ID: <20170412114540.5voh5jh53a2ibzek@dell>
References: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5258b3f76edfad70a9c9141c29144b34677c8398.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5258b3f76edfad70a9c9141c29144b34677c8398.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, andy@infradead.org, hdegoede@redhat.com, linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Apr 2017, sathyanarayanan.kuppuswamy@linux.intel.com wrote:

> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Since all second level thermal irqs are consumed by the same
> device(bxt_wcove_thermal), there is no need to expose them as separate
> interrupts. We can just export only the first level irqs for thermal and
> let the device(bxt_wcove_thermal) driver handle the second level irqs
> based on thermal interrupt status register. Also, just using only the
> first level irq will eliminate the bug involved in requesting only the
> second level irq and not explicitly enable the first level irq. For
> more info on this issue please read the details at,
> 
> https://lkml.org/lkml/2017/2/27/148
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index bb18e20..c08d514 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -83,10 +83,7 @@ enum bxtwc_irqs {
>  
>  enum bxtwc_irqs_level2 {
>  	/* Level 2 */
> -	BXTWC_THRM0_IRQ = 0,
> -	BXTWC_THRM1_IRQ,
> -	BXTWC_THRM2_IRQ,
> -	BXTWC_BCU_IRQ,
> +	BXTWC_BCU_IRQ = 0,
>  	BXTWC_ADC_IRQ,
>  	BXTWC_USBC_IRQ,
>  	BXTWC_CHGR0_IRQ,
> @@ -113,17 +110,14 @@ static const struct regmap_irq bxtwc_regmap_irqs[] = {
>  };
>  
>  static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
> -	REGMAP_IRQ_REG(BXTWC_THRM0_IRQ, 0, 0xff),
> -	REGMAP_IRQ_REG(BXTWC_THRM1_IRQ, 1, 0xbf),
> -	REGMAP_IRQ_REG(BXTWC_THRM2_IRQ, 2, 0xff),
> -	REGMAP_IRQ_REG(BXTWC_BCU_IRQ, 3, 0x1f),
> -	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 4, 0xff),
> -	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 5, BIT(5)),
> -	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 5, 0x1f),
> -	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 6, 0x1f),
> -	REGMAP_IRQ_REG(BXTWC_GPIO0_IRQ, 7, 0xff),
> -	REGMAP_IRQ_REG(BXTWC_GPIO1_IRQ, 8, 0x3f),
> -	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 9, 0x03),
> +	REGMAP_IRQ_REG(BXTWC_BCU_IRQ, 0, 0x1f),
> +	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 1, 0xff),
> +	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 2, BIT(5)),
> +	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 2, 0x1f),
> +	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 3, 0x1f),
> +	REGMAP_IRQ_REG(BXTWC_GPIO0_IRQ, 4, 0xff),
> +	REGMAP_IRQ_REG(BXTWC_GPIO1_IRQ, 5, 0x3f),
> +	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 6, 0x03),
>  };
>  
>  static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> @@ -141,8 +135,8 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
>  
>  static struct regmap_irq_chip bxtwc_regmap_irq_chip_level2 = {
>  	.name = "bxtwc_irq_chip_level2",
> -	.status_base = BXTWC_THRM0IRQ,
> -	.mask_base = BXTWC_MTHRM0IRQ,
> +	.status_base = BXTWC_BCUIRQ,
> +	.mask_base = BXTWC_MBCUIRQ,
>  	.irqs = bxtwc_regmap_irqs_level2,
>  	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_level2),
>  	.num_regs = 10,
> @@ -176,9 +170,7 @@ static struct resource charger_resources[] = {
>  };
>  
>  static struct resource thermal_resources[] = {
> -	DEFINE_RES_IRQ(BXTWC_THRM0_IRQ),
> -	DEFINE_RES_IRQ(BXTWC_THRM1_IRQ),
> -	DEFINE_RES_IRQ(BXTWC_THRM2_IRQ),
> +	DEFINE_RES_IRQ(BXTWC_THRM_LVL1_IRQ),
>  };
>  
>  static struct resource bcu_resources[] = {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

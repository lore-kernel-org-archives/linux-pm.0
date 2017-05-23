From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 3/8] thermal: intel_bxt_pmic_thermal: use first level
 PMIC thermal irq
Date: Tue, 23 May 2017 14:24:12 +0800
Message-ID: <1495520652.2303.0.camel@intel.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <fda73b083e5e67e8fcc9fc2d01a590f689a06c91.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <fda73b083e5e67e8fcc9fc2d01a590f689a06c91.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com, gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-04-14 at 16:25 -0700,
sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.in
> tel.com>
> 
> PMIC mfd driver only exports first level irq for thermal device.
> But currently we are reading the irqs from the second level irq
> chip, So this patch fixes this issue by adding support to use
> first level PMIC thermal irq.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

-rui
> ---
>  drivers/thermal/intel_bxt_pmic_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Changes since v1:
>  * None
> 
> diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c
> b/drivers/thermal/intel_bxt_pmic_thermal.c
> index 0f19a39..ef6b322 100644
> --- a/drivers/thermal/intel_bxt_pmic_thermal.c
> +++ b/drivers/thermal/intel_bxt_pmic_thermal.c
> @@ -241,7 +241,7 @@ static int pmic_thermal_probe(struct
> platform_device *pdev)
>  	}
>  
>  	regmap = pmic->regmap;
> -	regmap_irq_chip = pmic->irq_chip_data_level2;
> +	regmap_irq_chip = pmic->irq_chip_data;
>  
>  	pmic_irq_count = 0;
>  	while ((irq = platform_get_irq(pdev, pmic_irq_count)) !=
> -ENXIO) {

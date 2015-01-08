From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/3] mfd/axp20x: add support for fuel gauge cell driver
Date: Wed, 7 Jan 2015 17:05:00 -0800
Message-ID: <20150107170500.321d0e8f@ultegra>
References: <20150107212552.GC3440@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150107212552.GC3440-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 7 Jan 2015 13:25:52 -0800
Todd E Brandt <todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> mfd/axp20x: add support for fuel gauge cell
> 
Acked-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Register definitions and platform data structure 
> for fuel gauge cell devices.
> 
> Signed-off-by: Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ----
>  include/linux/mfd/axp20x.h | 43
> +++++++++++++++++++++++++++++++++++++++++-- 1 file changed, 41
> insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 81589d1..dfabd6d 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -124,10 +124,27 @@ enum {
>  #define AXP288_PMIC_ADC_H               0x56
>  #define AXP288_PMIC_ADC_L               0x57
>  #define AXP288_ADC_TS_PIN_CTRL          0x84
> -
>  #define AXP288_PMIC_ADC_EN              0x84
> -#define AXP288_FG_TUNE5			0xed
>  
> +/* Fuel Gauge */
> +#define AXP288_FG_RDC1_REG          0xba
> +#define AXP288_FG_RDC0_REG          0xbb
> +#define AXP288_FG_OCVH_REG          0xbc
> +#define AXP288_FG_OCVL_REG          0xbd
> +#define AXP288_FG_OCV_CURVE_REG     0xc0
> +#define AXP288_FG_DES_CAP1_REG      0xe0
> +#define AXP288_FG_DES_CAP0_REG      0xe1
> +#define AXP288_FG_CC_MTR1_REG       0xe2
> +#define AXP288_FG_CC_MTR0_REG       0xe3
> +#define AXP288_FG_OCV_CAP_REG       0xe4
> +#define AXP288_FG_CC_CAP_REG        0xe5
> +#define AXP288_FG_LOW_CAP_REG       0xe6
> +#define AXP288_FG_TUNE0             0xe8
> +#define AXP288_FG_TUNE1             0xe9
> +#define AXP288_FG_TUNE2             0xea
> +#define AXP288_FG_TUNE3             0xeb
> +#define AXP288_FG_TUNE4             0xec
> +#define AXP288_FG_TUNE5             0xed
>  
>  /* Regulators IDs */
>  enum {
> @@ -236,4 +253,26 @@ struct axp20x_dev {
>  	const struct regmap_irq_chip	*regmap_irq_chip;
>  };
>  
> +#define BATTID_LEN				64
> +#define OCV_CURVE_SIZE			32
> +#define MAX_THERM_CURVE_SIZE	25
> +#define PD_DEF_MIN_TEMP			0
> +#define PD_DEF_MAX_TEMP			55
> +
> +struct axp20x_fg_pdata {
> +	char battid[BATTID_LEN + 1];
> +	int design_cap;
> +	int min_volt;
> +	int max_volt;
> +	int max_temp;
> +	int min_temp;
> +	int cap1;
> +	int cap0;
> +	int rdc1;
> +	int rdc0;
> +	int ocv_curve[OCV_CURVE_SIZE];
> +	int tcsz;
> +	int thermistor_curve[MAX_THERM_CURVE_SIZE][2];
> +};
> +
>  #endif /* __LINUX_MFD_AXP20X_H */

[Jacob Pan]

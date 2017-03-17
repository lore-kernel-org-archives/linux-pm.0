From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/15] mfd: Add Cherry Trail Whiskey Cove PMIC driver
Date: Fri, 17 Mar 2017 19:00:46 +0200
Message-ID: <1489770046.19767.66.camel@linux.intel.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
         <20170317095527.10487-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
> Add mfd driver for Intel CHT Whiskey Cove PMIC, based on various non
> upstreamed CHT Whiskey Cove PMIC patches.
> 
> This is a somewhat minimal version which adds irqchip support and
> cells
> for: ACPI PMIC opregion support, the i2c-controller driving the
> external
> charger irc and the pwrsrc/extcon block.
> 
> Further cells can be added in the future if/when drivers are
> upstreamed
> for them.

Couple of minor comments, otherwise looks good to me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +/* Whiskey Cove PMIC share same ACPI ID between different platforms
> */
> +#define CHT_WC_HRV		3
> +
> +/* Level 1 IRQs (level 2 IRQs are handled in the child device
> drivers) */
> +enum {
> +	CHT_WC_PWRSRC_IRQ = 0,
> +	CHT_WC_THRM_IRQ,
> +	CHT_WC_BCU_IRQ,
> +	CHT_WC_ADC_IRQ,
> +	CHT_WC_EXT_CHGR_IRQ,
> +	CHT_WC_GPIO_IRQ,
> +	/* There is no irq 6 */
> +	CHT_WC_CRIT_IRQ = 7,

I would prefer explicit over implicit (adding = N to each line), but
this is minor.

> +};

> +	pmic->regmap = devm_regmap_init(dev, NULL, client,
> &cht_wc_regmap_cfg);
> +	if (IS_ERR(pmic->regmap))
> +		return PTR_ERR(pmic->regmap);
> +
> +	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, pmic->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED, 0,
> +				       &cht_wc_regmap_irq_chip,
> +				       &pmic->irq_chip_data);
> +	if (ret)
> +		return ret;
> +


> +	return devm_mfd_add_devices(dev, -1, cht_wc_dev,
> ARRAY_SIZE(cht_wc_dev),
> +			NULL, 0, regmap_irq_get_domain(pmic-
> >irq_chip_data));

PLATFORM_DEVID_NONE, please.

> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

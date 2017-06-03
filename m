From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 7/8] mfd: intel_soc_pmic_bxtwc: Use chained irqs for
 second level irq chips
Date: Sat, 3 Jun 2017 16:26:08 +0300
Message-ID: <CAHp75Vcut2ohV3cY7syW=CZMiACeR0ZvNx_Cs+3YFK1cE_pGFA@mail.gmail.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170531070225.bymdhhpclidwwtpt@dell> <bb0ef9dac8b2c0275369da87059fd8c708f2c46c.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <bb0ef9dac8b2c0275369da87059fd8c708f2c46c.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 1, 2017 at 1:37 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Whishkey cove PMIC has support to mask/unmask interrupts at two levels.
> At first level we can mask/unmask interrupt domains like TMU, GPIO, ADC,
> CHGR, BCU THERMAL and PWRBTN and at second level, it provides facility
> to mask/unmask individual interrupts belong each of this domain. For
> example, in case of TMU, at first level we have TMU interrupt domain,
> and at second level we have two interrupts, wake alarm, system alarm that
> belong to the TMU interrupt domain.
>
> Currently, in this driver all first level irqs are registered as part of
> irq chip(bxtwc_regmap_irq_chip). By default, after you register the irq
> chip from your driver, all irqs in that chip will masked and can only be
> enabled if that irq is requested using request_irq call. This is the
> default Linux irq behavior model. And whenever a dependent device that
> belongs to PMIC requests only the second level irq and not explicitly
> unmask the first level irq, then in essence the second level irq will
> still be disabled. For example, if TMU device driver request wake_alarm
> irq and not explicitly unmask TMU level 1 irq then according to the default
> Linux irq model,  wake_alarm irq will still be disabled. So the proper
> solution to fix this issue is to use the chained irq chip concept. We
> should chain all the second level chip irqs to the corresponding first
> level irq. To do this, we need to create separate irq chips for every
> group of second level irqs.
>
> In case of TMU, when adding second level irq chip, instead of using pmic
> irq we should use the corresponding first level irq. So the following
> code will change from

pmic -> PMIC
irq -> IRQ
irqs -> IRQs

These do apply to entire commit message.

>
> ret = regmap_add_irq_chip(pmic->regmap, pmic->irq, ...)
>
> to,
>
> virq = regmap_irq_get_virq(&pmic->irq_chip_data, BXTWC_TMU_LVL1_IRQ);
>
> ret = regmap_add_irq_chip(pmic->regmap, virq, ...)
>
> In case of typec wcove driver, Since USBC IRQ is moved under charger level2
> irq chip. We should use charger irq chip(irq_chip_data_chgr) to get the USBC
> virtual IRQ number.

typec wcove -> Whiskey Cove Type-C

> +enum bxtwc_irqs_tmu {
> +       BXTWC_TMU_IRQ = 0,
> +};

> -enum bxtwc_irqs_tmu {
> -       BXTWC_TMU_IRQ = 0,

Leave it on the same place it will make patch a bit more cleaner.

> +static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> +       REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
> +};

> -static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> -       REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),

Ditto.

> +static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
> +                               struct regmap_irq_chip_data *pdata,
> +                               int pirq, int irq_flags,
> +                               const struct regmap_irq_chip *chip,
> +                               struct regmap_irq_chip_data **data)
> +{
> +       int irq;
> +
> +       irq = regmap_irq_get_virq(pdata, pirq);
> +       if (irq < 0) {
> +               dev_err(pmic->dev, "failed to get virtual interrupt:%d\n", irq);

Follow below pattern, i.e. "Failed to ..."

Moreover, it would be useful to see for which interrupt we are trying
to get a virtual one.
chip->name + pirq I guess would give us a thing.

> +               return irq;
> +       }
> +
> +       return devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq, irq_flags,
> +                                       0, chip, data);
> +}

-- 
With Best Regards,
Andy Shevchenko

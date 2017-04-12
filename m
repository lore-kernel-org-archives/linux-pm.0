From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 1/7] mfd: intel_soc_pmic_bxtwc: fix TMU interrupt index
Date: Wed, 12 Apr 2017 21:59:54 +0100
Message-ID: <20170412205954.yl2dsgpbev7ovyfs@dell>
References: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170412104551.g2xkpihz2n2hju4m@dell>
 <CAENHMvO7KYFcEvGeCnA9bBYC3qTn7o8f1B6-maS5Z6n_d1Z=DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAENHMvO7KYFcEvGeCnA9bBYC3qTn7o8f1B6-maS5Z6n_d1Z=DQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, Andy Shevchenko <andy@infradead.org>, Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Apr 2017, Sathyanarayanan Kuppuswamy Natarajan wrote:

> Hi Lee,
> 
> Thanks. Will remove the code segment in next version.

Please always reply inline.  Top posting is frowned upon.

> On Wed, Apr 12, 2017 at 3:45 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 10 Apr 2017, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> >
> >> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>
> >> TMU interrupts are registered as a separate interrupt chip, and
> >> hence it should start its interrupt index(BXTWC_TMU_IRQ) number
> >> from 0. But currently, BXTWC_TMU_IRQ is defined as part of enum
> >> bxtwc_irqs_level2 and its index value is 11. Since this index
> >> value is used when calculating .num_irqs of regmap_irq_chip_tmu,
> >> it incorrectly reports number of irqs as 12 instead of actual
> >> value of 1.
> >>
> >> static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> >>       REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
> >> };
> >>
> >> static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
> >>       .name = "bxtwc_irq_chip_tmu",
> >>       .status_base = BXTWC_TMUIRQ,
> >>       .mask_base = BXTWC_MTMUIRQ,
> >>       .irqs = bxtwc_regmap_irqs_tmu,
> >>       .num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_tmu),
> >>       .num_regs = 1,
> >> };
> >>
> >> This patch fixes this issue by creating new enum of tmu irqs and
> >> resetting its starting index to 0.
> >>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> ---
> >>  drivers/mfd/intel_soc_pmic_bxtwc.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > Patch looks fine, but please remove the code segment from the commit
> > log.
> >
> > For the code:
> >
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> >
> >> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> >> index 699c8c7..bb18e20 100644
> >> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> >> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> >> @@ -94,7 +94,10 @@ enum bxtwc_irqs_level2 {
> >>       BXTWC_GPIO0_IRQ,
> >>       BXTWC_GPIO1_IRQ,
> >>       BXTWC_CRIT_IRQ,
> >> -     BXTWC_TMU_IRQ,
> >> +};
> >> +
> >> +enum bxtwc_irqs_tmu {
> >> +     BXTWC_TMU_IRQ = 0,
> >>  };
> >>
> >>  static const struct regmap_irq bxtwc_regmap_irqs[] = {
> >
> 
> 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

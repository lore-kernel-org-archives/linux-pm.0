From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/8] thermal: intel_bxt_pmic_thermal: use first level
 PMIC thermal irq
Date: Tue, 23 May 2017 08:26:15 +0100
Message-ID: <20170523072615.r4widzjc6apwxpwb@dell>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <fda73b083e5e67e8fcc9fc2d01a590f689a06c91.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <1495520652.2303.0.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1495520652.2303.0.camel@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, andy@infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 23 May 2017, Zhang Rui wrote:

> On Fri, 2017-04-14 at 16:25 -0700,
> sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.in
> > tel.com>
> > 
> > PMIC mfd driver only exports first level irq for thermal device.
> > But currently we are reading the irqs from the second level irq
> > chip, So this patch fixes this issue by adding support to use
> > first level PMIC thermal irq.
> > 
> > Signed-off-by: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Acked-by: Zhang Rui <rui.zhang@intel.com>

I think this is the last Ack.

Please collect them all and re-submit the set so I can pick it up.

> > ---
> >  drivers/thermal/intel_bxt_pmic_thermal.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Changes since v1:
> >  * None
> > 
> > diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c
> > b/drivers/thermal/intel_bxt_pmic_thermal.c
> > index 0f19a39..ef6b322 100644
> > --- a/drivers/thermal/intel_bxt_pmic_thermal.c
> > +++ b/drivers/thermal/intel_bxt_pmic_thermal.c
> > @@ -241,7 +241,7 @@ static int pmic_thermal_probe(struct
> > platform_device *pdev)
> >  	}
> >  
> >  	regmap = pmic->regmap;
> > -	regmap_irq_chip = pmic->irq_chip_data_level2;
> > +	regmap_irq_chip = pmic->irq_chip_data;
> >  
> >  	pmic_irq_count = 0;
> >  	while ((irq = platform_get_irq(pdev, pmic_irq_count)) !=
> > -ENXIO) {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

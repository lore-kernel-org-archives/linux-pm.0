From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: axp20x: Add AXP288 volatile registers.
Date: Tue, 17 Jan 2017 14:58:53 +0000
Message-ID: <20170117145853.GB3718@dell>
References: <20170111194941.5425-1-oss@c-mauderer.de>
 <20170113140156.GE6864@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170113140156.GE6864@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Mauderer <oss@c-mauderer.de>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Jan 2017, Lee Jones wrote:

> On Wed, 11 Jan 2017, Christian Mauderer wrote:
> 
> > The axp288_fuelgauge driver and some other axp288_xxx are using a number
> > of the registers of the chip that are changed by hardware (for example
> > charge level). Because these registers are not marked as "volatile" in
> > the regmap, a cached version is used instead of the correct register
> > value. In case of the axp288_fuelgauge that leads to a battery level
> > that only changes on reboot. This patch adds the volatile registers of
> > the chip.
> > 
> > Signed-off-by: Christian Mauderer <oss@c-mauderer.de>
> > ---
> >  drivers/mfd/axp20x.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Applied, thanks.

Change of plan.  This patch does not apply.

Please rebase it on top of the MFD tree.

> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index ed918de84238..d74b3daca23f 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -118,7 +118,10 @@ static const struct regmap_range axp288_writeable_ranges[] = {
> >  };
> >  
> >  static const struct regmap_range axp288_volatile_ranges[] = {
> > +	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
> >  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
> > +	regmap_reg_range(AXP20X_CC_CTRL, AXP288_FG_OCVL_REG),
> > +	regmap_reg_range(AXP288_FG_DES_CAP1_REG, AXP288_FG_CC_CAP_REG),
> >  };
> >  
> >  static const struct regmap_access_table axp288_writeable_table = {
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

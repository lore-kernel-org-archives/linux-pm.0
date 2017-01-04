From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 15/22] mfd: axp20x: add CHRG_CTRL1 to writeable regs for
 AXP20X/AXP22X
Date: Wed, 4 Jan 2017 11:57:16 +0000
Message-ID: <20170104115716.GE24058@dell>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-16-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102163723.7939-16-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz, bonbons@linux-vserver.org
List-Id: linux-pm@vger.kernel.org

On Mon, 02 Jan 2017, Quentin Schulz wrote:

> The CHR_CTRL1 register is made of 7 read-write bits with one being used
> to set the target voltage for battery charging.
> 
> This adds the CHRG_CTRL1 register to the list of writeable registers for
> AXP20X and AXP22X PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 2 ++
>  1 file changed, 2 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 65c57d0..19bdba3 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -66,6 +66,7 @@ static const struct regmap_access_table axp152_volatile_table = {
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>  	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>  };
> @@ -94,6 +95,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
>  static const struct regmap_range axp22x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

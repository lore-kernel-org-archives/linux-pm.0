From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 16/22] mfd: axp20x: add V_OFF to writeable regs for
 AXP20X and AXP22X
Date: Wed, 4 Jan 2017 11:57:31 +0000
Message-ID: <20170104115731.GF24058@dell>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-17-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102163723.7939-17-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz, bonbons@linux-vserver.org
List-Id: linux-pm@vger.kernel.org

On Mon, 02 Jan 2017, Quentin Schulz wrote:

> The V_OFF register has its first 3 read-write bits for the minimal
> voltage (Voff) of the battery before the system is automatically shut
> down due to the power being too low.
> 
> This adds V_OFF register to the writeable registers of AXP20X and AXP22X
> PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 19bdba3..7f0f05f 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -65,7 +65,7 @@ static const struct regmap_access_table axp152_volatile_table = {
>  
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> -	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_V_OFF),
>  	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>  	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
> @@ -94,7 +94,7 @@ static const struct regmap_access_table axp20x_volatile_table = {
>  /* AXP22x ranges are shared with the AXP809, as they cover the same range */
>  static const struct regmap_range axp22x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> -	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
> +	regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_V_OFF),
>  	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL1),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

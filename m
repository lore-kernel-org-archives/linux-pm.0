From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: fix 64-bit build
 warning
Date: Thu, 12 Jan 2017 16:53:55 +0100
Message-ID: <20170112165355.2c1ced68@kitsune.suse.cz>
References: <20170111145211.746189-1-arnd@arndb.de>
        <20170112025824.ifplt45l3syibjda@earth>
        <2151755.ZC9SDDZNPX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2151755.ZC9SDDZNPX@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Thu, 12 Jan 2017 09:32:26 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday, January 12, 2017 3:58:24 AM CET Sebastian Reichel wrote:
> > Hi Arnd,
> > 
> > On Wed, Jan 11, 2017 at 03:51:55PM +0100, Arnd Bergmann wrote:  
> > > Casting a pointer to 'int' is not always valid:
> > > 
> > > drivers/power/supply/axp20x_usb_power.c: In function
> > > 'axp20x_usb_power_probe':
> > > drivers/power/supply/axp20x_usb_power.c:297:21: error: cast from
> > > pointer to integer of different size [-Werror=pointer-to-int-cast]
> > > 
> > > This makes the code use uintptr_t explicitly.
> > > 
> > > Fixes: 0dcc70ca8644 ("power: supply: axp20x_usb_power: use
> > > of_device_id data field instead of device_is_compatible")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> > 
> > I queued Michal's patch instead:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=15df6d98ec3b40775918fc6ef73d7f1c2d0cf870  
> 
> Hmm, that doesn't look right: You can't really rely on an 'enum' type
> to have a specific size, especially not the same size as a pointer,
> in portable code.
> 
> IIRC on many architectures it defaults to 'int' rather than 'long',
> and it might also be 'short' on architectures that default to enums
> being the smallest integer type that fits.

Technically to fit the pointer into an integer you should be using
uintptr_t or unsigned long. However, gcc does not issue a warning when
casting to enum either. The reason might possibly be that when casting
to an enum you make it clear that you are expecting one of the values
that are part of the enumeration and the value should fit into the enum
even if its actual size is char.

Either way handling of casts from the match pointer to integer varies
between drivers and some that are possibly never built on 64bit even use
int.

drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:
adv7511->type = (enum adv7511_type)of_device_get_match_data(dev);
drivers/i2c/busses/i2c-rcar.c:	priv->devtype = (enum
rcar_i2c_type)of_device_get_match_data(dev);
drivers/net/ethernet/renesas/ravb_main.c:	chip_id = (enum
ravb_chip_id)of_device_get_match_data(&pdev->dev);
drivers/pci/host/pci-imx6.c:		(enum
imx6_pcie_variants)of_device_get_match_data(dev);
drivers/reset/hisilicon/hi6220_reset.c:	type = (enum
hi6220_reset_ctrl_type)of_device_get_match_data(dev);
drivers/usb/phy/phy-msm-usb.c:	pdata->phy_type = (enum
msm_usb_phy_type)of_device_get_match_data(&pdev->dev);

drivers/firmware/qcom_scm.c:	clks = (unsigned
long)of_device_get_match_data(&pdev->dev);
drivers/gpu/drm/exynos/exynos5433_drm_decon.c:	ctx->out_type =
(unsigned long)of_device_get_match_data(dev);
drivers/pinctrl/sunxi/pinctrl-sun5i.c:	unsigned long variant =
(unsigned long)of_device_get_match_data(&pdev->dev);
drivers/spi/spi-sun6i.c:	sspi->fifo_depth = (unsigned
long)of_device_get_match_data(&pdev->dev);
drivers/thermal/rcar_thermal.c:#define rcar_of_data(dev)
((unsigned long)of_device_get_match_data(dev))
sound/soc/sh/rcar/core.c:	priv->flags	= (unsigned
long)of_device_get_match_data(dev);

drivers/spi/spi-mpc512x-psc.c:	mps->type =
(int)of_device_get_match_data(dev);
drivers/leds/leds-pm8058.c:	led->ledtype =
(u32)of_device_get_match_data(&pdev->dev);


So what is the preferred way to do the cast to be portable across Linux
architectures?

Thanks

Michal

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v9 3/4] ARM: dts: rockchip: add syscon-reboot-mode DT node
Date: Mon, 20 Jun 2016 14:55:46 -0700
Message-ID: <20160620215545.GE1256@tuxbot>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
 <1466404769-3534-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466404769-3534-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, k.kozlowski@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at
List-Id: linux-pm@vger.kernel.org

On Sun 19 Jun 23:39 PDT 2016, Andy Yan wrote:

> Rockchip platform use a SYSCON mapped register store
> the reboot mode magic value for bootloader to use when
> system reboot. So add syscon-reboot-mode driver DT node
> for rk3xxx/rk3036/rk3288 based platform
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
[..]
> diff --git a/include/dt-bindings/soc/rockchip_boot-mode.h b/include/dt-bindings/soc/rockchip_boot-mode.h
> new file mode 100644
> index 0000000..ae7c867
> --- /dev/null
> +++ b/include/dt-bindings/soc/rockchip_boot-mode.h
> @@ -0,0 +1,15 @@
> +#ifndef __ROCKCHIP_BOOT_MODE_H
> +#define __ROCKCHIP_BOOT_MODE_H
> +
> +/*high 24 bits is tag, low 8 bits is type*/
> +#define REBOOT_FLAG		0x5242C300
> +/* normal boot */
> +#define BOOT_NORMAL		(REBOOT_FLAG + 0)
> +/* enter bootloader rockusb mode */
> +#define BOOT_BL_DOWNLOAD	(REBOOT_FLAG + 1)
> +/* enter recovery */
> +#define BOOT_RECOVERY		(REBOOT_FLAG + 3)
> + /* enter fastboot mode */
> +#define BOOT_FASTBOOT		(REBOOT_FLAG + 9)

The names of these defines are too generic for being in a header file.
You should likely make them include "ROCKCHIP" and "BOOT_MODE".

Regards,
Bjorn

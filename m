From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] thermal: imx: add NVMEM dependency
Date: Tue, 19 Sep 2017 13:53:14 +0300
Message-ID: <1505818394.29684.13.camel@nxp.com>
References: <20170918204825.159177-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:37275
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751205AbdISKxT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Sep 2017 06:53:19 -0400
In-Reply-To: <20170918204825.159177-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-09-18 at 22:48 +0200, Arnd Bergmann wrote:
> The driver now fails to link into vmlinux when CONFIG_NVMEM is a loadable
> module:
> 
> drivers/thermal/imx_thermal.o: In function `imx_thermal_probe':
> imx_thermal.c:(.text+0x360): undefined reference to
> `nvmem_cell_read_u32'
> imx_thermal.c:(.text+0x360): relocation truncated to fit:
> R_AARCH64_CALL26 against undefined symbol `nvmem_cell_read_u32'
> imx_thermal.c:(.text+0x388): undefined reference to
> `nvmem_cell_read_u32'
> imx_thermal.c:(.text+0x388): relocation truncated to fit:
> R_AARCH64_CALL26 against undefined symbol `nvmem_cell_read_u32'
> 
> This adds a Kconfig dependency to force it to be a module as well
> when its dependency is loadable.

This must be a very strange config with NVMEM=m and IMX_THERMAL=y on
arm64. Still, it makes sense that it should work at least at the
Kconfig level.

> Fixes: 7fe5ba04fcdc ("thermal: imx: Add support for reading OCOTP through nvmem")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>

> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 07002df4f83a..cb14f1ec5953 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -206,6 +206,7 @@ config HISI_THERMAL
>  config IMX_THERMAL
>  	tristate "Temperature sensor driver for Freescale i.MX SoCs"
>  	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
> +	depends on NVMEM || !NVMEM

The || !NVMEM part is so that it also works when NVMEM=n, right?

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v2 2/3] phy: core: Drop unused runtime PM APIs
Date: Thu, 21 Dec 2017 10:33:31 +0000
Message-ID: <TY1PR06MB0992E87FAA770B745DCBA690D80D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
 <1513778960-10073-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513778960-10073-3-git-send-email-ulf.hansson@linaro.org>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf-san,

> -----Original Message-----
> From: Ulf Hansson, Sent: Wednesday, December 20, 2017 11:09 PM
<snip>
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index b4298a1..050b620 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -17,7 +17,6 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/device.h>
> -#include <linux/pm_runtime.h>

After I applied this patch, some ata and gpu drivers causes build error [1]=
.
So, we should fix the drivers at first...

Best regards,
Yoshihiro Shimoda
---
[1]
drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_resume':
drivers/ata/ahci_qoriq.c:318:2: error: implicit declaration of function 'pm=
_runtime_disable' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_disable(dev);
  ^
drivers/ata/ahci_qoriq.c:319:2: error: implicit declaration of function 'pm=
_runtime_set_active' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_set_active(dev);
  ^
drivers/ata/ahci_qoriq.c:320:2: error: implicit declaration of function 'pm=
_runtime_enable' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_enable(dev);
  ^
drivers/ata/ahci.c: In function 'ahci_init_one':
drivers/ata/ahci.c:1761:2: error: implicit declaration of function 'pm_runt=
ime_put_noidle' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_put_noidle(&pdev->dev);
  ^
drivers/ata/ahci.c: In function 'ahci_remove_one':
drivers/ata/ahci.c:1767:2: error: implicit declaration of function 'pm_runt=
ime_get_noresume' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_get_noresume(&pdev->dev);
  ^
drivers/ata/libahci.c: In function 'ahci_rpm_get_port':
drivers/ata/libahci.c:239:9: error: implicit declaration of function 'pm_ru=
ntime_get_sync' [-Werror=3Dimplicit-function-declaration]
  return pm_runtime_get_sync(ap->dev);
         ^
drivers/ata/libahci.c: In function 'ahci_rpm_put_port':
drivers/ata/libahci.c:251:2: error: implicit declaration of function 'pm_ru=
ntime_put' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_put(ap->dev);
  ^
drivers/ata/ahci_ceva.c: In function 'ceva_ahci_resume':
drivers/ata/ahci_ceva.c:326:2: error: implicit declaration of function 'pm_=
runtime_disable' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_disable(dev);
  ^
drivers/ata/ahci_ceva.c:327:2: error: implicit declaration of function 'pm_=
runtime_set_active' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_set_active(dev);
  ^
drivers/ata/ahci_ceva.c:328:2: error: implicit declaration of function 'pm_=
runtime_enable' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_enable(dev);
  ^
cc1: some warnings being treated as errors
make[2]: *** [drivers/ata/ahci_qoriq.o] Error 1
make[2]: *** Waiting for unfinished jobs....
cc1: some warnings being treated as errors
make[2]: *** [drivers/ata/ahci_ceva.o] Error 1
cc1: some warnings being treated as errors
make[2]: *** [drivers/ata/ahci.o] Error 1
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c: In function 'analogix_d=
p_get_modes':
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:949:3: error: implicit d=
eclaration of function 'pm_runtime_get_sync' [-Werror=3Dimplicit-function-d=
eclaration]
   pm_runtime_get_sync(dp->dev);
   ^
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:951:3: error: implicit d=
eclaration of function 'pm_runtime_put' [-Werror=3Dimplicit-function-declar=
ation]
   pm_runtime_put(dp->dev);
   ^
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c: In function 'analogix_d=
p_bridge_disable':
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1120:2: error: implicit =
declaration of function 'pm_runtime_put_sync' [-Werror=3Dimplicit-function-=
declaration]
  pm_runtime_put_sync(dp->dev);
  ^
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c: In function 'analogix_d=
p_bind':
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1387:2: error: implicit =
declaration of function 'pm_runtime_enable' [-Werror=3Dimplicit-function-de=
claration]
  pm_runtime_enable(dev);
  ^
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1431:2: error: implicit =
declaration of function 'pm_runtime_disable' [-Werror=3Dimplicit-function-d=
eclaration]
  pm_runtime_disable(dev);
  ^
drivers/gpu/drm/exynos/exynos_drm_dsi.c: In function 'exynos_dsi_enable':
drivers/gpu/drm/exynos/exynos_drm_dsi.c:1385:2: error: implicit declaration=
 of function 'pm_runtime_get_sync' [-Werror=3Dimplicit-function-declaration=
]
  pm_runtime_get_sync(dsi->dev);
  ^
drivers/gpu/drm/exynos/exynos_drm_dsi.c:1392:3: error: implicit declaration=
 of function 'pm_runtime_put_sync' [-Werror=3Dimplicit-function-declaration=
]
   pm_runtime_put_sync(dsi->dev);
   ^
drivers/gpu/drm/exynos/exynos_drm_dsi.c: In function 'exynos_dsi_probe':
drivers/gpu/drm/exynos/exynos_drm_dsi.c:1797:2: error: implicit declaration=
 of function 'pm_runtime_enable' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_enable(dev);
  ^
drivers/gpu/drm/exynos/exynos_drm_dsi.c: In function 'exynos_dsi_remove':
drivers/gpu/drm/exynos/exynos_drm_dsi.c:1808:2: error: implicit declaration=
 of function 'pm_runtime_disable' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_disable(&pdev->dev);
  ^
drivers/gpu/drm/rockchip/cdn-dp-core.c: In function 'cdn_dp_clk_enable':
drivers/gpu/drm/rockchip/cdn-dp-core.c:111:8: error: implicit declaration o=
f function 'pm_runtime_get_sync' [-Werror=3Dimplicit-function-declaration]
  ret =3D pm_runtime_get_sync(dp->dev);
        ^
drivers/gpu/drm/rockchip/cdn-dp-core.c:137:2: error: implicit declaration o=
f function 'pm_runtime_put' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_put(dp->dev);
  ^
drivers/gpu/drm/rockchip/cdn-dp-core.c: In function 'cdn_dp_clk_disable':
drivers/gpu/drm/rockchip/cdn-dp-core.c:148:2: error: implicit declaration o=
f function 'pm_runtime_put_sync' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_put_sync(dp->dev);
  ^
drivers/gpu/drm/rockchip/cdn-dp-core.c: In function 'cdn_dp_bind':
drivers/gpu/drm/rockchip/cdn-dp-core.c:1094:2: error: implicit declaration =
of function 'pm_runtime_enable' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_enable(dev);
  ^
drivers/gpu/drm/rockchip/cdn-dp-core.c: In function 'cdn_dp_unbind':
drivers/gpu/drm/rockchip/cdn-dp-core.c:1118:2: error: implicit declaration =
of function 'pm_runtime_disable' [-Werror=3Dimplicit-function-declaration]
  pm_runtime_disable(dev);
  ^
cc1: some warnings being treated as errors
make[2]: *** [drivers/ata/libahci.o] Error 1
make[1]: *** [drivers/ata] Error 2
make[1]: *** Waiting for unfinished jobs....
cc1: some warnings being treated as errors
make[5]: *** [drivers/gpu/drm/bridge/analogix/analogix_dp_core.o] Error 1
make[4]: *** [drivers/gpu/drm/bridge/analogix] Error 2
make[3]: *** [drivers/gpu/drm/bridge] Error 2
make[3]: *** Waiting for unfinished jobs....
cc1: some warnings being treated as errors
make[4]: *** [drivers/gpu/drm/exynos/exynos_drm_dsi.o] Error 1
make[3]: *** [drivers/gpu/drm/exynos] Error 2
cc1: some warnings being treated as errors
make[4]: *** [drivers/gpu/drm/rockchip/cdn-dp-core.o] Error 1
make[3]: *** [drivers/gpu/drm/rockchip] Error 2
make[2]: *** [drivers/gpu/drm] Error 2
make[1]: *** [drivers/gpu] Error 2
make: *** [drivers] Error 2

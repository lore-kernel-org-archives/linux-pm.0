From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/4] add support of SCPSYS power domain for MediaTek MT7622
Date: Tue, 8 Aug 2017 13:41:12 +0200
Message-ID: <CAPDyKFpDyhPc=T8SqWdh-mm4kOqFstHNMuRbL_qP04rynoLcsw@mail.gmail.com>
References: <cover.1502090240.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1502090240.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 7 August 2017 at 09:24,  <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
> Changes since v2:
> - reduce code duplication of scpsys_probe across all SoCs
>
> Changes since v1:
> - rebase to Linux v4.13-rc1
>
> There are four power domains on MediaTek MT7622 SoC which are respectively
> ETHSYS for Ethernet including extra embedded switch, HIF0SYS for PCI-E and
> SATA, HIF1SYS for USB and WBSYS for WIFI and Bluetooth.
>
> Those functions could be selectively powered gated when the corresponding
> function is no longer to use in order to reach more minimal power
> dissipation through the patch series introduced here.
>
> Chen Zhong (1):
>   soc: mediatek: add header files required for MT7622 SCPSYS dt-binding
>
> Sean Wang (3):
>   dt-bindings: soc: update the binding document for SCPSYS on MediaTek
>     MT7622 SoC
>   soc: mediatek: reduce code duplication of scpsys_probe across all SoCs
>   soc: mediatek: add SCPSYS power domain driver for MediaTek MT7622 SoC
>
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    |   3 +
>  drivers/soc/mediatek/mtk-scpsys.c                  | 247 ++++++++++++---------
>  include/dt-bindings/power/mt7622-power.h           |  22 ++
>  include/linux/soc/mediatek/infracfg.h              |   7 +
>  4 files changed, 179 insertions(+), 100 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt7622-power.h
>
> --
> 2.7.4
>

Looks good to me! Feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

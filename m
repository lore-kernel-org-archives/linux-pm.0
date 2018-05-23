From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 00/13] add power domain support for Rockchip Socs
Date: Wed, 23 May 2018 12:02:22 +0200
Message-ID: <CAPDyKFrMBS5-TckrB22=S-JCAooMpg+g1BgRModMWGaoBJcJLA@mail.gmail.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Caesar Wang <wxt@rock-chips.com>, xxx@rock-chips.com, Feng Xiao <xf@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On 23 May 2018 at 08:48, Elaine Zhang <zhangqing@rock-chips.com> wrote:
> add power domain support for RK3036/RK3128/RK3228/PX30 Soc.
> fix up the wrong value when set power domain up.
>
> Change in V2:
> Fix up the commit message description and Assign author.
>
> Change in V3:
> [PATCH 01/13]: The Copyright description use SPDX tag instead.
> [PATCH 05/13]: The Copyright description use SPDX tag instead.
> [PATCH 08/13]: The Copyright description use SPDX tag instead.
> [PATCH 11/13]: The Copyright description use SPDX tag instead.
>
> Caesar Wang (3):
>   dt-bindings: power: add RK3036 SoCs header for power-domain
>   dt-bindings: add binding for rk3036 power domains
>   Soc: rockchip: power-domain: add power domain support for rk3036
>
> Elaine Zhang (6):
>   dt-bindings: power: add RK3128 SoCs header for power-domain
>   dt-bindings: add binding for rk3128 power domains
>   soc: rockchip: power-domain: add power domain support for rk3128
>   dt-bindings: power: add RK3228 SoCs header for power-domain
>   dt-bindings: add binding for rk3228 power domains
>   soc: rockchip: power-domain: add power domain support for rk3228
>
> Finley Xiao (4):
>   soc: rockchip: power-domain: Fix wrong value when power up pd
>   dt-bindings: power: add PX30 SoCs header for power-domain
>   dt-bindings: add binding for px30 power domains
>   soc: rockchip: power-domain: add power domain support for px30
>
>  .../bindings/soc/rockchip/power_domain.txt         |  12 +++
>  drivers/soc/rockchip/pm_domains.c                  | 116 ++++++++++++++++++++-
>  include/dt-bindings/power/px30-power.h             |  27 +++++
>  include/dt-bindings/power/rk3036-power.h           |  13 +++
>  include/dt-bindings/power/rk3128-power.h           |  14 +++
>  include/dt-bindings/power/rk3228-power.h           |  21 ++++
>  6 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/power/px30-power.h
>  create mode 100644 include/dt-bindings/power/rk3036-power.h
>  create mode 100644 include/dt-bindings/power/rk3128-power.h
>  create mode 100644 include/dt-bindings/power/rk3228-power.h
>
> --
> 1.9.1
>
>

Seems like the changes in v3 is very small, so feel free to add, for the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

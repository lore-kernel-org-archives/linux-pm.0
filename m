From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 0/5] thermal: imx: Add nvmem-cells binding on imx6sx
Date: Mon, 17 Jul 2017 16:00:22 +0200
Message-ID: <20170717160022.6892b839@karo-electronics.de>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500041281.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, 14 Jul 2017 17:11:05 +0300 Leonard Crestez wrote:
> On imx6sx accessing OCOTP directly is wrong because the ocotp clock needs to be
> enabled first. Fix this by adding a nvmem-cells binding and using it on imx6sx,
> imx6ul and imx6ull.
> 
> The existing binding is kept around because it works fine on imx6qdl.
> 
> This was initially reported by Lothar Waßmann <LW@KARO-electronics.de> in reply
> to a patch adding imx6ul/ull support:
> 
> Link: https://lkml.org/lkml/2017/6/9/578
> 
> ---
> Changes since v1:
>  * Move nvmem_cell_read_u32 to nvmem core (Shawn Guo, Srinivas Kandagatla)
>  * Adjust binding description (Rob Herring)
>  * Adjust formatting of thermal info cells (Shawn Guo)
>  * Link: https://lkml.org/lkml/2017/7/6/426
> 
> Leonard Crestez (5):
>   thermal: imx: Add nvmem-cells alternate binding for OCOTP access
>   nvmem: core: Add nvmem_cell_read_u32
>   thermal: imx: Add support for reading OCOTP through nvmem
>   ARM: dts: imx6sx: Use nvmem-cells for tempmon
>   ARM: dts: imx6ul: Add imx6ul-tempmon
> 
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   7 ++
>  arch/arm/boot/dts/imx6sx.dtsi                      |  13 ++-
>  arch/arm/boot/dts/imx6ul.dtsi                      |  19 ++++
>  drivers/nvmem/core.c                               |  37 ++++++++
>  drivers/thermal/imx_thermal.c                      | 103 +++++++++++++++------
>  include/linux/nvmem-consumer.h                     |   8 ++
>  6 files changed, 156 insertions(+), 31 deletions(-)
> 
Works as expected on TX6UL-5010.

Tested-By: Lothar Waßmann <LW@KARO-electronics.de>


Lothar Waßmann

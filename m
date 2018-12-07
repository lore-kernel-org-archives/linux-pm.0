From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 1/4] dt-bindings: fsl: scu: add thermal binding
Date: Fri, 7 Dec 2018 17:13:23 -0600
Message-ID: <20181207231323.GA10231@bogus>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
 <1543458696-4741-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543458696-4741-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Aisheng DONG <aisheng.dong@nxp.com>, Andy Gross <andy.gross@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "arnd@arndb.de" <arnd@arndb.de>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>, "ezequiel@collabora.com" <ezequiel@collabora.com>, "olof@lixom.net" <olof@lixom.net>, bjorn.andersson@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 29 Nov 2018 02:37:24 +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *move binding doc to SCU since it is belonging to SCU;
>   *change compatile string to start with "fsl" instead of "nxp" to align with other nodes in dtb.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

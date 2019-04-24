From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V12 5/5] arm64: dts: imx: add i.MX8QXP thermal support
Date: Wed, 24 Apr 2019 16:21:04 -0500
Message-ID: <20190424212104.GA26974@bogus>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-5-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555384609-7030-5-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Daniel Baluta <daniel.baluta@nxp.com>, Peng Fan <peng.fan@nxp.com>, "heiko@sntech.de" <heiko@sntech.de>, "horms+renesas@verge.net.au" <horms+renesas@verge.ne>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Apr 2019 03:22:41 +0000, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V11:
> 	- add cooling device for all secondary CPUs.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

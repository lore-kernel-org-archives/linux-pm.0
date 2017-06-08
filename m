From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Thu, 8 Jun 2017 13:45:35 -0300
Message-ID: <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
 <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35148 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbdFHQpg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 12:45:36 -0400
In-Reply-To: <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 8, 2017 at 1:26 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:

> +                       tempmon: tempmon {
> +                               compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
> +                               interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +                               fsl,tempmon = <&anatop>;
> +                               fsl,tempmon-data = <&ocotp>;
> +                               clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;

Does the IMX6UL_CLK_PLL3_USB_OTG clock really control tempmon? Please
double check.

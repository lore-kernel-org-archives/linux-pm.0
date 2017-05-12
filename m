From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: imx6sx-sdb: Remove OPP override
Date: Fri, 12 May 2017 08:33:55 +0800
Message-ID: <20170512003354.GA8471@dragon>
References: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757083AbdELAeM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 May 2017 20:34:12 -0400
Content-Disposition: inline
In-Reply-To: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Anson Huang <Anson.Huang@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Peter Chen <peter.chen@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Henri Roosen <henri.roosen@ginzinger.com>, Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Fri, May 05, 2017 at 02:00:17PM +0300, Leonard Crestez wrote:
> The board file for imx6sx-sdb overrides cpufreq operating points to use
> higher voltages. This is done because the board has a shared rail for
> VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
> needs to be a value suitable for both ARM and SOC.
> 
> This only applies to LDO bypass mode, a feature not present in upstream.
> When LDOs are enabled the effect is to use higher voltages than necessary
> for no good reason.
> 
> Setting these higher voltages can make some boards fail to boot with ugly
> semi-random crashes reminiscent of memory corruption. These failures only
> happen on board rev. C, rev. B is reported to still work.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> CC: stable@vger.kernel.org

Applied, thanks.

From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Thu, 4 May 2017 20:50:53 +0800
Message-ID: <20170504125052.GP18578@dragon>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbdEDMvU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 08:51:20 -0400
Content-Disposition: inline
In-Reply-To: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Peter Chen <Peter.Chen@nxp.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org

On Tue, Apr 25, 2017 at 07:57:59PM +0300, Leonard Crestez wrote:
> The board file for imx6sx-dbg overrides cpufreq operating points to use

s/imx6sx-dbg/imx6sx-sdb

> higher voltages. This is done because the board has a shared rail for
> VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
> needs to be a value suitable for both ARM and SOC.
> 
> This was introduced in:
> 
> commit 54183bd7f766 ("ARM: imx6sx-sdb: add revb board and make it default")
> 
> This only only applies to LDO bypass mode, a feature not present in

s/only only/only

> upstream. When LDOs are enabled the effect is to use higher voltages than
> necesarry for no good reason.
> 
> Setting these higher voltages can make some boards fail to boot with ugly

Please make it clear it's RevC board.

> semi-random crashes, reminiscent of memory corruption. These failures
> happen the first time the lowest idle state is used. Remove the OPP
> override in order to fix those crashes.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Please add tags for Fixes and Cc stable.

Shawn

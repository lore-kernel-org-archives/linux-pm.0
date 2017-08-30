From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: imx6q: Fix imx6sx low frequency support
Date: Thu, 31 Aug 2017 01:31:38 +0200
Message-ID: <1559706.kkUfkg9agS@aspire.rjw.lan>
References: <4304e578a343c9acaed46b7e205d49bb63323f80.1503918257.git.leonard.crestez@nxp.com> <1503922071.2347.0.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42940 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbdH3XkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2017 19:40:21 -0400
In-Reply-To: <1503922071.2347.0.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Anson Huang <Anson.Huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, kernel@pengutronix.de, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Monday, August 28, 2017 2:07:51 PM CEST Lucas Stach wrote:
> Am Montag, den 28.08.2017, 14:05 +0300 schrieb Leonard Crestez:
> > This patch contains the minimal changes required to support imx6sx OPP
> > of 198 Mhz. Without this patch cpufreq still reports success but the
> > frequency is not changed, the "arm" clock will still be at 396000000 in
> > clk_summary.
> > 
> > In order to do this PLL1 needs to be still kept enabled while changing
> > the ARM clock. This is a hardware requirement: when ARM_PODF is changed
> > in CCM we need to check the busy bit of CCM_CDHIPR bit 16 arm_podf_busy,
> > and this bit is sync with PLL1 clock, so if PLL1 NOT enabled, this
> > bit will never get clear.
> > 
> > Keep pll1_sys explicitly enabled until after the rate is change to deal
> > with this. Otherwise from the clk framework perspective pll1_sys is
> > unused and gets turned off.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Patch applied, thanks!

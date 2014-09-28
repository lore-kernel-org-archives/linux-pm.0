From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 2/6] clk: imx5: add step clock, used when
 reprogramming PLL1
Date: Sun, 28 Sep 2014 12:13:24 +0800
Message-ID: <20140928041322.GH12999@dragon>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
 <1411738864-26549-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bon0139.outbound.protection.outlook.com ([157.56.111.139]:15875
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750733AbaI1EOD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 28 Sep 2014 00:14:03 -0400
Content-Disposition: inline
In-Reply-To: <1411738864-26549-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Fri, Sep 26, 2014 at 03:41:00PM +0200, Lucas Stach wrote:
> This is the bypass clock used to feed the ARM partition
> while we reprogram PLL1 to another rate.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c    | 9 ++++++++-

This is a patch touching arch/arm/ file, so should be prefixed with "ARM".
I fixed those prefix up and applied patch 2-5.

Shawn

>  include/dt-bindings/clock/imx5-clock.h | 4 +++-
>  2 files changed, 11 insertions(+), 2 deletions(-)

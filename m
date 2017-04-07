From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: imx6qdl-sabresd: Set LDO regulator
 supply
Date: Fri, 7 Apr 2017 20:20:59 +0800
Message-ID: <20170407122058.GC16503@dragon>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
 <0e90881cb5b766eec66db692522591aa47165663.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932601AbdDGMVR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Apr 2017 08:21:17 -0400
Content-Disposition: inline
In-Reply-To: <0e90881cb5b766eec66db692522591aa47165663.1491324640.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Apr 04, 2017 at 08:04:13PM +0300, Leonard Crestez wrote:
> Setting the supply is optional but beneficial, it will cause PMIC
> voltages to be dynamically changed with cpu frequency.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.

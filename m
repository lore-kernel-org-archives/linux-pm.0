From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6qp-sabresd: Set reg_arm regulator
 supply
Date: Fri, 7 Apr 2017 20:21:23 +0800
Message-ID: <20170407122121.GD16503@dragon>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
 <f032759a6df750e504d040dfc80d834046c4c540.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932601AbdDGMVk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Apr 2017 08:21:40 -0400
Content-Disposition: inline
In-Reply-To: <f032759a6df750e504d040dfc80d834046c4c540.1491324640.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Apr 04, 2017 at 08:04:14PM +0300, Leonard Crestez wrote:
> On imx6qp-sabresd LDO_ARM is connected to a different PMIC output than
> the other imx6qdl-sabresd boards.
> 
> Setting cpu0 arm-supply to sw2_reg is wrong, this must have mistakenly
> slipped out of the vendor tree where this is are used for LDO bypass.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.

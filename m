From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 3/5] thermal: imx: Add support for reading OCOTP
 through nvmem
Date: Tue, 25 Jul 2017 16:08:36 +0800
Message-ID: <20170725080835.GD20064@dragon>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
 <faf9c3e5f970b9609073c4c191a7af03d647ea51.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750824AbdGYIJW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jul 2017 04:09:22 -0400
Content-Disposition: inline
In-Reply-To: <faf9c3e5f970b9609073c4c191a7af03d647ea51.1500041281.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 14, 2017 at 05:11:08PM +0300, Leonard Crestez wrote:
> On newer imx SOCs accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first. Add support for reading those same values through
> the nvmem API instead.
> 
> The older path is preserved for compatibility with older dts and because it
> works correctly on imx6qdl chips.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

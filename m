From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 3/5] thermal: imx: Add support for reading OCOTP
 through nvmem
Date: Tue, 08 Aug 2017 15:21:55 +0800
Message-ID: <1502176915.4296.1.camel@intel.com>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
         <faf9c3e5f970b9609073c4c191a7af03d647ea51.1500041281.git.leonard.crestez@nxp.com>
         <20170725080835.GD20064@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36031 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdHHHWF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Aug 2017 03:22:05 -0400
In-Reply-To: <20170725080835.GD20064@dragon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Leonard Crestez <leonard.crestez@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2017-07-25 at 16:08 +0800, Shawn Guo wrote:
> On Fri, Jul 14, 2017 at 05:11:08PM +0300, Leonard Crestez wrote:
> > 
> > On newer imx SOCs accessing OCOTP directly is wrong because the
> > ocotp clock
> > needs to be enabled first. Add support for reading those same
> > values through
> > the nvmem API instead.
> > 
> > The older path is preserved for compatibility with older dts and
> > because it
> > works correctly on imx6qdl chips.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>

I'm okay with the thermal change.
We still need ACK for the nvmem changes in this patch series.

thanks,
rui

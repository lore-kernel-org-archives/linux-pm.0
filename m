From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 0/2] soc: imx: gpc: Power off PU domain in
 suspend/resume on 6qp
Date: Mon, 02 Jul 2018 14:15:18 +0200
Message-ID: <1530533718.22468.87.camel@pengutronix.de>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530530881.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Montag, den 02.07.2018, 14:52 +0300 schrieb Leonard Crestez:
> Tested by doing `rtcwake -s 5 -m mem` while running glxgears on
> etnaviv.
> 
> The first patch is required because otherwise it is not easy to reach
> pgc
> domains from the gpc itself when using new-style bindings. It's also
> easier to understand.
> 
> The use of dynamic allocation in this driver is strange. Since there
> is
> only one GPC physically present in each soc my impulse would be to
> make
> most things global and delete imx_gpc_driver.remove entirely.
> 
> With current code (even without my patches) attempting to dynamically
> remove/probe the GPC fils since since the per-pgc platform_device
> instances are not removed. I'm trying something like this:
> 
> echo 130000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
> echo 134000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
> echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/unbind
> echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/bind
> 
> But is there any usecase for dynamically removing the GPC? Instead of
> trying to fix it I'd rather delete imx_gpc_driver.remove, just like
> for gpcv2. Would anyone object to a patch doing this?

Yes, as this is taking things in wrong direction. With device-links we
are able to unbind consumer devices when a provider is removed. As the
GPC is a consumer of a regulator, not having the ability to unbind it
would break that use case.

We might still have bugs in some of those functions, but then those
should really be fixed instead of removed.

Regards,
Lucas

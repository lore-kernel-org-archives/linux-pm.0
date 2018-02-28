From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
Date: Wed, 28 Feb 2018 19:25:31 +0200
Message-ID: <1519838731.16494.8.camel@nxp.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
         <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>, rui.zhang@intel.com, edubezval@gmail.com, shawnguo@kernel.org
Cc: Linux-imx@nxp.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, fabio.estevam@nxp.com, linux@armlinux.org.uk, kernel@pengutronix.de, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: linux-pm@vger.kernel.org

On Sat, 2018-02-24 at 16:02 +0800, Anson Huang wrote:
> This patch adds i.MX7 thermal sensor support, most
> of the i.MX7 thermal sensor functions are same with
> i.MX6 except the registers offset/layout, so we move
> those registers offset/layout definitions to soc data
> structure.
> 
> i.MX7 uses single calibration data @25C, the calibration
> data is located at OCOTP offset 0x4F0, bit[17:9], the
> formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

On imx7d (also 6sx and 6ul) OCOTP read will hang silently if the ocotp
clk is not enabled. For example this can happen if imx_thermal is built
as a module or probes after unused clocks are disabled.

This driver has support for reading ocotp values through the ocotp
nvmem driver (which handles clks properly). Since imx7d is a new
compatible string for upstream maybe you could just make new-style
bindings mandatory and drop the changes to imx_init_from_tempmon_data?

See commit 2067b757e972 ("ARM: dts: imx6ul: Add imx6ul-tempmon")

--
Regards,
Leonard

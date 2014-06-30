From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] Thermal: imx: correct critical trip temperature setting
Date: Mon, 30 Jun 2014 10:21:24 +0800
Message-ID: <20140630022122.GA3338@shlinux2>
References: <1403247786-19899-1-git-send-email-b20788@freescale.com>
 <1404095067.2289.6.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1lp0142.outbound.protection.outlook.com ([207.46.163.142]:22161
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753412AbaF3DVN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 29 Jun 2014 23:21:13 -0400
Content-Disposition: inline
In-Reply-To: <1404095067.2289.6.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Anson Huang <b20788@freescale.com>, eduardo.valentin@ti.com, linux-pm@vger.kernel.org

On Mon, Jun 30, 2014 at 10:24:27AM +0800, Zhang Rui wrote:
> On Fri, 2014-06-20 at 15:03 +0800, Anson Huang wrote:
> > On latest i.MX6 SOC with thermal calibration data of 0x5A100000,
> > the critical trip temperature will be an invalid value and
> > cause system auto shutdown as below log:
> > 
> > thermal thermal_zone0: critical temperature reached(42 C),shutting down
> > 
> > So, with universal formula for thermal sensor, only room
> > temperature point is calibrated, which means the calibration
> > data read from fuse only has valid data of bit [31:20], others
> > are all 0, the critical trip point temperature can NOT depend
> > on the hot point calibration data, here we set it to 20 C higher
> > than default passive temperature.
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> 
> Shawn,
> what do you think of this patch?

I'm fine the with patch.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

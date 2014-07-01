From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal: imx: correct critical trip temperature setting
Date: Tue, 01 Jul 2014 09:22:45 +0800
Message-ID: <1404177765.8366.7.camel@rzhang1-toshiba>
References: <1403247786-19899-1-git-send-email-b20788@freescale.com>
	 <1404095067.2289.6.camel@rzhang1-toshiba> <20140630022122.GA3338@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52468 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576AbaGABWt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 Jun 2014 21:22:49 -0400
In-Reply-To: <20140630022122.GA3338@shlinux2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Anson Huang <b20788@freescale.com>, eduardo.valentin@ti.com, linux-pm@vger.kernel.org

On Mon, 2014-06-30 at 10:21 +0800, Shawn Guo wrote:
> On Mon, Jun 30, 2014 at 10:24:27AM +0800, Zhang Rui wrote:
> > On Fri, 2014-06-20 at 15:03 +0800, Anson Huang wrote:
> > > On latest i.MX6 SOC with thermal calibration data of 0x5A100000,
> > > the critical trip temperature will be an invalid value and
> > > cause system auto shutdown as below log:
> > > 
> > > thermal thermal_zone0: critical temperature reached(42 C),shutting down
> > > 
> > > So, with universal formula for thermal sensor, only room
> > > temperature point is calibrated, which means the calibration
> > > data read from fuse only has valid data of bit [31:20], others
> > > are all 0, the critical trip point temperature can NOT depend
> > > on the hot point calibration data, here we set it to 20 C higher
> > > than default passive temperature.
> > > 
> > > Signed-off-by: Anson Huang <b20788@freescale.com>
> > 
> > Shawn,
> > what do you think of this patch?
> 
> I'm fine the with patch.
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

applied, thanks!

-rui



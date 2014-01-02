From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2] thermal: imx: correct suspend/resume flow
Date: Thu, 2 Jan 2014 10:16:03 +0800
Message-ID: <20140102021601.GA15104@S2101-09.ap.freescale.net>
References: <1387896204-31754-1-git-send-email-b20788@freescale.com>
 <1388628111.3739.68.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [65.55.88.15] ([65.55.88.15]:4289 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750732AbaABCQy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jan 2014 21:16:54 -0500
Content-Disposition: inline
In-Reply-To: <1388628111.3739.68.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Anson Huang <b20788@freescale.com>, eduardo.valentin@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 02, 2014 at 10:01:51AM +0800, Zhang Rui wrote:
> On Tue, 2013-12-24 at 09:43 -0500, Anson Huang wrote:
> > Fixes regression introduced by:
> > 
> > commit 37713a1e8e4c1a1067ad4c99296f78d3c82ed9c4
> > Author: Philipp Zabel <p.zabel@pengutronix.de>
> > Date:   Thu Aug 1 18:33:12 2013 +0200
> > 
> >     thermal: imx: implement thermal alarm interrupt handling
> > 
> > The commit 37713a1e8e4 makes imx thermal sensor always powered up as alarm
> > function is enabled, but the suspend callback of imx thermal returns
> > success only if thermal sensor is powered down, so it will always returns
> > fail hence break system's suspend, this patch disables imx thermal sensor
> > before suspend and re-enable it after resume.
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> 
> applied. BTW, this should also be a stable material for 3.12, right?

Right.  That would be great.  Thanks.

Shawn


From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Tue, 19 Jan 2016 08:29:17 +0100
Message-ID: <20160119072917.GA13237@pengutronix.de>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
 <20151217193332.GB7999@localhost.localdomain>
 <20160104141940.GI13058@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53175 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752191AbcASH3W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 02:29:22 -0500
Content-Disposition: inline
In-Reply-To: <20160104141940.GI13058@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

Eduardo,

On Mon, Jan 04, 2016 at 03:19:40PM +0100, Sascha Hauer wrote:
> Hi Eduardo,
> 
> > 
> > That should remove the policy of computing the maximum from this driver.
> > Please have a look on the work being done [1] to add grouping and
> > aggregation of thermal zones. With that in place, you should be a matter
> > of configuring the grouping and selecting max as the aggregation function,
> > from the thermal core, instead in the driver. Which should give the
> > system engineer, more flexibility to compose whatever policy based on
> > the exposed sensors.
> 
> I think the aggregation of thermal zones is quite useful when it comes
> to putting different chips together to a system. I am not so sure how
> useful it is to expose different thermal zones of a single SoC to the
> device tree.
> Currently the only control knob we have is the CPU frequency. When any
> of the sensors on the SoC gets too hot then the only thing we can do is
> to decrease the CPU frequency. This does not leave much space for
> configuration in the device tree.
> What I need to be able is to attach multiple sensors to one thermal
> zone. The aggregation patch series only partly solves that and I think
> is inconsistent, but I commented on the series directly.

Any input on this? I really like to get this driver upstream as it is
currently blocking other Mediatek drivers.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

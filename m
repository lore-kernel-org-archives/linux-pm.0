From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 13/13] thermal: of: implement .set_trips for device tree
 thermal zones
Date: Mon, 13 Apr 2015 08:30:18 +0200
Message-ID: <20150413063018.GT9742@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-14-git-send-email-s.hauer@pengutronix.de>
 <20150407024307.GH4648@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60874 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbbDMGaZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 02:30:25 -0400
Content-Disposition: inline
In-Reply-To: <20150407024307.GH4648@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Eduardo,

On Mon, Apr 06, 2015 at 07:43:08PM -0700, Eduardo Valentin wrote:
> On Thu, Mar 26, 2015 at 04:54:00PM +0100, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/thermal/of-thermal.c | 12 ++++++++++++
> >  include/linux/thermal.h      |  1 +
> >  2 files changed, 13 insertions(+)
> 
> Can you please include at least one user of this call back in your patch
> series?

Thanks for the comments on this series. I'll address them in the next
round. The user for this callback is not yet ready to be posted. I'll
try and move this patch to the end of the series so that the series can
be applied without this one.

Thanks
  Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

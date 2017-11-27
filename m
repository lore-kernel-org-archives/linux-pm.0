From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] thermal: imx: improve comments describing algorithm
 for temp calculation
Date: Mon, 27 Nov 2017 20:52:02 +0100
Message-ID: <20171127195202.yxuedcz4onfdsoif@pengutronix.de>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
 <20171121200225.23316-3-u.kleine-koenig@pengutronix.de>
 <1511807993.20123.31.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52147 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752883AbdK0TwE (ORCPT
        <rfc822;linux-pm@vger.kernel.ORG>); Mon, 27 Nov 2017 14:52:04 -0500
Content-Disposition: inline
In-Reply-To: <1511807993.20123.31.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Mon, Nov 27, 2017 at 08:39:53PM +0200, Leonard Crestez wrote:
> On Tue, 2017-11-21 at 21:02 +0100, Uwe Kleine-König wrote:
> > The description of the implemented algorithm is hardly understandable
> > without having the right application note side-by-side to the code.
> > 
> > Fix this by using shorter and more intuitive variable names, describe
> > their meaning and transform a single formula instead of first talking about
> > slope and then about "milli_Tmeas".
> > 
> > There are no code changes.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Maybe you should reorder so that patches 2 and 4 (which are most
> interesting) are right next to each other?

I don't see added benefit to reshuffle, but as I have to respin the
series, I can do that.

> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

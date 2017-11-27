From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 2/4] thermal: imx: improve comments describing algorithm
 for temp calculation
Date: Mon, 27 Nov 2017 20:39:53 +0200
Message-ID: <1511807993.20123.31.camel@nxp.com>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
         <20171121200225.23316-3-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-co1nam03on0057.outbound.protection.outlook.com ([104.47.40.57]:6496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751360AbdK0Sj7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Nov 2017 13:39:59 -0500
In-Reply-To: <20171121200225.23316-3-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Tue, 2017-11-21 at 21:02 +0100, Uwe Kleine-König wrote:
> The description of the implemented algorithm is hardly understandable
> without having the right application note side-by-side to the code.
> 
> Fix this by using shorter and more intuitive variable names, describe
> their meaning and transform a single formula instead of first talking about
> slope and then about "milli_Tmeas".
> 
> There are no code changes.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Maybe you should reorder so that patches 2 and 4 (which are most
interesting) are right next to each other?

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>

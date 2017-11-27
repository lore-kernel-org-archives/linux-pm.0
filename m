From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/4] thermal: imx: use consistent style to write
 temperatures
Date: Mon, 27 Nov 2017 20:45:46 +0100
Message-ID: <20171127194546.blxa3mohfchiqkku@pengutronix.de>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
 <20171121200225.23316-4-u.kleine-koenig@pengutronix.de>
 <1511808047.20123.32.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54861 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751700AbdK0Tpu (ORCPT
        <rfc822;linux-pm@vger.kernel.ORG>); Mon, 27 Nov 2017 14:45:50 -0500
Content-Disposition: inline
In-Reply-To: <1511808047.20123.32.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>

On Mon, Nov 27, 2017 at 08:40:47PM +0200, Leonard Crestez wrote:
> On Tue, 2017-11-21 at 21:02 +0100, Uwe Kleine-König wrote:
> > 
> > The previous commit already took care to use the right notation for
> > temperatures. Add correct units to all values representing temperatures in
> > the right notation for the rest of the file.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> I'm not sure adding unicode to source code adds much but OK.

Ah, I wasn't aware that ° is not in the ASCII range. AFAIK it doesn't
hurt from the correctness POV for the C compiler. Not sure if all kernel
coders are using utf-8 capable (and correctly configured) editors,
though. But we cannot find out if we don't start using utf-8 :-)

Honestly, I don't care much. If we choose to drop this patch, patch 2
should be changed to not introduce ° either.
 
> > -	 * Set the critical trip point at 5C under max
> > -	 * Set the passive trip point at 10C under max (can change via sysfs)
> > +	 * Set the critical trip point at 5 °C under max
> > +	 * Set the passive trip point at 10 °C under max (changable via sysfs)
> 
> It's spelled "changEable".

I thought I looked that up, but you are right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

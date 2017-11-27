From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 3/4] thermal: imx: use consistent style to write
 temperatures
Date: Mon, 27 Nov 2017 20:40:47 +0200
Message-ID: <1511808047.20123.32.camel@nxp.com>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
         <20171121200225.23316-4-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:33267
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751360AbdK0Skw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Nov 2017 13:40:52 -0500
In-Reply-To: <20171121200225.23316-4-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>

On Tue, 2017-11-21 at 21:02 +0100, Uwe Kleine-König wrote:
> 
> The previous commit already took care to use the right notation for
> temperatures. Add correct units to all values representing temperatures in
> the right notation for the rest of the file.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
I'm not sure adding unicode to source code adds much but OK.

>  	/*
> -	 * Set the critical trip point at 5C under max
> -	 * Set the passive trip point at 10C under max (can change via sysfs)
> +	 * Set the critical trip point at 5 °C under max
> +	 * Set the passive trip point at 10 °C under max (changable via sysfs)

It's spelled "changEable".

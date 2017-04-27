From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1] spi: mxs: implement runtime pm
Date: Thu, 27 Apr 2017 11:39:05 +0200
Message-ID: <20170427093905.ev4orboomjxz75zl@pengutronix.de>
References: <20170426201028.19217-1-u.kleine-koenig@pengutronix.de>
 <1493282949.13947.8.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48461 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754761AbdD0JjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 05:39:07 -0400
Content-Disposition: inline
In-Reply-To: <1493282949.13947.8.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-spi@vger.kernel.org

Hello Lucas,

On Thu, Apr 27, 2017 at 10:49:09AM +0200, Lucas Stach wrote:
> > +static const struct dev_pm_ops mxs_spi_pm = {
> > +	SET_RUNTIME_PM_OPS(mxs_spi_runtime_suspend,
> > +			   mxs_spi_runtime_resume, NULL)
> > +	SET_SYSTEM_SLEEP_PM_OPS(mxs_spi_suspend, mxs_spi_resume)
> > +};
> 
> This would be UNIVERSAL_DEV_PM_OPS, but it bears the question if your
> suspend callback is really prepared to be used a system suspend
> callback. See the comment above the definition of the
> UNIVERSAL_DEV_PM_OPS macro.

that doesn't apply here as mxs_spi_runtime_suspend != mxs_spi_suspend.

/me gives a cup of coffee to Lucas
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

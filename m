From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] thermal: imx: Use better parameter names than "val"
Date: Mon, 27 Nov 2017 20:50:38 +0100
Message-ID: <20171127195038.k3ntwdqmdibfooi7@pengutronix.de>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
 <20171121200225.23316-2-u.kleine-koenig@pengutronix.de>
 <1511807971.20123.29.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34371 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753266AbdK0Tun (ORCPT
        <rfc822;linux-pm@vger.kernel.ORG>); Mon, 27 Nov 2017 14:50:43 -0500
Content-Disposition: inline
In-Reply-To: <1511807971.20123.29.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel@pengutronix.de

On Mon, Nov 27, 2017 at 08:39:31PM +0200, Leonard Crestez wrote:
> On Tue, 2017-11-21 at 21:02 +0100, Uwe Kleine-König wrote:
> > The values passed to imx_init_calib() and imx_init_temp_grade() are
> > read from specific OCOTP values. Use their names (in lower case) as
> > parameter name instead of "val" to make the code easier to understand.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/thermal/imx_thermal.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> > index e7d4ffc3de7f..21b8c4c4da3c 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -347,13 +347,13 @@ static struct thermal_zone_device_ops imx_tz_ops = {
> >  	.set_trip_temp = imx_set_trip_temp,
> >  };
> >  
> > -static int imx_init_calib(struct platform_device *pdev, u32 val)
> > +static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
> >  {
> >  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> >  	int t1, n1;
> >  	u64 temp64;
> >  
> > -	if (val == 0 || val == ~0) {
> > +	if (ocotp_ana1 == 0 || ocotp_ana1 == ~0) {
> >  		dev_err(&pdev->dev, "invalid sensor calibration data\n");
> >  		return -EINVAL;
> >  	}
> > @@ -364,7 +364,7 @@ static int imx_init_calib(struct platform_device *pdev, u32 val)
> >  	 * Use universal formula now and only need sensor value @ 25C
> >  	 * slope = 0.4297157 - (0.0015976 * 25C fuse)
> >  	 */
> > -	n1 = val >> 20;
> > +	n1 = ocotp_ana1 >> 20;
> >  	t1 = 25; /* t1 always 25C */
> >  
> >  	/*
> > @@ -392,12 +392,12 @@ static int imx_init_calib(struct platform_device *pdev, u32 val)
> >  	return 0;
> >  }
> >  
> > -static void imx_init_temp_grade(struct platform_device *pdev, u32 val)
> > +static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
> 
> On imx7 (thermal not currently supported in upstream) the temperature
> grade is in OCOTP_TESTER3. So using a more generic parameter name here
> would be preferable or this would have to be changed again later.

Then I suggest to change the semantic and make this:

	imx_init_temp_grade(struct platform_device *pdev, u32 grade)

and let the caller do the bit shift and masking.

Does the same problem exist for ocotp_ana1?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
